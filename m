Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67F22C4681
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbgKYRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732587AbgKYRLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:11:15 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5BA2145D;
        Wed, 25 Nov 2020 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606324274;
        bh=S9mqO8nOGmShe0beo70gwMlwGvRmn/c2d8abMCY3Deg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbtrWAViuU2Y7GvRgNW3SeCPeH+DmV3sRC26xh3NiEgEYxWwxqlj4HrCgmJstJQaI
         HlmF3TrZILbhAmUY1dj40J3+Gb1xrExEZ7aionLla32Mg3/G9e0FeZA51sJvufBtRP
         TfxIQ2vvrrOdVT8EoX4c+m7AXo1Wjcdl8PFEUuL0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: indicate to user that a cs is gone
Date:   Wed, 25 Nov 2020 19:09:57 +0200
Message-Id: <20201125170957.30494-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125170957.30494-1-ogabbay@kernel.org>
References: <20201125170957.30494-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We want to indicate to the user that a certain command submission
is finished long time ago and it is no longer in database.
This means no further information regarding this cs can be obtained.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 68 ++++++++++++++-----
 include/uapi/misc/habanalabs.h                |  5 +-
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7309dd2b88a9..f91b17480588 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -11,9 +11,22 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+/**
+ * enum hl_cs_wait_status - cs wait status
+ * @CS_WAIT_STATUS_BUSY: cs was not completed yet
+ * @CS_WAIT_STATUS_COMPLETED: cs completed
+ * @CS_WAIT_STATUS_GONE: cs completed but fence is already gone
+ */
+enum hl_cs_wait_status {
+	CS_WAIT_STATUS_BUSY,
+	CS_WAIT_STATUS_COMPLETED,
+	CS_WAIT_STATUS_GONE
+};
+
 static void job_wq_completion(struct work_struct *work);
-static long _hl_cs_wait_ioctl(struct hl_device *hdev,
-		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
+static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
+				u64 timeout_us, u64 seq,
+				enum hl_cs_wait_status *status);
 static void cs_do_release(struct kref *ref);
 
 static void hl_sob_reset(struct kref *ref)
@@ -942,7 +955,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 	int rc = 0, do_ctx_switch;
 	void __user *chunks;
 	u32 num_chunks, tmp;
-	long ret;
+	int ret;
 
 	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
 
@@ -996,18 +1009,19 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 
 		/* Need to wait for restore completion before execution phase */
 		if (num_chunks) {
+			enum hl_cs_wait_status status;
 wait_again:
 			ret = _hl_cs_wait_ioctl(hdev, ctx,
 					jiffies_to_usecs(hdev->timeout_jiffies),
-					*cs_seq);
-			if (ret <= 0) {
+					*cs_seq, &status);
+			if (ret) {
 				if (ret == -ERESTARTSYS) {
 					usleep_range(100, 200);
 					goto wait_again;
 				}
 
 				dev_err(hdev->dev,
-					"Restore CS for context %d failed to complete %ld\n",
+					"Restore CS for context %d failed to complete %d\n",
 					ctx->asid, ret);
 				rc = -ENOEXEC;
 				goto out;
@@ -1337,12 +1351,14 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
-static long _hl_cs_wait_ioctl(struct hl_device *hdev,
-		struct hl_ctx *ctx, u64 timeout_us, u64 seq)
+static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
+				u64 timeout_us, u64 seq,
+				enum hl_cs_wait_status *status)
 {
 	struct hl_fence *fence;
 	unsigned long timeout;
-	long rc;
+	int rc = 0;
+	long completion_rc;
 
 	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
 		timeout = timeout_us;
@@ -1360,11 +1376,17 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 				seq, ctx->cs_sequence);
 	} else if (fence) {
 		if (!timeout_us)
-			rc = completion_done(&fence->completion);
+			completion_rc = completion_done(&fence->completion);
 		else
-			rc = wait_for_completion_interruptible_timeout(
+			completion_rc =
+				wait_for_completion_interruptible_timeout(
 					&fence->completion, timeout);
 
+		if (completion_rc > 0)
+			*status = CS_WAIT_STATUS_COMPLETED;
+		else
+			*status = CS_WAIT_STATUS_BUSY;
+
 		if (fence->error == -ETIMEDOUT)
 			rc = -ETIMEDOUT;
 		else if (fence->error == -EIO)
@@ -1375,7 +1397,7 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		dev_dbg(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
 			seq, ctx->cs_sequence);
-		rc = 1;
+		*status = CS_WAIT_STATUS_GONE;
 	}
 
 	hl_ctx_put(ctx);
@@ -1387,14 +1409,16 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	union hl_wait_cs_args *args = data;
+	enum hl_cs_wait_status status;
 	u64 seq = args->in.seq;
-	long rc;
+	int rc;
 
-	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq);
+	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq,
+				&status);
 
 	memset(args, 0, sizeof(*args));
 
-	if (rc < 0) {
+	if (rc) {
 		if (rc == -ERESTARTSYS) {
 			dev_err_ratelimited(hdev->dev,
 				"user process got signal while waiting for CS handle %llu\n",
@@ -1415,10 +1439,18 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		return rc;
 	}
 
-	if (rc == 0)
-		args->out.status = HL_WAIT_CS_STATUS_BUSY;
-	else
+	switch (status) {
+	case CS_WAIT_STATUS_GONE:
+		args->out.flags |= HL_WAIT_CS_STATUS_FLAG_GONE;
+		fallthrough;
+	case CS_WAIT_STATUS_COMPLETED:
 		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
+		break;
+	case CS_WAIT_STATUS_BUSY:
+	default:
+		args->out.status = HL_WAIT_CS_STATUS_BUSY;
+		break;
+	}
 
 	return 0;
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 96eea49f48bc..808d20da024a 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -662,10 +662,13 @@ struct hl_wait_cs_in {
 #define HL_WAIT_CS_STATUS_ABORTED	3
 #define HL_WAIT_CS_STATUS_INTERRUPTED	4
 
+#define HL_WAIT_CS_STATUS_FLAG_GONE	0x1
+
 struct hl_wait_cs_out {
 	/* HL_WAIT_CS_STATUS_* */
 	__u32 status;
-	__u32 pad;
+	/* HL_WAIT_CS_STATUS_FLAG* */
+	__u32 flags;
 };
 
 union hl_wait_cs_args {
-- 
2.17.1

