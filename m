Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4483B303B35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404823AbhAZLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389160AbhAZHBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A1A206FA;
        Tue, 26 Jan 2021 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611644424;
        bh=NQFmcFw2uDiOg9BM4rw5VVG/fV9MLB9VPBaNL+zHvt4=;
        h=From:To:Cc:Subject:Date:From;
        b=XfR2FsDsrji8wCRibL/EuthSrBoPPXSW3bqqsyQKgLAdjsxpW5FAG0aqRdkvTEPJ4
         l58EMjFxE790vKaqnEn0vWT3eoYOBK0zKzxc8qRURddsqWSfYolpvGthJCe0E2BlFR
         G28LHw26EX8GyH1MpCHk0bst/N1cyf3qUwgKnkSHO1PDk7fFyMcRemUv5mIx4gzgtq
         obxp5ocawuiFskfPiHZN5rc8fSAv8r4giZ3YCMOj+BvtMtDuvW1gOX8LN1IgiBThvF
         vuQ3241SazhMdsWRZbzNuEQq70LlLJNdpcptGOvclL9VtZo3+TICKHdH8HuxSSKcCi
         ZM6YglcRexKQQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: add CS completion and timeout properties
Date:   Tue, 26 Jan 2021 09:00:18 +0200
Message-Id: <20210126070018.15585-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support staged submission feature, we need to
distinguish on which command submission we want to receive
timeout and for which we want to receive completion.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 104 ++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h   |  15 ++-
 drivers/misc/habanalabs/common/hw_queue.c     |  24 +++-
 3 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a5e9bb0a4855..57daff0e59ae 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -149,9 +149,10 @@ void hl_fence_get(struct hl_fence *fence)
 		kref_get(&fence->refcount);
 }
 
-static void hl_fence_init(struct hl_fence *fence)
+static void hl_fence_init(struct hl_fence *fence, u64 sequence)
 {
 	kref_init(&fence->refcount);
+	fence->cs_sequence = sequence;
 	fence->error = 0;
 	fence->timestamp = ktime_set(0, 0);
 	init_completion(&fence->completion);
@@ -184,6 +185,28 @@ static void cs_job_put(struct hl_cs_job *job)
 	kref_put(&job->refcount, cs_job_do_release);
 }
 
+bool cs_needs_completion(struct hl_cs *cs)
+{
+	/* In case this is a staged CS, only the last CS in sequence should
+	 * get a completion, any non staged CS will always get a completion
+	 */
+	if (cs->staged_cs && !cs->staged_last)
+		return false;
+
+	return true;
+}
+
+bool cs_needs_timeout(struct hl_cs *cs)
+{
+	/* In case this is a staged CS, only the first CS in sequence should
+	 * get a timeout, any non staged CS will always get a timeout
+	 */
+	if (cs->staged_cs && !cs->staged_first)
+		return false;
+
+	return true;
+}
+
 static bool is_cb_patched(struct hl_device *hdev, struct hl_cs_job *job)
 {
 	/*
@@ -225,7 +248,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 	parser.queue_type = job->queue_type;
 	parser.is_kernel_allocated_cb = job->is_kernel_allocated_cb;
 	job->patched_cb = NULL;
-	parser.completion = true;
+	parser.completion = cs_needs_completion(job->cs);
 
 	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
 
@@ -291,8 +314,21 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 
 	hl_debugfs_remove_job(hdev, job);
 
-	if (job->queue_type == QUEUE_TYPE_EXT ||
-			job->queue_type == QUEUE_TYPE_HW)
+	/* We decrement reference only for a CS that gets completion
+	 * because the reference was incremented only for this kind of CS
+	 * right before it was scheduled.
+	 *
+	 * In staged submission, only the last CS marked as 'staged_last'
+	 * gets completion, hence its release function will be called from here.
+	 * As for all the rest CS's in the staged submission which do not get
+	 * completion, their CS reference will be decremented by the
+	 * 'staged_last' CS during the CS release flow.
+	 * All relevant PQ CI counters will be incremented during the CS release
+	 * flow by calling 'hl_hw_queue_update_ci'.
+	 */
+	if (cs_needs_completion(cs) &&
+		(job->queue_type == QUEUE_TYPE_EXT ||
+			job->queue_type == QUEUE_TYPE_HW))
 		cs_put(cs);
 
 	cs_job_put(job);
@@ -347,8 +383,8 @@ static void cs_do_release(struct kref *ref)
 
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
-	/* Need to update CI for internal queues */
-	hl_int_hw_queue_update_ci(cs);
+	/* Need to update CI for all queue jobs that does not get completion */
+	hl_hw_queue_update_ci(cs);
 
 	/* remove CS from CS mirror list */
 	spin_lock(&hdev->cs_mirror_lock);
@@ -359,6 +395,7 @@ static void cs_do_release(struct kref *ref)
 	 * running from the TDR context
 	 */
 	if (!cs->timedout && hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) {
+		bool next_entry_found = false;
 		struct hl_cs *next;
 
 		if (cs->tdr_active)
@@ -367,10 +404,13 @@ static void cs_do_release(struct kref *ref)
 		spin_lock(&hdev->cs_mirror_lock);
 
 		/* queue TDR for next CS */
-		next = list_first_entry_or_null(&hdev->cs_mirror_list,
-						struct hl_cs, mirror_node);
+		list_for_each_entry(next, &hdev->cs_mirror_list, mirror_node)
+			if (cs_needs_timeout(next)) {
+				next_entry_found = true;
+				break;
+			}
 
-		if (next && !next->tdr_active) {
+		if (next_entry_found && !next->tdr_active) {
 			next->tdr_active = true;
 			schedule_delayed_work(&next->work_tdr,
 						hdev->timeout_jiffies);
@@ -462,7 +502,8 @@ static void cs_timedout(struct work_struct *work)
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
-			enum hl_cs_type cs_type, struct hl_cs **cs_new)
+			enum hl_cs_type cs_type, u64 user_sequence,
+			struct hl_cs **cs_new)
 {
 	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *other = NULL;
@@ -511,6 +552,18 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 				(hdev->asic_prop.max_pending_cs - 1)];
 
 	if (other && !completion_done(&other->completion)) {
+		/* If the following statement is true, it means we have reached
+		 * a point in which only part of the staged submission was
+		 * submitted and we don't have enough room in the 'cs_pending'
+		 * array for the rest of the submission.
+		 * This causes a deadlock because this CS will never be
+		 * completed as it depends on future CS's for completion.
+		 */
+		if (other->cs_sequence == user_sequence)
+			dev_crit_ratelimited(hdev->dev,
+				"Staged CS %llu deadlock due to lack of resources",
+				user_sequence);
+
 		dev_dbg_ratelimited(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
 		atomic64_inc(&ctx->cs_counters.max_cs_in_flight_drop_cnt);
@@ -529,7 +582,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 	/* init hl_fence */
-	hl_fence_init(&cs_cmpl->base_fence);
+	hl_fence_init(&cs_cmpl->base_fence, cs_cmpl->cs_seq);
 
 	cs->sequence = cs_cmpl->cs_seq;
 
@@ -825,7 +878,7 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 num_chunks, u64 *cs_seq, u32 flags)
 {
-	bool int_queues_only = true;
+	bool staged_mid, int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_chunk *cs_chunk_array;
 	struct hl_cs_counters_atomic *cntr;
@@ -833,9 +886,11 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
+	u64 user_sequence;
 	int rc, i;
 
 	cntr = &hdev->aggregated_cs_counters;
+	user_sequence = *cs_seq;
 	*cs_seq = ULLONG_MAX;
 
 	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks,
@@ -843,7 +898,14 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	if (rc)
 		goto out;
 
-	rc = allocate_cs(hdev, hpriv->ctx, CS_TYPE_DEFAULT, &cs);
+	if ((flags & HL_CS_FLAGS_STAGED_SUBMISSION) &&
+			!(flags & HL_CS_FLAGS_STAGED_SUBMISSION_FIRST))
+		staged_mid = true;
+	else
+		staged_mid = false;
+
+	rc = allocate_cs(hdev, hpriv->ctx, CS_TYPE_DEFAULT,
+			staged_mid ? user_sequence : ULLONG_MAX, &cs);
 	if (rc)
 		goto free_cs_chunk_array;
 
@@ -911,8 +973,9 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		 * Only increment for JOB on external or H/W queues, because
 		 * only for those JOBs we get completion
 		 */
-		if (job->queue_type == QUEUE_TYPE_EXT ||
-				job->queue_type == QUEUE_TYPE_HW)
+		if (cs_needs_completion(cs) &&
+			(job->queue_type == QUEUE_TYPE_EXT ||
+				job->queue_type == QUEUE_TYPE_HW))
 			cs_get(cs);
 
 		hl_debugfs_add_job(hdev, job);
@@ -928,11 +991,14 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		}
 	}
 
-	if (int_queues_only) {
+	/* We allow a CS with any queue type combination as long as it does
+	 * not get a completion
+	 */
+	if (int_queues_only && cs_needs_completion(cs)) {
 		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
 		atomic64_inc(&cntr->validation_drop_cnt);
 		dev_err(hdev->dev,
-			"Reject CS %d.%llu because only internal queues jobs are present\n",
+			"Reject CS %d.%llu since it contains only internal queues jobs and needs completion\n",
 			cs->ctx->asid, cs->sequence);
 		rc = -EINVAL;
 		goto free_cs_object;
@@ -1037,7 +1103,7 @@ static int hl_submit_pending_cb(struct hl_fpriv *hpriv)
 		list_move_tail(&pending_cb->cb_node, &local_cb_list);
 	spin_unlock(&ctx->pending_cb_lock);
 
-	rc = allocate_cs(hdev, ctx, CS_TYPE_DEFAULT, &cs);
+	rc = allocate_cs(hdev, ctx, CS_TYPE_DEFAULT, ULLONG_MAX, &cs);
 	if (rc)
 		goto add_list_elements;
 
@@ -1410,7 +1476,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		}
 	}
 
-	rc = allocate_cs(hdev, ctx, cs_type, &cs);
+	rc = allocate_cs(hdev, ctx, cs_type, ULLONG_MAX, &cs);
 	if (rc) {
 		if (cs_type == CS_TYPE_WAIT ||
 			cs_type == CS_TYPE_COLLECTIVE_WAIT)
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e105612ed577..fd2fffd20ba1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -486,6 +486,7 @@ struct asic_fixed_properties {
  * struct hl_fence - software synchronization primitive
  * @completion: fence is implemented using completion
  * @refcount: refcount for this fence
+ * @cs_sequence: sequence of the corresponding command submission
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
  *
@@ -493,6 +494,7 @@ struct asic_fixed_properties {
 struct hl_fence {
 	struct completion	completion;
 	struct kref		refcount;
+	u64			cs_sequence;
 	int			error;
 	ktime_t			timestamp;
 };
@@ -1176,7 +1178,11 @@ struct hl_userptr {
  * @tdr_active: true if TDR was activated for this CS (to prevent
  *		double TDR activation).
  * @aborted: true if CS was aborted due to some device error.
- * @timestamp: true if a timestmap must be captured upon completion
+ * @timestamp: true if a timestmap must be captured upon completion.
+ * @staged_last: true if this is the last staged CS and needs completion.
+ * @staged_first: true if this is the first staged CS and we need to receive
+ *                timeout for this CS.
+ * @staged_cs: true if this CS is part of a staged submission.
  */
 struct hl_cs {
 	u16			*jobs_in_queue_cnt;
@@ -1198,6 +1204,9 @@ struct hl_cs {
 	u8			tdr_active;
 	u8			aborted;
 	u8			timestamp;
+	u8			staged_last;
+	u8			staged_first;
+	u8			staged_cs;
 };
 
 /**
@@ -2118,7 +2127,7 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
 int hl_hw_queue_schedule_cs(struct hl_cs *cs);
 u32 hl_hw_queue_add_ptr(u32 ptr, u16 val);
 void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
-void hl_int_hw_queue_update_ci(struct hl_cs *cs);
+void hl_hw_queue_update_ci(struct hl_cs *cs);
 void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset);
 
 #define hl_queue_inc_ptr(p)		hl_hw_queue_add_ptr(p, 1)
@@ -2196,6 +2205,8 @@ int hl_gen_sob_mask(u16 sob_base, u8 sob_mask, u8 *mask);
 void hl_fence_put(struct hl_fence *fence);
 void hl_fence_get(struct hl_fence *fence);
 void cs_get(struct hl_cs *cs);
+bool cs_needs_completion(struct hl_cs *cs);
+bool cs_needs_timeout(struct hl_cs *cs);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 76217258780a..ad440ae785a3 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -38,7 +38,7 @@ static inline int queue_free_slots(struct hl_hw_queue *q, u32 queue_len)
 		return (abs(delta) - queue_len);
 }
 
-void hl_int_hw_queue_update_ci(struct hl_cs *cs)
+void hl_hw_queue_update_ci(struct hl_cs *cs)
 {
 	struct hl_device *hdev = cs->ctx->hdev;
 	struct hl_hw_queue *q;
@@ -53,8 +53,13 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
 	if (!hdev->asic_prop.max_queues || q->queue_type == QUEUE_TYPE_HW)
 		return;
 
+	/* We must increment CI for every queue that will never get a
+	 * completion, there are 2 scenarios this can happen:
+	 * 1. All queues of a non completion CS will never get a completion.
+	 * 2. Internal queues never gets completion.
+	 */
 	for (i = 0 ; i < hdev->asic_prop.max_queues ; i++, q++) {
-		if (q->queue_type == QUEUE_TYPE_INT)
+		if (!cs_needs_completion(cs) || q->queue_type == QUEUE_TYPE_INT)
 			atomic_add(cs->jobs_in_queue_cnt[i], &q->ci);
 	}
 }
@@ -292,6 +297,10 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 	len = job->job_cb_size;
 	ptr = cb->bus_address;
 
+	/* Skip completion flow in case this is a non completion CS */
+	if (!cs_needs_completion(job->cs))
+		goto submit_bd;
+
 	cq_pkt.data = cpu_to_le32(
 			((q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
 				& CQ_ENTRY_SHADOW_INDEX_MASK) |
@@ -318,6 +327,7 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 
 	cq->pi = hl_cq_inc_ptr(cq->pi);
 
+submit_bd:
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
 
@@ -525,6 +535,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	struct hl_cs_job *job, *tmp;
 	struct hl_hw_queue *q;
 	int rc = 0, i, cq_cnt;
+	bool first_entry;
 	u32 max_queues;
 
 	cntr = &hdev->aggregated_cs_counters;
@@ -548,7 +559,9 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 			switch (q->queue_type) {
 			case QUEUE_TYPE_EXT:
 				rc = ext_queue_sanity_checks(hdev, q,
-						cs->jobs_in_queue_cnt[i], true);
+						cs->jobs_in_queue_cnt[i],
+						cs_needs_completion(cs) ?
+								true : false);
 				break;
 			case QUEUE_TYPE_INT:
 				rc = int_queue_sanity_checks(hdev, q,
@@ -586,9 +599,10 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	list_add_tail(&cs->mirror_node, &hdev->cs_mirror_list);
 
 	/* Queue TDR if the CS is the first entry and if timeout is wanted */
+	first_entry = list_first_entry(&hdev->cs_mirror_list,
+					struct hl_cs, mirror_node) == cs;
 	if ((hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) &&
-			(list_first_entry(&hdev->cs_mirror_list,
-					struct hl_cs, mirror_node) == cs)) {
+				first_entry && cs_needs_timeout(cs)) {
 		cs->tdr_active = true;
 		schedule_delayed_work(&cs->work_tdr, hdev->timeout_jiffies);
 
-- 
2.25.1

