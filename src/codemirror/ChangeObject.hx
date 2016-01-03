package codemirror;

typedef ChangeObject = {
  from : Pos,
  to : Pos,
  text : Array<String>,
  removed : String,
  ?origin : String
}
