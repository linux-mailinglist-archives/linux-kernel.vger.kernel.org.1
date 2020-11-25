Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157E2C467F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgKYRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgKYRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:11:12 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95742063A;
        Wed, 25 Nov 2020 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606324271;
        bh=5zwFIYDGQ9GqFrbWXOtsJw8jMCKYoLS7jRgaB7apgrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBPCsKEvTQhoBWkrghS9xn24+mPiC0ZtD5bngtA/hHF397f5Ap1uSGBw6rIRZBHDO
         BpRVqpcFimb17DDvvP3bKCSMymCe0ino1ILouhk++do/a8bM5q7PyvCLXywDDwPt6o
         ZFzvoOJOLAVqKg7HTdO7NFH6ymt1MDoL9Sows7Bk=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: add support for cs with timestamp
Date:   Wed, 25 Nov 2020 19:09:55 +0200
Message-Id: <20201125170957.30494-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125170957.30494-1-ogabbay@kernel.org>
References: <20201125170957.30494-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

add support for user to request a timestamp upon
cs completion.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 44 ++++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h   |  4 ++
 include/uapi/misc/habanalabs.h                |  6 ++-
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f91b17480588..bd2f54399020 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -26,7 +26,7 @@ enum hl_cs_wait_status {
 static void job_wq_completion(struct work_struct *work);
 static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 seq,
-				enum hl_cs_wait_status *status);
+				enum hl_cs_wait_status *status, s64 *timestamp);
 static void cs_do_release(struct kref *ref);
 
 static void hl_sob_reset(struct kref *ref)
@@ -150,6 +150,7 @@ static void hl_fence_init(struct hl_fence *fence)
 {
 	kref_init(&fence->refcount);
 	fence->error = 0;
+	fence->timestamp = ktime_set(0, 0);
 	init_completion(&fence->completion);
 }
 
@@ -404,6 +405,8 @@ static void cs_do_release(struct kref *ref)
 	else if (!cs->submitted)
 		cs->fence->error = -EBUSY;
 
+	if (cs->timestamp)
+		cs->fence->timestamp = ktime_get();
 	complete_all(&cs->fence->completion);
 	hl_fence_put(cs->fence);
 
@@ -734,7 +737,8 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 		return -EBUSY;
 	}
 
-	cs_type_flags = args->in.cs_flags & ~HL_CS_FLAGS_FORCE_RESTORE;
+	cs_type_flags = args->in.cs_flags &
+			~(HL_CS_FLAGS_FORCE_RESTORE | HL_CS_FLAGS_TIMESTAMP);
 
 	if (unlikely(cs_type_flags && !is_power_of_2(cs_type_flags))) {
 		dev_err(hdev->dev,
@@ -798,7 +802,7 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 }
 
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
-				u32 num_chunks, u64 *cs_seq)
+				u32 num_chunks, u64 *cs_seq, bool timestamp)
 {
 	bool int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
@@ -825,6 +829,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		goto free_cs_chunk_array;
 	}
 
+	cs->timestamp = !!timestamp;
 	*cs_seq = cs->sequence;
 
 	hl_debugfs_add_cs(cs);
@@ -995,7 +1000,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			rc = 0;
 		} else {
 			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
-						cs_seq);
+						cs_seq, false);
 		}
 
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -1013,7 +1018,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 wait_again:
 			ret = _hl_cs_wait_ioctl(hdev, ctx,
 					jiffies_to_usecs(hdev->timeout_jiffies),
-					*cs_seq, &status);
+					*cs_seq, &status, NULL);
 			if (ret) {
 				if (ret == -ERESTARTSYS) {
 					usleep_range(100, 200);
@@ -1154,7 +1159,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 
 static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
-				u64 *cs_seq)
+				u64 *cs_seq, bool timestamp)
 {
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
@@ -1259,6 +1264,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto free_cs_chunk_array;
 	}
 
+	cs->timestamp = !!timestamp;
+
 	/*
 	 * Save the signal CS fence for later initialization right before
 	 * hanging the wait CS on the queue.
@@ -1334,10 +1341,11 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	case CS_TYPE_WAIT:
 	case CS_TYPE_COLLECTIVE_WAIT:
 		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks, num_chunks,
-						&cs_seq);
+			&cs_seq, args->in.cs_flags & HL_CS_FLAGS_TIMESTAMP);
 		break;
 	default:
-		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq);
+		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
+				args->in.cs_flags & HL_CS_FLAGS_TIMESTAMP);
 		break;
 	}
 
@@ -1353,13 +1361,16 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 
 static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 seq,
-				enum hl_cs_wait_status *status)
+				enum hl_cs_wait_status *status, s64 *timestamp)
 {
 	struct hl_fence *fence;
 	unsigned long timeout;
 	int rc = 0;
 	long completion_rc;
 
+	if (timestamp)
+		*timestamp = 0;
+
 	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
 		timeout = timeout_us;
 	else
@@ -1382,10 +1393,13 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				wait_for_completion_interruptible_timeout(
 					&fence->completion, timeout);
 
-		if (completion_rc > 0)
+		if (completion_rc > 0) {
 			*status = CS_WAIT_STATUS_COMPLETED;
-		else
+			if (timestamp)
+				*timestamp = ktime_to_ns(fence->timestamp);
+		} else {
 			*status = CS_WAIT_STATUS_BUSY;
+		}
 
 		if (fence->error == -ETIMEDOUT)
 			rc = -ETIMEDOUT;
@@ -1411,10 +1425,11 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	union hl_wait_cs_args *args = data;
 	enum hl_cs_wait_status status;
 	u64 seq = args->in.seq;
+	s64 timestamp;
 	int rc;
 
 	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq,
-				&status);
+				&status, &timestamp);
 
 	memset(args, 0, sizeof(*args));
 
@@ -1439,6 +1454,11 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		return rc;
 	}
 
+	if (timestamp) {
+		args->out.flags |= HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD;
+		args->out.timestamp_nsec = timestamp;
+	}
+
 	switch (status) {
 	case CS_WAIT_STATUS_GONE:
 		args->out.flags |= HL_WAIT_CS_STATUS_FLAG_GONE;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9c9c8b24c47a..8e2d164d97e8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -481,12 +481,14 @@ struct asic_fixed_properties {
  * @completion: fence is implemented using completion
  * @refcount: refcount for this fence
  * @error: mark this fence with error
+ * @timestamp: timestamp upon completion
  *
  */
 struct hl_fence {
 	struct completion	completion;
 	struct kref		refcount;
 	int			error;
+	ktime_t			timestamp;
 };
 
 /**
@@ -1127,6 +1129,7 @@ struct hl_userptr {
  * @tdr_active: true if TDR was activated for this CS (to prevent
  *		double TDR activation).
  * @aborted: true if CS was aborted due to some device error.
+ * @timestamp: true if a timestmap must be captured upon completion
  */
 struct hl_cs {
 	u16			*jobs_in_queue_cnt;
@@ -1147,6 +1150,7 @@ struct hl_cs {
 	u8			timedout;
 	u8			tdr_active;
 	u8			aborted;
+	u8			timestamp;
 };
 
 /**
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 808d20da024a..6eff4e05eccb 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -592,6 +592,7 @@ struct hl_cs_chunk {
 #define HL_CS_FLAGS_SIGNAL		0x2
 #define HL_CS_FLAGS_WAIT		0x4
 #define HL_CS_FLAGS_COLLECTIVE_WAIT	0x8
+#define HL_CS_FLAGS_TIMESTAMP		0x20
 
 #define HL_CS_STATUS_SUCCESS		0
 
@@ -662,13 +663,16 @@ struct hl_wait_cs_in {
 #define HL_WAIT_CS_STATUS_ABORTED	3
 #define HL_WAIT_CS_STATUS_INTERRUPTED	4
 
-#define HL_WAIT_CS_STATUS_FLAG_GONE	0x1
+#define HL_WAIT_CS_STATUS_FLAG_GONE		0x1
+#define HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD	0x2
 
 struct hl_wait_cs_out {
 	/* HL_WAIT_CS_STATUS_* */
 	__u32 status;
 	/* HL_WAIT_CS_STATUS_FLAG* */
 	__u32 flags;
+	/* valid only if HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD is set */
+	__s64 timestamp_nsec;
 };
 
 union hl_wait_cs_args {
-- 
2.17.1

