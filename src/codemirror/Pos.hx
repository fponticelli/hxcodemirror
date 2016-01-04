package codemirror;

@:native("CodeMirror.Pos")
extern class Pos {
  /**
  A constructor for the {line, ch} objects that are used to represent positions in editor documents.
  */
  function new(line: Int, ?ch: Int) : Void;
  var ch : Int;
  var line : Int;
}

extern class PosHit extends Pos {
  var hitSide : Null<Bool>;
}
