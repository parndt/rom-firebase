# frozen_string_literal: true

require 'rom'
require_relative 'firebase/commands/create'
require_relative 'firebase/commands/delete'
require_relative 'firebase/commands/update'
require_relative 'firebase/dataset'
require_relative 'firebase/gateway'
require_relative 'firebase/mapper_compiler'
require_relative 'firebase/relation'
require_relative 'firebase/repository'
require_relative 'firebase/request_handler'
require_relative 'firebase/response_handler'
require_relative 'firebase/types/timestamp'

ROM.register_adapter(:firebase, ROM::Firebase)
