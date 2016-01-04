package codemirror;

import haxe.extern.EitherType as E;
import js.html.Element;

@:native("Doc")
extern class Doc extends BasicDoc {
  // DOCUMENT MANAGEMENT METHODS
  /**
  Retrieve the editor associated with a document. May return null.
  */
  function getEditor() : CodeMirror;
}
