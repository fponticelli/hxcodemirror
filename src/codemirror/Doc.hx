package codemirror;

@:native("CodeMirror.Doc")
extern class Doc extends EventEmitter {

  // EVENTS

  /**
  Fired whenever a change occurs to the document. changeObj has a similar type as the object passed to the editor's "change" event.
  */
  inline function onChange(handler : Doc -> ChangeObject -> Void) : Void
    this.on("change", handler);
  inline function offChange(handler : Doc -> ChangeObject -> Void) : Void
    this.off("change", handler);
  /**
  See the description of the same event on editor instances.
  */
  inline function onBeforeChange(handler : Doc -> ChangeObject -> Void) : Void
    this.on("beforeChange", handler);
  inline function offBeforeChange(handler : Doc -> ChangeObject -> Void) : Void
    this.off("beforeChange", handler);
  /**
  Fired whenever the cursor or selection in this document changes.
  */
  inline function onCursorActivity(handler : Doc -> Void) : Void
    this.on("cursorActivity", handler);
  inline function offCursorActivity(handler : Doc -> Void) : Void
    this.off("cursorActivity", handler);
  /**
  Equivalent to the event by the same name as fired on editor instances.
  */
  inline function onBeforeSelectionChange(handler : Doc -> { ranges : Array<Range>, origin : String, update : Array<Range> -> Void } -> Void) : Void
    this.on("beforeSelectionChange", handler);
  inline function offBeforeSelectionChange(handler : Doc -> { ranges : Array<Range>, origin : String, update : Array<Range> -> Void } -> Void) : Void
    this.off("beforeSelectionChange", handler);
}
