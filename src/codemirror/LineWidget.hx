package codemirror;

@:native("CodeMirror.LineWidget")
extern class LineWidget extends EventEmitter {
  // EVENTS
  /*
  Fired whenever the editor re-adds the widget to the DOM. This will happen once right after the widget is added (if it is scrolled into view), and then again whenever it is scrolled out of view and back in again, or when changes to the editor options or the line the widget is on require the widget to be redrawn.
  */
  inline function onRedraw(handler : Void -> Void) : Void
    this.on("redraw", handler);
  inline function offRedraw(handler : Void -> Void) : Void
    this.off("redraw", handler);
}
