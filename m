Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C062A347E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgKBTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgKBTp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:45:27 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE3520731;
        Mon,  2 Nov 2020 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346327;
        bh=lo0IBN1ZG0QJIt1HgBezUROdxd8mSyZAwRupjjHYJwo=;
        h=From:To:Cc:Subject:Date:From;
        b=K2GDC4CTqrR/5645GiAOWT2dERcvJYQwYxjyTFSdDiSH4Q/TwJZPvFABbKxECV4at
         hTyr2f/KC745+Qge99Af6wZpbzEz6P+UtQRwX4sUL8ltgAj2JBLTfXuuqLOuQZSd4t
         BE+0Bje/TY20OyTqElOH2zovOyot/iTl3yddZHAs=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: change aggregate cs counters to atomic
Date:   Mon,  2 Nov 2020 21:45:23 +0200
Message-Id: <20201102194523.23096-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we will have multiple contexts/processes, we can't just
increment aggregated counters. We need to make them atomic as they can
be incremented by multiple processes

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 42 +++++++++----------
 drivers/misc/habanalabs/common/habanalabs.h   | 17 +++++++-
 .../misc/habanalabs/common/habanalabs_ioctl.c | 18 +++++++-
 drivers/misc/habanalabs/common/hw_queue.c     |  7 +++-
 4 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b2b974ecc431..9d49dd1558af 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -242,20 +242,6 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	kfree(job);
 }
 
-static void cs_counters_aggregate(struct hl_device *hdev, struct hl_ctx *ctx)
-{
-	hdev->aggregated_cs_counters.device_in_reset_drop_cnt +=
-			ctx->cs_counters.device_in_reset_drop_cnt;
-	hdev->aggregated_cs_counters.out_of_mem_drop_cnt +=
-			ctx->cs_counters.out_of_mem_drop_cnt;
-	hdev->aggregated_cs_counters.parsing_drop_cnt +=
-			ctx->cs_counters.parsing_drop_cnt;
-	hdev->aggregated_cs_counters.queue_full_drop_cnt +=
-			ctx->cs_counters.queue_full_drop_cnt;
-	hdev->aggregated_cs_counters.max_cs_in_flight_drop_cnt +=
-			ctx->cs_counters.max_cs_in_flight_drop_cnt;
-}
-
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs,
@@ -358,7 +344,6 @@ static void cs_do_release(struct kref *ref)
 
 	complete_all(&cs->fence->completion);
 	hl_fence_put(cs->fence);
-	cs_counters_aggregate(hdev, cs->ctx);
 
 	kfree(cs->jobs_in_queue_cnt);
 	kfree(cs);
@@ -397,11 +382,14 @@ static void cs_timedout(struct work_struct *work)
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 			enum hl_cs_type cs_type, struct hl_cs **cs_new)
 {
-	struct hl_cs_compl *cs_cmpl;
+	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *other = NULL;
+	struct hl_cs_compl *cs_cmpl;
 	struct hl_cs *cs;
 	int rc;
 
+	cntr = &hdev->aggregated_cs_counters;
+
 	cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
 	if (!cs)
 		return -ENOMEM;
@@ -436,6 +424,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		dev_dbg_ratelimited(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
 		ctx->cs_counters.max_cs_in_flight_drop_cnt++;
+		atomic64_inc(&cntr->max_cs_in_flight_drop_cnt);
 		rc = -EAGAIN;
 		goto free_fence;
 	}
@@ -610,6 +599,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 {
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_chunk *cs_chunk_array;
+	struct hl_cs_counters_atomic *cntr;
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
@@ -617,6 +607,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	u32 size_to_copy;
 	int rc, i;
 
+	cntr = &hdev->aggregated_cs_counters;
 	*cs_seq = ULLONG_MAX;
 
 	if (num_chunks > HL_MAX_JOBS_PER_CS) {
@@ -664,6 +655,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 						&is_kernel_allocated_cb);
 		if (rc) {
 			hpriv->ctx->cs_counters.parsing_drop_cnt++;
+			atomic64_inc(&cntr->parsing_drop_cnt);
 			goto free_cs_object;
 		}
 
@@ -671,6 +663,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 			cb = get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
 			if (!cb) {
 				hpriv->ctx->cs_counters.parsing_drop_cnt++;
+				atomic64_inc(&cntr->parsing_drop_cnt);
 				rc = -EINVAL;
 				goto free_cs_object;
 			}
@@ -685,6 +678,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 						is_kernel_allocated_cb);
 		if (!job) {
 			hpriv->ctx->cs_counters.out_of_mem_drop_cnt++;
+			atomic64_inc(&cntr->out_of_mem_drop_cnt);
 			dev_err(hdev->dev, "Failed to allocate a new job\n");
 			rc = -ENOMEM;
 			if (is_kernel_allocated_cb)
@@ -718,6 +712,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		rc = cs_parser(hpriv, job);
 		if (rc) {
 			hpriv->ctx->cs_counters.parsing_drop_cnt++;
+			atomic64_inc(&cntr->parsing_drop_cnt);
 			dev_err(hdev->dev,
 				"Failed to parse JOB %d.%llu.%d, err %d, rejecting the CS\n",
 				cs->ctx->asid, cs->sequence, job->id, rc);
@@ -727,6 +722,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 	if (int_queues_only) {
 		hpriv->ctx->cs_counters.parsing_drop_cnt++;
+		atomic64_inc(&cntr->parsing_drop_cnt);
 		dev_err(hdev->dev,
 			"Reject CS %d.%llu because only internal queues jobs are present\n",
 			cs->ctx->asid, cs->sequence);
@@ -768,20 +764,22 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
 				u64 *cs_seq)
 {
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_ctx *ctx = hpriv->ctx;
+	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
+	u64 *signal_seq_arr = NULL, signal_seq;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *sig_fence = NULL;
+	struct hl_ctx *ctx = hpriv->ctx;
+	enum hl_queue_type q_type;
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
-	enum hl_queue_type q_type;
-	u64 *signal_seq_arr = NULL, signal_seq;
-	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
 	int rc;
 
 	*cs_seq = ULLONG_MAX;
+	cntr = &hdev->aggregated_cs_counters;
 
 	if (num_chunks > HL_MAX_JOBS_PER_CS) {
 		dev_err(hdev->dev,
@@ -920,6 +918,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	job = hl_cs_allocate_job(hdev, q_type, true);
 	if (!job) {
 		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		rc = -ENOMEM;
 		goto put_cs;
@@ -934,6 +933,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				q_type == QUEUE_TYPE_HW && hdev->mmu_enable);
 	if (!cb) {
 		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		kfree(job);
 		rc = -EFAULT;
 		goto put_cs;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 80d4d7385ffe..d7cf833a20bc 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1067,6 +1067,21 @@ struct hl_cs_parser {
 	u8			contains_dma_pkt;
 };
 
+/**
+ * struct hl_info_cs_counters - command submission counters
+ * @out_of_mem_drop_cnt: dropped due to memory allocation issue
+ * @parsing_drop_cnt: dropped due to error in packet parsing
+ * @queue_full_drop_cnt: dropped due to queue full
+ * @device_in_reset_drop_cnt: dropped due to device in reset
+ * @max_cs_in_flight_drop_cnt: dropped due to maximum CS in-flight
+ */
+struct hl_cs_counters_atomic {
+	atomic64_t out_of_mem_drop_cnt;
+	atomic64_t parsing_drop_cnt;
+	atomic64_t queue_full_drop_cnt;
+	atomic64_t device_in_reset_drop_cnt;
+	atomic64_t max_cs_in_flight_drop_cnt;
+};
 
 /*
  * MEMORY STRUCTURE
@@ -1649,7 +1664,7 @@ struct hl_device {
 
 	struct hl_device_idle_busy_ts	*idle_busy_ts_arr;
 
-	struct hl_cs_counters		aggregated_cs_counters;
+	struct hl_cs_counters_atomic	aggregated_cs_counters;
 
 	struct hl_mmu_priv		mmu_priv;
 	struct hl_mmu_funcs		mmu_func;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 07317ea49129..350a768309bd 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -314,10 +314,13 @@ static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 
 static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
-	struct hl_device *hdev = hpriv->hdev;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct hl_info_cs_counters cs_counters = { {0} };
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_counters_atomic *cntr;
 	u32 max_size = args->return_size;
-	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	cntr = &hdev->aggregated_cs_counters;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
@@ -325,6 +328,17 @@ static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	memcpy(&cs_counters.cs_counters, &hdev->aggregated_cs_counters,
 			sizeof(struct hl_cs_counters));
 
+	cs_counters.cs_counters.out_of_mem_drop_cnt =
+			atomic64_read(&cntr->out_of_mem_drop_cnt);
+	cs_counters.cs_counters.parsing_drop_cnt =
+			atomic64_read(&cntr->parsing_drop_cnt);
+	cs_counters.cs_counters.queue_full_drop_cnt =
+			atomic64_read(&cntr->queue_full_drop_cnt);
+	cs_counters.cs_counters.device_in_reset_drop_cnt =
+			atomic64_read(&cntr->device_in_reset_drop_cnt);
+	cs_counters.cs_counters.max_cs_in_flight_drop_cnt =
+			atomic64_read(&cntr->max_cs_in_flight_drop_cnt);
+
 	if (hpriv->ctx)
 		memcpy(&cs_counters.ctx_cs_counters, &hpriv->ctx->cs_counters,
 				sizeof(struct hl_cs_counters));
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 5e66c98fb0d3..adb61f9eb2b5 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -485,17 +485,21 @@ static void init_signal_wait_cs(struct hl_cs *cs)
  */
 int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 {
+	struct hl_cs_counters_atomic *cntr;
 	struct hl_ctx *ctx = cs->ctx;
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_cs_job *job, *tmp;
 	struct hl_hw_queue *q;
-	u32 max_queues;
 	int rc = 0, i, cq_cnt;
+	u32 max_queues;
+
+	cntr = &hdev->aggregated_cs_counters;
 
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		ctx->cs_counters.device_in_reset_drop_cnt++;
+		atomic64_inc(&cntr->device_in_reset_drop_cnt);
 		dev_err(hdev->dev,
 			"device is disabled or in reset, CS rejected!\n");
 		rc = -EPERM;
@@ -529,6 +533,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 			if (rc) {
 				ctx->cs_counters.queue_full_drop_cnt++;
+				atomic64_inc(&cntr->queue_full_drop_cnt);
 				goto unroll_cq_resv;
 			}
 
-- 
2.17.1

