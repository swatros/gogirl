import H from "@here/maps-api-for-javascript";
import { map } from "jquery";
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["map", "directions", "summary", "todirections"]

  connect() {

    // Step 0: define map origin, destination, and areas to avoid:
    this.origin = JSON.parse(this.mapTarget.dataset.origin);
    this.destination = JSON.parse(this.mapTarget.dataset.destination);
    this.incidents = JSON.parse(this.mapTarget.dataset.incidents);
    this.avoidIncidents = this.mapTarget.dataset.avoid;

    // Step 1: initialize communication with the platform
    var routeMapContainer = document.getElementById('map');
    this.platform = new H.service.Platform({
      apikey: this.mapTarget.dataset.hereApiKey
    });
    var defaultLayers = this.platform.createDefaultLayers();

    //Step 2: initialize a map
    this.map = new H.Map(this.mapTarget,
      defaultLayers.vector.normal.map, {
      padding: {top: 24, right: 60, bottom: 60, left: 60},
      background: {color: 'black'},
      pixelRatio: window.devicePixelRatio || 1
  });

    //Step 3: make the map interactive
    var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(this.map));

    // CALL OTHER MAP JS FUNCTIONS, AS DEFINED BELOW:
    this.generateRoute({lat: this.origin[0], lng: this.origin[1]}, { lat: this.destination[0], lng: this.destination[1]});
  }

  generateRoute(origin, destination) {

    var router = this.platform.getRoutingService(null, 8),
      routeRequestParams = {
        routingMode: 'fast',
        transportMode: 'pedestrian',
        'pedestrian[speed]': 1.4,
        origin: `${origin.lat},${origin.lng}`,
        destination: `${destination.lat},${destination.lng}`,
        'avoid[areas]': this.avoidIncidents,
        return: 'polyline,turnByTurnActions,actions,instructions,travelSummary'
        };

      const onSuccess = (result) => {
        if (result.routes.length) {
          this.drawRoute(result.routes[0])
          this.summarizeRoute(result.routes[0])
          this.addManueversToPanel(result.routes[0])
        }
      }

      router.calculateRoute(routeRequestParams, onSuccess);
  }

  summarizeRoute(route) {
    let eta = new Date(route.sections[0].arrival.time);
    let distanceToGo = (route.sections[0].travelSummary.length / 1000).toFixed(1);
    console.log()

    let etaHolder = document.getElementById('eta');

    let etaMinutes = ""
    if (eta.getMinutes() > 9) {
      etaMinutes = eta.getMinutes()
    } else {
      etaMinutes = `0${eta.getMinutes()}`
    }

    etaHolder.innerHTML = `${eta.getHours()}:${etaMinutes}`;

    let distanceHolder = document.getElementById('distance');
    distanceHolder.innerHTML = `${distanceToGo} km`;
  }

  drawRoute(route) {
    route.sections.forEach((section) => {
      let linestring = H.geo.LineString.fromFlexiblePolyline(section.polyline);

      let polyline = new H.map.Polyline(linestring, {
        style: {
          lineWidth: 4,
          strokeColor: 'rgba(0, 128, 255, 0.7)'
        }
      });

      console.log(route.sections);

      this.map.addObject(polyline);

      var destinationIcon = new H.map.Icon('https://img.icons8.com/external-those-icons-fill-those-icons/48/000000/external-pin-maps-and-locations-those-icons-fill-those-icons.png', { size: { w: 40, h: 40 } });
      var originIcon = new H.map.Icon('https://img.icons8.com/external-flatart-icons-outline-flatarticons/64/000000/external-map-pin-basic-ui-elements-flatart-icons-outline-flatarticons.png', { size: { w: 40, h: 40 } });
      var flagIcon = new H.map.Icon('https://img.icons8.com/color/30/000000/high-importance--v1.png', { size: { w: 20, h: 20 } });
      var userIcon = new H.map.Icon('https://img.icons8.com/ios-filled/50/000000/user-female-circle.png', { size: { w: 25, h: 25 } })


      function addMarkersToMap(map, incidents) {
        var destinationMarker = new H.map.Marker(
          {
            lat: route.sections[0].arrival.place.location.lat,
            lng: route.sections[0].arrival.place.location.lng
          },
          {
            icon: destinationIcon
          }
        );
        map.addObject(destinationMarker);

        var originMarker = new H.map.Marker(
          {
            lat: route.sections[0].departure.place.location.lat,
            lng: route.sections[0].departure.place.location.lng
          },
          {
            icon: originIcon
          }
        );
        map.addObject(originMarker);

        incidents.forEach((incident) => {
          var incidentMarker = new H.map.Marker({
            lat: incident.lat,
            lng: incident.lng
          },
          {
            icon: flagIcon
          })
          map.addObject(incidentMarker)
        })
  }

      addMarkersToMap(this.map, this.incidents);

      // ADD CONTINUOUS USER LOCATION TO MAP AS ICON

      const showPosition = (position) => {
        console.log(position.coords)

        if (this.userMarker) {
          this.userMarker.setGeometry({ lat: position.coords.latitude, lng: position.coords.longitude })
        } else {
          this.userMarker = new H.map.Marker({
            lat: position.coords.latitude,
            lng: position.coords.longitude
          },
            {
              icon: userIcon
            })
          this.map.addObject(this.userMarker)
      }
    }

    navigator.geolocation.watchPosition(showPosition);

      // ADJUST MAP VIEW CENTER

      this.map.getViewModel().setLookAtData({
        bounds: polyline.getBoundingBox()
      });

    });
  }

  addManueversToPanel(route, container) {
    var nodeOL = document.createElement('ol');

    nodeOL.className = 'directions-js';

    route.sections.forEach((section) => {
      section.actions.forEach((action, idx) => {
        var li = document.createElement('li'),
          spanArrow = document.createElement('span'),
          spanInstruction = document.createElement('span');

        spanArrow.className = 'arrow ' + (action.direction || '') + action.action;
        spanInstruction.innerHTML = section.actions[idx].instruction;
        li.appendChild(spanArrow);
        li.appendChild(spanInstruction);

        nodeOL.appendChild(li);
      });
    });

    let routeDirectionsContainer = this.directionsTarget;
    routeDirectionsContainer.appendChild(nodeOL);
  }
}
