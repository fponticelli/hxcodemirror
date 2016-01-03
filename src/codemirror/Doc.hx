package codemirror;

@:native("CodeMirror.Doc")
extern class Doc extends EventEmitter {

  // EVENTS

  /**
  Fired whenever a change occurs to the document. changeObj has a similar type as the object passed to the editor's "change" event.
  */
  function onChange(handler : Doc -> ChangeObject -> Void) : Void;
  /**
  See the description of the same event on editor instances.
  */
  function onBeforeChange(handler : Doc -> ChangeObject -> Void) : Void;
  /**
  Fired whenever the cursor or selection in this document changes.
  */
  function onCursorActivity(handler : Doc -> Void) : Void;
  /**
  Equivalent to the event by the same name as fired on editor instances.
  */
  function onBeforeSelectionChange(handler : Doc -> { ranges : Array<Range>, origin : String, update : Array<Range> -> Void } -> Void) : Void;
}
