include strutils

type
   TokenType = enum
      tokNull, tokLabel, tokDecleration
   Token = object
      tType*: TokenType
      tValue*: string
   Context = object
      currentSection: string
      isData: bool
      isMain: bool
      isSub: bool


proc newContext(): Context = 
   result = Context(currentSection: "", isData: false, isMain: false, isSub: false)

proc updateContext(ctx: var Context, newContext: string) = 
   ctx.currentSection = newContext
   ctx.isData = false
   ctx.isMain = false
   ctx.isSub = false

   case newContext:
      of ".data":
         ctx.isData = true
         ctx.isMain = false
         ctx.isSub = false
      of ".start":
         ctx.isData = false
         ctx.isMain = true
         ctx.isSub = false
      else:
         ctx.isData = false
         ctx.isMain = false
         ctx.isSub = true

proc newToken(toktype: TokenType, tokval: string): Token =
   result = Token(tType: toktype, tValue: tokval)


proc tokenize(content: string) =
   var tokens: seq[Token]
   var ctx = newContext()

   for line in content.splitLines:
      for tok in line.splitWhitespace:
         echo tok
         if tok.startsWith("."):
            ctx.updateContext(tok)
            tokens.add(newToken(tokLabel, tok))

   echo tokens



proc parse*(filepath: string) =
   let file = readFile(filepath)
   tokenize(file)



