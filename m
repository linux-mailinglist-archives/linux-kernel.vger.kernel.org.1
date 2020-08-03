Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9B23A382
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHCLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHCLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:44:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC06C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:44:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so30332719wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MSBSvmjm8Dab2AsIfnzY3jPCUEYi7Wki8rvAcELJwN8=;
        b=akTfqrW0jov/Or3O6P2ONODMhbsETl00Pq8mhuKef/BKShsAinsxZ8o1JUfRSmqlfy
         5QPrjSmKaDEepVcdGUDSbLygaI8tjk05PlYNjmsoEv5/0kwYwS+oQhQcwlNW5ZpPiu9z
         ou8Mf6Km8RBn5NxIq9zPW27utx/GyJbtJOBIaOT18giyrhQo0ftrKZYKBUsyIwFodfMk
         isZtdG9rYYsyBrN6MXfuVI6Pq4g6s6iGMncIxLqcdOw53+yf+Swpmib6rwLAuJgzErPH
         CMswV5DjZnS38+snyW9OOzGzoSGxT/2e9CPQLDuZ3yZNe+wwhxPxFElS8wE+ws8i4ZJa
         ydwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MSBSvmjm8Dab2AsIfnzY3jPCUEYi7Wki8rvAcELJwN8=;
        b=J2o3Rtp8xy0V+gPUU8KRASxzKigz8jZpm0Q4qm3olbISunubrv3KiNt6Xrxtc4bdL0
         GxCezmg8lUfaCVoFPKAYfFiyLnXlb+s7da4ZKKDGeZz7OxvWDgMcGHIfamAGdTWNDf+m
         pMGIYyJtKlB4M9w+FrBwtVOfsTiJ7PHjp/CoUEB4m7Am0IKgS/m03xWP/lqEJS9u3SFP
         4eUiO1/NJkwNhmxRNXB301NGw2aJgjsLYU3IDxUkqGXLgOUrxsDBTG1qQug1EbNmgDgD
         U9HgBUOlFZthEedoChnqoYGgRZRDhr1IY43rdWzGhnP9eKwt7UtNU9yLpiAO8DoXwer0
         cQZw==
X-Gm-Message-State: AOAM532ax1ROAMhNsWFXh7mno25vsdBeeVDCTkAhhif07u8fvO/WXpQt
        goqLGsZbJQdoHnZVCV5AbwD59L+W
X-Google-Smtp-Source: ABdhPJz/bAQGun66KYA1f1lhVpdkDVYhlKDpqcB9S4hnntd/lS4Z22pG6iioDRfUTO57qzmxL03AUg==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr14076463wrh.381.1596455047343;
        Mon, 03 Aug 2020 04:44:07 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 128sm24155441wmz.43.2020.08.03.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:44:05 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 1/2] habanalabs: Replace dma-fence mechanism with completions
Date:   Mon,  3 Aug 2020 14:44:01 +0300
Message-Id: <20200803114402.26013-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

habanalabs driver uses dma-fence mechanism for synchronization.
dma-fence mechanism was designed solely for GPUs, hence we purpose
a simpler mechanism based on completions to replace current
dma-fence objects.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Replace kfree_rcu with regular kfree

 .../habanalabs/common/command_submission.c    | 95 +++++++++----------
 drivers/misc/habanalabs/common/context.c      | 13 +--
 drivers/misc/habanalabs/common/habanalabs.h   | 30 ++++--
 drivers/misc/habanalabs/common/hw_queue.c     |  2 +-
 4 files changed, 77 insertions(+), 63 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b9840e368eb5..3d79ad3ce7e0 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -38,26 +38,10 @@ void hl_sob_reset_error(struct kref *ref)
 			hw_sob->q_idx, hw_sob->sob_id);
 }
 
-static const char *hl_fence_get_driver_name(struct dma_fence *fence)
-{
-	return "HabanaLabs";
-}
-
-static const char *hl_fence_get_timeline_name(struct dma_fence *fence)
-{
-	struct hl_cs_compl *hl_cs_compl =
-		container_of(fence, struct hl_cs_compl, base_fence);
-
-	return dev_name(hl_cs_compl->hdev->dev);
-}
-
-static bool hl_fence_enable_signaling(struct dma_fence *fence)
-{
-	return true;
-}
-
-static void hl_fence_release(struct dma_fence *fence)
+void hl_fence_release(struct kref *kref)
 {
+	struct hl_fence *fence =
+		container_of(kref, struct hl_fence, refcount);
 	struct hl_cs_compl *hl_cs_cmpl =
 		container_of(fence, struct hl_cs_compl, base_fence);
 	struct hl_device *hdev = hl_cs_cmpl->hdev;
@@ -99,15 +83,27 @@ static void hl_fence_release(struct dma_fence *fence)
 	}
 
 free:
-	kfree_rcu(hl_cs_cmpl, base_fence.rcu);
+	kfree(hl_cs_cmpl);
 }
 
-static const struct dma_fence_ops hl_fence_ops = {
-	.get_driver_name = hl_fence_get_driver_name,
-	.get_timeline_name = hl_fence_get_timeline_name,
-	.enable_signaling = hl_fence_enable_signaling,
-	.release = hl_fence_release
-};
+void hl_fence_put(struct hl_fence *fence)
+{
+	if (fence)
+		kref_put(&fence->refcount, hl_fence_release);
+}
+
+void hl_fence_get(struct hl_fence *fence)
+{
+	if (fence)
+		kref_get(&fence->refcount);
+}
+
+void hl_fence_init(struct hl_fence *fence)
+{
+	kref_init(&fence->refcount);
+	fence->error = 0;
+	init_completion(&fence->completion);
+}
 
 static void cs_get(struct hl_cs *cs)
 {
@@ -336,7 +332,7 @@ static void cs_do_release(struct kref *ref)
 		 * In case the wait for signal CS was submitted, the put occurs
 		 * in init_signal_wait_cs() right before hanging on the PQ.
 		 */
-		dma_fence_put(cs->signal_fence);
+		hl_fence_put(cs->signal_fence);
 	}
 
 	/*
@@ -348,19 +344,18 @@ static void cs_do_release(struct kref *ref)
 	hl_ctx_put(cs->ctx);
 
 	/* We need to mark an error for not submitted because in that case
-	 * the dma fence release flow is different. Mainly, we don't need
+	 * the hl fence release flow is different. Mainly, we don't need
 	 * to handle hw_sob for signal/wait
 	 */
 	if (cs->timedout)
-		dma_fence_set_error(cs->fence, -ETIMEDOUT);
+		cs->fence->error = -ETIMEDOUT;
 	else if (cs->aborted)
-		dma_fence_set_error(cs->fence, -EIO);
+		cs->fence->error = -EIO;
 	else if (!cs->submitted)
-		dma_fence_set_error(cs->fence, -EBUSY);
-
-	dma_fence_signal(cs->fence);
-	dma_fence_put(cs->fence);
+		cs->fence->error = -EBUSY;
 
+	complete_all(&cs->fence->completion);
+	hl_fence_put(cs->fence);
 	cs_counters_aggregate(hdev, cs->ctx);
 
 	kfree(cs->jobs_in_queue_cnt);
@@ -401,7 +396,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 			enum hl_cs_type cs_type, struct hl_cs **cs_new)
 {
 	struct hl_cs_compl *cs_cmpl;
-	struct dma_fence *other = NULL;
+	struct hl_fence *other = NULL;
 	struct hl_cs *cs;
 	int rc;
 
@@ -434,7 +429,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs_cmpl->cs_seq = ctx->cs_sequence;
 	other = ctx->cs_pending[cs_cmpl->cs_seq &
 				(hdev->asic_prop.max_pending_cs - 1)];
-	if ((other) && (!dma_fence_is_signaled(other))) {
+
+	if (other && !completion_done(&other->completion)) {
 		dev_dbg(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
 		rc = -EAGAIN;
@@ -448,8 +444,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_fence;
 	}
 
-	dma_fence_init(&cs_cmpl->base_fence, &hl_fence_ops, &cs_cmpl->lock,
-			ctx->asid, ctx->cs_sequence);
+	/* init hl_fence */
+	hl_fence_init(&cs_cmpl->base_fence);
 
 	cs->sequence = cs_cmpl->cs_seq;
 
@@ -458,9 +454,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 							&cs_cmpl->base_fence;
 	ctx->cs_sequence++;
 
-	dma_fence_get(&cs_cmpl->base_fence);
+	hl_fence_get(&cs_cmpl->base_fence);
 
-	dma_fence_put(other);
+	hl_fence_put(other);
 
 	spin_unlock(&ctx->cs_lock);
 
@@ -773,7 +769,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
-	struct dma_fence *sig_fence = NULL;
+	struct hl_fence *sig_fence = NULL;
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
@@ -875,14 +871,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			dev_err(hdev->dev,
 				"CS seq 0x%llx is not of a signal CS\n",
 				signal_seq);
-			dma_fence_put(sig_fence);
+			hl_fence_put(sig_fence);
 			rc = -EINVAL;
 			goto free_signal_seq_array;
 		}
 
-		if (dma_fence_is_signaled(sig_fence)) {
+		if (completion_done(&sig_fence->completion)) {
 			/* signal CS already finished */
-			dma_fence_put(sig_fence);
+			hl_fence_put(sig_fence);
 			rc = 0;
 			goto free_signal_seq_array;
 		}
@@ -894,7 +890,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	rc = allocate_cs(hdev, ctx, cs_type, &cs);
 	if (rc) {
 		if (cs_type == CS_TYPE_WAIT)
-			dma_fence_put(sig_fence);
+			hl_fence_put(sig_fence);
 		hl_ctx_put(ctx);
 		goto free_signal_seq_array;
 	}
@@ -1154,7 +1150,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq)
 {
-	struct dma_fence *fence;
+	struct hl_fence *fence;
 	unsigned long timeout;
 	long rc;
 
@@ -1173,12 +1169,15 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 				"Can't wait on CS %llu because current CS is at seq %llu\n",
 				seq, ctx->cs_sequence);
 	} else if (fence) {
-		rc = dma_fence_wait_timeout(fence, true, timeout);
+		rc = wait_for_completion_interruptible_timeout(
+				&fence->completion, timeout);
+
 		if (fence->error == -ETIMEDOUT)
 			rc = -ETIMEDOUT;
 		else if (fence->error == -EIO)
 			rc = -EIO;
-		dma_fence_put(fence);
+
+		hl_fence_put(fence);
 	} else {
 		dev_dbg(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 3e375958e73b..b168a9fce817 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -23,7 +23,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 	 */
 
 	for (i = 0 ; i < hdev->asic_prop.max_pending_cs ; i++)
-		dma_fence_put(ctx->cs_pending[i]);
+		hl_fence_put(ctx->cs_pending[i]);
 
 	kfree(ctx->cs_pending);
 
@@ -128,7 +128,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	atomic_set(&ctx->thread_ctx_switch_token, 1);
 	ctx->thread_ctx_switch_wait_token = 0;
 	ctx->cs_pending = kcalloc(hdev->asic_prop.max_pending_cs,
-				sizeof(struct dma_fence *),
+				sizeof(struct hl_fence *),
 				GFP_KERNEL);
 	if (!ctx->cs_pending)
 		return -ENOMEM;
@@ -184,10 +184,10 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
-struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
+struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 {
 	struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
-	struct dma_fence *fence;
+	struct hl_fence *fence;
 
 	spin_lock(&ctx->cs_lock);
 
@@ -201,8 +201,9 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 		return NULL;
 	}
 
-	fence = dma_fence_get(
-			ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)]);
+	fence = ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)];
+	hl_fence_get(fence);
+
 	spin_unlock(&ctx->cs_lock);
 
 	return fence;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 018d9d67e8e6..6df9db821a31 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -15,7 +15,6 @@
 #include <linux/cdev.h>
 #include <linux/iopoll.h>
 #include <linux/irqreturn.h>
-#include <linux/dma-fence.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
@@ -342,9 +341,22 @@ struct asic_fixed_properties {
 	u8				completion_queues_count;
 };
 
+/**
+ * struct hl_fence - software synchronization primitive
+ * @completion: fence is implemented using completion
+ * @refcount: refcount for this fence
+ * @error: mark this fence with error
+ *
+ */
+struct hl_fence {
+	struct completion	completion;
+	struct kref		refcount;
+	int			error;
+};
+
 /**
  * struct hl_cs_compl - command submission completion object.
- * @base_fence: kernel fence object.
+ * @base_fence: hl fence object.
  * @lock: spinlock to protect fence.
  * @hdev: habanalabs device structure.
  * @hw_sob: the H/W SOB used in this signal/wait CS.
@@ -353,7 +365,7 @@ struct asic_fixed_properties {
  * @sob_val: the SOB value that is used in this signal/wait CS.
  */
 struct hl_cs_compl {
-	struct dma_fence	base_fence;
+	struct hl_fence		base_fence;
 	spinlock_t		lock;
 	struct hl_device	*hdev;
 	struct hl_hw_sob	*hw_sob;
@@ -800,7 +812,7 @@ struct hl_va_range {
  * @hdev: pointer to the device structure.
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
- * @cs_pending: array of DMA fence objects representing pending CS.
+ * @cs_pending: array of hl fence objects representing pending CS.
  * @host_va_range: holds available virtual addresses for host mappings.
  * @host_huge_va_range: holds available virtual addresses for host mappings
  *                      with huge pages.
@@ -832,7 +844,7 @@ struct hl_ctx {
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
 	struct kref		refcount;
-	struct dma_fence	**cs_pending;
+	struct hl_fence		**cs_pending;
 	struct hl_va_range	*host_va_range;
 	struct hl_va_range	*host_huge_va_range;
 	struct hl_va_range	*dram_va_range;
@@ -919,8 +931,8 @@ struct hl_cs {
 	struct list_head	job_list;
 	spinlock_t		job_lock;
 	struct kref		refcount;
-	struct dma_fence	*fence;
-	struct dma_fence	*signal_fence;
+	struct hl_fence		*fence;
+	struct hl_fence		*signal_fence;
 	struct work_struct	finish_work;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
@@ -1736,7 +1748,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
 void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
-struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
+struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
 
@@ -1778,6 +1790,8 @@ void hl_cs_rollback_all(struct hl_device *hdev);
 struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 		enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
 void hl_sob_reset_error(struct kref *ref);
+void hl_fence_put(struct hl_fence *fence);
+void hl_fence_get(struct hl_fence *fence);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 287681646071..65b9aa69a83e 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -474,7 +474,7 @@ static void init_signal_wait_cs(struct hl_cs *cs)
 		 * wait CS was submitted.
 		 */
 		mb();
-		dma_fence_put(cs->signal_fence);
+		hl_fence_put(cs->signal_fence);
 		cs->signal_fence = NULL;
 	}
 }
-- 
2.17.1

