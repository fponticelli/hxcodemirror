package codemirror;

import js.html.Element;

@:native("CodeMirror")
extern class CodeMirror {
  public function new(el : Element) : Void;
}
