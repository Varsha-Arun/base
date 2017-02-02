do $$
  begin

    -- Remove vault systemIntegration
    delete from "systemIntegrations" where "name" = 'vault';

    -- Remove amazons3 systemIntegration
    delete from "systemIntegrations" where "name" = 'amazons3';

    -- Remove masterIntegrationFields for Vault
    delete from "masterIntegrationFields" where "masterIntegrationId"= (select id from "masterIntegrations" where "typeCode" = 5006 and
  "name" = 'VAULT');

   -- Remove old masterIntegrationFields from amazons3
   delete from "masterIntegrationFields" where "masterIntegrationId"= (select id from "masterIntegrations" where "typeCode" = 5005 and
 "name" = 'amazons3');

    -- Remove amazons3 masterIntegration
    delete from "masterIntegrations" where "typeCode" = 5005 and "name" = 'amazons3';

    -- Remove vault masterIntegration
    delete from "masterIntegrations" where "typeCode" = 5006 and "name" = 'VAULT';

    -- Remove old masterIntegrationFields from github auth
    delete from "masterIntegrationFields" where id in (76, 77, 78);

    -- Remove redundant masterIntegrationFields from bitbucket auth
    delete from "masterIntegrationFields" where id in (82, 83, 84);

    -- Remove old masterIntegrationFields from bitbucket server auth
    delete from "masterIntegrationFields" where id in (95, 96, 98, 99, 100, 101);

    -- Remove old masterIntegrationFields from github enterprise auth
    delete from "masterIntegrationFields" where id in (104, 105, 106);

    -- Remove systemCodes.id and set code as primary key
    if exists (select 1 from information_schema.columns where table_name = 'systemCodes' and column_name = 'id') then
      alter table "systemCodes" drop column id;
      alter table "systemCodes" add constraint "systemCodes_pkey" primary key (code);
    end if;

    -- Remove systemProperties.id and set fieldName as primary key
    if exists (select 1 from information_schema.columns where table_name = 'systemProperties' and column_name = 'id') then
      alter table "systemProperties" drop column id;
      alter table "systemProperties" add constraint "systemProperties_pkey" primary key ("fieldName");
    end if;

    -- Update  systemMachineImages.systemIntegrationId and set allowedNull to true
    if exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'systemIntegrationId') then
      alter table "systemMachineImages" alter column "systemIntegrationId" drop not null;
    end if;

    -- insert all systemCodes
    if not exists (select 1 from "systemCodes" where code = 1000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1000, 'gitRepo', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1001) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1001, 'image', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1003) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1003, 'dockerOptions', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1004) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1004, 'params', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1006) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1006, 'replicas', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1008) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1008, 'kickStart', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1010) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1010, 'time', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1012) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1012, 'version', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1013) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1013, 'trigger', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1014) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1014, 'syncRepo', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1015) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1015, 'cluster', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1016) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1016, 'notification', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1017) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1017, 'loadBalancer', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1018) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1018, 'integration', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1019) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1019, 'file', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 1020) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1020, 'ciRepo', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2000, 'manifest', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2005) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2005, 'runCI', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2007) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2007, 'runSh', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2008) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2008, 'release', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2009) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2009, 'rSync', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2010) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2010, 'deploy', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2011) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2011, 'jenkinsJob', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2012) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2012, 'ciJob', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 2013) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2013, 'provision', 'resource', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 4000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4000, 'queued', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4001) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4001, 'processing', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4002) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4002, 'success', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4003) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4003, 'failure', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4004) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4004, 'error', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4005) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4005, 'waiting', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4006) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4006, 'cancelled', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4007) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4007, 'unstable', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;
    if not exists (select 1 from "systemCodes" where code = 4008) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4008, 'skipped', 'status', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5000, 'scm', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5001) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5001, 'hub', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5002) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5002, 'deploy', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5003) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5003, 'notification', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5004) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5004, 'key', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5005) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5005, 'cloudproviders', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5006) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5006, 'secretsBackend', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5007) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5007, 'auth', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5008) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5008, 'payment', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5009) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5009, 'externalci', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5010) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5010, 'artifact', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 5011) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5011, 'mktg', 'integration', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 0) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (0, 'WAITING', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 10) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (10, 'QUEUED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 20) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (20, 'PROCESSING', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 30) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (30, 'SUCCESS', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 40) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (40, 'SKIPPED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 50) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (50, 'UNSTABLE', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 60) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (60, 'TIMEOUT', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 70) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (70, 'CANCELED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 80) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (80, 'FAILED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 90) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (90, 'STOPPED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 100) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (100, 'NOTINITIALIZED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 101) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (101, 'NOTDEPLOYED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 110) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (110, 'DELETING', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 120) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (120, 'DELETED', 'statusCodes', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6000, 'member', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6010) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6010, 'collaborator', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6020) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6020, 'admin', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Codes for system-level roles
    if not exists (select 1 from "systemCodes" where code = 6040) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6040, 'publicUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6050) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6050, 'freeUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6060) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6060, 'justUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6070) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6070, 'opsUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6080) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6080, 'superUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6090) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6090, 'betaUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 6100) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6100, 'serviceUser', 'roles', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Codes for nodeType
    if not exists (select 1 from "systemCodes" where code = 7000) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (7000, 'custom', 'nodeType', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 7001) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (7001, 'dynamic', 'nodeType', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemCodes" where code = 7002) then
      insert into "systemCodes" ("code", "name", "group", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (7002, 'system', 'nodeType', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- insert all systemProperties
    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysUserName') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysUserName', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysPassword') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysPassword', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysDeployKey') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysDeployKey', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysDeployKeyExternalId') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysDeployKeyExternalId', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysWebhookExternalId') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysWebhookExternalId', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'processQueue') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('processQueue', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'registryUserName') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('registryUserName', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'registryAccessKey') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('registryAccessKey', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'registrySecretKey') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('registrySecretKey', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'nodeUserName') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('nodeUserName', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'nodePassword') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('nodePassword', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'execQueue') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('execQueue', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'sshPrivateKey') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sshPrivateKey', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'deployPrivateKey') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('deployPrivateKey', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemProperties" where "fieldName" = 'webhookSecret') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('webhookSecret', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    -- insert all masterIntegrations
    -- Git Store
    if not exists (select 1 from "masterIntegrations" where "name" = 'Git store' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('574ee696d49b091400b75f19', 1, 'Git store', 'Internal Gitlab Server', 'scm', true, 'system', 5000, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Git Store
    if not exists (select 1 from "masterIntegrationFields" where "id" = 1) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (1, '574ee696d49b091400b75f19', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 2) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (2, '574ee696d49b091400b75f19', 'password', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 3) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (3, '574ee696d49b091400b75f19', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Docker
    if not exists (select 1 from "masterIntegrations" where "name" = 'Docker' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5553a7ac3566980c00a3bf0e', 2, 'Docker', 'Docker', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Docker
    if not exists (select 1 from "masterIntegrationFields" where "id" = 4) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (4, '5553a7ac3566980c00a3bf0e', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 5) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (5, '5553a7ac3566980c00a3bf0e', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 6) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (6, '5553a7ac3566980c00a3bf0e', 'email', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Private Docker Registry
    if not exists (select 1 from "masterIntegrations" where "name" = 'Private Docker Registry' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('559e8f3e90252e0c00672376', 3, 'Private Docker Registry', 'Private Docker Registry', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Private Docker Registry
    if not exists (select 1 from "masterIntegrationFields" where "id" = 7) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (7, '559e8f3e90252e0c00672376', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 8) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (8, '559e8f3e90252e0c00672376', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 9) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (9, '559e8f3e90252e0c00672376', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 10) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (10, '559e8f3e90252e0c00672376', 'email', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- slack
    if not exists (select 1 from "masterIntegrations" where "name" = 'Slack' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('55bba7932c6c780b00e4426c', 4, 'Slack', 'Slack', 'notification', true, 'account', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Slack
    if not exists (select 1 from "masterIntegrationFields" where "id" = 11) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (11, '55bba7932c6c780b00e4426c', 'webhookUrl', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- webhook
    if not exists (select 1 from "masterIntegrations" where "name" = 'webhook' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('573aab7c5419f10f00bef322', 5, 'webhook', 'Event Trigger', 'notification', true, 'account', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for webhook
    if not exists (select 1 from "masterIntegrationFields" where "id" = 13) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (13, '573aab7c5419f10f00bef322', 'project', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 14) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (14, '573aab7c5419f10f00bef322', 'webhookURL', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 15) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (15, '573aab7c5419f10f00bef322', 'authorization', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- GCR
    if not exists (select 1 from "masterIntegrations" where "name" = 'GCR' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5553a8333566980c00a3bf1b', 6, 'GCR', 'GCR', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Braintree
    if not exists (select 1 from "masterIntegrations" where "name" = 'braintree' and "typeCode" = 5008) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57aafd0673ea26cb053fe1ca', 32, 'braintree', 'braintree', 'payment', true, 'system', 5008, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for GCR
    if not exists (select 1 from "masterIntegrationFields" where "id" = 16) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (16, '5553a8333566980c00a3bf1b', 'JSON_key', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- ECR
    if not exists (select 1 from "masterIntegrations" where "name" = 'ECR' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5673c6561895ca4474669507', 7, 'ECR', 'Amazon ECR', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for ECR
    if not exists (select 1 from "masterIntegrationFields" where "id" = 17) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (17, '5673c6561895ca4474669507', 'aws_access_key_id', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 18) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (18, '5673c6561895ca4474669507', 'aws_secret_access_key', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- AWS
    if not exists (select 1 from "masterIntegrations" where "name" = 'AWS' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('55c8d2333399590c007982f8', 8, 'AWS', 'AWS', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for AWS
    if not exists (select 1 from "masterIntegrationFields" where "id" = 19) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (19, '55c8d2333399590c007982f8', 'aws_access_key_id', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 20) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (20, '55c8d2333399590c007982f8', 'aws_secret_access_key', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 22) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (22, '55c8d2333399590c007982f8', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- AWS_IAM
    if not exists (select 1 from "masterIntegrations" where "name" = 'AWS_IAM' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('571032a897aadea0ee186900', 9, 'AWS_IAM', 'Amazon Web Services (IAM)', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-23', '2016-06-23');
    end if;

    -- masterIntegrationFields for AWS_IAM
    if not exists (select 1 from "masterIntegrationFields" where "id" = 24) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (24, '571032a897aadea0ee186900', 'assumeRoleARN', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-23', '2016-06-23');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 26) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (26, '571032a897aadea0ee186900', 'output', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-23', '2016-06-23');
    end if;
    if not exists (select 1 from "masterIntegrationFields" where "id" = 27) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (27, '571032a897aadea0ee186900', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-23', '2016-06-23');
    end if;

    -- AWS-ROOT
    if not exists (select 1 from "masterIntegrations" where "name" = 'AWS' and "typeCode" = 5005) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57467326b3cbfc0c004f9110', 10, 'AWS', 'AWS-ROOT', 'cloudproviders', true, 'system', 5005, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for AWS-ROOT
    if not exists (select 1 from "masterIntegrationFields" where "id" = 28) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (28, '57467326b3cbfc0c004f9110', 'accessKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 29) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (29, '57467326b3cbfc0c004f9110', 'secretKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- GKE
    if not exists (select 1 from "masterIntegrations" where "name" = 'GKE' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d417653270aa438861cf65', 11, 'GKE', 'Google Container Engine', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

     -- masterIntegrationFields for GKE
    if not exists (select 1 from "masterIntegrationFields" where "id" = 30) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (30, '56d417653270aa438861cf65', 'JSON_key', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 31) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (31, '56d417653270aa438861cf65', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- DCL
    if not exists (select 1 from "masterIntegrations" where "name" = 'DCL' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('570651b5f028a50b008bd955', 12, 'DCL', 'Docker Cloud', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

     -- masterIntegrationFields for DCL
    if not exists (select 1 from "masterIntegrationFields" where "id" = 32) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (32, '570651b5f028a50b008bd955', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 33) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (33, '570651b5f028a50b008bd955', 'token', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 34) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (34, '570651b5f028a50b008bd955', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- ACS
    if not exists (select 1 from "masterIntegrations" where "name" = 'ACS' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5723561699ddf70c00be27ed', 13, 'ACS', 'Azure Container Service', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for ACS
    if not exists (select 1 from "masterIntegrationFields" where "id" = 35) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (35, '5723561699ddf70c00be27ed', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 36) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (36, '5723561699ddf70c00be27ed', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- ghe
    if not exists (select 1 from "masterIntegrations" where "name" = 'ghe' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('563347d6046d220c002a3474', 15, 'ghe', 'Github Enterprise', 'scm', true, 'account', 5000, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for ghe
    if not exists (select 1 from "masterIntegrationFields" where "id" = 39) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (39, '563347d6046d220c002a3474', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 40) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (40, '563347d6046d220c002a3474', 'token', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- bitbucket
    if not exists (select 1 from "masterIntegrations" where "name" = 'bitbucket' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('562dc347b84b390c0083e72e', 16, 'bitbucket', 'BitBucket', 'scm', true, 'account', 5000, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for bitbucket
    if not exists (select 1 from "masterIntegrationFields" where "id" = 41) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (41, '562dc347b84b390c0083e72e', 'token', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 42) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (42, '562dc347b84b390c0083e72e', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Email
    if not exists (select 1 from "masterIntegrations" where "name" = 'Email' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('55816ffb4d96360c000ec6f3', 18, 'Email', 'Email', 'notification', true, 'account', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Email
    if not exists (select 1 from "masterIntegrationFields" where "id" = 44) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (44, '55816ffb4d96360c000ec6f3', 'Email address', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Quay.io
    if not exists (select 1 from "masterIntegrations" where "name" = 'Quay.io' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('559eab320a31140d00a15d3a', 19, 'Quay.io', 'Quay.io', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Quay.io
    if not exists (select 1 from "masterIntegrationFields" where "id" = 45) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (45, '559eab320a31140d00a15d3a', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 46) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (46, '559eab320a31140d00a15d3a', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 47) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (47, '559eab320a31140d00a15d3a', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 48) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (48, '559eab320a31140d00a15d3a', 'email', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 49) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (49, '559eab320a31140d00a15d3a', 'accessToken', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- github
    if not exists (select 1 from "masterIntegrations" where "name" = 'github' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('562dc2f048095b0d00ceebcd', 20, 'github', 'GitHub', 'scm', true, 'account', 5000, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for github
    if not exists (select 1 from "masterIntegrationFields" where "id" = 50) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (50, '562dc2f048095b0d00ceebcd', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 51) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (51, '562dc2f048095b0d00ceebcd', 'token', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- gitlab
    if not exists (select 1 from "masterIntegrations" where "name" = 'gitlab' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5728e13b3d93990c000fd8e4', 21, 'gitlab', 'GitLab', 'scm', true, 'account', 5000,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for gitlab
    if not exists (select 1 from "masterIntegrationFields" where "id" = 52) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (52, '5728e13b3d93990c000fd8e4', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 53) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (53, '5728e13b3d93990c000fd8e4', 'token', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- bitbucketServer
    if not exists (select 1 from "masterIntegrations" where "name" = 'bitbucketServer' and "typeCode" = 5000) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('572af430ead9631100f7f64d', 22, 'bitbucketServer', 'BitBucket Server', 'scm', true, 'account', 5000, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for bitbucketServer
    if not exists (select 1 from "masterIntegrationFields" where "id" = 54) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (54, '572af430ead9631100f7f64d', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 55) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (55, '572af430ead9631100f7f64d', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 56) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (56, '572af430ead9631100f7f64d', 'token', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- ssh-key
    if not exists (select 1 from "masterIntegrations" where "name" = 'ssh-key' and "typeCode" = 5004) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('568aa7c3368a090c006da702', 23, 'ssh-key', 'SSH Key', 'key', true, 'account', 5004, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for ssh-key
    if not exists (select 1 from "masterIntegrationFields" where "id" = 57) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (57, '568aa7c3368a090c006da702', 'publicKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 58) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (58, '568aa7c3368a090c006da702', 'privateKey', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- pem-key
    if not exists (select 1 from "masterIntegrations" where "name" = 'pem-key' and "typeCode" = 5004) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('568aa74cd43b0d0c004fec91', 24, 'pem-key', 'PEM Key', 'key', true, 'account', 5004, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for pem-key
    if not exists (select 1 from "masterIntegrationFields" where "id" = 59) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (59, '568aa74cd43b0d0c004fec91', 'key', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- hipchat
    if not exists (select 1 from "masterIntegrations" where "name" = 'hipchat' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56fb978f1cc7210f00bd5e72', 25, 'hipchat', 'HipChat', 'notification', true, 'account', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for hipchat
    if not exists (select 1 from "masterIntegrationFields" where "id" = 60) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (60, '56fb978f1cc7210f00bd5e72', 'token', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Docker Trusted Registry
    if not exists (select 1 from "masterIntegrations" where "name" = 'Docker Trusted Registry' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57110b987ed9d269c9d71ac1', 26, 'Docker Trusted Registry', 'Docker Trusted Registry', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Docker Trusted Registry
    if not exists (select 1 from "masterIntegrationFields" where "id" = 61) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (61, '57110b987ed9d269c9d71ac1', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 62) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (62, '57110b987ed9d269c9d71ac1', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 63) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (63, '57110b987ed9d269c9d71ac1', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 64) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (64, '57110b987ed9d269c9d71ac1', 'email', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- DDC
    if not exists (select 1 from "masterIntegrations" where "name" = 'DDC' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('571f081b37803a0d00455d25', 27, 'DDC', 'Docker DataCenter', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for DDC
    if not exists (select 1 from "masterIntegrationFields" where "id" = 65) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (65, '571f081b37803a0d00455d25', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 66) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (66, '571f081b37803a0d00455d25', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 67) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (67, '571f081b37803a0d00455d25', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- TRIPUB
    if not exists (select 1 from "masterIntegrations" where "name" = 'TRIPUB' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('576ce63321333398d11a35ab', 28, 'TRIPUB', 'Joyent Triton Public Cloud ', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for TRIPUB
    if not exists (select 1 from "masterIntegrationFields" where "id" = 68) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (68, '576ce63321333398d11a35ab', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 69) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (69, '576ce63321333398d11a35ab', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 70) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (70, '576ce63321333398d11a35ab', 'validityPeriod', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 71 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 71;
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 71) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (71, '576ce63321333398d11a35ab', 'publicKey', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 72 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 72;
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 72) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (72, '576ce63321333398d11a35ab', 'privateKey', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 73 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 73;
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 73) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (73, '576ce63321333398d11a35ab', 'certificates', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- github auth
    if not exists (select 1 from "masterIntegrations" where "name" = 'github' and "typeCode" = 5007) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('577de63321333398d11a35ac', 30, 'github', 'github auth', 'auth', true, 'system', 5007, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for github auth
    if not exists (select 1 from "masterIntegrationFields" where "id" = 74) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (74, '577de63321333398d11a35ac', 'clientId', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 75) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (75, '577de63321333398d11a35ac', 'clientSecret', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 111) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (111, '577de63321333398d11a35ac', 'wwwUrl', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 79) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (79, '577de63321333398d11a35ac', 'providerId', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 79 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 79;
    end if;

    -- bitbucket auth
    if not exists (select 1 from "masterIntegrations" where "name" = 'bitbucket' and "typeCode" = 5007) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('577de63321333398d11a35ad', 31, 'bitbucket', 'bitbucket auth', 'auth', true, 'system', 5007, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for bitbucket auth
    if not exists (select 1 from "masterIntegrationFields" where "id" = 80) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (80, '577de63321333398d11a35ad', 'clientId', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 81) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (81, '577de63321333398d11a35ad', 'clientSecret', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 108) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (108, '577de63321333398d11a35ad', 'wwwUrl', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 85) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (85, '577de63321333398d11a35ad', 'providerId', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 85 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 85;
    end if;

    -- SMTP
    if not exists (select 1 from "masterIntegrations" where "name" = 'SMTP' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57cea8056ce9c71800d31ab3', 33, 'SMTP', 'SMTP', 'notification', true, 'system', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for SMTP
    if not exists (select 1 from "masterIntegrationFields" where "id" = 86) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (86, '57cea8056ce9c71800d31ab3', 'emailAuthUser', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 87) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (87, '57cea8056ce9c71800d31ab3', 'emailAuthPassword', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 88) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (88, '57cea8056ce9c71800d31ab3', 'emailSender', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 126) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (126, '57cea8056ce9c71800d31ab3', 'host', 'string', true, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 127) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (127, '57cea8056ce9c71800d31ab3', 'port', 'string', true, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 128) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (128, '57cea8056ce9c71800d31ab3', 'secure', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 129) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (129, '57cea8056ce9c71800d31ab3', 'hostname', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 130) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (130, '57cea8056ce9c71800d31ab3', 'proxy', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- bitbucket server auth
    if not exists (select 1 from "masterIntegrations" where "name" = 'bitbucketServer' and "typeCode" = 5007) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('577de63321333398d11a35ae', 35, 'bitbucketServer', 'bitbucket server auth', 'auth', true, 'system', 5007, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for bitbucket server auth
    if not exists (select 1 from "masterIntegrationFields" where "id" = 93) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (93, '577de63321333398d11a35ae', 'clientId', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 94) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (94, '577de63321333398d11a35ae', 'clientSecret', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 109) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (109, '577de63321333398d11a35ae', 'wwwUrl', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 97) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (97, '577de63321333398d11a35ae', 'providerId', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 97 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 97;
    end if;

    -- github enterprise auth

    -- rename from githubEnterprise to ghe if it exists
    if exists (select 1 from "masterIntegrations" where "id" = '507f1f77bcf86cd799439011' and "name" = 'githubEnterprise') then
      update "masterIntegrations" set name = 'ghe' where "id" = '507f1f77bcf86cd799439011';
    end if;

    if not exists (select 1 from "masterIntegrations" where "name" = 'ghe' and "typeCode" = 5007) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('507f1f77bcf86cd799439011', 36, 'ghe', 'github enterprise auth', 'auth', true, 'system', 5007, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for github enterprise
    if not exists (select 1 from "masterIntegrationFields" where "id" = 102) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (102, '507f1f77bcf86cd799439011', 'clientId', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 103) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (103, '507f1f77bcf86cd799439011', 'clientSecret', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 110) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (110, '507f1f77bcf86cd799439011', 'wwwUrl', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 107) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (107, '507f1f77bcf86cd799439011', 'providerId', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if exists (select 1 from "masterIntegrationFields" where "id" = 107 and "isRequired" = true) then
      update "masterIntegrationFields" set "isRequired" = false where "id" = 107;
    end if;

    -- JENKINS
    if not exists (select 1 from "masterIntegrations" where "name" = 'Jenkins' and "typeCode" = 5009) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57dbab5d15c59206bf4fbb50', 37, 'Jenkins', 'Jenkins', 'externalci', true, 'account', 5009, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for JENKINS
    if not exists (select 1 from "masterIntegrationFields" where "id" = 112) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (112, '57dbab5d15c59206bf4fbb50', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 113) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (113, '57dbab5d15c59206bf4fbb50', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 114) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (114, '57dbab5d15c59206bf4fbb50', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- artifactory
    if not exists (select 1 from "masterIntegrations" where "name" = 'artifactory' and "typeCode" = 5001) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57dbab5d15c59206bf4fbb51', 38, 'artifactory', 'JFrog Artifactory', 'hub', true, 'account', 5001, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for artifactory
    if not exists (select 1 from "masterIntegrationFields" where "id" = 115) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (115, '57dbab5d15c59206bf4fbb51', 'username', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 116) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (116, '57dbab5d15c59206bf4fbb51', 'password', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 117) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (117, '57dbab5d15c59206bf4fbb51', 'url', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- CLUSTER
    if not exists (select 1 from "masterIntegrations" where "name" = 'CLUSTER' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('576ce63321333398d11a35ac', 39, 'CLUSTER', 'Node Cluster', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for CLUSTER
    if not exists (select 1 from "masterIntegrationFields" where "id" = 118) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (118, '576ce63321333398d11a35ac', 'nodes', 'array', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 119) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (119, '576ce63321333398d11a35ac', 'publicKey', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 120) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (120, '576ce63321333398d11a35ac', 'privateKey', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Mailgun
    if not exists (select 1 from "masterIntegrations" where "name" = 'mailgun' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57e8ea91424bff9c871d7321', 40, 'mailgun', 'Mailgun', 'notification', true, 'system', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Mailgun
    if not exists (select 1 from "masterIntegrationFields" where "id" = 121) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (121, '57e8ea91424bff9c871d7321', 'apiKey', 'string', true, true, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 122) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (122, '57e8ea91424bff9c871d7321', 'domain', 'string', true, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 123) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (123, '57e8ea91424bff9c871d7321', 'proxy', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 131) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (131, '57e8ea91424bff9c871d7321', 'emailSender', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Gmail
    if not exists (select 1 from "masterIntegrations" where "name" = 'gmail' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57e8ea9c14d3ef88e56fecb4', 41, 'gmail', 'Gmail', 'notification', true, 'system', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Gmail
    if not exists (select 1 from "masterIntegrationFields" where "id" = 124) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (124, '57e8ea9c14d3ef88e56fecb4', 'username', 'string', true, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 125) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (125, '57e8ea9c14d3ef88e56fecb4', 'password', 'string', true, true, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 132) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (132, '57e8ea9c14d3ef88e56fecb4', 'proxy', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 133) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values (133, '57e8ea9c14d3ef88e56fecb4', 'emailSender', 'string', false, false, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- S3
    if not exists (select 1 from "masterIntegrations" where "name" = 'S3' and "typeCode" = 5010) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57e8ea9c14d3ef88e56fecb5', 42, 'S3', 'Amazon S3', 'artifact', true, 'system', 5010, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for S3

    if not exists (select 1 from "masterIntegrationFields" where "id" = 134) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (134, '57e8ea9c14d3ef88e56fecb5', 'accessKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 135) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (135, '57e8ea9c14d3ef88e56fecb5', 'secretKey', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 136) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (136, '57e8ea9c14d3ef88e56fecb5', 'region', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Hubspot
      if not exists (select 1 from "masterIntegrations" where "name" = 'hubspot' and "typeCode" = 5011) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5811a2e9e73d22829eb0ab3c', 43, 'hubspot', 'Hubspot', 'mktg', true, 'system', 5011, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for Hubspot

    if not exists (select 1 from "masterIntegrationFields" where "id" = 141) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (141, '5811a2e9e73d22829eb0ab3c', 'hubspotApiEndPoint', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 142) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (142, '5811a2e9e73d22829eb0ab3c', 'hubspotApiToken', 'string', true, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- irc
    if not exists (select 1 from "masterIntegrations" where "name" = 'irc' and "typeCode" = 5003) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('57e8ea9c14d3ef88e56fecb6', 44, 'irc', 'irc', 'notification', true, 'account', 5003, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- kubernetes
    if not exists (select 1 from "masterIntegrations" where "name" = 'KUBERNETES' and "typeCode" = 5002) then
      insert into "masterIntegrations" ("id", "masterIntegrationId", "name", "displayName", "type", "isEnabled", "level", "typeCode", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('5811a2e9e73d22829eb0ab3d', 45, 'KUBERNETES', 'Kubernetes', 'deploy', true, 'account', 5002, '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- masterIntegrationFields for kubernetes
    if not exists (select 1 from "masterIntegrationFields" where "id" = 143) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (143, '5811a2e9e73d22829eb0ab3d', 'clusterAccessType', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 144) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (144, '5811a2e9e73d22829eb0ab3d', 'masterKubeConfigContent', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 145) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (145, '5811a2e9e73d22829eb0ab3d', 'bastionHostIP', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 146) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (146, '5811a2e9e73d22829eb0ab3d', 'bastionKubeConfigType', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 147) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (147, '5811a2e9e73d22829eb0ab3d', 'bastionKubeConfigContent', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 148) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (148, '5811a2e9e73d22829eb0ab3d', 'bastionPublicKey', 'string', false, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 149) then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (149, '5811a2e9e73d22829eb0ab3d', 'bastionPrivateKey', 'string', false, true,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Add systemImages

    if not exists (select 1 from "systemImages" where "systemImageId" = 1) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('565c404911614a47280079d8', 1, 'shippable/minv2', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 2) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4164e71e4ea0c00a87562', 2, 'drydock/u12nod', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 3) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4165571e4ea0c00a876ab', 3, 'drydock/u12pyt', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 4) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4165c71e4ea0c00a87815', 4, 'drydock/u12jav', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 5) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d416622d28670c0001d9e5', 5, 'drydock/u12sca', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 6) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4166821e3800d00186af0', 6, 'drydock/u12rub', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 7) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4166d2d28670c0001daf9', 7, 'drydock/u12php', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 8) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d416742d28670c0001de37', 8, 'drydock/u12gol', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 9) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4167a71e4ea0c00a87e97', 9, 'drydock/u12clo', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 10) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4167f21e3800d00186eb1', 10, 'drydock/u14nod', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 11) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4168421e3800d001871b9', 11, 'drydock/u14pyt', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 12) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d416882d28670c0001e5d4', 12, 'drydock/u14jav', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 13) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4168e8d5d8b0d003ba048', 13, 'drydock/u14sca', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 14) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d416922d28670c0001e9c1', 14, 'drydock/u14rub', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 15) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4169821e3800d001876c0', 15, 'drydock/u14php', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 16) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4169d2d28670c0001eecb', 16, 'drydock/u14gol', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 17) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d416a321e3800d00187afd', 17, 'drydock/u14clo', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 18) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d447d362e4000d0072fded', 18, 'drydock/u12nodpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 19) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d447e070def30c00cb9bd2', 19, 'drydock/u12nodall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 20) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d447ed70def30c00cba197', 20, 'drydock/u12pytpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 21) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d447f570def30c00cba434', 21, 'drydock/u12pytall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 22) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4480270def30c00cba8a1', 22, 'drydock/u12javpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 23) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4480b70def30c00cbaaf7', 23, 'drydock/u12javall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 24) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4481670def30c00cbad96', 24, 'drydock/u12scapls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 25) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4481d7ba0490c008571cd', 25, 'drydock/u12scaall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 26) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4482362e4000d00731976', 26, 'drydock/u12rubpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 27) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4482970def30c00cbb19b', 27, 'drydock/u12ruball', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 28) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4482f7ba0490c008575bb', 28, 'drydock/u12phppls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 29) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4483762e4000d00731e7d', 29, 'drydock/u12phpall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 30) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4483e62e4000d00731ff0', 30, 'drydock/u12golpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 31) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4484562e4000d00732325', 31, 'drydock/u12golall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 32) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448527ba0490c00857b1e', 32, 'drydock/u12clopls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 33) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4485b70def30c00cbbfbc', 33, 'drydock/u12cloall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 34) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4486562e4000d00732a3a', 34, 'drydock/u14nodpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 35) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4486c62e4000d00732c21', 35, 'drydock/u14nodall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 36) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4487870def30c00cbc5b1', 36, 'drydock/u14pytpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 37) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d44881805a410c003a5b6c', 37, 'drydock/u14pytall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 38) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4489b70def30c00cbd5b0', 38, 'drydock/u14javpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 39) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448a470def30c00cbda5f', 39, 'drydock/u14javall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 40) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448c070def30c00cbe87e', 40, 'drydock/u14scapls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 41) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448c970def30c00cbea2b', 41, 'drydock/u14scaall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 42) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448e070def30c00cc06e7', 42, 'drydock/u14rubpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 43) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448e870def30c00cc0f11', 43, 'drydock/u14ruball', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 44) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448ed70def30c00cc164e', 44, 'drydock/u14phppls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 45) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448f470def30c00cc1aca', 45, 'drydock/u14phpall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 46) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d448fc70def30c00cc235f', 46, 'drydock/u14golpls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 47) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4490470def30c00cc2d0d', 47, 'drydock/u14golall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 48) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4490b70def30c00cc32fe', 48, 'drydock/u14clopls', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 49) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('56d4491570def30c00cc3ae1', 49, 'drydock/u14cloall', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 50) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('570631d5c72afc0c00c3cd54', 50, 'drydock/u14cpp', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "systemImages" where "systemImageId" = 51) then
      insert into "systemImages" ("id", "systemImageId", "name", "isActive","createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('570631e08317100c00ef87b9', 51, 'drydock/u12cpp', true, '540e7735399939140041d885', '540e7735399939140041d885', '2016-06-01', '2016-06-01');
    end if;

    -- Add sourceName to resources and migrate name to sourceName
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'sourceName') then
      alter table "resources" add column "sourceName" varchar(255);
      UPDATE "resources" SET "sourceName" = "name";
    end if;

    -- Add lastVersionId and lastVersionName columns to resources
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'lastVersionId') then
      alter table "resources" add column "lastVersionId" INTEGER;
    end if;

    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'lastVersionName') then
      alter table "resources" add column "lastVersionName" varchar(255);
    end if;

    -- Update lastVersionId and lastVersionName in resources
    if not exists (select 1 from pg_constraint where conname = 'resources_lastVersionId_fkey') then
      update resources as r set "lastVersionId"=(select id from versions where "versionNumber"=r."lastVersionNumber" and "resourceId"=r.id), "lastVersionName"=(select "versionName" from versions where "versionNumber"=r."lastVersionNumber" and "resourceId"=r.id);
    end if;

    -- Add sysIntegrationName to systemProperties
    if not exists (select 1 from "systemProperties" where "fieldName" = 'sysIntegrationName') then
      insert into "systemProperties" ("fieldName", "createdBy", "updatedBy", "createdAt", "updatedAt")
      values ('sysIntegrationName', '54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a',  '2016-06-01', '2016-06-01');
    end if;

    -- Add subscriptionIntegrationId to resources
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'subscriptionIntegrationId') then
      alter table "resources" add column "subscriptionIntegrationId" integer;
    end if;

    -- Add projectId to resources
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'projectId') then
      alter table "resources" add column "projectId" varchar(24);
    end if;

    -- Add nextTriggerTime to resources
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'nextTriggerTime') then
      alter table "resources" add column "nextTriggerTime" timestamp with time zone;
    end if;

    -- Add resourceNextTriggerTimeI Index on resources
    if not exists (select 1 from pg_indexes where tablename = 'resources' and indexname = 'resourceNextTriggerTimeI') then
      create index "resourceNextTriggerTimeI" on "resources" using btree("nextTriggerTime");
    end if;

    -- Add subsIntPermsProjIdI Index on subscriptionIntegrationPermissions
    if not exists (select 1 from pg_indexes where tablename = 'subscriptionIntegrationPermissions' and indexname = 'subsIntPermsProjIdI') then
      create index "subsIntPermsProjIdI" on "subscriptionIntegrationPermissions" using btree("projectId");
    end if;

    -- Remove accountIntegrationId in resources
    if exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'accountIntegrationId') then
      alter table "resources" drop column "accountIntegrationId";
    end if;

    -- Remove isJobStep in resources
    if exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'isJobStep') then
      alter table "resources" drop column "isJobStep";
    end if;

    -- Change jobLengthInMS of dailyAggs from int to big int
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobLengthInMS' and data_type = 'int') then
      alter table "dailyAggs" ALTER COLUMN "jobLengthInMS" type bigint;
    end if;

    -- Change jobLengthInMS of dailyAggs from int to big int
    if exists (select 1 from information_schema.columns where table_name = 'projectDailyAggs' and column_name = 'jobLengthInMS' and data_type = 'int') then
      alter table "projectDailyAggs" ALTER COLUMN "jobLengthInMS" type bigint;
    end if;

  -- Make "formJSONValues" nullable in systemIntegrations table
    if exists (select 1 from information_schema.columns where table_name = 'systemIntegrations' and column_name = 'formJSONValues') then
      alter table "systemIntegrations" alter column "formJSONValues" drop not null;
    end if;

    -- Add isConsistent to resources and set it as false
    if not exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'isConsistent') then
      alter table "resources" add column "isConsistent" boolean NOT NULL DEFAULT false;
    end if;
    if exists (select 1 from information_schema.columns where table_name = 'resources' and column_name = 'isConsistent' and column_default IS NULL) then
      alter table "resources" alter column "isConsistent" SET DEFAULT false;
      update "resources" set "isConsistent"=false WHERE "isConsistent" IS NULL;
      alter table "resources" alter column "isConsistent" SET NOT NULL;
    end if;

    -- Set default values true for buildJobs.isSerial
    if exists (select 1 from information_schema.columns where table_name = 'buildJobs' and column_name = 'isSerial' and column_default IS NOT NULL) then
      alter table "buildJobs" alter column "isSerial" SET DEFAULT true;
    end if;

    -- Add execImage column to systemMachineImages
    if not exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'execImage') then
      alter table "systemMachineImages" add column "execImage" varchar(80);
      update "systemMachineImages" set "execImage"='shipimg/mexec:master.3859' where "execImage" is null;
      alter table "systemMachineImages" alter column "execImage" set not null;
    end if;

    -- Add runShImage column to systemMachineImages
    if not exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'runShImage') then
      alter table "systemMachineImages" add column "runShImage" varchar(80);
      update "systemMachineImages" set "runShImage"='shipimg/micro50:stepExec.server.6262' where "runShImage" is null;
      alter table "systemMachineImages" alter column "runShImage" set not null;
    end if;

    -- Add execImage column to systemConfigs
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'execImage') then
      alter table "systemConfigs" add column "execImage" varchar(255);
      update "systemConfigs" set "execImage"='shipimg/mexec:master.3859' where "execImage" is null;
      alter table "systemConfigs" alter column "execImage" set not null;
    end if;

    -- Add versionName to versions
    if not exists (select 1 from information_schema.columns where table_name = 'versions' and column_name = 'versionName') then
      alter table "versions" add column "versionName" varchar(255);
    end if;

    -- Add projectId to versions
    if not exists (select 1 from information_schema.columns where table_name = 'versions' and column_name = 'projectId') then
      alter table "versions" add column "projectId" varchar(24);
    end if;

    -- Add github in providers
    if not exists (select 1 from "providers" where "url" = 'https://api.github.com') then
      insert into "providers" ("id", "masterIntegrationId", "url", "name", "createdAt", "updatedAt")
      values ('562dbd9710c5980d003b0451', '562dc2f048095b0d00ceebcd', 'https://api.github.com', 'github', '2016-02-29T00:00:00.000Z', '2016-02-29T00:00:00.000Z');
    end if;

    -- Add bitbucket in providers
    if not exists (select 1 from "providers" where "url" = 'https://bitbucket.org') then
      insert into "providers" ("id", "masterIntegrationId", "url", "name", "createdAt", "updatedAt")
      values ('562dbda348095b0d00ce6a43', '562dc347b84b390c0083e72e', 'https://bitbucket.org', 'bitbucket', '2016-02-29T00:00:00.000Z', '2016-02-29T00:00:00.000Z');
    end if;

    -- Make "sourceId" nullable in projects table
    if exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'sourceId') then
      alter table "projects" alter column "sourceId" drop not null;
    end if;

    -- change type of "sourceDefaultBranch" to varchar(255) in projects table
    if exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'sourceDefaultBranch') then
      alter table "projects" alter column "sourceDefaultBranch" type varchar(255);
    end if;

    -- Add "isInternal" to accountTokens table
    if not exists (select 1 from information_schema.columns where table_name = 'accountTokens' and column_name = 'isInternal') then
      alter table "accountTokens" add column "isInternal" BOOLEAN DEFAULT false;
    end if;

    -- Add "privateJobQuota" to subscriptions table
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'privateJobQuota') then
      alter table "subscriptions" add column "privateJobQuota" INTEGER;
      -- Initial default for existing rows
      update "subscriptions" set "privateJobQuota" = 150;
      alter table "subscriptions" alter column "privateJobQuota" set not null;
    end if;

    -- Add "privateJobCount" to subscriptions table
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'privateJobCount') then
      alter table "subscriptions" add column "privateJobCount" INTEGER default 0 not null;
    end if;
    -- Update "privateJobCount" columns without a default
    if exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'privateJobCount' and column_default is null) then
      alter table "subscriptions" alter column "privateJobCount" set DEFAULT 0;
    end if;

    -- Add "privateJobQuotaResetsAt" to subscriptions table
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'privateJobQuotaResetsAt') then
      alter table "subscriptions" add column "privateJobQuotaResetsAt" TIMESTAMP WITH TIME ZONE;
      -- Initial default for existing rows
      update "subscriptions" set "privateJobQuotaResetsAt" = '2016-09-01';
      alter table "subscriptions" alter column "privateJobQuotaResetsAt" set not null;
    end if;

    -- Drop not null constraint on formJSONValues for accountIntegrations
    if exists (select 1 from information_schema.columns where table_name = 'accountIntegrations' and column_name = 'formJSONValues') then
      alter table "accountIntegrations" alter column "formJSONValues" drop not null;
    end if;

    -- Update the name for masterIntegrationFields
    if exists (select 1 from "masterIntegrationFields" where "id" = 116) then
      update "masterIntegrationFields" set "name"='password' where "id"= 116;
    end if;

    -- Remove unused systemCodes
    delete from "systemCodes" where "code" = 1002 and "name" = 'ecsCluster' and "group" = 'resource';

    delete from "systemCodes" where "code" = 1005 and "name" = 'dclCluster' and "group" = 'resource';

    delete from "systemCodes" where "code" = 1007 and "name" = 'gkeCluster' and "group" = 'resource';

    delete from "systemCodes" where "code" = 1009 and "name" = 'ddcCluster' and "group" = 'resource';

    delete from "systemCodes" where "code" = 1011 and "name" = 'tripubCluster' and "group" = 'resource';

    delete from "systemCodes" where "code" = 2001 and "name" = 'ecsDeploy' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3001 and "name" = 'ecsDeploySteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 2003 and "name" = 'gkeDeploy' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3003 and "name" = 'gkeDeploySteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 2006 and "name" = 'tripubDeploy' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3006 and "name" = 'tripubDeploySteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 2002 and "name" = 'dclDeploy' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3002 and "name" = 'dclDeploySteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 2004 and "name" = 'ddcDeploy' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3004 and "name" = 'ddcDeploySteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3000 and "name" = 'manifestSteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3005 and "name" = 'runCISteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3007 and "name" = 'runShSteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3008 and "name" = 'releaseSteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3009 and "name" = 'rSyncSteps' and "group" = 'resource';

    delete from "systemCodes" where "code" = 3010 and "name" = 'deploySteps' and "group" = 'resource';

    -- Add braintreeSubscriptionId in subscriptions
     if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'braintreeSubscriptionId') then
       alter table "subscriptions" add column "braintreeSubscriptionId" character varying(255);
     end if;

    -- Add minionCount in subscriptions
     if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'minionCount') then
       alter table "subscriptions" add column "minionCount" integer NOT NULL DEFAULT 1;
     end if;

  -- Add pipelineCount in subscriptions
     if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'pipelineCount') then
       alter table "subscriptions" add column "pipelineCount" integer NOT NULL DEFAULT 1;
     end if;

  -- Add discount in transactions
     if not exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'discount') then
       alter table "transactions" add column "discount" numeric NOT NULL DEFAULT 0;
     end if;
  -- Update discount columns with the wrong type
     if exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'discount' and data_type = 'double precision') then
       alter table "transactions" alter column "discount" type numeric;
     end if;
  -- Update discount columns without a default
     if exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'discount' and column_default is null) then
       alter table "transactions" alter column "discount" set DEFAULT 0;
     end if;

  -- Add price in transactions
     if not exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'price') then
       alter table "transactions" add column "price" numeric NOT NULL DEFAULT 0;
     end if;
  -- Update price columns with the wrong type
     if exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'price' and data_type = 'double precision') then
       alter table "transactions" alter column "price" type numeric;
     end if;
  -- Update price columns without a default
     if exists (select 1 from information_schema.columns where table_name = 'transactions' and column_name = 'price' and column_default is null) then
       alter table "transactions" alter column "price" set DEFAULT 0;
     end if;

  -- Adds account details in accounts table
     if not exists (select 1 from "accounts" where "id" = '540e55445e5bad6f98764522') then
       insert into "accounts" ("id", "createdAt", "updatedAt")
       values ('540e55445e5bad6f98764522', '2016-02-29T00:00:00Z', '2016-02-29T00:00:00Z');
     end if;

   -- Adds accountRole for serviceUser
    if exists (select 1 from information_schema.columns where table_name = 'accountRoles') then
      if not exists (select 1 from "accountRoles" where "accountId" = '540e55445e5bad6f98764522' and "roleCode" = 6100) then
        insert into "accountRoles" ("accountId", "roleCode", "createdAt", "updatedAt")
        values ('540e55445e5bad6f98764522', 6100, '2016-02-29T00:00:00Z', '2016-02-29T00:00:00Z');
      end if;
    end if;

  -- Adds serviceUser token in accountTokens table for local
     if not exists (select 1 from "accountTokens" where "name" = 'serviceUser' and "isInternal" = true) then
       insert into "accountTokens" ("id", "name", "accountId", "apiToken", "isInternal", "createdBy", "updatedBy", "createdAt", "updatedAt")
       values ('540e55445e5bad6f98764522', 'serviceUser', '540e55445e5bad6f98764522', (select "serviceUserToken" from "systemConfigs" where id=1), true, '540e55445e5bad6f98764522', '540e55445e5bad6f98764522', '2016-02-29T00:00:00Z', '2016-02-29T00:00:00Z');
     end if;

  -- Update mailChimpId columns in accounts table to use 80 characters
    if exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'mailChimpId' and character_maximum_length = 24) then
      alter table "accounts" alter column "mailChimpId" type varchar(80);
    end if;

  -- Remove paidSubCount from dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'paidSubCount') then
      alter table "dailyAggs" drop column "paidSubCount";
    end if;

   -- Remove isNewPipeline from subscriptions
    if exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'isNewPipeline') then
      alter table "subscriptions" drop column "isNewPipeline";
    end if;

  -- Add externalBuildUrl in builds
    if not exists (select 1 from information_schema.columns where table_name = 'builds' and column_name = 'externalBuildUrl') then
      alter table "builds" add column "externalBuildUrl" varchar(510);
    end if;

  -- Add projectId in builds
    if not exists (select 1 from information_schema.columns where table_name = 'builds' and column_name = 'projectId') then
      alter table "builds" add column "projectId" varchar(24);
    end if;

  -- Set projectIds for builds where projectId is null
    UPDATE builds SET "projectId" = (SELECT "projectId" FROM resources WHERE id="resourceId") WHERE "projectId" IS NULL;

  -- Add projectId in buildJobs
    if not exists (select 1 from information_schema.columns where table_name = 'buildJobs' and column_name = 'projectId') then
      alter table "buildJobs" add column "projectId" varchar(24);
    end if;

  -- Set projectIds for buildJobs where projectId is null
    UPDATE "buildJobs" SET "projectId" = (SELECT "projectId" FROM builds WHERE id="buildJobs"."buildId") WHERE "projectId" IS NULL;

  -- Set projectId column of builds table set to not null
    if exists (select 1 from information_schema.columns where table_name = 'builds' and column_name = 'projectId') then
      alter table "builds" alter column "projectId" set not null;
    end if;

  -- Set projectId column of buildJobs table set to not null
    if exists (select 1 from information_schema.columns where table_name = 'buildJobs' and column_name = 'projectId') then
      alter table "buildJobs" alter column "projectId" set not null;
    end if;

  -- Remove systemConfigs.braintreeEnabled
    if exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'braintreeEnabled') then
      alter table "systemConfigs" drop column "braintreeEnabled";
    end if;

    -- Add systemConfigs.serverEnabled
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'serverEnabled') then
      alter table "systemConfigs" add column "serverEnabled" boolean NOT NULL DEFAULT true;
    end if;

    -- Add systemConfigs.autoSelectBuilderToken
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'autoSelectBuilderToken') then
      alter table "systemConfigs" add column "autoSelectBuilderToken" boolean DEFAULT false;
    end if;

    -- Add projects.ownerAccountId
    if not exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'ownerAccountId') then
      alter table "projects" add column "ownerAccountId" varchar(24);
      update projects set "ownerAccountId" = "enabledBy";
    end if;

    -- Add projects.builderAccountId
    if not exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'builderAccountId') then
      alter table "projects" add column "builderAccountId" varchar(24);
    end if;

    -- Set builderAccountId for projects with only a ownerAccountId
      UPDATE projects SET "builderAccountId" = "ownerAccountId" WHERE "builderAccountId" IS NULL AND "ownerAccountId" IS NOT NULL;

    -- Adds foreign key relationships for projects
    if not exists (select 1 from pg_constraint where conname = 'projects_enabledBy_fkey') then
      update projects as p set "enabledBy"=(select id from accounts where "id"=p."enabledBy");
      alter table "projects" add constraint "projects_enabledBy_fkey" foreign key ("enabledBy") references "accounts"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'projects_ownerAccountId_fkey') then
      update projects as p set "ownerAccountId"=(select id from accounts where "id"=p."ownerAccountId");
      alter table "projects" add constraint "projects_ownerAccountId_fkey" foreign key ("ownerAccountId") references "accounts"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'projects_builderAccountId_fkey') then
      alter table "projects" add constraint "projects_builderAccountId_fkey" foreign key ("builderAccountId") references "accounts"(id) on update restrict on delete restrict;
    end if;

    -- Add column nodeTypeCode to subscriptions table
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'nodeTypeCode') then
      alter table "subscriptions" add column "nodeTypeCode" integer;
      update "subscriptions" set "nodeTypeCode" = 7000 where "isUsingCustomHost" = true;
      update "subscriptions" set "nodeTypeCode" = 7001 where "isUsingCustomHost" = false;
      alter table "subscriptions" add constraint "subscriptions_nodeTypeCode_fkey" foreign key("nodeTypeCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    -- Add column nodeTypeCode to clusterNodes table
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodes' and column_name = 'nodeTypeCode') then
      alter table "clusterNodes" add column "nodeTypeCode" integer;
      alter table "clusterNodes" add constraint "clusterNodes_nodeTypeCode_fkey" foreign key("nodeTypeCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    -- Remove isUsingCustomHost from subscriptions
    if exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'isUsingCustomHost') then
      alter table "subscriptions" drop column "isUsingCustomHost";
    end if;

    -- username is no longer a required field for bitbucketServer account integrations
    update "masterIntegrationFields" set "isRequired" = false where "id" = 54;

    -- "port" is not a required field for github auth master integration
    update "masterIntegrationFields" set "isRequired" = false where "id" = 77;

    -- "port" is not a required field for bitbucket auth master integration
    update "masterIntegrationFields" set "isRequired" = false where "id" = 83;

  -- Adds foreign key relationships for resources
    if not exists (select 1 from pg_constraint where conname = 'resources_subscriptionId_fkey') then
      alter table "resources" add constraint "resources_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'resources_subscriptionIntegrationId_fkey') then
      alter table "resources" add constraint "resources_subscriptionIntegrationId_fkey" foreign key ("subscriptionIntegrationId") references "subscriptionIntegrations"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'resources_projectId_fkey') then
      alter table "resources" add constraint "resources_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'resources_typeCode_fkey') then
      alter table "resources" add constraint "resources_typeCode_fkey" foreign key ("typeCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'resources_lastVersionId_fkey') then
      alter table "resources" add constraint "resources_lastVersionId_fkey" foreign key("lastVersionId") references "versions"(id) on update restrict on delete set null;
    end if;

  -- Adds foreign key relationships for versions
    if not exists (select 1 from pg_constraint where conname = 'versions_subscriptionId_fkey') then
      alter table "versions" add constraint "versions_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'versions_projectId_fkey') then
      alter table "versions" add constraint "versions_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for jobDependencies
    if not exists (select 1 from pg_constraint where conname = 'jobDependencies_subscriptionId_fkey') then
      alter table "jobDependencies" add constraint "jobDependencies_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for buildJobs
    if not exists (select 1 from pg_constraint where conname = 'buildJobs_subscriptionId_fkey') then
      alter table "buildJobs" add constraint "buildJobs_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'buildJobs_projectId_fkey') then
      alter table "buildJobs" add constraint "buildJobs_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for buildJobConsoles
    if not exists (select 1 from pg_constraint where conname = 'buildJobConsoles_buildJobId_fkey') then
      alter table "buildJobConsoles" add constraint "buildJobConsoles_buildJobId_fkey" foreign key ("buildJobId") references "buildJobs"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for accountIntegrations
    if not exists (select 1 from pg_constraint where conname = 'accountIntegrations_accountId_fkey') then
      alter table "accountIntegrations" add constraint "accountIntegrations_accountId_fkey" foreign key ("accountId") references "accounts"(id) on update restrict on delete restrict;
    end if;
    if not exists (select 1 from pg_constraint where conname = 'accountIntegrations_providerId_fkey') then
      alter table "accountIntegrations" add constraint "accountIntegrations_providerId_fkey" foreign key ("providerId") references "providers"(id) on update restrict on delete restrict;
    end if;
    if not exists (select 1 from pg_constraint where conname = 'accountIntegrations_masterIntegrationId_fkey') then
      alter table "accountIntegrations" add constraint "accountIntegrations_masterIntegrationId_fkey" foreign key ("masterIntegrationId") references "masterIntegrations"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for accountTokens
    if not exists (select 1 from pg_constraint where conname = 'accountTokens_accountId_fkey') then
      alter table "accountTokens" add constraint "accountTokens_accountId_fkey" foreign key ("accountId") references "accounts"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for accountProfiles
    if not exists (select 1 from pg_constraint where conname = 'accountProfiles_accountId_fkey') then
      alter table "accountProfiles" add constraint "accountProfiles_accountId_fkey" foreign key ("accountId") references "accounts"(id) on update restrict on delete restrict;
    end if;
    if not exists (select 1 from pg_constraint where conname = 'accountProfiles_providerId_fkey') then
      alter table "accountProfiles" add constraint "accountProfiles_providerId_fkey" foreign key ("providerId") references "providers"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for systemIntegrations
    if not exists (select 1 from pg_constraint where conname = 'systemIntegrations_masterIntegrationId_fkey') then
      alter table "systemIntegrations" add constraint "systemIntegrations_masterIntegrationId_fkey" foreign key ("masterIntegrationId") references "masterIntegrations"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for subscriptionIntegrations
    if not exists (select 1 from pg_constraint where conname = 'subscriptionIntegrations_subscriptionId_fkey') then
      alter table "subscriptionIntegrations" add constraint "subscriptionIntegrations_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'subscriptionIntegrations_accountIntegrationId_fkey') then
      alter table "subscriptionIntegrations" add constraint "subscriptionIntegrations_accountIntegrationId_fkey" foreign key ("accountIntegrationId") references "accountIntegrations"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for projects
    if not exists (select 1 from pg_constraint where conname = 'projects_providerId_fkey') then
      alter table "projects" add constraint "projects_providerId_fkey" foreign key ("providerId") references "providers"(id) on update restrict on delete restrict;
    end if;
    if not exists (select 1 from pg_constraint where conname = 'projects_subscriptionId_fkey') then
      alter table "projects" add constraint "projects_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for projectDailyAggs
    if not exists (select 1 from pg_constraint where conname = 'projectDailyAggs_projectId_fkey') then
      alter table "projectDailyAggs" add constraint "projectDailyAggs_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;
    if not exists (select 1 from pg_constraint where conname = 'projectDailyAggs_subscriptionId_fkey') then
      alter table "projectDailyAggs" add constraint "projectDailyAggs_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

  -- Removes accountId foreign key from transactions
    if exists (select 1 from pg_constraint where conname = 'transactions_accountId_fkey') then
      alter table "transactions" drop constraint "transactions_accountId_fkey";
    end if;

  -- Adds foreign key relationships for transactions
    if not exists (select 1 from pg_constraint where conname = 'transactions_subscriptionId_fkey') then
      alter table "transactions" add constraint "transactions_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for builds
    if not exists (select 1 from pg_constraint where conname = 'builds_subscriptionId_fkey') then
      alter table "builds" add constraint "builds_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'builds_projectId_fkey') then
      alter table "builds" add constraint "builds_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for clusterNodeStats
    if not exists (select 1 from pg_constraint where conname = 'clusterNodeStats_clusterNodeId_fkey') then
      alter table "clusterNodeStats" add constraint "clusterNodeStats_clusterNodeId_fkey" foreign key ("clusterNodeId") references "clusterNodes"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for clusterNodeConsoles
    if not exists (select 1 from pg_constraint where conname = 'clusterNodeConsoles_clusterNodeId_fkey') then
      alter table "clusterNodeConsoles" add constraint "clusterNodeConsoles_clusterNodeId_fkey" foreign key ("clusterNodeId") references "clusterNodes"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for jobConsoles
    if not exists (select 1 from pg_constraint where conname = 'jobConsoles_jobId_fkey') then
      alter table "jobConsoles" add constraint "jobConsoles_jobId_fkey" foreign key ("jobId") references "jobs"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for clusterNodes
    if not exists (select 1 from pg_constraint where conname = 'clusterNodes_subscriptionId_fkey') then
      alter table "clusterNodes" add constraint "clusterNodes_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'clusterNodes_statusCode_fkey') then
      alter table "clusterNodes" add constraint "clusterNodes_statusCode_fkey" foreign key ("statusCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'clusterNodes_systemMachineImageId_fkey') then
      alter table "clusterNodes" add constraint "clusterNodes_systemMachineImageId_fkey" foreign key ("systemMachineImageId") references "systemMachineImages"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for jobTestReports
    if not exists (select 1 from pg_constraint where conname = 'jobTestReports_jobId_fkey') then
      alter table "jobTestReports" add constraint "jobTestReports_jobId_fkey" foreign key ("jobId") references "jobs"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for jobCoverageReports
    if not exists (select 1 from pg_constraint where conname = 'jobCoverageReports_jobId_fkey') then
      alter table "jobCoverageReports" add constraint "jobCoverageReports_jobId_fkey" foreign key ("jobId") references "jobs"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for jobs
    if not exists (select 1 from pg_constraint where conname = 'jobs_statusCode_fkey') then
      alter table "jobs" add constraint "jobs_statusCode_fkey" foreign key ("statusCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'jobs_subscriptionId_fkey') then
      alter table "jobs" add constraint "jobs_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'jobs_projectId_fkey') then
      alter table "jobs" add constraint "jobs_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'jobs_runId_fkey') then
      alter table "jobs" add constraint "jobs_runId_fkey" foreign key ("runId") references "runs"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for runs
    if not exists (select 1 from pg_constraint where conname = 'runs_statusCode_fkey') then
      alter table "runs" add constraint "runs_statusCode_fkey" foreign key ("statusCode") references "systemCodes"(code) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'runs_projectId_fkey') then
      alter table "runs" add constraint "runs_projectId_fkey" foreign key ("projectId") references "projects"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'runs_providerId_fkey') then
      alter table "runs" add constraint "runs_providerId_fkey" foreign key ("providerId") references "providers"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'runs_subscriptionId_fkey') then
      alter table "runs" add constraint "runs_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for providers
    if not exists (select 1 from pg_constraint where conname = 'providers_masterIntegrationId_fkey') then
      alter table "providers" add constraint "providers_masterIntegrationId_fkey" foreign key ("masterIntegrationId") references "masterIntegrations"(id) on update restrict on delete restrict;
    end if;

  -- Adds foreign key relationships for subscriptions
    if not exists (select 1 from pg_constraint where conname = 'subscriptions_providerId_fkey') then
      alter table "subscriptions" add constraint "subscriptions_providerId_fkey" foreign key ("providerId") references "providers"(id) on update restrict on delete restrict;
    end if;

    if not exists (select 1 from pg_constraint where conname = 'subscriptions_systemMachineImageId_fkey') then
      alter table "subscriptions" add constraint "subscriptions_systemMachineImageId_fkey" foreign key ("systemMachineImageId") references "systemMachineImages"(id) on update restrict on delete restrict;
    end if;

    -- Add systemRoles to accountTokens
    if not exists (select 1 from information_schema.columns where table_name = 'accountTokens' and column_name = 'systemRoles') then
      alter table "accountTokens" add column "systemRoles" text default '[]' NOT NUll;
    end if;

    -- Drop clusterNodes_jobId_fkey constraint from clusterNodes table
    if exists (select 1 from pg_constraint where conname = 'clusterNodes_jobId_fkey') then
      alter table "clusterNodes" drop constraint "clusterNodes_jobId_fkey";
    end if;

    -- Adds consolidateReports coloumn in projects table
    if not exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'consolidateReports') then
      alter table "projects" add column "consolidateReports" BOOLEAN DEFAULT false;
    end if;

    -- Adds externalBuildId column in builds table
    if not exists (select 1 from information_schema.columns where table_name = 'builds' and column_name = 'externalBuildId') then
      alter table "builds" add column "externalBuildId" varchar(255);
    end if;

    -- Reindex projAccAccIdProjIdU to projAccAccIdProjIdRoleCodeU in projectAccounts table
    if exists (select 1 from pg_indexes where tablename = 'projectAccounts' and indexname = 'projAccAccIdProjIdU') then
      drop index "projAccAccIdProjIdU";
    end if;

    if not exists (select 1 from pg_indexes where tablename = 'projectAccounts' and indexname = 'projAccAccIdProjIdRoleCodeU') then
      create unique index "projAccAccIdProjIdRoleCodeU" on "projectAccounts" using btree("accountId", "projectId", "roleCode");
    end if;

    -- Reindex subsAccSubsIdAccIdU to subsAccSubsIdAccIdRoleCodeU in subscriptionAccounts table
    if exists (select 1 from pg_indexes where tablename = 'subscriptionAccounts' and indexname = 'subsAccSubsIdAccIdU') then
      drop index "subsAccSubsIdAccIdU";
    end if;

    if not exists (select 1 from pg_indexes where tablename = 'subscriptionAccounts' and indexname = 'subsAccSubsIdAccIdRoleCodeU') then
      create unique index "subsAccSubsIdAccIdRoleCodeU" on "subscriptionAccounts" using btree("accountId", "subscriptionId", "roleCode");
    end if;

    -- drop coloumn isShippableNode from clusterNodes table
    if exists (select 1 from information_schema.columns where table_name = 'clusterNodes' and column_name = 'isShippableNode') then
      alter table "clusterNodes" drop column "isShippableNode";
    end if;

    -- adds column dynamicNodesSystemIntegrationId in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'dynamicNodesSystemIntegrationId') then
      alter table "systemConfigs" add column "dynamicNodesSystemIntegrationId" varchar(24);
    end if;

    -- Adds isShippableInitialized coloumn in systemNodes table
    if not exists (select 1 from information_schema.columns where table_name = 'systemNodes' and column_name = 'isShippableInitialized') then
      alter table "systemNodes" add column "isShippableInitialized" BOOLEAN;
    end if;

    -- Adds systemNodePrivateKey column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'systemNodePrivateKey') then
      alter table "systemConfigs" add column "systemNodePrivateKey" TEXT ;
    end if;

    -- Adds systemNodePublicKey column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'systemNodePublicKey') then
      alter table "systemConfigs" add column "systemNodePublicKey" varchar(1020) ;
    end if;

    -- Drop systemIntegrationId from systemMachineImages
    if exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'systemIntegrationId') then
      alter table "systemMachineImages" drop column "systemIntegrationId";
    end if;

    -- Drop cachingEnabled from systemConfigs
    if exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'cachingEnabled') then
      alter table "systemConfigs" drop column "cachingEnabled";
    end if;

    -- Drop hubspotEnabled from systemConfigs
    if exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'hubspotEnabled') then
      alter table "systemConfigs" drop column "hubspotEnabled";
    end if;

    -- Adds allowSystemNodes column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'allowSystemNodes') then
      alter table "systemConfigs" add column "allowSystemNodes" BOOLEAN default false;
    end if;

    -- Adds allowDynamicNodes column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'allowDynamicNodes') then
      alter table "systemConfigs" add column "allowDynamicNodes" BOOLEAN default false;
    end if;

    -- Adds allowCustomNodes column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'allowCustomNodes') then
      alter table "systemConfigs" add column "allowCustomNodes" BOOLEAN default false;
    end if;

    -- Adds consoleMaxLifespan column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'consoleMaxLifespan') then
      alter table "systemConfigs" add column "consoleMaxLifespan" INTEGER default 0;
    end if;

    -- Adds consoleCleanupHour column in systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'consoleCleanupHour') then
      alter table "systemConfigs" add column "consoleCleanupHour" INTEGER default 0;
    end if;

    -- Drop projectPermissions
    if exists (select 1 from information_schema.columns where table_name = 'projectPermissions') then
      drop table "projectPermissions";
    end if;

    -- Drop subscriptionPermissions
    if exists (select 1 from information_schema.columns where table_name = 'subscriptionPermissions') then
      drop table "subscriptionPermissions";
    end if;

    -- Drop betaUsers
    if exists (select 1 from information_schema.columns where table_name = 'betaUsers') then
      drop table "betaUsers";
    end if;

    -- Drop superUsers
    if exists (select 1 from information_schema.columns where table_name = 'superUsers') then
      drop table "superUsers";
    end if;

    -- remove outdated routeRoles
    if exists (select 1 from information_schema.columns where table_name = 'routeRoles') then
      delete from "routeRoles" where "routePattern"='/accounts/:id' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accounts/:id/dependencies' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accounts/:id/sync' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accounts/:id/generateSSHKeys' and "httpVerb"='POST';
      delete from "routeRoles" where "routePattern"='/accounts/:id' and "httpVerb"='PUT';
      delete from "routeRoles" where "routePattern"='/accounts/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/accountIntegrations/:id' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accountIntegrations/:id/dependencies' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accountIntegrations/:id/validateProjectOwnerToken' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accountIntegrations/:id' and "httpVerb"='PUT';
      delete from "routeRoles" where "routePattern"='/accountIntegrations/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id' and "httpVerb"='PUT';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:clusterNodeId/status' and "httpVerb"='POST';
      delete from "routeRoles" where "routePattern"='/systemNodes/:systemNodeId/status' and "httpVerb"='POST';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id/status' and "httpVerb"='POST';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id/validate' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id/initScript' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/clusterNodeStats/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/clusterNodes/:id/clusterNodeStats' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/clusterNodeStats/:clusterNodeStatId' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/jobCoverageReports/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/subscriptionIntegrations/:id/dependencies' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accountTokens/:id' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/accountTokens/:id' and "httpVerb"='DELETE';
      delete from "routeRoles" where "routePattern"='/transactions/:id' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/transactions/:id/receipt' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/jobDependencies/:id' and "httpVerb" = 'PUT';
      delete from "routeRoles" where "routePattern"='/jobDependencies/:id' and "httpVerb" = 'DELETE';
      delete from "routeRoles" where "routePattern"='/subscriptionIntegrationPermissions/:id' and "httpVerb" = 'DELETE';
      delete from "routeRoles" where "routePattern"='/systemMachineImages/:id' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/providers/:id' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/passthrough/discounts/:id' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/passthrough/jobs/:id/reports' and "httpVerb" = 'GET';
      delete from "routeRoles" where "routePattern"='/accounts/:accountId/sync' and "httpVerb"='GET';
      delete from "routeRoles" where "routePattern"='/projects/:projectId/sync' and "httpVerb"='GET';
    end if;

    -- masterIntegrationFields for Braintree
    if not exists (select 1 from "masterIntegrationFields" where "id" = 137 and "name" = 'braintreeEnvironment') then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (137, '57aafd0673ea26cb053fe1ca', 'braintreeEnvironment', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 138 and "name" = 'braintreeMerchantId') then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (138, '57aafd0673ea26cb053fe1ca', 'braintreeMerchantId', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 139 and "name" = 'braintreePrivateKey') then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (139, '57aafd0673ea26cb053fe1ca', 'braintreePrivateKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    if not exists (select 1 from "masterIntegrationFields" where "id" = 140 and "name" = 'braintreePublicKey') then
      insert into "masterIntegrationFields" ("id", "masterIntegrationId", "name", "dataType", "isRequired", "isSecure","createdBy", "updatedBy", "createdAt", "updatedAt")
      values (140, '57aafd0673ea26cb053fe1ca', 'braintreePublicKey', 'string', true, false,'54188262bc4d591ba438d62a', '54188262bc4d591ba438d62a', '2016-06-01', '2016-06-01');
    end if;

    -- Add "customHostDockerVersion" to systemConfigs table
    if not exists (select 1 from information_schema.columns where table_name = 'systemConfigs' and column_name = 'customHostDockerVersion') then
      alter table "systemConfigs" add column "customHostDockerVersion" varchar(24);
    end if;

    -- Add "isConsoleArchived" field to buildJobs table
    if not exists (select 1 from information_schema.columns where table_name = 'buildJobs' and column_name = 'isConsoleArchived') then
      alter table "buildJobs" add column "isConsoleArchived" boolean NOT NULL DEFAULT false;
    end if;

    -- Add "isConsoleArchived" field to jobs table
    if not exists (select 1 from information_schema.columns where table_name = 'jobs' and column_name = 'isConsoleArchived') then
      alter table "jobs" add column "isConsoleArchived" boolean NOT NULL DEFAULT false;
    end if;

    -- update Git Store integration type
    update "masterIntegrations" set "level" = 'system' where "masterIntegrationId" = 1 and "name" = 'Git store' and type = 'scm';

    -- Add column subnetId in systemMachineImages table
    if not exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'subnetId') then
      alter table "systemMachineImages" add column "subnetId" varchar(80);
    end if;

    -- drop NOT NULL from subnetId in systemMachineImages table
    if exists (select 1 from information_schema.columns where table_name = 'systemMachineImages' and column_name = 'subnetId') then
      alter table "systemMachineImages" alter column "subnetId" DROP NOT NULL;
    end if;

    -- Add isSuperUser column to accounts
    if not exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'isSuperUser') then
      alter table "accounts" add column "isSuperUser" boolean NOT NULL DEFAULT false;
    end if;

    -- Add isBetaUser column to accounts
    if not exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'isBetaUser') then
      alter table "accounts" add column "isBetaUser" boolean NOT NULL DEFAULT false;
    end if;

    -- Add isOpsUser column to accounts
    if not exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'isOpsUser') then
      alter table "accounts" add column "isOpsUser" boolean NOT NULL DEFAULT false;
    end if;

    -- Adds addOnMinionCount and addOnMinionCountOverridden columns to subscriptions
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'addOnMinionCount') then
      alter table "subscriptions" add column "addOnMinionCount" INTEGER NOT NULL DEFAULT 0;
    end if;
    if not exists (select 1 from information_schema.columns where table_name = 'subscriptions' and column_name = 'addOnMinionCountOverridden') then
      alter table "subscriptions" add column "addOnMinionCountOverridden" BOOLEAN NOT NULL DEFAULT false;
    end if;
  end
$$;

-- Add route Roles
create or replace function set_route_role(
  httpVerb varchar, routePattern varchar, roleCode int)

  returns void as $$
  begin

    -- insert if not exists
    if not exists (select 1 from "routeRoles"
      where "httpVerb" = httpVerb and
        "routePattern" = routePattern and
        "roleCode" = roleCode
    ) then
      insert into "routeRoles" ("httpVerb", "routePattern", "roleCode",
        "createdAt", "updatedAt")
      values (httpVerb, routePattern, roleCode,
        now(), now());
    end if;
  end
$$ LANGUAGE plpgsql;

do $$
  begin

    -- set accounts routeRoles

    perform set_route_role(
      routePattern := '/accounts',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/dependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/runStatus',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/runStatus',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/runStatus',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/runStatus',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId/generateSSHKeys',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/:accountId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/auth/:systemIntegrationId',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accounts/auth/:systemIntegrationId/link',
      httpVerb := 'POST',
      roleCode := 6060
    );

    --set accountCards routeRoles
    perform set_route_role(
      routePattern := '/accountCards/:accountCardId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountCards',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountCards/:accountCardId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountCards',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountCards/:accountCardId/dependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    --set accountIntegration routes

    perform set_route_role(
      routePattern := '/accountIntegrations',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations/:accountIntegrationId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations/:accountIntegrationId/dependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations/:accountIntegrationId/validateProjectOwnerToken',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations/:accountIntegrationId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountIntegrations/:accountIntegrationId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set accountProfiles routeRoles

    perform set_route_role(
      routePattern := '/accountProfiles',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set accountRoles routeRoles

    perform set_route_role(
      routePattern := '/accountRoles',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set accountTokens routeRoles

    perform set_route_role(
      routePattern := '/accountTokens',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountTokens/:accountTokenId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountTokens',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/accountTokens/:accountTokenId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set builds routeRoles

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/buildStatus',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/buildStatus',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/builds',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/builds/:buildId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set buildJobs routeRoles

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    -- set buildJobConsoles routeRoles

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/buildJobs/:buildJobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set clusterNodes routeRoles

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'GET',
      roleCode := 6060
    );

     perform set_route_role(
       routePattern := '/clusterNodes/:clusterNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6000
     );

     perform set_route_role(
       routePattern := '/clusterNodes/:clusterNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6010
     );

     perform set_route_role(
       routePattern := '/clusterNodes/:clusterNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6020
     );

     perform set_route_role(
       routePattern := '/clusterNodes/:clusterNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6040
     );

     perform set_route_role(
       routePattern := '/clusterNodes/:clusterNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6060
     );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/initScript',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/initScript',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/initScript',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/initScript',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'PUT',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes',
      httpVerb := 'POST',
      roleCode := 6060
    );

    -- set cluster node consoles route roles
    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeConsoles',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeConsoles',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeConsoles',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeConsoles',
      httpVerb := 'GET',
      roleCode := 6020
    );

    -- set clusterNodeStats routeRoles
    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'POST',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/clusterNodeStats',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeStats',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeStats',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/clusterNodes/:clusterNodeId/clusterNodeStats',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set jobConsoles Roles

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/consoles',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set jobDependencies Roles

    perform set_route_role(
      routePattern := '/jobDependencies',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobDependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobDependencies',
      httpVerb := 'POST',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobDependencies',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'PUT',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'DELETE',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobDependencies/:jobDependencyId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set jobCoverageReports routeRoles
    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobCoverageReports',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports/:jobCoverageReportId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports/:jobCoverageReportId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobCoverageReports/:jobCoverageReportId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set jobs routeRoles

    perform set_route_role(
      routePattern := '/jobs',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobs',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set jobTestReports routeRoles

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpverb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpverb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpverb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpverb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpverb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobTestReports',
      httpverb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobTestReports',
      httpverb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobTestReports',
      httpverb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobTestReports',
      httpverb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/jobs/:jobId/jobTestReports',
      httpverb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobTestReports/:jobTestReportId',
      httpverb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobTestReports/:jobTestReportId',
      httpverb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobTestReports/:jobTestReportId',
      httpverb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/jobTestReports',
      httpVerb := 'POST',
      roleCode := 6060
    );

    -- set masterIntegrations routeRoles

    perform set_route_role(
      routePattern := '/masterIntegrations',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set masterIntegrationFields routeRoles

    perform set_route_role(
      routePattern := '/masterIntegrationFields',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set passthrough routeRoles
    perform set_route_role(
      routePattern := '/passthrough/discounts/:discountId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/passthrough/discounts/:discountId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/passthrough/discounts/:discountId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/passthrough/discounts/:discountId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/passthrough/jobs/:jobId/reports',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/passthrough/jobs/:jobId/reports',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/passthrough/jobs/:jobId/reports',
      httpVerb := 'GET',
      roleCode := 6060
    );

    --set payments routeRoles
    perform set_route_role(
      routePattern := '/payments/clienttoken',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set plans routeRoles
    perform set_route_role(
      routePattern := '/plans',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set projects routeRoles
    perform set_route_role(
      routePattern := '/projects',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/projects',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/projects',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/branchRunStatus',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/branchRunStatus',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/branchRunStatus',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/branchRunStatus',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/branchRunStatus',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/createCi',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/createCi',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/createCi',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/disable',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/disable',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/owners',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/owners',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/reset',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/reset',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/enable',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/enable',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/enable',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/decrypt',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/decrypt',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/newBuild',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/newBuild',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/newBuild',
      httpVerb := 'POST',
      roleCode := 6050
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/newBuild',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/projects/:projectId/artifactUrl',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set projectAccounts routeRoles

    perform set_route_role(
      routePattern := '/projectAccounts',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/projectAccounts',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/projectAccounts',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/projectAccounts',
      httpVerb := 'GET',
      roleCode := 6020
    );

    -- set providers routeRoles
    perform set_route_role(
      routePattern := '/providers/:providerId',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/providers/:providerId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set resources routeRoles
    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'GET',
      roleCode := 6050
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/dependencies',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/dependencies',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/dependencies',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/dependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/syncRepo',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/syncRepo',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/syncRepo',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/files',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/triggerNewBuildRequest',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/triggerNewBuildRequest',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/resources/:resourceId/triggerNewBuildRequest',
      httpVerb := 'POST',
      roleCode := 6060
    );

    -- set runs routeRoles
    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/runs',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/runs/:runId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/runs/:runId/cancel',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/runs/:runId/cancel',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/runs/:runId/cancel',
      httpVerb := 'POST',
      roleCode := 6060
    );

    -- set subscriptions routeRoles

    perform set_route_role(
      routePattern := '/subscriptions',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptions',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/subscriptions',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'GET',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/reset',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/reset',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/v2/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/v2/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/v2/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/v2/subscriptions/:subscriptionId/billing',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/cards',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/cards',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/encrypt',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/encrypt',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/encrypt',
      httpVerb := 'POST',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/encrypt',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/decrypt',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/decrypt',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/runStatus',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/runStatus',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscription/:subscriptionId/runStatus',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/runStatus',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/state',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/state',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/state',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/state',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set subscriptionsAccounts routeRoles

    perform set_route_role(
      routePattern := '/subscriptionAccounts',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptionAccounts',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionAccounts',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionAccounts',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set subscriptionIntegrations routeRoles
    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId/dependencies',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId/dependencies',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'PUT',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'PUT',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrations/:subscriptionIntegrationId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set subscriptionintegrationpermissions routeRoles

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'GET',
      roleCode := 6000
    );
    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions/:subscriptionIntegrationPermissionId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions/:subscriptionIntegrationPermissionId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptionIntegrationPermissions/:subscriptionIntegrationPermissionId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

    -- set systemMachineImages routes

    perform set_route_role(
      routePattern := '/systemMachineImages',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/systemMachineImages',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/systemMachineImages',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/systemMachineImages',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/systemMachineImages/:systemMachineImageId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/systemMachineImages/:systemMachineImageId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/systemMachineImages/:systemMachineImageId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/systemMachineImages/:systemMachineImageId',
      httpVerb := 'GET',
      roleCode := 6060
    );
    -- set vortex routeRoles

    perform set_route_role(
      routePattern := '/vortex',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/vortex',
      httpVerb := 'GET',
      roleCode := 6060
    );

    -- set systemCodes routeRoles
    perform set_route_role(
      routePattern := '/systemCodes',
      httpVerb := 'GET',
      roleCode := 6040
    );

    -- set systemNodes routeRoles
    perform set_route_role(
      routePattern := '/systemNodes/:systemNodeId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/systemNodes/:systemNodeId',
      httpVerb := 'PUT',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/systemNodes/:systemNodeId',
      httpVerb := 'PUT',
      roleCode := 6060
    );

    perform set_route_role(
       routePattern := '/systemNodes/:systemNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6040
     );

     perform set_route_role(
       routePattern := '/systemNodes/:systemNodeId/validate',
       httpVerb := 'GET',
       roleCode := 6060
     );

    -- set systemNodeStats routeRoles
    perform set_route_role(
      routePattern := '/systemNodeStats',
      httpVerb := 'POST',
      roleCode := 6040
    );

    perform set_route_role(
      routePattern := '/systemNodeStats',
      httpVerb := 'POST',
      roleCode := 6060
    );

    -- set transactions routeRoles

    perform set_route_role(
      routePattern := '/transactions/:transactionId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/transactions/:transactionId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/transactions/:transactionId/receipt',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/transactions/:transactionId/receipt',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/transactions',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/subscriptions/:subscriptionId/transactions',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/transactions',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/transactions',
      httpVerb := 'GET',
      roleCode := 6020
    );

    -- set versions routeRoles
    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'GET',
      roleCode := 6000
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'GET',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'GET',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'GET',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'POST',
      roleCode := 6050
    );

    perform set_route_role(
      routePattern := '/versions',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/v2/versions',
      httpVerb := 'POST',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/v2/versions',
      httpVerb := 'POST',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/v2/versions',
      httpVerb := 'POST',
      roleCode := 6050
    );

    perform set_route_role(
      routePattern := '/v2/versions',
      httpVerb := 'POST',
      roleCode := 6060
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'DELETE',
      roleCode := 6010
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'DELETE',
      roleCode := 6020
    );

    perform set_route_role(
      routePattern := '/versions/:versionId',
      httpVerb := 'DELETE',
      roleCode := 6060
    );

  end
$$;

do $$
  begin
    if exists (select 1 from information_schema.columns where table_name = 'routePermissions') then
      drop table "routePermissions";
    end if;
  end
$$;


do $$
  begin
    -- Remove csWindowBuiltProjects in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'csWindowBuiltProjects') then
      alter table "dailyAggs" drop column "csWindowBuiltProjects";
    end if;

    -- Remove csWindowGreenProjects in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'csWindowGreenProjects') then
      alter table "dailyAggs" drop column "csWindowGreenProjects";
    end if;

    -- Remove csWindowEnabledProjects in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'csWindowEnabledProjects') then
      alter table "dailyAggs" drop column "csWindowEnabledProjects";
    end if;

    -- Remove projectsTodayStg06 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg06') then
      alter table "dailyAggs" drop column "projectsTodayStg06";
    end if;

    -- Remove projectsTodayStg05 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg05') then
      alter table "dailyAggs" drop column "projectsTodayStg05";
    end if;

    -- Remove projectsTodayStg04 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg04') then
      alter table "dailyAggs" drop column "projectsTodayStg04";
    end if;

    -- Remove projectsTodayStg03 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg03') then
      alter table "dailyAggs" drop column "projectsTodayStg03";
    end if;

    -- Remove projectsTodayStg02 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg02') then
      alter table "dailyAggs" drop column "projectsTodayStg02";
    end if;

    -- Remove projectsTodayStg01 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg01') then
      alter table "dailyAggs" drop column "projectsTodayStg01";
    end if;

    -- Remove projectsTodayStg00 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsTodayStg00') then
      alter table "dailyAggs" drop column "projectsTodayStg00";
    end if;

    -- Remove projectsRedTodayStg06 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg06') then
      alter table "dailyAggs" drop column "projectsRedTodayStg06";
    end if;

    -- Remove projectsRedTodayStg05 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg05') then
      alter table "dailyAggs" drop column "projectsRedTodayStg05";
    end if;

    -- Remove projectsRedTodayStg04 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg04') then
      alter table "dailyAggs" drop column "projectsRedTodayStg04";
    end if;

    -- Remove projectsRedTodayStg03 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg03') then
      alter table "dailyAggs" drop column "projectsRedTodayStg03";
    end if;

    -- Remove projectsRedTodayStg02 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg02') then
      alter table "dailyAggs" drop column "projectsRedTodayStg02";
    end if;

    -- Remove projectsRedTodayStg01 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg01') then
      alter table "dailyAggs" drop column "projectsRedTodayStg01";
    end if;

    -- Remove projectsRedTodayStg00 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'projectsRedTodayStg00') then
      alter table "dailyAggs" drop column "projectsRedTodayStg00";
    end if;

    -- Remove jobGreenRateStg06 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg06') then
      alter table "dailyAggs" drop column "jobGreenRateStg06";
    end if;

    -- Remove jobGreenRateStg05 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg05') then
      alter table "dailyAggs" drop column "jobGreenRateStg05";
    end if;

    -- Remove jobGreenRateStg04 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg04') then
      alter table "dailyAggs" drop column "jobGreenRateStg04";
    end if;

    -- Remove jobGreenRateStg03 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg03') then
      alter table "dailyAggs" drop column "jobGreenRateStg03";
    end if;

    -- Remove jobGreenRateStg02 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg02') then
      alter table "dailyAggs" drop column "jobGreenRateStg02";
    end if;

    -- Remove jobGreenRateStg01 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg01') then
      alter table "dailyAggs" drop column "jobGreenRateStg01";
    end if;

    -- Remove jobGreenRateStg00 in dailyAggs
    if exists (select 1 from information_schema.columns where table_name = 'dailyAggs' and column_name = 'jobGreenRateStg00') then
      alter table "dailyAggs" drop column "jobGreenRateStg00";
    end if;

    -- Add subscriptionId field in clusterNodeConsoles
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeConsoles' and column_name = 'subscriptionId') then
      alter table "clusterNodeConsoles" add column "subscriptionId" varchar(24);
    end if;

    -- Add subscriptionId field in clusterNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'subscriptionId') then
      alter table "clusterNodeStats" add column "subscriptionId" varchar(24);
    end if;
    -- Add memoryUsageInPercentage field in clusterNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'memoryUsageInPercentage') then
      alter table "clusterNodeStats" add column "memoryUsageInPercentage" decimal;
    end if;
    -- Add cpuLoadInPercentage field in clusterNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'cpuLoadInPercentage') then
      alter table "clusterNodeStats" add column "cpuLoadInPercentage" decimal;
    end if;
    -- Add activeContainersCount field in clusterNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'activeContainersCount') then
      alter table "clusterNodeStats" add column "activeContainersCount" integer;
    end if;
    -- Add totalContainersCount field in clusterNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'totalContainersCount') then
      alter table "clusterNodeStats" add column "totalContainersCount" integer;
    end if;

    if exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'cdmContainers') then
      alter table "clusterNodeStats" alter column "cdmContainers" drop not null;
    end if;
    if exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'disks') then
      alter table "clusterNodeStats" alter column "disks" drop not null;
    end if;
    if exists (select 1 from information_schema.columns where table_name = 'clusterNodeStats' and column_name = 'memory') then
      alter table "clusterNodeStats" alter column "memory" drop not null;
    end if;

    -- Add memoryUsageInPercentage field in systemNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'memoryUsageInPercentage') then
      alter table "systemNodeStats" add column "memoryUsageInPercentage" decimal;
    end if;
    -- Add cpuLoadInPercentage field in systemNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'cpuLoadInPercentage') then
      alter table "systemNodeStats" add column "cpuLoadInPercentage" decimal;
    end if;
    -- Add activeContainersCount field in systemNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'activeContainersCount') then
      alter table "systemNodeStats" add column "activeContainersCount" integer;
    end if;
    -- Add totalContainersCount field in systemNodeStats
    if not exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'totalContainersCount') then
      alter table "systemNodeStats" add column "totalContainersCount" integer;
    end if;

    if exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'cdmContainers') then
      alter table "systemNodeStats" alter column "cdmContainers" drop not null;
    end if;
    if exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'disks') then
      alter table "systemNodeStats" alter column "disks" drop not null;
    end if;
    if exists (select 1 from information_schema.columns where table_name = 'systemNodeStats' and column_name = 'memory') then
      alter table "systemNodeStats" alter column "memory" drop not null;
    end if;

    -- Adds foreign key constraint on subscriptionId for clusterNodeConsoles
    if not exists (select 1 from pg_constraint where conname = 'clusterNodeConsoles_subscriptionId_fkey') then
      alter table "clusterNodeConsoles" add constraint "clusterNodeConsoles_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    -- Adds foreign key constraint on subscriptionId for clusterNodeStats
    if not exists (select 1 from pg_constraint where conname = 'clusterNodeStats_subscriptionId_fkey') then
      alter table "clusterNodeStats" add constraint "clusterNodeStats_subscriptionId_fkey" foreign key ("subscriptionId") references "subscriptions"(id) on update restrict on delete restrict;
    end if;

    -- Moves accounts.systemRoles data to accountRoles table
    if exists (select 1 from information_schema.columns where table_name = 'accountRoles') then
      if exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'systemRoles') then
      begin
      declare
        accounts_rec record;
        begin
          for accounts_rec in select id, "systemRoles" as roles from accounts where "systemRoles" not like '["user"]' and "systemRoles" not like '[ "user" ]'
          loop
            if accounts_rec.roles like '%opsUser%' then
              if not exists (select 1 from "accountRoles" where "accountId" = accounts_rec.id and "roleCode" = 6070) then
                insert into "accountRoles" ("accountId", "roleCode", "createdAt", "updatedAt")
                values (accounts_rec.id, 6070, '2016-06-01', '2016-06-01');
              end if;
            end if;
            if accounts_rec.roles like '%superUser%' then
              if not exists (select 1 from "accountRoles" where "accountId" = accounts_rec.id and "roleCode" = 6080) then
                insert into "accountRoles" ("accountId", "roleCode", "createdAt", "updatedAt")
                values (accounts_rec.id, 6080, '2016-06-01', '2016-06-01');
              end if;
            end if;
            if accounts_rec.roles like '%betaUser%' then
              if not exists (select 1 from "accountRoles" where "accountId" = accounts_rec.id and "roleCode" = 6090) then
                insert into "accountRoles" ("accountId", "roleCode", "createdAt", "updatedAt")
                values (accounts_rec.id, 6090, '2016-06-01', '2016-06-01');
              end if;
            end if;
            if accounts_rec.roles like '%serviceUser%' then
              if not exists (select 1 from "accountRoles" where "accountId" = accounts_rec.id and "roleCode" = 6100) then
                insert into "accountRoles" ("accountId", "roleCode", "createdAt", "updatedAt")
                values (accounts_rec.id, 6100, '2016-06-01', '2016-06-01');
              end if;
            end if;
          end loop;
        end;
        alter table "accounts" drop column "systemRoles";
      end;
      end if;
    end if;

    -- Drop Vault related fields from accounts table
    if exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'secretsToken') then
      alter table "accounts" drop column "secretsToken";
    end if;

    if exists (select 1 from information_schema.columns where table_name = 'accounts' and column_name = 'lastSecretsTokenRefreshedAt') then
      alter table "accounts" drop column "lastSecretsTokenRefreshedAt";
    end if;

    -- Remove isSyncing in projects
    if exists (select 1 from information_schema.columns where table_name = 'projects' and column_name = 'isSyncing') then
      alter table "projects" drop column "isSyncing";
    end if;
  end
$$;
