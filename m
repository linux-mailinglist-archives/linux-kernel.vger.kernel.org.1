Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F182D5D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgLJONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:13:01 -0500
Received: from mxout04.lancloud.ru ([89.108.124.63]:40102 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgLJONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:13:01 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 64E562071700
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Date:   Thu, 10 Dec 2020 17:12:16 +0300
From:   Elvira Khabirova <e.khabirova@omprussia.ru>
To:     <op-tee@lists.trustedfirmware.org>
CC:     <linux-kernel@vger.kernel.org>, <k.karasev@omprussia.ru>,
        <s.shtylyov@omprussia.ru>, <vesa.jaaskelainen@vaisala.com>,
        <jens.wiklander@linaro.org>, <i.zhbanov@omprussia.ru>,
        <dan.carpenter@oracle.com>
Subject: [PATCH v4 RESEND] tee: add support for application-based session
 login methods
Message-ID: <20201210171216.6f546b10@akathisia>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1903.lancloud.ru (fd00:f066::73)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is both a resend and a request for comments.

The main reason for implementing this was to be able to authorize
access to particular TAs based on the applications that request it.
Furthermore, being able to distinguish between different applications
also allows having trusted storage per-application.
I believe this functionality might be crucial to many users of op-tee.

This patch provides two possible ways of calculating the application
identifier strings. This also serves as a stub for other methods.
Since there is no concept of "application" known to the Linux kernel,
the two proposed methods are based on the calling task's executable:
the executable file's path and its SELinux attributes.
Some vendor-specific methods may employ a service running in userspace,
but these two methods are the only ones that we came up with that
are fully contained in the kernel and are usable (and we actually use
one of the two methods suggested).

There might be other valid definitions of application-based identifier
strings. The GP TEE Client API specifies the credentials generated as
"only depending on the identity of the application program", being
"persistent within one implementation, across multiple invocations of
the application and across power cycles, enabling them to be used to
disambiguate persistent storage"; not more specific than that.

Perhaps some other properties of a running task can be used to calculate
an app ID, for example, to not depend on having an executable file
(which is admittedly a rare thing to come by), or to be able
to distinguish between different scripts run with one interpreter
(which is also rare since the TEE Client API is C-based).

If you're interested in this patch, or if you're using application-based
login methods but with a different scheme, I would love to hear your
experiences. Maybe there are other methods to consider; maybe the
proposed methods are enough.

If you're interested in testing this patch out, there is a reviewed,
good-to-go pull request in the optee_test repository:
https://github.com/OP-TEE/optee_test/pull/468

>8------------------------------------------------------8<

GP TEE Client API in addition to login methods already supported
in the kernel also defines several application-based methods:
TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
TEEC_LOGIN_GROUP_APPLICATION.

It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
depending on the identity of the program, being persistent within one
implementation, across multiple invocations of the application
and across power cycles, enabling them to be used to disambiguate
persistent storage. The exact nature is REE-specific.

As the exact method of generating application identifier strings may
vary between vendors, setups and installations, add two suggested
methods and an exact framework for vendors to extend upon.

Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
---
Changes in v4:
- Fix potential exe_file leaks.

Changes in v3:
- Remove free_app_id() and replace it with calls to kfree().

Changes in v2:
- Rename some functions and variables to make them shorter.
- Include linux/security.h unconditionally.
- Restructure error handling in tee_session_calc_client_uuid().
---
 drivers/tee/Kconfig    |  29 ++++++++++
 drivers/tee/tee_core.c | 126 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index e99d840c2511..4cd6e0d2aad5 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -11,6 +11,35 @@ config TEE
 	  This implements a generic interface towards a Trusted Execution
 	  Environment (TEE).
 
+choice
+	prompt "Application ID for client UUID"
+	depends on TEE
+	default TEE_APPID_PATH
+	help
+	  This option allows to choose which method will be used to generate
+	  application identifiers for client UUID generation when login methods
+	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
+	  and TEE_LOGIN_GROUP_APPLICATION are used.
+	  Please be mindful of the security of each method in your particular
+	  installation.
+
+	config TEE_APPID_PATH
+		bool "Path-based application ID"
+		help
+		  Use the executable's path as an application ID.
+
+	config TEE_APPID_SECURITY
+		bool "Security extended attribute based application ID"
+		help
+		  Use the executable's security extended attribute as an application ID.
+endchoice
+
+config TEE_APPID_SECURITY_XATTR
+	string "Security extended attribute to use for application ID"
+	depends on TEE_APPID_SECURITY
+	help
+	  Attribute to be used as an application ID (with the security prefix removed).
+
 if TEE
 
 menu "TEE drivers"
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 6ade4a5c4840..510ef2fceb82 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -7,9 +7,12 @@
 
 #include <linux/cdev.h>
 #include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
@@ -21,7 +24,7 @@
 
 #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
 
-#define TEE_UUID_NS_NAME_SIZE	128
+#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
 
 /*
  * TEE Client UUID name space identifier (UUIDv4)
@@ -125,6 +128,65 @@ static int tee_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_TEE_APPID_SECURITY
+static const char *get_app_id(void **data)
+{
+	struct file *exe_file;
+	const char *name = CONFIG_TEE_APPID_SECURITY_XATTR;
+	int len;
+
+	exe_file = get_mm_exe_file(current->mm);
+	if (!exe_file)
+		return ERR_PTR(-ENOENT);
+
+	if (!exe_file->f_inode) {
+		fput(exe_file);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/*
+	 * An identifier string for the binary. Depends on the implementation.
+	 * Could be, for example, a string containing the application vendor ID,
+	 * or the binary's signature, or its hash and a timestamp.
+	 */
+	len = security_inode_getsecurity(exe_file->f_inode, name, data, true);
+	fput(exe_file);
+
+	if (len < 0)
+		return ERR_PTR(len);
+
+	return *data;
+}
+#endif /* CONFIG_TEE_APPID_SECURITY */
+
+#ifdef CONFIG_TEE_APPID_PATH
+static const char *get_app_id(void **data)
+{
+	struct file *exe_file;
+	char *path;
+
+	*data = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
+	if (!*data)
+		return ERR_PTR(-ENOMEM);
+
+	exe_file = get_mm_exe_file(current->mm);
+	if (!exe_file) {
+		kfree(*data);
+		return ERR_PTR(-ENOENT);
+	}
+
+	path = file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
+	fput(exe_file);
+
+	if (IS_ERR(path)) {
+		kfree(*data);
+		return path;
+	}
+
+	return path;
+}
+#endif /* CONFIG_TEE_APPID_PATH */
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -197,6 +259,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	gid_t ns_grp = (gid_t)-1;
 	kgid_t grp = INVALID_GID;
 	char *name = NULL;
+	void *app_id_data = NULL;
+	const char *app_id = NULL;
 	int name_len;
 	int rc;
 
@@ -218,6 +282,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	 * For TEEC_LOGIN_GROUP:
 	 * gid=<gid>
 	 *
+	 * For TEEC_LOGIN_APPLICATION:
+	 * app=<application id>
+	 *
+	 * For TEEC_LOGIN_USER_APPLICATION:
+	 * uid=<uid>:app=<application id>
+	 *
+	 * For TEEC_LOGIN_GROUP_APPLICATION:
+	 * gid=<gid>:app=<application id>
 	 */
 
 	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
@@ -228,10 +300,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	case TEE_IOCTL_LOGIN_USER:
 		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
 				    current_euid().val);
-		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
-			rc = -E2BIG;
-			goto out_free_name;
-		}
 		break;
 
 	case TEE_IOCTL_LOGIN_GROUP:
@@ -244,10 +312,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 
 		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x",
 				    grp.val);
-		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
-			rc = -E2BIG;
+		break;
+
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		app_id = get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc = PTR_ERR(app_id);
+			goto out_free_name;
+		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
+				    app_id);
+		kfree(app_id_data);
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		app_id = get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc = PTR_ERR(app_id);
 			goto out_free_name;
 		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
+				    current_euid().val, app_id);
+		kfree(app_id_data);
+		break;
+
+	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
+		memcpy(&ns_grp, connection_data, sizeof(gid_t));
+		grp = make_kgid(current_user_ns(), ns_grp);
+		if (!gid_valid(grp) || !in_egroup_p(grp)) {
+			rc = -EPERM;
+			goto out_free_name;
+		}
+
+		app_id = get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc = PTR_ERR(app_id);
+			goto out_free_name;
+		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
+				    grp.val, app_id);
+		kfree(app_id_data);
 		break;
 
 	default:
@@ -255,7 +362,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		goto out_free_name;
 	}
 
-	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	if (name_len < TEE_UUID_NS_NAME_SIZE)
+		rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	else
+		rc = -E2BIG;
 out_free_name:
 	kfree(name);
 
-- 
2.29.2

