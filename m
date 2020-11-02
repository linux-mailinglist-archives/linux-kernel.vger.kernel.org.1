Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9C2A34B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKBT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgKBT6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:58:15 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6C222268;
        Mon,  2 Nov 2020 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347094;
        bh=h5/f8c0fm7OeAI1GorqMzOyUgmmrDY+diNACdAuAFuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01Awkvrj3Iz2ZZX02pexK7qGhsEGqX2QFYCh13C35wkSkHV4Ish9UL80Ift0lNRhS
         U3bRYpOi4ynpQ1+h3u7E5lgRAt1Jbkuhf+vydYh8OU35pPcY2SoGfg9wxmzJ7WL7NF
         QMSRHxnBVNstBEvPkzv7iMXaToNMPCW2BZ5KdM8c=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs: sync stream refactor functions
Date:   Mon,  2 Nov 2020 21:58:01 +0200
Message-Id: <20201102195802.10608-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102195802.10608-1-ogabbay@kernel.org>
References: <20201102195802.10608-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Refactor sync stream implementation by reducing function length
for better readability.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 210 ++++++++++--------
 1 file changed, 119 insertions(+), 91 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0d82c7dd93d0..b0f33579ca7f 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -792,22 +792,121 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	return rc;
 }
 
+static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
+		struct hl_cs_chunk *chunk, u64 *signal_seq)
+{
+	u64 *signal_seq_arr = NULL;
+	u32 size_to_copy, signal_seq_arr_len;
+	int rc = 0;
+
+	signal_seq_arr_len = chunk->num_signal_seq_arr;
+
+	/* currently only one signal seq is supported */
+	if (signal_seq_arr_len != 1) {
+		dev_err(hdev->dev,
+			"Wait for signal CS supports only one signal CS seq\n");
+		return -EINVAL;
+	}
+
+	signal_seq_arr = kmalloc_array(signal_seq_arr_len,
+					sizeof(*signal_seq_arr),
+					GFP_ATOMIC);
+	if (!signal_seq_arr)
+		return -ENOMEM;
+
+	size_to_copy = chunk->num_signal_seq_arr * sizeof(*signal_seq_arr);
+	if (copy_from_user(signal_seq_arr,
+				u64_to_user_ptr(chunk->signal_seq_arr),
+				size_to_copy)) {
+		dev_err(hdev->dev,
+			"Failed to copy signal seq array from user\n");
+		rc = -EFAULT;
+		goto out;
+	}
+
+	/* currently it is guaranteed to have only one signal seq */
+	*signal_seq = signal_seq_arr[0];
+
+out:
+	kfree(signal_seq_arr);
+
+	return rc;
+}
+
+static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
+		struct hl_ctx *ctx, struct hl_cs *cs, enum hl_queue_type q_type,
+		u32 q_idx)
+{
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_cs_job *job;
+	struct hl_cb *cb;
+	u32 cb_size;
+
+	cntr = &hdev->aggregated_cs_counters;
+
+	job = hl_cs_allocate_job(hdev, q_type, true);
+	if (!job) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		return -ENOMEM;
+	}
+
+	if (cs->type == CS_TYPE_WAIT)
+		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
+	else
+		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
+
+	cb = hl_cb_kernel_create(hdev, cb_size,
+				q_type == QUEUE_TYPE_HW && hdev->mmu_enable);
+	if (!cb) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		kfree(job);
+		return -EFAULT;
+	}
+
+	job->id = 0;
+	job->cs = cs;
+	job->user_cb = cb;
+	job->user_cb->cs_cnt++;
+	job->user_cb_size = cb_size;
+	job->hw_queue_id = q_idx;
+
+	/*
+	 * No need in parsing, user CB is the patched CB.
+	 * We call hl_cb_destroy() out of two reasons - we don't need the CB in
+	 * the CB idr anymore and to decrement its refcount as it was
+	 * incremented inside hl_cb_kernel_create().
+	 */
+	job->patched_cb = job->user_cb;
+	job->job_cb_size = job->user_cb_size;
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+
+	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+
+	list_add_tail(&job->cs_node, &cs->job_list);
+
+	hl_debugfs_add_job(hdev, job);
+
+	return 0;
+}
+
 static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
 				u64 *cs_seq)
 {
-	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
-	u64 *signal_seq_arr = NULL, signal_seq;
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *sig_fence = NULL;
-	struct hl_ctx *ctx = hpriv->ctx;
-	enum hl_queue_type q_type;
-	struct hl_cs_job *job;
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_cs_compl *sig_waitcs_cmpl;
 	struct hl_cs *cs;
-	struct hl_cb *cb;
+	enum hl_queue_type q_type;
+	u32 size_to_copy, q_idx;
+	u64 signal_seq;
 	int rc;
 
 	*cs_seq = ULLONG_MAX;
@@ -857,52 +956,23 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	}
 
 	if (cs_type == CS_TYPE_WAIT) {
-		struct hl_cs_compl *sig_waitcs_cmpl;
-
-		signal_seq_arr_len = chunk->num_signal_seq_arr;
-
-		/* currently only one signal seq is supported */
-		if (signal_seq_arr_len != 1) {
-			dev_err(hdev->dev,
-				"Wait for signal CS supports only one signal CS seq\n");
-			rc = -EINVAL;
+		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq);
+		if (rc)
 			goto free_cs_chunk_array;
-		}
 
-		signal_seq_arr = kmalloc_array(signal_seq_arr_len,
-						sizeof(*signal_seq_arr),
-						GFP_ATOMIC);
-		if (!signal_seq_arr) {
-			rc = -ENOMEM;
-			goto free_cs_chunk_array;
-		}
-
-		size_to_copy = chunk->num_signal_seq_arr *
-				sizeof(*signal_seq_arr);
-		if (copy_from_user(signal_seq_arr,
-					u64_to_user_ptr(chunk->signal_seq_arr),
-					size_to_copy)) {
-			dev_err(hdev->dev,
-				"Failed to copy signal seq array from user\n");
-			rc = -EFAULT;
-			goto free_signal_seq_array;
-		}
-
-		/* currently it is guaranteed to have only one signal seq */
-		signal_seq = signal_seq_arr[0];
 		sig_fence = hl_ctx_get_fence(ctx, signal_seq);
 		if (IS_ERR(sig_fence)) {
 			dev_err(hdev->dev,
 				"Failed to get signal CS with seq 0x%llx\n",
 				signal_seq);
 			rc = PTR_ERR(sig_fence);
-			goto free_signal_seq_array;
+			goto free_cs_chunk_array;
 		}
 
 		if (!sig_fence) {
 			/* signal CS already finished */
 			rc = 0;
-			goto free_signal_seq_array;
+			goto free_cs_chunk_array;
 		}
 
 		sig_waitcs_cmpl =
@@ -914,14 +984,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				signal_seq);
 			hl_fence_put(sig_fence);
 			rc = -EINVAL;
-			goto free_signal_seq_array;
+			goto free_cs_chunk_array;
 		}
 
 		if (completion_done(&sig_fence->completion)) {
 			/* signal CS already finished */
 			hl_fence_put(sig_fence);
 			rc = 0;
-			goto free_signal_seq_array;
+			goto free_cs_chunk_array;
 		}
 	}
 
@@ -933,70 +1003,31 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		if (cs_type == CS_TYPE_WAIT)
 			hl_fence_put(sig_fence);
 		hl_ctx_put(ctx);
-		goto free_signal_seq_array;
+		goto free_cs_chunk_array;
 	}
 
 	/*
 	 * Save the signal CS fence for later initialization right before
 	 * hanging the wait CS on the queue.
 	 */
-	if (cs->type == CS_TYPE_WAIT)
+	if (cs_type == CS_TYPE_WAIT)
 		cs->signal_fence = sig_fence;
 
 	hl_debugfs_add_cs(cs);
 
 	*cs_seq = cs->sequence;
 
-	job = hl_cs_allocate_job(hdev, q_type, true);
-	if (!job) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
-		atomic64_inc(&cntr->out_of_mem_drop_cnt);
-		dev_err(hdev->dev, "Failed to allocate a new job\n");
-		rc = -ENOMEM;
-		goto put_cs;
-	}
-
-	if (cs->type == CS_TYPE_WAIT)
-		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
-	else
-		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
+	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_SIGNAL)
+		rc = cs_ioctl_signal_wait_create_jobs(hdev, ctx, cs, q_type,
+				q_idx);
 
-	cb = hl_cb_kernel_create(hdev, cb_size,
-				q_type == QUEUE_TYPE_HW && hdev->mmu_enable);
-	if (!cb) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
-		atomic64_inc(&cntr->out_of_mem_drop_cnt);
-		kfree(job);
-		rc = -EFAULT;
+	if (rc)
 		goto put_cs;
-	}
 
-	job->id = 0;
-	job->cs = cs;
-	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
-	job->user_cb_size = cb_size;
-	job->hw_queue_id = q_idx;
-
-	/*
-	 * No need in parsing, user CB is the patched CB.
-	 * We call hl_cb_destroy() out of two reasons - we don't need the CB in
-	 * the CB idr anymore and to decrement its refcount as it was
-	 * incremented inside hl_cb_kernel_create().
-	 */
-	job->patched_cb = job->user_cb;
-	job->job_cb_size = job->user_cb_size;
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
-
-	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
-
-	list_add_tail(&job->cs_node, &cs->job_list);
 
 	/* increment refcount as for external queues we get completion */
 	cs_get(cs);
 
-	hl_debugfs_add_job(hdev, job);
-
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
 		if (rc != -EAGAIN)
@@ -1016,9 +1047,6 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 put_cs:
 	/* We finished with the CS in this function, so put the ref */
 	cs_put(cs);
-free_signal_seq_array:
-	if (cs_type == CS_TYPE_WAIT)
-		kfree(signal_seq_arr);
 free_cs_chunk_array:
 	kfree(cs_chunk_array);
 out:
-- 
2.17.1

