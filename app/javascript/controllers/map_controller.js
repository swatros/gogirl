import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["map", "directions"]

  connect() {

    // Step 0: define map origin, destination, and center:
    this.origin = JSON.parse(this.mapTarget.dataset.origin);
    this.destination = JSON.parse(this.mapTarget.dataset.destination);

    // Step 1: initialize communication with the platform
    var routeMapContainer = document.getElementById('map');
    this.platform = new H.service.Platform({
      apikey: this.mapTarget.dataset.hereApiKey
    });
    var defaultLayers = this.platform.createDefaultLayers();

    //Step 2: initialize a map - this map is centered over Origin
    this.map = new H.Map(this.mapTarget,
      defaultLayers.vector.normal.map, {
      padding: {top: 24, right: 24, bottom: 24, left: 24},
      pixelRatio: window.devicePixelRatio || 1
  });


    //Step 3: make the map interactive
    var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(this.map));

    // Disabled all default map UI (zoom buttons, scale, traffic layers)
    // var ui = H.ui.UI.createDefault(map, defaultLayers);

    // CALL OTHER MAP JS FUNCTIONS, AS DEFINED BELOW:

    this.generateRoute({lat: this.origin[0], lng: this.origin[1]}, { lat: this.destination[0], lng: this.destination[1]});

  }

  generateRoute(origin, destination) {
    var router = this.platform.getRoutingService(null, 8),
      routeRequestParams = {
        routingMode: 'fast',
        transportMode: 'pedestrian',
        origin: `${origin.lat},${origin.lng}`,
        destination: `${destination.lat},${destination.lng}`,
        return: 'polyline,turnByTurnActions,actions,instructions,travelSummary'
        };

      const onSuccess = (result) => {
        if (result.routes.length) {
          this.drawRoute(result.routes[0])
        }
      }

      router.calculateRoute(routeRequestParams, onSuccess);

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

      this.map.addObject(polyline);

      this.map.getViewModel().setLookAtData({
        bounds: polyline.getBoundingBox()
      });
    });
  }
}







    //       /*
    //       * The styling of the route response on the map is entirely under the developer's control.
    //       * A representitive styling can be found the full JS + HTML code of this example
    //       * in the functions below:
    //       */
    //       addRouteShapeToMap(route);
    //       addManueversToMap(route);
    //       addManueversToDirections(route);
    //       addSummaryToDirections(route);
    //       // ... etc.
    //     }

    //     /**
    //      * This function will be called if a communication error occurs during the JSON-P request
    //      * @param  {Object} error  The error message received.
    //      */
    //     function onError(error) {
    //       alert('Can\'t reach the remote server');
    //   }

    // // Hold a reference to any infobubble opened
    // var bubble;

    // /**
    //  * Opens/Closes a infobubble
    //  * @param  {H.geo.Point} position     The location on the map.
    //  * @param  {String} text              The contents of the infobubble.
    //  */
    // function openBubble(position, text) {
    //   if (!bubble) {
    //     bubble = new H.ui.InfoBubble(
    //       position,
    //       { content: text });
    //     ui.addBubble(bubble);
    //   } else {
    //     bubble.setPosition(position);
    //     bubble.setContent(text);
    //     bubble.open();
    //   }
    // }


    // /**
    //  * Creates a H.map.Polyline from the shape of the route and adds it to the map.
    //  * @param {Object} route A route as received from the H.service.RoutingService
    //  */
    // function addRouteShapeToMap(route) {
    //   route.sections.forEach((section) => {
    //     // decode LineString from the flexible polyline
    //     let linestring = H.geo.LineString.fromFlexiblePolyline(section.polyline);

    //     // Create a polyline to display the route:
    //     let polyline = new H.map.Polyline(linestring, {
    //       style: {
    //         lineWidth: 4,
    //         strokeColor: 'rgba(0, 128, 255, 0.7)'
    //       }
    //     });

    //     // Add the polyline to the map
    //     this.map.addObject(polyline);
    //     // And zoom to its bounding rectangle
    //     this.map.getViewModel().setLookAtData({
    //       bounds: polyline.getBoundingBox()
    //     });
    //   });
    // }


    // /**
    //  * Creates a series of H.map.Marker points from the route and adds them to the map.
    //  * @param {Object} route  A route as received from the H.service.RoutingService
    //  */
    // function addManueversToMap(route) {
    //   var svgMarkup = '<svg width="18" height="18" ' +
    //     'xmlns="http://www.w3.org/2000/svg">' +
    //     '<circle cx="8" cy="8" r="8" ' +
    //     'fill="#1b468d" stroke="white" stroke-width="1"  />' +
    //     '</svg>',
    //     dotIcon = new H.map.Icon(svgMarkup, { anchor: { x: 8, y: 8 } }),
    //     group = new H.map.Group(),
    //     i,
    //     j;
    //   route.sections.forEach((section) => {
    //     let poly = H.geo.LineString.fromFlexiblePolyline(section.polyline).getLatLngAltArray();

    //     let actions = section.actions;
    //     // Add a marker for each maneuver
    //     for (i = 0; i < actions.length; i += 1) {
    //       let action = actions[i];
    //       var marker = new H.map.Marker({
    //         lat: poly[action.offset * 3],
    //         lng: poly[action.offset * 3 + 1]
    //       },
    //         { icon: dotIcon });
    //       marker.instruction = action.instruction;
    //       group.addObject(marker);
    //     }

    //     group.addEventListener('tap', function (evt) {
    //       this.map.setCenter(evt.target.getGeometry());
    //       openBubble(
    //         evt.target.getGeometry(), evt.target.instruction);
    //     }, false);

    //     // Add the maneuvers group to the map
    //     this.map.addObject(group);
    //   });
    // }


    // /**
    //  * Creates a series of H.map.Marker points from the route and adds them to the map.
    //  * @param {Object} route  A route as received from the H.service.RoutingService
    //  */
    // function addSummaryToDirections(route) {
    //   let duration = 0,
    //     distance = 0;

    //   route.sections.forEach((section) => {
    //     distance += section.travelSummary.length;
    //     duration += section.travelSummary.duration;
    //   });

    //   var summaryDiv = document.createElement('div'),
    //     content = '';
    //   content += '<b>Total distance</b>: ' + distance + 'm. <br/>';
    //   content += '<b>Travel Time</b>: ' + duration.toMMSS();


    //   summaryDiv.style.fontSize = 'small';
    //   summaryDiv.style.marginLeft = '5%';
    //   summaryDiv.style.marginRight = '5%';
    //   summaryDiv.innerHTML = content;
    //   routeInstructionsContainer.appendChild(summaryDiv);
    // }

    // /**
    //  * Creates a series of H.map.Marker points from the route and adds them to the map.
    //  * @param {Object} route  A route as received from the H.service.RoutingService
    //  */
    // function addManueversToDirections(route) {
    //   var nodeOL = document.createElement('ol');

    //   nodeOL.style.fontSize = 'small';
    //   nodeOL.style.marginLeft = '5%';
    //   nodeOL.style.marginRight = '5%';
    //   nodeOL.className = 'directions';

    //   route.sections.forEach((section) => {
    //     section.actions.forEach((action, idx) => {
    //       var li = document.createElement('li'),
    //         spanArrow = document.createElement('span'),
    //         spanInstruction = document.createElement('span');

    //       spanArrow.className = 'arrow ' + (action.direction || '') + action.action;
    //       spanInstruction.innerHTML = section.actions[idx].instruction;
    //       li.appendChild(spanArrow);
    //       li.appendChild(spanInstruction);

    //       nodeOL.appendChild(li);
    //     });
    //   });

    //   routeInstructionsContainer.appendChild(nodeOL);
    // }


    // Number.prototype.toMMSS = function () {
    //   return Math.floor(this / 60) + ' minutes ' + (this % 60) + ' seconds.';
    // }

    // // Now use the map as required...
    // calculateRouteFromAtoB(platform);
