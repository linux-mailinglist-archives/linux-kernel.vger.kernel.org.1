Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40D62C7549
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgK1WW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgK1WWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:22:53 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C28222C2;
        Sat, 28 Nov 2020 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606602132;
        bh=aGTmS0z+D05IYeFB2jcaFSqcfuduoHuL9YN7sZ6NmZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i7MsJaPxiu7KD7rGjnR0et0JSM8kiZ5smK66RdKvMTTtVkQvCgVEVx3ZBv5Q1Vix9
         2glCltd4GPQqpsFENU6mzTpCyOVfjgcl812q+xN6s7RJVGAi+edlNNXiwCku9tnzBd
         F2vSNwDLU2oiugDJbH3rVALCmC6fW4pxywm1Gmog=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Add CB IOCTL opcode to retrieve CB information
Date:   Sun, 29 Nov 2020 00:22:03 +0200
Message-Id: <20201128222207.23722-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add a new CB IOCTL opcode that enables a user to query about a CB and
get its usage count.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 38 +++++++++++++++++++
 include/uapi/misc/habanalabs.h                | 15 +++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 2856bb3423ee..6f6a904ab6ca 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -375,12 +375,43 @@ int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle)
 	return rc;
 }
 
+static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
+			u64 cb_handle, u32 *usage_cnt)
+{
+	struct hl_cb *cb;
+	u32 handle;
+	int rc = 0;
+
+	/* The CB handle was given to user to do mmap, so need to shift it back
+	 * to the value which was allocated by the IDR module.
+	 */
+	cb_handle >>= PAGE_SHIFT;
+	handle = (u32) cb_handle;
+
+	spin_lock(&mgr->cb_lock);
+
+	cb = idr_find(&mgr->cb_handles, handle);
+	if (!cb) {
+		dev_err(hdev->dev,
+			"CB info failed, no match to handle 0x%x\n", handle);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*usage_cnt = atomic_read(&cb->cs_cnt);
+
+out:
+	spin_unlock(&mgr->cb_lock);
+	return rc;
+}
+
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cb_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
 	enum hl_device_status status;
 	u64 handle = 0;
+	u32 usage_cnt = 0;
 	int rc;
 
 	if (!hl_device_operational(hdev, &status)) {
@@ -413,6 +444,13 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 					args->in.cb_handle);
 		break;
 
+	case HL_CB_OP_INFO:
+		rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
+				&usage_cnt);
+		memset(args, 0, sizeof(*args));
+		args->out.usage_cnt = usage_cnt;
+		break;
+
 	default:
 		rc = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 6eff4e05eccb..8c15a7d336a0 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -483,6 +483,8 @@ struct hl_info_args {
 #define HL_CB_OP_CREATE		0
 /* Opcode to destroy previously created command buffer */
 #define HL_CB_OP_DESTROY	1
+/* Opcode to retrieve information about a command buffer */
+#define HL_CB_OP_INFO		2
 
 /* 2MB minus 32 bytes for 2xMSG_PROT */
 #define HL_MAX_CB_SIZE		(0x200000 - 32)
@@ -506,8 +508,17 @@ struct hl_cb_in {
 };
 
 struct hl_cb_out {
-	/* Handle of CB */
-	__u64 cb_handle;
+	union {
+		/* Handle of CB */
+		__u64 cb_handle;
+
+		/* Information about CB */
+		struct {
+			/* Usage count of CB */
+			__u32 usage_cnt;
+			__u32 pad;
+		};
+	};
 };
 
 union hl_cb_args {
-- 
2.17.1

