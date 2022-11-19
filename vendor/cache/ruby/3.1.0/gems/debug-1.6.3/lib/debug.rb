require_relative 'debug/session'
return unless defined?(DEBUGGER__)
DEBUGGER__::start no_sigint_hook: true, nonstop: true
