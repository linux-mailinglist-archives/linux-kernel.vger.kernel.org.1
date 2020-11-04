Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011672A6153
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgKDKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgKDKOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:14:41 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79E7223FD;
        Wed,  4 Nov 2020 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604484880;
        bh=OtkGcExcBJiusw6T34uKjVJB03S9SBma1asnbE37PtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt/FnxsFTNhqfN9grEGjIPaL/vboG9Z4lUafyenVVJ6O80O5Pl0UzSj4NcjOPb11O
         ntK0MxXcU2KJlSf2Iy2sK6PtLta6JVp5gZGwQdY05S2swgFtpZWLyJcK3z5jluUJVt
         ehlO978f2QLs8kbQofkww+OQlNZ8JTNJ1V4ciM8U=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Small refactoring of CS IOCTL handling
Date:   Wed,  4 Nov 2020 12:14:29 +0200
Message-Id: <20201104101429.15594-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104101429.15594-1-ogabbay@kernel.org>
References: <20201104101429.15594-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Refactor the CS IOCTL handling by gathering common code into
sub-functions, in order to ease future additions of new CS types.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 419 ++++++++++--------
 1 file changed, 224 insertions(+), 195 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index e9529f3efc1b..3e6f4e5ef7ec 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -11,8 +11,6 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
-#define HL_CS_FLAGS_SIG_WAIT	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT)
-
 static void job_wq_completion(struct work_struct *work);
 static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
@@ -660,44 +658,114 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 	return job;
 }
 
-static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
-				u32 num_chunks, u64 *cs_seq)
+static enum hl_cs_type hl_cs_get_cs_type(u32 cs_type_flags)
+{
+	if (cs_type_flags & HL_CS_FLAGS_SIGNAL)
+		return CS_TYPE_SIGNAL;
+	else if (cs_type_flags & HL_CS_FLAGS_WAIT)
+		return CS_TYPE_WAIT;
+	else if (cs_type_flags & HL_CS_FLAGS_COLLECTIVE_WAIT)
+		return CS_TYPE_COLLECTIVE_WAIT;
+	else
+		return CS_TYPE_DEFAULT;
+}
+
+static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_cs_chunk *cs_chunk_array;
-	struct hl_cs_counters_atomic *cntr;
-	struct hl_cs_job *job;
-	struct hl_cs *cs;
-	struct hl_cb *cb;
-	bool int_queues_only = true;
-	u32 size_to_copy;
-	int rc, i;
+	struct hl_ctx *ctx = hpriv->ctx;
+	u32 cs_type_flags, num_chunks;
+	enum hl_cs_type cs_type;
 
-	cntr = &hdev->aggregated_cs_counters;
-	*cs_seq = ULLONG_MAX;
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_warn_ratelimited(hdev->dev,
+			"Device is %s. Can't submit new CS\n",
+			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+		return -EBUSY;
+	}
+
+	cs_type_flags = args->in.cs_flags & ~HL_CS_FLAGS_FORCE_RESTORE;
+
+	if (unlikely(cs_type_flags && !is_power_of_2(cs_type_flags))) {
+		dev_err(hdev->dev,
+			"CS type flags are mutually exclusive, context %d\n",
+			ctx->asid);
+		return -EINVAL;
+	}
+
+	cs_type = hl_cs_get_cs_type(cs_type_flags);
+	num_chunks = args->in.num_chunks_execute;
+
+	if (unlikely((cs_type != CS_TYPE_DEFAULT) &&
+					!hdev->supports_sync_stream)) {
+		dev_err(hdev->dev, "Sync stream CS is not supported\n");
+		return -EINVAL;
+	}
+
+	if (cs_type == CS_TYPE_DEFAULT) {
+		if (!num_chunks) {
+			dev_err(hdev->dev,
+				"Got execute CS with 0 chunks, context %d\n",
+				ctx->asid);
+			return -EINVAL;
+		}
+	} else if (num_chunks != 1) {
+		dev_err(hdev->dev,
+			"Sync stream CS mandates one chunk only, context %d\n",
+			ctx->asid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hl_cs_copy_chunk_array(struct hl_device *hdev,
+					struct hl_cs_chunk **cs_chunk_array,
+					void __user *chunks, u32 num_chunks)
+{
+	u32 size_to_copy;
 
 	if (num_chunks > HL_MAX_JOBS_PER_CS) {
 		dev_err(hdev->dev,
 			"Number of chunks can NOT be larger than %d\n",
 			HL_MAX_JOBS_PER_CS);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	cs_chunk_array = kmalloc_array(num_chunks, sizeof(*cs_chunk_array),
+	*cs_chunk_array = kmalloc_array(num_chunks, sizeof(**cs_chunk_array),
 					GFP_ATOMIC);
-	if (!cs_chunk_array) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!*cs_chunk_array)
+		return -ENOMEM;
 
 	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
-	if (copy_from_user(cs_chunk_array, chunks, size_to_copy)) {
+	if (copy_from_user(*cs_chunk_array, chunks, size_to_copy)) {
 		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
-		rc = -EFAULT;
-		goto free_cs_chunk_array;
+		kfree(*cs_chunk_array);
+		return -EFAULT;
 	}
 
+	return 0;
+}
+
+static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
+				u32 num_chunks, u64 *cs_seq)
+{
+	bool int_queues_only = true;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_chunk *cs_chunk_array;
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_cs_job *job;
+	struct hl_cs *cs;
+	struct hl_cb *cb;
+	int rc, i;
+
+	cntr = &hdev->aggregated_cs_counters;
+	*cs_seq = ULLONG_MAX;
+
+	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks);
+	if (rc)
+		goto out;
+
 	/* increment refcnt for context */
 	hl_ctx_get(hdev, hpriv->ctx);
 
@@ -828,6 +896,108 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	return rc;
 }
 
+static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
+				u64 *cs_seq)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
+	bool need_soft_reset = false;
+	int rc = 0, do_ctx_switch;
+	void __user *chunks;
+	u32 num_chunks, tmp;
+	long ret;
+
+	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
+
+	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
+		mutex_lock(&hpriv->restore_phase_mutex);
+
+		if (do_ctx_switch) {
+			rc = hdev->asic_funcs->context_switch(hdev, ctx->asid);
+			if (rc) {
+				dev_err_ratelimited(hdev->dev,
+					"Failed to switch to context %d, rejecting CS! %d\n",
+					ctx->asid, rc);
+				/*
+				 * If we timedout, or if the device is not IDLE
+				 * while we want to do context-switch (-EBUSY),
+				 * we need to soft-reset because QMAN is
+				 * probably stuck. However, we can't call to
+				 * reset here directly because of deadlock, so
+				 * need to do it at the very end of this
+				 * function
+				 */
+				if ((rc == -ETIMEDOUT) || (rc == -EBUSY))
+					need_soft_reset = true;
+				mutex_unlock(&hpriv->restore_phase_mutex);
+				goto out;
+			}
+		}
+
+		hdev->asic_funcs->restore_phase_topology(hdev);
+
+		chunks = (void __user *) (uintptr_t) args->in.chunks_restore;
+		num_chunks = args->in.num_chunks_restore;
+
+		if (!num_chunks) {
+			dev_dbg(hdev->dev,
+				"Need to run restore phase but restore CS is empty\n");
+			rc = 0;
+		} else {
+			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
+						cs_seq);
+		}
+
+		mutex_unlock(&hpriv->restore_phase_mutex);
+
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to submit restore CS for context %d (%d)\n",
+				ctx->asid, rc);
+			goto out;
+		}
+
+		/* Need to wait for restore completion before execution phase */
+		if (num_chunks) {
+wait_again:
+			ret = _hl_cs_wait_ioctl(hdev, ctx,
+					jiffies_to_usecs(hdev->timeout_jiffies),
+					*cs_seq);
+			if (ret <= 0) {
+				if (ret == -ERESTARTSYS) {
+					usleep_range(100, 200);
+					goto wait_again;
+				}
+
+				dev_err(hdev->dev,
+					"Restore CS for context %d failed to complete %ld\n",
+					ctx->asid, ret);
+				rc = -ENOEXEC;
+				goto out;
+			}
+		}
+
+		ctx->thread_ctx_switch_wait_token = 1;
+
+	} else if (!ctx->thread_ctx_switch_wait_token) {
+		rc = hl_poll_timeout_memory(hdev,
+			&ctx->thread_ctx_switch_wait_token, tmp, (tmp == 1),
+			100, jiffies_to_usecs(hdev->timeout_jiffies), false);
+
+		if (rc == -ETIMEDOUT) {
+			dev_err(hdev->dev,
+				"context switch phase timeout (%d)\n", tmp);
+			goto out;
+		}
+	}
+
+out:
+	if ((rc == -ETIMEDOUT || rc == -EBUSY) && (need_soft_reset))
+		hl_device_reset(hdev, false, false);
+
+	return rc;
+}
+
 static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 		struct hl_cs_chunk *chunk, u64 *signal_seq)
 {
@@ -935,43 +1105,25 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
 				u64 *cs_seq)
 {
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
-	struct hl_fence *sig_fence = NULL;
-	struct hl_cs_counters_atomic *cntr;
+	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_compl *sig_waitcs_cmpl;
-	struct hl_cs *cs;
+	u32 q_idx, collective_engine_id = 0;
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_fence *sig_fence = NULL;
+	struct hl_ctx *ctx = hpriv->ctx;
 	enum hl_queue_type q_type;
-	u32 size_to_copy, q_idx, collective_engine_id = 0;
+	struct hl_cs *cs;
 	u64 signal_seq;
 	int rc;
 
 	*cs_seq = ULLONG_MAX;
 	cntr = &hdev->aggregated_cs_counters;
 
-	if (num_chunks > HL_MAX_JOBS_PER_CS) {
-		dev_err(hdev->dev,
-			"Number of chunks can NOT be larger than %d\n",
-			HL_MAX_JOBS_PER_CS);
-		rc = -EINVAL;
-		goto out;
-	}
-
-	cs_chunk_array = kmalloc_array(num_chunks, sizeof(*cs_chunk_array),
-					GFP_ATOMIC);
-	if (!cs_chunk_array) {
-		rc = -ENOMEM;
+	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks);
+	if (rc)
 		goto out;
-	}
-
-	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
-	if (copy_from_user(cs_chunk_array, chunks, size_to_copy)) {
-		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
-		rc = -EFAULT;
-		goto free_cs_chunk_array;
-	}
 
 	/* currently it is guaranteed to have only one chunk */
 	chunk = &cs_chunk_array[0];
@@ -1108,158 +1260,38 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 {
-	struct hl_device *hdev = hpriv->hdev;
 	union hl_cs_args *args = data;
-	struct hl_ctx *ctx = hpriv->ctx;
-	void __user *chunks_execute, *chunks_restore;
 	enum hl_cs_type cs_type;
-	u32 num_chunks_execute, num_chunks_restore, sig_wait_flags;
 	u64 cs_seq = ULONG_MAX;
-	int rc, do_ctx_switch;
-	bool need_soft_reset = false;
-
-	if (hl_device_disabled_or_in_reset(hdev)) {
-		dev_warn_ratelimited(hdev->dev,
-			"Device is %s. Can't submit new CS\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
-		rc = -EBUSY;
-		goto out;
-	}
-
-	sig_wait_flags = args->in.cs_flags & HL_CS_FLAGS_SIG_WAIT;
-
-	if (unlikely(sig_wait_flags == HL_CS_FLAGS_SIG_WAIT)) {
-		dev_err(hdev->dev,
-			"Signal and wait CS flags are mutually exclusive, context %d\n",
-		ctx->asid);
-		rc = -EINVAL;
-		goto out;
-	}
+	void __user *chunks;
+	u32 num_chunks;
+	int rc;
 
-	if (unlikely((sig_wait_flags & HL_CS_FLAGS_SIG_WAIT) &&
-			(!hdev->supports_sync_stream))) {
-		dev_err(hdev->dev, "Sync stream CS is not supported\n");
-		rc = -EINVAL;
+	rc = hl_cs_sanity_checks(hpriv, args);
+	if (rc)
 		goto out;
-	}
-
-	if (args->in.cs_flags & HL_CS_FLAGS_SIGNAL)
-		cs_type = CS_TYPE_SIGNAL;
-	else if (args->in.cs_flags & HL_CS_FLAGS_WAIT)
-		cs_type = CS_TYPE_WAIT;
-	else if (args->in.cs_flags & HL_CS_FLAGS_COLLECTIVE_WAIT)
-		cs_type = CS_TYPE_COLLECTIVE_WAIT;
-	else
-		cs_type = CS_TYPE_DEFAULT;
 
-	chunks_execute = (void __user *) (uintptr_t) args->in.chunks_execute;
-	num_chunks_execute = args->in.num_chunks_execute;
-
-	if (cs_type == CS_TYPE_DEFAULT) {
-		if (!num_chunks_execute) {
-			dev_err(hdev->dev,
-				"Got execute CS with 0 chunks, context %d\n",
-				ctx->asid);
-			rc = -EINVAL;
-			goto out;
-		}
-	} else if (num_chunks_execute != 1) {
-		dev_err(hdev->dev,
-			"Sync stream CS mandates one chunk only, context %d\n",
-			ctx->asid);
-		rc = -EINVAL;
+	rc = hl_cs_ctx_switch(hpriv, args, &cs_seq);
+	if (rc)
 		goto out;
-	}
-
-	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
-
-	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
-		long ret;
-
-		chunks_restore =
-			(void __user *) (uintptr_t) args->in.chunks_restore;
-		num_chunks_restore = args->in.num_chunks_restore;
-
-		mutex_lock(&hpriv->restore_phase_mutex);
-
-		if (do_ctx_switch) {
-			rc = hdev->asic_funcs->context_switch(hdev, ctx->asid);
-			if (rc) {
-				dev_err_ratelimited(hdev->dev,
-					"Failed to switch to context %d, rejecting CS! %d\n",
-					ctx->asid, rc);
-				/*
-				 * If we timedout, or if the device is not IDLE
-				 * while we want to do context-switch (-EBUSY),
-				 * we need to soft-reset because QMAN is
-				 * probably stuck. However, we can't call to
-				 * reset here directly because of deadlock, so
-				 * need to do it at the very end of this
-				 * function
-				 */
-				if ((rc == -ETIMEDOUT) || (rc == -EBUSY))
-					need_soft_reset = true;
-				mutex_unlock(&hpriv->restore_phase_mutex);
-				goto out;
-			}
-		}
-
-		hdev->asic_funcs->restore_phase_topology(hdev);
-
-		if (!num_chunks_restore) {
-			dev_dbg(hdev->dev,
-			"Need to run restore phase but restore CS is empty\n");
-			rc = 0;
-		} else {
-			rc = cs_ioctl_default(hpriv, chunks_restore,
-						num_chunks_restore, &cs_seq);
-		}
-
-		mutex_unlock(&hpriv->restore_phase_mutex);
-
-		if (rc) {
-			dev_err(hdev->dev,
-				"Failed to submit restore CS for context %d (%d)\n",
-				ctx->asid, rc);
-			goto out;
-		}
-
-		/* Need to wait for restore completion before execution phase */
-		if (num_chunks_restore) {
-			ret = _hl_cs_wait_ioctl(hdev, ctx,
-					jiffies_to_usecs(hdev->timeout_jiffies),
-					cs_seq);
-			if (ret <= 0) {
-				dev_err(hdev->dev,
-					"Restore CS for context %d failed to complete %ld\n",
-					ctx->asid, ret);
-				rc = -ENOEXEC;
-				goto out;
-			}
-		}
-
-		ctx->thread_ctx_switch_wait_token = 1;
-	} else if (!ctx->thread_ctx_switch_wait_token) {
-		u32 tmp;
-
-		rc = hl_poll_timeout_memory(hdev,
-			&ctx->thread_ctx_switch_wait_token, tmp, (tmp == 1),
-			100, jiffies_to_usecs(hdev->timeout_jiffies), false);
 
-		if (rc == -ETIMEDOUT) {
-			dev_err(hdev->dev,
-				"context switch phase timeout (%d)\n", tmp);
-			goto out;
-		}
+	cs_type = hl_cs_get_cs_type(args->in.cs_flags &
+					~HL_CS_FLAGS_FORCE_RESTORE);
+	chunks = (void __user *) (uintptr_t) args->in.chunks_execute;
+	num_chunks = args->in.num_chunks_execute;
+
+	switch (cs_type) {
+	case CS_TYPE_SIGNAL:
+	case CS_TYPE_WAIT:
+	case CS_TYPE_COLLECTIVE_WAIT:
+		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks, num_chunks,
+						&cs_seq);
+		break;
+	default:
+		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq);
+		break;
 	}
 
-	if (cs_type == CS_TYPE_DEFAULT)
-		rc = cs_ioctl_default(hpriv, chunks_execute, num_chunks_execute,
-					&cs_seq);
-	else
-		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks_execute,
-						num_chunks_execute, &cs_seq);
-
 out:
 	if (rc != -EAGAIN) {
 		memset(args, 0, sizeof(*args));
@@ -1267,9 +1299,6 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		args->out.seq = cs_seq;
 	}
 
-	if (((rc == -ETIMEDOUT) || (rc == -EBUSY)) && (need_soft_reset))
-		hl_device_reset(hdev, false, false);
-
 	return rc;
 }
 
-- 
2.17.1

