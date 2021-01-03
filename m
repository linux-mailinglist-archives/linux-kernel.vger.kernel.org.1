Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A987B2E8E18
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhACU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbhACU36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:29:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E915207D1;
        Sun,  3 Jan 2021 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609705757;
        bh=zDt3iwuu9AYkKkBldQtOMaAcyfsi1A0DOfGTnYjHXh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utbm2JcPVQauR96saxsLaXd7P7VukROq3e8FaLOklS1ol3ko630HwE6iiJ4Y38h70
         zkoKa37rC3gNIU9FQjA7hDfdzYlKz2tGY5HNOAmuSoi2+VXXRcHF1SbjLpz5kYEPex
         cD3iIW4qqw/I2YA2Ud768hhzjs1+czBZRj4KsXDoIC1+rRBuYwwBGv+Qdr8yd/n2oe
         3Ubhd6OY+Jpcn4Wq0OIzYKJhTF26k4pvaIaY53ASZ91dSuHTQSJdgbfBR1cnk7KVMS
         MYvG4d4cI6YkqC9qFfEzCDXuiqSWr9iCmK/YL5IO4CP92BFq7GD8oeugCSyKVRFwXU
         qdnWaGvr5Z2gw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs: add driver support for internal cb scheduling
Date:   Sun,  3 Jan 2021 22:29:08 +0200
Message-Id: <20210103202909.243-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103202909.243-1-ogabbay@kernel.org>
References: <20210103202909.243-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support scnenarios in which driver needs access to
HW components but it cannot access them directly, we add support for
scheduling command buffers internally.
These command buffers will be transmitted upon next user command
submission context.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 141 ++++++++++++++++++
 drivers/misc/habanalabs/common/context.c      |   3 +
 drivers/misc/habanalabs/common/device.c       |   2 +
 drivers/misc/habanalabs/common/habanalabs.h   |  26 ++++
 4 files changed, 172 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 3affb350070c..2dd69d6d4782 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -585,6 +585,18 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 	}
 }
 
+void hl_pending_cb_rollback_all(struct hl_device *hdev)
+{
+	struct hl_pending_cb *pending_cb, *tmp;
+
+	list_for_each_entry_safe(pending_cb, tmp,
+			&hdev->kernel_ctx->pending_cb_list, cb_node) {
+		list_del(&pending_cb->cb_node);
+		hl_cb_put(pending_cb->cb);
+		kfree(pending_cb);
+	}
+}
+
 static void job_wq_completion(struct work_struct *work)
 {
 	struct hl_cs_job *job = container_of(work, struct hl_cs_job,
@@ -954,6 +966,131 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	return rc;
 }
 
+static int pending_cb_create_job(struct hl_device *hdev, struct hl_ctx *ctx,
+		struct hl_cs *cs, struct hl_cb *cb, u32 size, u32 hw_queue_id)
+{
+	struct hw_queue_properties *hw_queue_prop;
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_cs_job *job;
+
+	hw_queue_prop = &hdev->asic_prop.hw_queues_props[hw_queue_id];
+	cntr = &hdev->aggregated_cs_counters;
+
+	job = hl_cs_allocate_job(hdev, hw_queue_prop->type, true);
+	if (!job) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		return -ENOMEM;
+	}
+
+	job->id = 0;
+	job->cs = cs;
+	job->user_cb = cb;
+	atomic_inc(&job->user_cb->cs_cnt);
+	job->user_cb_size = size;
+	job->hw_queue_id = hw_queue_id;
+	job->patched_cb = job->user_cb;
+	job->job_cb_size = job->user_cb_size;
+
+	/* increment refcount as for external queues we get completion */
+	cs_get(cs);
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
+static int hl_submit_pending_cb(struct hl_fpriv *hpriv)
+{
+	struct hw_queue_properties *hw_queue_prop;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
+	struct hl_pending_cb *pending_cb, *tmp;
+	struct list_head local_cb_list;
+	struct hl_cs *cs;
+	struct hl_cb *cb;
+	u32 hw_queue_id;
+	u32 cb_size;
+	int process_list, rc = 0;
+
+	if (list_empty(&ctx->pending_cb_list))
+		return 0;
+
+	process_list = atomic_cmpxchg(&ctx->thread_pending_cb_token, 1, 0);
+
+	/* Only a single thread is allowed to process the list */
+	if (!process_list)
+		return 0;
+
+	if (list_empty(&ctx->pending_cb_list))
+		goto free_pending_cb_token;
+
+	/* move all list elements to a local list */
+	INIT_LIST_HEAD(&local_cb_list);
+	spin_lock(&ctx->pending_cb_lock);
+	list_for_each_entry_safe(pending_cb, tmp, &ctx->pending_cb_list,
+								cb_node)
+		list_move_tail(&pending_cb->cb_node, &local_cb_list);
+	spin_unlock(&ctx->pending_cb_lock);
+
+	rc = allocate_cs(hdev, ctx, CS_TYPE_DEFAULT, &cs);
+	if (rc)
+		goto add_list_elements;
+
+	hl_debugfs_add_cs(cs);
+
+	/* Iterate through pending cb list, create jobs and add to CS */
+	list_for_each_entry(pending_cb, &local_cb_list, cb_node) {
+		cb = pending_cb->cb;
+		cb_size = pending_cb->cb_size;
+		hw_queue_id = pending_cb->hw_queue_id;
+		hw_queue_prop = &hdev->asic_prop.hw_queues_props[hw_queue_id];
+
+		rc = pending_cb_create_job(hdev, ctx, cs, cb, cb_size,
+								hw_queue_id);
+		if (rc)
+			goto free_cs_object;
+	}
+
+	rc = hl_hw_queue_schedule_cs(cs);
+	if (rc) {
+		if (rc != -EAGAIN)
+			dev_err(hdev->dev,
+				"Failed to submit CS %d.%llu (%d)\n",
+				ctx->asid, cs->sequence, rc);
+		goto free_cs_object;
+	}
+
+	/* pending cb was scheduled successfully */
+	list_for_each_entry_safe(pending_cb, tmp, &local_cb_list, cb_node) {
+		list_del(&pending_cb->cb_node);
+		kfree(pending_cb);
+	}
+
+	cs_put(cs);
+
+	goto free_pending_cb_token;
+
+free_cs_object:
+	cs_rollback(hdev, cs);
+	cs_put(cs);
+add_list_elements:
+	spin_lock(&ctx->pending_cb_lock);
+	list_for_each_entry_safe_reverse(pending_cb, tmp, &local_cb_list,
+								cb_node)
+		list_move(&pending_cb->cb_node, &ctx->pending_cb_list);
+	spin_unlock(&ctx->pending_cb_lock);
+free_pending_cb_token:
+	atomic_set(&ctx->thread_pending_cb_token, 1);
+
+	return rc;
+}
+
 static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 				u64 *cs_seq)
 {
@@ -1353,6 +1490,10 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	if (rc)
 		goto out;
 
+	rc = hl_submit_pending_cb(hpriv);
+	if (rc)
+		goto out;
+
 	cs_type = hl_cs_get_cs_type(args->in.cs_flags &
 					~HL_CS_FLAGS_FORCE_RESTORE);
 	chunks = (void __user *) (uintptr_t) args->in.chunks_execute;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 3d86b83f4ca6..a5003461b577 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -142,8 +142,11 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	kref_init(&ctx->refcount);
 
 	ctx->cs_sequence = 1;
+	INIT_LIST_HEAD(&ctx->pending_cb_list);
+	spin_lock_init(&ctx->pending_cb_lock);
 	spin_lock_init(&ctx->cs_lock);
 	atomic_set(&ctx->thread_ctx_switch_token, 1);
+	atomic_set(&ctx->thread_pending_cb_token, 1);
 	ctx->thread_ctx_switch_wait_token = 0;
 	ctx->cs_pending = kcalloc(hdev->asic_prop.max_pending_cs,
 				sizeof(struct hl_fence *),
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9ef77a2a34ec..66ca8bd8fc70 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -998,6 +998,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
+	hl_pending_cb_rollback_all(hdev);
 
 kill_processes:
 	if (hard_reset) {
@@ -1519,6 +1520,7 @@ void hl_device_fini(struct hl_device *hdev)
 
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
+	hl_pending_cb_rollback_all(hdev);
 
 	/* Kill processes here after CS rollback. This is because the process
 	 * can't really exit until all its CSs are done, which is what we
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 537545df531a..c4ca55467bdd 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1016,6 +1016,20 @@ struct hl_cs_counters_atomic {
 	atomic64_t validation_drop_cnt;
 };
 
+/**
+ * struct hl_pending_cb - pending command buffer structure
+ * @cb_node: cb node in pending cb list
+ * @cb: command buffer to send in next submission
+ * @cb_size: command buffer size
+ * @hw_queue_id: destination queue id
+ */
+struct hl_pending_cb {
+	struct list_head	cb_node;
+	struct hl_cb		*cb;
+	u32			cb_size;
+	u32			hw_queue_id;
+};
+
 /**
  * struct hl_ctx - user/kernel context.
  * @mem_hash: holds mapping from virtual address to virtual memory area
@@ -1031,6 +1045,8 @@ struct hl_cs_counters_atomic {
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
  *            MMU hash or walking the PGT requires talking this lock.
  * @debugfs_list: node in debugfs list of contexts.
+ * pending_cb_list: list of pending command buffers waiting to be sent upon
+ *                  next user command submission context.
  * @cs_counters: context command submission counters.
  * @cb_va_pool: device VA pool for command buffers which are mapped to the
  *              device's MMU.
@@ -1039,11 +1055,17 @@ struct hl_cs_counters_atomic {
  *			index to cs_pending array.
  * @dram_default_hops: array that holds all hops addresses needed for default
  *                     DRAM mapping.
+ * @pending_cb_lock: spinlock to protect pending cb list
  * @cs_lock: spinlock to protect cs_sequence.
  * @dram_phys_mem: amount of used physical DRAM memory by this context.
  * @thread_ctx_switch_token: token to prevent multiple threads of the same
  *				context	from running the context switch phase.
  *				Only a single thread should run it.
+ * @thread_pending_cb_token: token to prevent multiple threads from processing
+ *				the pending CB list. Only a single thread should
+ *				process the list since it is protected by a
+ *				spinlock and we don't want to halt the entire
+ *				command submission sequence.
  * @thread_ctx_switch_wait_token: token to prevent the threads that didn't run
  *				the context switch phase from moving to their
  *				execution phase before the context switch phase
@@ -1062,13 +1084,16 @@ struct hl_ctx {
 	struct mutex			mem_hash_lock;
 	struct mutex			mmu_lock;
 	struct list_head		debugfs_list;
+	struct list_head		pending_cb_list;
 	struct hl_cs_counters_atomic	cs_counters;
 	struct gen_pool			*cb_va_pool;
 	u64				cs_sequence;
 	u64				*dram_default_hops;
+	spinlock_t			pending_cb_lock;
 	spinlock_t			cs_lock;
 	atomic64_t			dram_phys_mem;
 	atomic_t			thread_ctx_switch_token;
+	atomic_t			thread_pending_cb_token;
 	u32				thread_ctx_switch_wait_token;
 	u32				asid;
 	u32				handle;
@@ -2143,6 +2168,7 @@ int hl_cb_va_pool_init(struct hl_ctx *ctx);
 void hl_cb_va_pool_fini(struct hl_ctx *ctx);
 
 void hl_cs_rollback_all(struct hl_device *hdev);
+void hl_pending_cb_rollback_all(struct hl_device *hdev);
 struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 		enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
 void hl_sob_reset_error(struct kref *ref);
-- 
2.25.1

