package codemirror;

extern class LineHandle extends EventEmitter {

  // EVENTS
  /**
  Will be fired when the line object is deleted. A line object is associated with the start of the line. Mostly useful when you need to find out when your gutter markers on a given line are removed.
  */
  inline function onDelete(handler : Void -> Void) : Void
    this.on("delete", handler);
  inline function offDelete(handler : Void -> Void) : Void
    this.off("delete", handler);
  /**
  Fires when the line's text content is changed in any way (but the line is not deleted outright). The change object is similar to the one passed to change event on the editor object.
  */
  inline function onChange(handler : LineHandle -> ChangeObject -> Void) : Void
    this.on("change", handler);
  inline function offChange(handler : LineHandle -> ChangeObject -> Void) : Void
    this.off("change", handler);
}
