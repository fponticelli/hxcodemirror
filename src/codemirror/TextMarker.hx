package codemirror;

@:native("CodeMirror.TextMarker")
extern class TextMarker extends EventEmitter {
  // EVENTS
  /**
  Fired when the cursor enters the marked range. From this event handler, the editor state may be inspected but not modified, with the exception that the range on which the event fires may be cleared.
  */
  inline function onBeforeCursorEnter(handler : Void -> Void) : Void
    this.on("beforeCursorEnter", handler);
  inline function offBeforeCursorEnter(handler : Void -> Void) : Void
    this.off("beforeCursorEnter", handler);
  /**
  Fired when the range is cleared, either through cursor movement in combination with clearOnEnter or through a call to its clear() method. Will only be fired once per handle. Note that deleting the range through text editing does not fire this event, because an undo action might bring the range back into existence. from and to give the part of the document that the range spanned when it was cleared.
  */
  inline function onClear(handler : Pos -> Pos -> Void) : Void
    this.on("clear", handler);
  inline function offClear(handler : Pos -> Pos -> Void) : Void
    this.off("clear", handler);
  /**
  Fired when the last part of the marker is removed from the document by editing operations.
  */
  inline function onHide(handler : Void -> Void) : Void
    this.on("hide", handler);
  inline function offHide(handler : Void -> Void) : Void
    this.off("hide", handler);
  /**
  Fired when, after the marker was removed by editing, a undo operation brought the marker back.
  */
  inline function onUnhide(handler : Void -> Void) : Void
    this.on("unhide", handler);
  inline function offUnhide(handler : Void -> Void) : Void
    this.off("unhide", handler);
}
