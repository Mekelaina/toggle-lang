# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import file_lexer

proc main() = 
  file_lexer.parse("examples/test.tog")

when isMainModule:
  main()

  