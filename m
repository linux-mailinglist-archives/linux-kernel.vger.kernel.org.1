Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B991BF848
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgD3Mhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 08:37:31 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:46709 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgD3Mh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:37:28 -0400
IronPort-SDR: AmD8xpi3Hr1Az4P2E+AOh4cURl9Etk1RPPyArq46mmuuwu7i4sLyWfYaRiykmnYbGpfp/AF0zl
 Tfe6vTH4oWf5oymVw6wQMOC5nbDlw28ap/phXwMPH6I1HB/FPSkb06efWv7fElIODPRxqYncge
 vbWkq1RBYwdWmWYe2dlc0Ecl6a5AOfpsMpfPRokhFbVTmOQix0T8DRsfhXxpS/HiKcgMqNMERt
 1EVU7aXnR0DL9zMP3IC+Ip2v7f+aS7pxQI/xuFyhq9ebVcDm31V8pD7dHbjLcCCXf1wZAc9p64
 Rjo=
X-IronPort-AV: E=Sophos;i="5.73,334,1583186400"; 
   d="scan'208";a="278151921"
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
To:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Subject: [PATCH v2 3/3] [RFC] tee: add support for app id for client UUID generation
Date:   Thu, 30 Apr 2020 15:37:11 +0300
Message-Id: <20200430123711.20083-4-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
References: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Apr 2020 12:37:21.0677 (UTC) FILETIME=[17F0A3D0:01D61EEC]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel does not provide common contex for application identifier,
instead different security frameworks provide own means to define
application identifier for running process. Code includes place holder for
such solutions but is left for later implementation.

Open questions:

1. App ID source

How to specify what source is used for app id?

Does it need to be protected on runtime?
- Should this be Kconfig setting?
- Cnfigure once during runtime thru sysfs or so?
- Configure from device tree?

2. Formatting for App ID

Should there be common format? Or common keyword id?

3. How to handle custom App ID sources

Android has own App ID so does Tizen.

Should there be place holder for this where to make local patch?

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 drivers/tee/tee_core.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d5db206d6af2..35ea20a99b9e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -125,6 +125,15 @@ static int tee_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static const char *tee_session_get_application_id(void)
+{
+	return NULL;
+}
+
+static void tee_session_free_application_id(const char *app_id)
+{
+}
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -218,6 +227,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
@@ -250,6 +267,47 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		}
 		break;
 
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		application_id = tee_session_get_application_id();
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
+				    application_id);
+		tee_session_free_application_id(application_id);
+		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
+			rc = -E2BIG;
+			goto out_free_name;
+		}
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		application_id = tee_session_get_application_id();
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE,
+				    "uid=%x:app=%s", current_euid().val,
+				    application_id);
+		tee_session_free_application_id(application_id);
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
+		application_id = tee_session_get_application_id();
+		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE,
+				    "gid=%x:app=%s", grp.val, application_id);
+		tee_session_free_application_id(application_id);
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
2.17.1

