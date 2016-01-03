package codemirror;

extern class LineHandle {
  /**
  Will be fired when the line object is deleted. A line object is associated with the start of the line. Mostly useful when you need to find out when your gutter markers on a given line are removed.
  */
  function onDelete(handler : Void -> Void) : Void;
  /**
  Fires when the line's text content is changed in any way (but the line is not deleted outright). The change object is similar to the one passed to change event on the editor object.
  */
  function onChange(handler : LineHandle -> ChangeObject -> Void) : Void;
}
