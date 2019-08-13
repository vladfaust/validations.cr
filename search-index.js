crystal_doc_search_index_callback({"repository_name":"github.com/vladfaust/validations.cr","body":"# Validations\n\n[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)\n[![Build status](https://img.shields.io/travis/vladfaust/validations.cr/master.svg?style=flat-square)](https://travis-ci.org/vladfaust/validations.cr)\n[![API Docs](https://img.shields.io/badge/api_docs-online-brightgreen.svg?style=flat-square)](https://github.vladfaust.com/validations.cr)\n[![Releases](https://img.shields.io/github/release/vladfaust/validations.cr.svg?style=flat-square)](https://github.com/vladfaust/validations.cr/releases)\n[![Awesome](https://awesome.re/badge-flat2.svg)](https://github.com/veelenga/awesome-crystal)\n[![vladfaust.com](https://img.shields.io/badge/style-.com-lightgrey.svg?longCache=true&style=flat-square&label=vladfaust&colorB=0a83d8)](https://vladfaust.com)\n[![Patrons count](https://img.shields.io/badge/dynamic/json.svg?label=patrons&url=https://www.patreon.com/api/user/11296360&query=$.included[0].attributes.patron_count&style=flat-square&colorB=red&maxAge=86400)](https://www.patreon.com/vladfaust)\n[![Gitter chat](https://img.shields.io/badge/chat%20on-gitter-green.svg?colorB=ED1965&logo=gitter&style=flat-square)](https://gitter.im/vladfaust/Lobby)\n\nA validations module for [Crystal](https://crystal-lang.org/).\n\n## Supporters\n\nThanks to all my patrons, I can continue working on beautiful Open Source Software! 🙏\n\n[Lauri Jutila](https://github.com/ljuti), [Alexander Maslov](https://seendex.ru), Dainel Vera, Anton Yordanov\n\n*You can become a patron too in exchange of prioritized support and other perks*\n\n[![Become Patron](https://vladfaust.com/img/patreon-small.svg)](https://www.patreon.com/vladfaust)\n\n## Installation\n\nAdd this to your application's `shard.yml`:\n\n```yaml\ndependencies:\n  validations:\n    github: vladfaust/validations.cr\n    version: ~> 0.2.0\n```\n\nThis shard follows [Semantic Versioning 2.0.0](https://semver.org/), so see [releases](https://github.com/vladfaust/callbacks.cr/releases) and change the `version` accordingly.\n\n## Usage\n\nThis shards allows validation composition (i.e. inclusion of modules with custom validations and rules).\n\n```crystal\nrequire \"validations\"\n\nmodule CustomValidations\n  include Validations\n\n  rule :email do |attr, value, rule|\n    invalidate(attr, \"must be an email\") unless /@/.match(value)\n  end\nend\n\nstruct User\n  include Validations\n  include CustomValidations\n\n  property name : String\n  property email : String\n  @age : UInt8?\n  @nilable : String?\n\n  def initialize(@name, @email, @age : UInt8? = nil, @nilable : String? = nil)\n  end\n\n  validate name, size: (1..16), presence: true\n  validate email, size: (6..64), email: true\n  validate @age, gte: 18\n\n  # Will not be run if `@nilable.nil?`\n  validate @nilable, size: (5..10)\n\n  # Custom validations are allowed\n  def validate\n    previous_def\n    invalidate(\"name\", \"must not be equal to Vadim\") if name == \"Vadim\"\n  end\nend\n\nuser = User.new(\"Vadim\", \"e-mail\", 17)\nuser.valid? # false\npp user.invalid_attributes\n# {\n#   \"name\" => [\"must have size in (1..16)\", \"must not be equal to Vadim\"],\n#   \"email\" => [\"must have size in (6..64)\", \"must be an email\"],\n#   \"@age\" => [\"must be greater than or equal to 18\"]\n# }\n```\n\n### List of currently implemented rules\n\n* `is: Object` - check if `attribute == object`\n* `presence: Bool` - check unless `attribute.nil?`\n* `gte: Comparable` - check if `attribute >= comparable`\n* `lte: Comparable` - check if `attribute <= comparable`\n* `gt: Comparable` - check if `attribute > comparable`\n* `lt: Comparable` - check if `attribute < comparable`\n* `in: Enumerable` - check if `enumerable.includes?(attribute)`\n* `size: Enumerable` - check if `enumerable.includes?(attribute.size)`\n* `size: Int` - check if `attribute.size == int`\n* `regex: Regex` - check if `regex.match(attribute)`\n\n#### Rules which need to be explicitly required\n\nSome rules are not required with `require \"validations\"`, you have to require them explicitly.\n\n* `require \"validations/rules/scheme\"` *(related to URI scheme)*\n  * `scheme: String` - check if `attribute.scheme == string`\n  * `scheme: Enumerable` - check if `enumerable.includes?(attribute.scheme)`\n\n## Contributing\n\n1. Fork it (<https://github.com/vladfaust/validations.cr/fork>)\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n\n## Contributors\n\n- [@vladfaust](https://github.com/vladfaust) Vlad Faust - creator, maintainer\n","program":{"html_id":"github.com/vladfaust/validations.cr/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"superclass":null,"ancestors":[],"locations":[],"repository_name":"github.com/vladfaust/validations.cr","program":true,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[{"html_id":"github.com/vladfaust/validations.cr/Hash","path":"Hash.html","kind":"class","full_name":"Hash(K, V)","name":"Hash","abstract":false,"superclass":{"html_id":"github.com/vladfaust/validations.cr/Reference","kind":"class","full_name":"Reference","name":"Reference"},"ancestors":[{"html_id":"github.com/vladfaust/validations.cr/Iterable","kind":"module","full_name":"Iterable","name":"Iterable"},{"html_id":"github.com/vladfaust/validations.cr/Enumerable","kind":"module","full_name":"Enumerable","name":"Enumerable"},{"html_id":"github.com/vladfaust/validations.cr/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"github.com/vladfaust/validations.cr/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"ext/hash.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/ext/hash.cr"}],"repository_name":"github.com/vladfaust/validations.cr","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[{"html_id":"github.com/vladfaust/validations.cr/Enumerable","kind":"module","full_name":"Enumerable","name":"Enumerable"},{"html_id":"github.com/vladfaust/validations.cr/Iterable","kind":"module","full_name":"Iterable","name":"Iterable"}],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":"A `Hash` represents a collection of key-value mappings, similar to a dictionary.\n\nMain operations are storing a key-value mapping (`#[]=`) and\nquerying the value associated to a key (`#[]`). Key-value mappings can also be\ndeleted (`#delete`).\nKeys are unique within a hash. When adding a key-value mapping with a key that\nis already in use, the old value will be forgotten.\n\n```\n# Create a new Hash for mapping String to Int32\nhash = Hash(String, Int32).new\nhash[\"one\"] = 1\nhash[\"two\"] = 2\nhash[\"one\"] # => 1\n```\n\n[Hash literals](http://crystal-lang.org/reference/syntax_and_semantics/literals/hash.html)\ncan also be used to create a `Hash`:\n\n```\n{\"one\" => 1, \"two\" => 2}\n```\n\nImplementation is based on an open hash table.\nTwo objects refer to the same hash key when their hash value (`Object#hash`)\nis identical and both objects are equal to each other (`Object#==`).\n\nEnumeration follows the order that the corresponding keys were inserted.\n\nNOTE: When using mutable data types as keys, changing the value of a key after\nit was inserted into the `Hash` may lead to undefined behaviour. This can be\nrestored by re-indexing the hash with `#rehash`.","summary":"<p>A <code><a href=\"Hash.html\">Hash</a></code> represents a collection of key-value mappings, similar to a dictionary.</p>","class_methods":[],"constructors":[],"instance_methods":[{"id":"fetch_or_set(key,value)-instance-method","html_id":"fetch_or_set(key,value)-instance-method","name":"fetch_or_set","doc":"Fetch *key* or set it to *value*.\n\n```\nh = {\"foo\" => \"bar\"}\nh.fetch_or_set(\"foo\", \"baz\"); pp h\n# {\"foo\" => \"bar\"}\nh.fetch_or_set(\"bar\", \"baz\"); pp h\n# {\"foo\" => \"bar\", \"bar\" => \"baz\"}\n```","summary":"<p>Fetch <em>key</em> or set it to <em>value</em>.</p>","abstract":false,"args":[{"name":"key","doc":null,"default_value":"","external_name":"key","restriction":""},{"name":"value","doc":null,"default_value":"","external_name":"value","restriction":""}],"args_string":"(key, value)","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/ext/hash.cr#L11","def":{"name":"fetch_or_set","args":[{"name":"key","doc":null,"default_value":"","external_name":"key","restriction":""},{"name":"value","doc":null,"default_value":"","external_name":"value","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if has_key?(key)\n  self[key]\nelse\n  self[key] = value\nend"}}],"macros":[],"types":[]},{"html_id":"github.com/vladfaust/validations.cr/Validations","path":"Validations.html","kind":"module","full_name":"Validations","name":"Validations","abstract":false,"superclass":null,"ancestors":[],"locations":[{"filename":"validations/rules/gt.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/gt.cr"},{"filename":"validations/rules/gte.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/gte.cr"},{"filename":"validations/rules/in.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/in.cr"},{"filename":"validations/rules/is.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/is.cr"},{"filename":"validations/rules/lt.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/lt.cr"},{"filename":"validations/rules/lte.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/lte.cr"},{"filename":"validations/rules/presence.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/presence.cr"},{"filename":"validations/rules/regex.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/regex.cr"},{"filename":"validations/rules/size.cr","line_number":1,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/size.cr"},{"filename":"validations.cr","line_number":48,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr"},{"filename":"validations/rules/scheme.cr","line_number":3,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations/rules/scheme.cr"}],"repository_name":"github.com/vladfaust/validations.cr","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":"Enables the including type to define attribute validations.\n\n```\nmodule CustomValidations\n  include Validations\n\n  rule :custom_rule do |attr, value|\n    invalidate(attr, \"must not be foo\") if value == \"foo\"\n  end\n\n  macro included\n    def validate\n      previous_def\n      invalidate(\"x\", \"must not be bar\") if x == \"bar\"\n    end\n  end\nend\n\nrecord ObjectToValidate, x : String\n\nstruct ObjectToValidate\n  include Validations\n  include CustomValidations\n\n  rule another_custom_rule do |attr, value|\n    invalidate(attr, \"must not be baz\") if value == \"baz\"\n  end\n\n  validate x, size: (1..10), custom_rule: 42, another_custom_rule: true\n\n  def validate\n    previous_def\n    invalidate(\"x\", \"must not be qux\") if x == \"qux\"\n  end\nend\n\no = ObjectToValidate.new(\"aaa\")\no.valid?             # true\no.invalid_attributes # {}\n\no = ObjectToValidate.new(\"foo\")\no.valid?             # false\no.invalid_attributes # {\"x\" => [\"must not be foo\"]}\n```","summary":"<p>Enables the including type to define attribute validations.</p>","class_methods":[],"constructors":[],"instance_methods":[{"id":"invalid_attributes:Hash(String,Array(String))?-instance-method","html_id":"invalid_attributes:Hash(String,Array(String))?-instance-method","name":"invalid_attributes","doc":"A hash of invalid attributes, if any. Equals to `nil` by default.\n\n```\npp user.invalid_attributes # nil\n\nuser.name = \"Ovuvuevuevue enyetuenwuevue ugbemugbem osas\"\npp user.valid? # => false\n\npp user.invalid_attributes\n# {\"name\" => [\"is too long\", \"is not slav enough\"]}\n```","summary":"<p>A hash of invalid attributes, if any.</p>","abstract":false,"args":[],"args_string":" : Hash(String, Array(String))?","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L75","def":{"name":"invalid_attributes","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Hash(String, Array(String)) | Nil","visibility":"Public","body":"@invalid_attributes"}},{"id":"valid!:self-instance-method","html_id":"valid!:self-instance-method","name":"valid!","doc":"Strict check if the including type is valid and return `self`,\nraise `Error` otherwise.","summary":"<p>Strict check if the including type is valid and return <code>self</code>, raise <code><a href=\"Validations/Error.html\">Error</a></code> otherwise.</p>","abstract":false,"args":[],"args_string":" : <span class=\"k\">self</span>","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L57","def":{"name":"valid!","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"self","visibility":"Public","body":"valid? || (raise(Error.new(invalid_attributes.not_nil!)))\nself\n"}},{"id":"valid?:Bool-instance-method","html_id":"valid?:Bool-instance-method","name":"valid?","doc":"Soft check if the including type is valid.","summary":"<p>Soft check if the including type is valid.</p>","abstract":false,"args":[],"args_string":" : Bool","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L50","def":{"name":"valid?","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Bool","visibility":"Public","body":"validate\ninvalid_attributes.nil? || invalid_attributes.not_nil!.empty?\n"}}],"macros":[{"id":"invalidate(attribute,message)-macro","html_id":"invalidate(attribute,message)-macro","name":"invalidate","doc":"Mark *attribute* as invalid with *message*.\n\n```\ninvalidate(\"name\", \"is not valid\")\n```","summary":"<p>Mark <em>attribute</em> as invalid with <em>message</em>.</p>","abstract":false,"args":[{"name":"attribute","doc":null,"default_value":"","external_name":"attribute","restriction":""},{"name":"message","doc":null,"default_value":"","external_name":"message","restriction":""}],"args_string":"(attribute, message)","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L99","def":{"name":"invalidate","args":[{"name":"attribute","doc":null,"default_value":"","external_name":"attribute","restriction":""},{"name":"message","doc":null,"default_value":"","external_name":"message","restriction":""}],"double_splat":null,"splat_index":null,"block_arg":null,"visibility":"Public","body":"    (@invalid_attributes ||= Hash(String, Array(String)).new).fetch_or_set(\n{{ attribute }}\n, Array(String).new).push(\n{{ message }}\n)\n  \n"}},{"id":"rule(rule,&block)-macro","html_id":"rule(rule,&amp;block)-macro","name":"rule","doc":"Define a custom *rule*.\n\nThe block will receive three attributes:\n\n* attribute name, e.g. `\"age\"`\n* actual value, e.g. `20`\n* rule which is currently applied, e.g. `18` for `gte: 18`\n\nNote that some arugments can be ommited in the block argument list (i.e. both `rule do |attr, value|` and `rule do |attr|` are valid as well).\n\n```\nrule :even do |attr, value, rule|\n  unless value.nil?\n    if rule\n      invalidate(attr, \"must be even\") unless value.not_nil! % 2 == 0\n    else\n      invalidate(attr, \"must not be even\") if value.not_nil! % 2 == 0\n    end\n  end\nend\n```\n\nRules can be defined both in the validated object and in an includable module.","summary":"<p>Define a custom <em>rule</em>.</p>","abstract":false,"args":[{"name":"rule","doc":null,"default_value":"","external_name":"rule","restriction":""}],"args_string":"(rule, &block)","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L179","def":{"name":"rule","args":[{"name":"rule","doc":null,"default_value":"","external_name":"rule","restriction":""}],"double_splat":null,"splat_index":null,"block_arg":{"name":"block","doc":null,"default_value":"","external_name":"block","restriction":""},"visibility":"Public","body":"    protected def validate_\n{{ rule.id.gsub(/\\s/, \"_\") }}\n(attr, value, rule)\n      \n{% for name, index in [\"attr\", \"value\", \"rule\"] of ::String %}\n        {% if block.args[index] && (block.args[index].stringify != name) %}\n          {{ block.args[index] }} = {{ name.id }}\n        {% end %}\n      {% end %}\n\n\n      \n{{ block.body.id }}\n\n    \nend\n  \n"}},{"id":"validate(attribute,**rules)-macro","html_id":"validate(attribute,**rules)-macro","name":"validate","doc":"Validate *attribute* with inline *rules*.\n\n```\nclass User\n  property name, age\n\n  validate name, size: (1..16)\n  validate age, gte: 18\nend\n```\n\nRuns `validate_{rule}` for each one of *rules* internally.\nYou can find currently implemented inline rules in `src/validations/rules`.\nThe list of inline rules can be extended with `.rule` macro.\n\nThe `#validate` method can also be redefined to run custom validations:\n\n```\ndef validate\n  previous_def # Mandatory, otherwise inline validations won't run\n  invalidate(\"name\", \"some error\") if name == \"Foo\"\nend\n```\n\nIt also can be redefined in included modules like this:\n\n```\nmodule CustomValidations\n  macro included\n    def validate\n      previous_def\n      invalidate(\"name\", \"another error\") if name == \"Bar\"\n    end\n  end\nend\n\nclass User\n  include Validations # Still need to include `Validations`\n  include CustomValidations\nend\n```","summary":"<p>Validate <em>attribute</em> with inline <em>rules</em>.</p>","abstract":false,"args":[{"name":"attribute","doc":null,"default_value":"","external_name":"attribute","restriction":""}],"args_string":"(attribute, **rules)","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L144","def":{"name":"validate","args":[{"name":"attribute","doc":null,"default_value":"","external_name":"attribute","restriction":""}],"double_splat":{"name":"rules","doc":null,"default_value":"","external_name":"rules","restriction":""},"splat_index":null,"block_arg":null,"visibility":"Public","body":"    def validate\n      \n{% if @type.has_method?(:validate) %}\n        previous_def\n      {% end %}\n\n\n      \n{% for rule in rules.keys %}\n        validate_{{ rule.id.gsub(/\\s/, \"_\") }}({{ attribute.stringify }}, {{ attribute }}, {{ rules[rule] }})\n      {% end %}\n\n    \nend\n  \n"}}],"types":[{"html_id":"github.com/vladfaust/validations.cr/Validations/Error","path":"Validations/Error.html","kind":"class","full_name":"Validations::Error","name":"Error","abstract":false,"superclass":{"html_id":"github.com/vladfaust/validations.cr/Exception","kind":"class","full_name":"Exception","name":"Exception"},"ancestors":[{"html_id":"github.com/vladfaust/validations.cr/Exception","kind":"class","full_name":"Exception","name":"Exception"},{"html_id":"github.com/vladfaust/validations.cr/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"github.com/vladfaust/validations.cr/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"validations.cr","line_number":76,"url":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr"}],"repository_name":"github.com/vladfaust/validations.cr","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"github.com/vladfaust/validations.cr/Validations","kind":"module","full_name":"Validations","name":"Validations"},"doc":"Raised when the including type has validation errors after calling `valid!`.","summary":"<p>Raised when the including type has validation errors after calling <code>valid!</code>.</p>","class_methods":[],"constructors":[{"id":"new(invalid_attributes:Hash(String,Array(String)))-class-method","html_id":"new(invalid_attributes:Hash(String,Array(String)))-class-method","name":"new","doc":null,"summary":null,"abstract":false,"args":[{"name":"invalid_attributes","doc":null,"default_value":"","external_name":"invalid_attributes","restriction":"Hash(String, Array(String))"}],"args_string":"(invalid_attributes : Hash(String, Array(String)))","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L80","def":{"name":"new","args":[{"name":"invalid_attributes","doc":null,"default_value":"","external_name":"invalid_attributes","restriction":"Hash(String, Array(String))"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = allocate\n_.initialize(invalid_attributes)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"id":"invalid_attributes:Hash(String,Array(String))-instance-method","html_id":"invalid_attributes:Hash(String,Array(String))-instance-method","name":"invalid_attributes","doc":"A hash of invalid attributes, which is never `nil`.","summary":"<p>A hash of invalid attributes, which is never <code>nil</code>.</p>","abstract":false,"args":[],"args_string":" : Hash(String, Array(String))","source_link":"https://github.com/vladfaust/validations.cr/blob/27d81f408db8bb611a04f0396ef967caff5432fd/src/validations.cr#L80","def":{"name":"invalid_attributes","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Hash(String, Array(String))","visibility":"Public","body":"@invalid_attributes"}}],"macros":[],"types":[]}]}]}})