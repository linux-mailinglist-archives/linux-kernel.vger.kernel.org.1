Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7804927EFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgI3Q47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:56:59 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:56054 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Q46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:56:58 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 590B22153BFA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Date:   Wed, 30 Sep 2020 19:56:52 +0300
From:   Elvira Khabirova <e.khabirova@omprussia.ru>
To:     <op-tee@lists.trustedfirmware.org>
CC:     <jens.wiklander@linaro.org>, <linux-kernel@vger.kernel.org>,
        <k.karasev@omprussia.ru>, <s.shtylyov@omprussia.ru>,
        <vesa.jaaskelainen@vaisala.com>
Subject: [PATCH v2] tee: add support for application-based session login
 methods
Message-ID: <20200930195652.5c316c3e@akathisia>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.255.69.56]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1903.lancloud.ru (fd00:f066::73)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/tee/Kconfig    |  29 +++++++++
 drivers/tee/tee_core.c | 133 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 6488b66d69dd..cd8f02a3d488 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -10,6 +10,35 @@ config TEE
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
index 67186d00a52f..31fb244b59ed 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -16,9 +16,12 @@
 
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
@@ -31,7 +34,7 @@
 
 #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
 
-#define TEE_UUID_NS_NAME_SIZE	128
+#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
 
 /*
  * TEE Client UUID name space identifier (UUIDv4)
@@ -136,6 +139,72 @@ static int tee_release(struct inode *inode, struct file *filp)
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
+	if (len < 0)
+		return ERR_PTR(len);
+
+	fput(exe_file);
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
+	if (IS_ERR(path)) {
+		kfree(*data);
+		return path;
+	}
+
+	fput(exe_file);
+
+	return path;
+}
+#endif /* CONFIG_TEE_APPID_PATH */
+
+#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
+static void free_app_id(void *data)
+{
+	kfree(data);
+}
+#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -208,6 +277,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	gid_t ns_grp = (gid_t)-1;
 	kgid_t grp = INVALID_GID;
 	char *name = NULL;
+	void *app_id_data = NULL;
+	const char *app_id = NULL;
 	int name_len;
 	int rc;
 
@@ -228,6 +299,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
@@ -238,10 +317,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	case TEE_IOCTL_LOGIN_USER:
 		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
 				    current_euid().val);
-		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
-			rc = -E2BIG;
-			goto out_free_name;
-		}
 		break;
 
 	case TEE_IOCTL_LOGIN_GROUP:
@@ -254,10 +329,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 
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
+		free_app_id(app_id_data);
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		app_id = get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc = PTR_ERR(app_id);
+			goto out_free_name;
+		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
+				    current_euid().val, app_id);
+		free_app_id(app_id_data);
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
 			goto out_free_name;
 		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
+				    grp.val, app_id);
+		free_app_id(app_id_data);
 		break;
 
 	default:
@@ -265,7 +379,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
2.17.1

