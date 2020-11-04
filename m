Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF02A5FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKDIgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbgKDIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:40 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F312080C;
        Wed,  4 Nov 2020 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604478999;
        bh=cw/KJYk7YpoFG2Uukii5llyop9aZMQEGLBhLVQKB078=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzI491zqM6xqzxd+n1KI7Z1AQWz81Fa1Md0ZZ61Q16Z+6rNSo4u7boTYYV4cPyF7Y
         0VGCdRkEtEzNpcYtnSlZpMJTQSSpRgRyd9arkAqJqp9vFejdS6q/HBZFgrvK+mF1YY
         ISgdy3aUD/bvat70tlpUvVLY3RuF+b+/sq6xmcN8=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: fix cs counters structure
Date:   Wed,  4 Nov 2020 10:36:25 +0200
Message-Id: <20201104083630.28402-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Fix cs counters structure in uapi to be one flat structure instead
of two instances of the same other structure.
use atomic read/increment for context counters so we could use
one structure for both aggregated and context counters.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 18 +++--
 drivers/misc/habanalabs/common/habanalabs.h   | 73 ++++++++++---------
 .../misc/habanalabs/common/habanalabs_ioctl.c | 35 ++++++---
 drivers/misc/habanalabs/common/hw_queue.c     |  5 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  4 +-
 include/uapi/misc/habanalabs.h                | 35 +++++----
 6 files changed, 95 insertions(+), 75 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 746005f7f991..e9529f3efc1b 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -462,7 +462,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	if (other && !completion_done(&other->completion)) {
 		dev_dbg_ratelimited(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
-		ctx->cs_counters.max_cs_in_flight_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.max_cs_in_flight_drop_cnt);
 		atomic64_inc(&cntr->max_cs_in_flight_drop_cnt);
 		rc = -EAGAIN;
 		goto free_fence;
@@ -720,7 +720,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		rc = validate_queue_index(hdev, chunk, &queue_type,
 						&is_kernel_allocated_cb);
 		if (rc) {
-			hpriv->ctx->cs_counters.parsing_drop_cnt++;
+			atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
 			atomic64_inc(&cntr->parsing_drop_cnt);
 			goto free_cs_object;
 		}
@@ -728,7 +728,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		if (is_kernel_allocated_cb) {
 			cb = get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
 			if (!cb) {
-				hpriv->ctx->cs_counters.parsing_drop_cnt++;
+				atomic64_inc(
+				&hpriv->ctx->cs_counters.parsing_drop_cnt);
 				atomic64_inc(&cntr->parsing_drop_cnt);
 				rc = -EINVAL;
 				goto free_cs_object;
@@ -743,7 +744,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		job = hl_cs_allocate_job(hdev, queue_type,
 						is_kernel_allocated_cb);
 		if (!job) {
-			hpriv->ctx->cs_counters.out_of_mem_drop_cnt++;
+			atomic64_inc(
+			&hpriv->ctx->cs_counters.out_of_mem_drop_cnt);
 			atomic64_inc(&cntr->out_of_mem_drop_cnt);
 			dev_err(hdev->dev, "Failed to allocate a new job\n");
 			rc = -ENOMEM;
@@ -777,7 +779,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 		rc = cs_parser(hpriv, job);
 		if (rc) {
-			hpriv->ctx->cs_counters.parsing_drop_cnt++;
+			atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
 			atomic64_inc(&cntr->parsing_drop_cnt);
 			dev_err(hdev->dev,
 				"Failed to parse JOB %d.%llu.%d, err %d, rejecting the CS\n",
@@ -787,7 +789,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	}
 
 	if (int_queues_only) {
-		hpriv->ctx->cs_counters.parsing_drop_cnt++;
+		atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
 		atomic64_inc(&cntr->parsing_drop_cnt);
 		dev_err(hdev->dev,
 			"Reject CS %d.%llu because only internal queues jobs are present\n",
@@ -880,7 +882,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 
 	job = hl_cs_allocate_job(hdev, q_type, true);
 	if (!job) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		return -ENOMEM;
@@ -894,7 +896,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	cb = hl_cb_kernel_create(hdev, cb_size,
 				q_type == QUEUE_TYPE_HW && hdev->mmu_enable);
 	if (!cb) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		kfree(job);
 		return -EFAULT;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2b17c13a2e34..0fe108eef1a4 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -936,6 +936,22 @@ struct hl_va_range {
 	u64			end_addr;
 };
 
+/**
+ * struct hl_cs_counters_atomic - command submission counters
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
+
 /**
  * struct hl_ctx - user/kernel context.
  * @mem_hash: holds mapping from virtual address to virtual memory area
@@ -954,6 +970,7 @@ struct hl_va_range {
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
  *            MMU hash or walking the PGT requires talking this lock.
  * @debugfs_list: node in debugfs list of contexts.
+ * @cs_counters: context command submission counters.
  * @cb_va_pool: device VA pool for command buffers which are mapped to the
  *              device's MMU.
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
@@ -976,26 +993,26 @@ struct hl_va_range {
 struct hl_ctx {
 	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
 	DECLARE_HASHTABLE(mmu_shadow_hash, MMU_HASH_TABLE_BITS);
-	struct hl_fpriv		*hpriv;
-	struct hl_device	*hdev;
-	struct kref		refcount;
-	struct hl_fence		**cs_pending;
-	struct hl_va_range	*host_va_range;
-	struct hl_va_range	*host_huge_va_range;
-	struct hl_va_range	*dram_va_range;
-	struct mutex		mem_hash_lock;
-	struct mutex		mmu_lock;
-	struct list_head	debugfs_list;
-	struct hl_cs_counters	cs_counters;
-	struct gen_pool		*cb_va_pool;
-	u64			cs_sequence;
-	u64			*dram_default_hops;
-	spinlock_t		cs_lock;
-	atomic64_t		dram_phys_mem;
-	atomic_t		thread_ctx_switch_token;
-	u32			thread_ctx_switch_wait_token;
-	u32			asid;
-	u32			handle;
+	struct hl_fpriv			*hpriv;
+	struct hl_device		*hdev;
+	struct kref			refcount;
+	struct hl_fence			**cs_pending;
+	struct hl_va_range		*host_va_range;
+	struct hl_va_range		*host_huge_va_range;
+	struct hl_va_range		*dram_va_range;
+	struct mutex			mem_hash_lock;
+	struct mutex			mmu_lock;
+	struct list_head		debugfs_list;
+	struct hl_cs_counters_atomic	cs_counters;
+	struct gen_pool			*cb_va_pool;
+	u64				cs_sequence;
+	u64				*dram_default_hops;
+	spinlock_t			cs_lock;
+	atomic64_t			dram_phys_mem;
+	atomic_t			thread_ctx_switch_token;
+	u32				thread_ctx_switch_wait_token;
+	u32				asid;
+	u32				handle;
 };
 
 /**
@@ -1164,22 +1181,6 @@ struct hl_cs_parser {
 	u8			contains_dma_pkt;
 };
 
-/**
- * struct hl_info_cs_counters - command submission counters
- * @out_of_mem_drop_cnt: dropped due to memory allocation issue
- * @parsing_drop_cnt: dropped due to error in packet parsing
- * @queue_full_drop_cnt: dropped due to queue full
- * @device_in_reset_drop_cnt: dropped due to device in reset
- * @max_cs_in_flight_drop_cnt: dropped due to maximum CS in-flight
- */
-struct hl_cs_counters_atomic {
-	atomic64_t out_of_mem_drop_cnt;
-	atomic64_t parsing_drop_cnt;
-	atomic64_t queue_full_drop_cnt;
-	atomic64_t device_in_reset_drop_cnt;
-	atomic64_t max_cs_in_flight_drop_cnt;
-};
-
 /*
  * MEMORY STRUCTURE
  */
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 350a768309bd..1d8bea626e78 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -315,7 +315,7 @@ static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
-	struct hl_info_cs_counters cs_counters = { {0} };
+	struct hl_info_cs_counters cs_counters = {0};
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_counters_atomic *cntr;
 	u32 max_size = args->return_size;
@@ -325,23 +325,34 @@ static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	memcpy(&cs_counters.cs_counters, &hdev->aggregated_cs_counters,
-			sizeof(struct hl_cs_counters));
-
-	cs_counters.cs_counters.out_of_mem_drop_cnt =
+	cs_counters.total_out_of_mem_drop_cnt =
 			atomic64_read(&cntr->out_of_mem_drop_cnt);
-	cs_counters.cs_counters.parsing_drop_cnt =
+	cs_counters.total_parsing_drop_cnt =
 			atomic64_read(&cntr->parsing_drop_cnt);
-	cs_counters.cs_counters.queue_full_drop_cnt =
+	cs_counters.total_queue_full_drop_cnt =
 			atomic64_read(&cntr->queue_full_drop_cnt);
-	cs_counters.cs_counters.device_in_reset_drop_cnt =
+	cs_counters.total_device_in_reset_drop_cnt =
 			atomic64_read(&cntr->device_in_reset_drop_cnt);
-	cs_counters.cs_counters.max_cs_in_flight_drop_cnt =
+	cs_counters.total_max_cs_in_flight_drop_cnt =
 			atomic64_read(&cntr->max_cs_in_flight_drop_cnt);
 
-	if (hpriv->ctx)
-		memcpy(&cs_counters.ctx_cs_counters, &hpriv->ctx->cs_counters,
-				sizeof(struct hl_cs_counters));
+	if (hpriv->ctx) {
+		cs_counters.ctx_out_of_mem_drop_cnt =
+				atomic64_read(
+				&hpriv->ctx->cs_counters.out_of_mem_drop_cnt);
+		cs_counters.ctx_parsing_drop_cnt =
+				atomic64_read(
+				&hpriv->ctx->cs_counters.parsing_drop_cnt);
+		cs_counters.ctx_queue_full_drop_cnt =
+				atomic64_read(
+				&hpriv->ctx->cs_counters.queue_full_drop_cnt);
+		cs_counters.ctx_device_in_reset_drop_cnt =
+				atomic64_read(
+			&hpriv->ctx->cs_counters.device_in_reset_drop_cnt);
+		cs_counters.ctx_max_cs_in_flight_drop_cnt =
+				atomic64_read(
+			&hpriv->ctx->cs_counters.max_cs_in_flight_drop_cnt);
+	}
 
 	return copy_to_user(out, &cs_counters,
 		min((size_t) max_size, sizeof(cs_counters))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 8a15db724116..239e2ba0545f 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -524,7 +524,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
-		ctx->cs_counters.device_in_reset_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.device_in_reset_drop_cnt);
 		atomic64_inc(&cntr->device_in_reset_drop_cnt);
 		dev_err(hdev->dev,
 			"device is disabled or in reset, CS rejected!\n");
@@ -558,7 +558,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 			}
 
 			if (rc) {
-				ctx->cs_counters.queue_full_drop_cnt++;
+				atomic64_inc(
+					&ctx->cs_counters.queue_full_drop_cnt);
 				atomic64_inc(&cntr->queue_full_drop_cnt);
 				goto unroll_cq_resv;
 			}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d8fdcae542c0..e5a2b7da0a20 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1141,7 +1141,7 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[queue_id];
 	job = hl_cs_allocate_job(hdev, hw_queue_prop->type, true);
 	if (!job) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		return -ENOMEM;
@@ -1151,7 +1151,7 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 	cb = hl_cb_kernel_create(hdev, cb_size,
 			hdev->mmu_enable && !patched_cb);
 	if (!cb) {
-		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		kfree(job);
 		return -EFAULT;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 0185311b679b..61f8f9144b54 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -407,23 +407,28 @@ struct hl_info_sync_manager {
 
 /**
  * struct hl_info_cs_counters - command submission counters
- * @out_of_mem_drop_cnt: dropped due to memory allocation issue
- * @parsing_drop_cnt: dropped due to error in packet parsing
- * @queue_full_drop_cnt: dropped due to queue full
- * @device_in_reset_drop_cnt: dropped due to device in reset
- * @max_cs_in_flight_drop_cnt: dropped due to maximum CS in-flight
+ * @total_out_of_mem_drop_cnt: total dropped due to memory allocation issue
+ * @ctx_out_of_mem_drop_cnt: context dropped due to memory allocation issue
+ * @total_parsing_drop_cnt: total dropped due to error in packet parsing
+ * @ctx_parsing_drop_cnt: context dropped due to error in packet parsing
+ * @total_queue_full_drop_cnt: total dropped due to queue full
+ * @ctx_queue_full_drop_cnt: context dropped due to queue full
+ * @total_device_in_reset_drop_cnt: total dropped due to device in reset
+ * @ctx_device_in_reset_drop_cnt: context dropped due to device in reset
+ * @total_max_cs_in_flight_drop_cnt: total dropped due to maximum CS in-flight
+ * @ctx_max_cs_in_flight_drop_cnt: context dropped due to maximum CS in-flight
  */
-struct hl_cs_counters {
-	__u64 out_of_mem_drop_cnt;
-	__u64 parsing_drop_cnt;
-	__u64 queue_full_drop_cnt;
-	__u64 device_in_reset_drop_cnt;
-	__u64 max_cs_in_flight_drop_cnt;
-};
-
 struct hl_info_cs_counters {
-	struct hl_cs_counters cs_counters;
-	struct hl_cs_counters ctx_cs_counters;
+	__u64 total_out_of_mem_drop_cnt;
+	__u64 ctx_out_of_mem_drop_cnt;
+	__u64 total_parsing_drop_cnt;
+	__u64 ctx_parsing_drop_cnt;
+	__u64 total_queue_full_drop_cnt;
+	__u64 ctx_queue_full_drop_cnt;
+	__u64 total_device_in_reset_drop_cnt;
+	__u64 ctx_device_in_reset_drop_cnt;
+	__u64 total_max_cs_in_flight_drop_cnt;
+	__u64 ctx_max_cs_in_flight_drop_cnt;
 };
 
 enum gaudi_dcores {
-- 
2.17.1

