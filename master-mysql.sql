-- https://raw.githubusercontent.com/sakaiproject/sakai/master/samigo/docs/auto_submit/auto_submit_mysql.sql

INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) VALUES (NULL, 1, 'automaticSubmission_isInstructorEditable', 'true');

-- Run these SQL commands to update the templates
CREATE TEMPORARY TABLE UPDATE_SAM_AUTO_IDS AS (SELECT ID FROM SAM_ASSESSMENTBASE_T WHERE TYPEID='142' AND ISTEMPLATE=1);
-- You may need to clean this up if you've run it multiple times
-- DELETE FROM SAM_ASSESSMETADATA_T WHERE ASSESSMENTID IN (SELECT ID FROM UPDATE_SAM_AUTO_IDS) AND LABEL='automaticSubmission_isInstructorEditable';
INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) SELECT NULL, ID, 'automaticSubmission_isInstructorEditable', 'true' FROM UPDATE_SAM_AUTO_IDS;
DROP TABLE UPDATE_SAM_AUTO_IDS;


-- Run these SQL commands to back fill to your existing assessments
CREATE TEMPORARY TABLE UPDATE_SAM_AUTO_IDS AS (SELECT ID FROM SAM_ASSESSMENTBASE_T WHERE ID NOT IN (SELECT ASSESSMENTID FROM SAM_ASSESSMETADATA_T WHERE label = 'automaticSubmission_isInstructorEditable'));
INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) SELECT NULL, ID, 'automaticSubmission_isInstructorEditable', 'true' FROM UPDATE_SAM_AUTO_IDS;
DROP TABLE UPDATE_SAM_AUTO_IDS;

-- Add an automatic link to TsugiCloud Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiCloud App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add automatic link to WarpWire nightly
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'WarpWire Test Server', 1, NULL, 'WarpWire Test Server', 0, NULL, 0, 0, 'https://sakainightly.warpwire.net/api/ltix/?mode=plugin', 1, 'lti:sakainightly:01', 0, 'gsAM:wUeZRn2-kJERm-OkqrKB-nJxdke-webMOj-pj8vL2', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);
 

INSERT INTO `lti_tools` (`id`, `SITE_ID`, `title`, `allowtitle`, `fa_icon`, `allowfa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `deployment_id`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowlineitems`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `rolemap`, `allowcustom`, `splash`, `lti13`, `lti13_client_id`, `lti13_tool_public`, `lti13_tool_keyset`, `lti13_tool_kid`, `lti13_tool_private`, `lti13_platform_public`, `lti13_platform_private`, `lti13_oidc_endpoint`, `lti13_oidc_redirect`, `lti13_settings`, `sha256`, `lti11_launch_type`, `xmlimport`, `created_at`, `updated_at`) VALUES
(74, NULL, 'CourseNetworking CNPost', 0, NULL, 0, 'CNPost', 0, 'This is an LTI service provided by CourseNetworking (thecn.com).  It is both a threaded discussion system (CNPost) that is part of a global student portfolio system (TheCN).  This is a test key, please contact CourseNetworking for your own key.  For more details, see https://support.thecn.com/hc/en-us/articles/235243908', 0, 0, NULL, 'https://www.thecn.com/program/lti/course', 0, '5e33510fc417ed6dfe59cb37', 0, '5c48feb958ca0809:c4a961118f5905f2d381c8018bb2ac6d:6289112293f8f575adcb328dd4cb9242a03bea15eb337f615ad1744518e71ca6:AES/CBC/PKCS5Padding', 0, NULL, NULL, 0, 0, 1, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2020-02-25 09:22:06', '2020-02-25 09:22:06');

-- Add a lot of links so that we can test paging easily after changes like SAK-39962
-- These are all inserted into site sedna so only the admin sees them
-- This is kind of repetitive so best to add new queries above this block

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 01 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 02 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 03 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 04 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 05 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 06 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 07 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 08 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 09 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 10 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 11 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 12 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 13 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 14 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 15 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 16 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 17 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 18 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 19 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 20 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 21 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 22 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 23 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 24 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 25 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 26 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 27 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 28 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 29 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 30 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

-- Add an automatic link to TsugiClone Test
INSERT INTO `lti_tools` (`SITE_ID`, `title`, `allowtitle`, `fa_icon`, `pagetitle`, `allowpagetitle`, `description`, `status`, `visible`, `launch`, `allowlaunch`, `consumerkey`, `allowconsumerkey`, `secret`, `allowsecret`, `frameheight`, `toolorder`, `allowframeheight`, `siteinfoconfig`, `sendname`, `sendemailaddr`, `allowoutcomes`, `allowroster`, `allowsettings`, `pl_launch`, `pl_linkselection`, `pl_contenteditor`, `pl_importitem`, `pl_fileitem`, `pl_assessmentselection`, `newpage`, `debug`, `custom`, `allowcustom`, `lti13`, `lti13_settings`, `xmlimport`, `splash`, `created_at`, `updated_at`, `sha256`) VALUES
(NULL, 'TsugiClone 31 App Store', 1, NULL, 'TsugiCloud App Store', 0, NULL, 0, 0, 'https://test.tsugicloud.org/tsugi/lti/store/', 1, '12345', 0, 'secret', 0, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NOW(), NOW(), 0);

