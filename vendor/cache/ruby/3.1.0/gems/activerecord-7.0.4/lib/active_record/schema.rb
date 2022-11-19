module ActiveRecord
  # = Active Record \Schema
  #
  # Allows programmers to programmatically define a schema in a portable
  # DSL. This means you can define tables, indexes, etc. without using SQL
  # directly, so your applications can more easily support multiple
  # databases.
  #
  # Usage:
  #
  #   ActiveRecord::Schema[7.0].define do
  #     create_table :authors do |t|
  #       t.string :name, null: false
  #     end
  #
  #     add_index :authors, :name, :unique
  #
  #     create_table :posts do |t|
  #       t.integer :author_id, null: false
  #       t.string :subject
  #       t.text :body
  #       t.boolean :private, default: false
  #     end
  #
  #     add_index :posts, :author_id
  #   end
  #
  # ActiveRecord::Schema is only supported by database adapters that also
  # support migrations, the two features being very similar.
  class Schema < Migration::Current
    module Definition
      extend ActiveSupport::Concern

      module ClassMethods
        # Eval the given block. All methods available to the current connection
        # adapter are available within the block, so you can easily use the
        # database definition DSL to build up your schema (
        # {create_table}[rdoc-ref:ConnectionAdapters::SchemaStatements#create_table],
        # {add_index}[rdoc-ref:ConnectionAdapters::SchemaStatements#add_index], etc.).
        #
        # The +info+ hash is optional, and if given is used to define metadata
        # about the current schema (currently, only the schema's version):
        #
        #   ActiveRecord::Schema[7.0].define(version: 2038_01_19_000001) do
        #     ...
        #   end
        def define(info = {}, &block)
          new.define(info, &block)
        end
      end

      def define(info, &block) # :nodoc:
        instance_eval(&block)

        if info[:version].present?
          connection.schema_migration.create_table
          connection.assume_migrated_upto_version(info[:version])
        end

        ActiveRecord::InternalMetadata.create_table
        ActiveRecord::InternalMetadata[:environment] = connection.migration_context.current_environment
      end
    end

    include Definition

    def self.[](version)
      @class_for_version ||= {}
      @class_for_version[version] ||= Class.new(Migration::Compatibility.find(version)) do
        include Definition
      end
    end
  end
end
