DROP TYPE IF EXISTS {{ conn|qtIdent(data.schema, data.name) }}{% if cascade%} CASCADE{% endif %};
