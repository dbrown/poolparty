#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'poolparty_types'

    module CloudThrift
      module CommandInterface
        class Client
          include ::Thrift::Client

          def run_command(cld, command, arglist)
            send_run_command(cld, command, arglist)
            return recv_run_command()
          end

          def send_run_command(cld, command, arglist)
            send_message('run_command', Run_command_args, :cld => cld, :command => command, :arglist => arglist)
          end

          def recv_run_command()
            result = receive_message(Run_command_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'run_command failed: unknown result')
          end

        end

        class Processor
          include ::Thrift::Processor

          def process_run_command(seqid, iprot, oprot)
            args = read_args(iprot, Run_command_args)
            result = Run_command_result.new()
            result.success = @handler.run_command(args.cld, args.command, args.arglist)
            write_result(result, oprot, 'run_command', seqid)
          end

        end

        # HELPER FUNCTIONS AND STRUCTURES

        class Run_command_args
          include ::Thrift::Struct
          CLD = 1
          COMMAND = 2
          ARGLIST = 3

          ::Thrift::Struct.field_accessor self, :cld, :command, :arglist
          FIELDS = {
            CLD => {:type => ::Thrift::Types::STRUCT, :name => 'cld', :class => CloudThrift::CloudQuery},
            COMMAND => {:type => ::Thrift::Types::STRING, :name => 'command'},
            ARGLIST => {:type => ::Thrift::Types::LIST, :name => 'arglist', :element => {:type => ::Thrift::Types::STRING}}
          }

          def struct_fields; FIELDS; end

          def validate
          end

        end

        class Run_command_result
          include ::Thrift::Struct
          SUCCESS = 0

          ::Thrift::Struct.field_accessor self, :success
          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => CloudThrift::CloudResponse}
          }

          def struct_fields; FIELDS; end

          def validate
          end

        end

      end

    end
