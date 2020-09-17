Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3326E0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgIQQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:36:43 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:60990 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgIQQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:33:44 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru A084E2092EC1
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Date:   Thu, 17 Sep 2020 18:38:03 +0300
From:   Elvira Khabirova <e.khabirova@omprussia.ru>
To:     <op-tee@lists.trustedfirmware.org>
CC:     <jens.wiklander@linaro.org>, <linux-kernel@vger.kernel.org>,
        <vesa.jaaskelainen@vaisala.com>, <s.shtylyov@omprussia.ru>,
        <k.karasev@omprussia.ru>
Subject: [RFC PATCH] tee: add support for application-based session login
 methods
Message-ID: <20200917183803.4a0c5263@akathisia>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.255.69.56]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1904.lancloud.ru (fd00:f066::74)
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
 drivers/tee/tee_core.c | 136 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 1 deletion(-)

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
index 64637e09a095..19c965dd212b 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -7,8 +7,10 @@
 
 #include <linux/cdev.h>
 #include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
@@ -17,11 +19,15 @@
 #include <crypto/sha.h>
 #include "tee_private.h"
 
+#ifdef CONFIG_TEE_APPID_SECURITY
+#include <linux/security.h>
+#endif
+
 #define TEE_NUM_DEVICES	32
 
 #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
 
-#define TEE_UUID_NS_NAME_SIZE	128
+#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
 
 /*
  * TEE Client UUID name space identifier (UUIDv4)
@@ -125,6 +131,67 @@ static int tee_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_TEE_APPID_SECURITY
+static const char *tee_session_get_application_id(void **data)
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
+static const char *tee_session_get_application_id(void **data)
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
+static void tee_session_free_application_id(void *data)
+{
+	kfree(data);
+}
+#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -197,6 +264,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	gid_t ns_grp = (gid_t)-1;
 	kgid_t grp = INVALID_GID;
 	char *name = NULL;
+	void *application_id_data = NULL;
+	const char *application_id = NULL;
 	int name_len;
 	int rc;
 
@@ -217,6 +286,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
@@ -249,6 +326,63 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		}
 		break;
 
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		application_id = tee_session_get_application_id(&application_id_data);
+		if (IS_ERR(application_id)) {
+			rc = PTR_ERR(application_id);
+			goto out_free_name;
+		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
+				    application_id);
+		tee_session_free_application_id(application_id_data);
+
+		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
+			rc = -E2BIG;
+			goto out_free_name;
+		}
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		application_id = tee_session_get_application_id(&application_id_data);
+		if (IS_ERR(application_id)) {
+			rc = PTR_ERR(application_id);
+			goto out_free_name;
+		}
+
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
+				    current_euid().val, application_id);
+		tee_session_free_application_id(application_id_data);
+
+		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
+			rc = -E2BIG;
+			goto out_free_name;
+		}
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
+		application_id = tee_session_get_application_id(&application_id_data);
+		if (IS_ERR(application_id)) {
+			rc = PTR_ERR(application_id);
+			goto out_free_name;
+		}
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
+				    grp.val, application_id);
+		tee_session_free_application_id(application_id_data);
+
+		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
+			rc = -E2BIG;
+			goto out_free_name;
+		}
+		break;
+
 	default:
 		rc = -EINVAL;
 		goto out_free_name;
-- 
2.28.0

