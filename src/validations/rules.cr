# Require only those rules which do not have external requires
# (i.e. skip "scheme" rule because it requires "uri")
#

require "./rules/gt"
require "./rules/gte"
require "./rules/in"
require "./rules/is"
require "./rules/lt"
require "./rules/lte"
require "./rules/presence"
require "./rules/regex"
require "./rules/size"
