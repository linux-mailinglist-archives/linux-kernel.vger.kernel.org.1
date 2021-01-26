Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B6304FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhA0DRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbhAZUlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:41:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 549FB22228;
        Tue, 26 Jan 2021 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611693665;
        bh=i1Eyd7na4zdgN3GI8mAOz2jE0EPKvw+WzGzXBBtHEaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdEH1kd6NP+ZJF2o8VrnYaXD25jKNxfc4hT17KSLGVHLC8AydxvVnQ89bp7e5jYZn
         xWKAgnkHVnYHwSaFBr22dyHJHWCWWNYWCXzmIgsE2fH1s8W+bxn9NGy/TAq2GEhDht
         5iUleIZR2TYqqxeEmtCOQ+tLGqFbMEy030AagnqQGR+/+3iBdtsj9wEPzjg7O5J0XJ
         N+3qrZymRd84SR/rkPiu7VwwIowFN6Pah5ZrXOiQuw3FM0QiogMR0GmTltYJHDhTJT
         Sp+uQVBDf5j8XQasr53P6oEiUgoLCgyXFnNmbcx1k4M9SnLc+8odhRPz6wSDBaZ1E4
         YXlN7l4ZWZt1w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs: staged submission support
Date:   Tue, 26 Jan 2021 22:40:56 +0200
Message-Id: <20210126204057.329-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126204057.329-1-ogabbay@kernel.org>
References: <20210126204057.329-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We introduce a new mechanism named Staged Submission.
This mechanism allows the user to send a whole CS in pieces.
Each CS will not require completion rather than the
last CS. Timeout timer will be triggered upon reception of the first
CS in group.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 214 ++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h   |   9 +
 drivers/misc/habanalabs/common/hw_queue.c     |  27 +++
 drivers/misc/habanalabs/gaudi/gaudi.c         |   1 +
 4 files changed, 227 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 57daff0e59ae..7bd4a03b3429 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -334,6 +334,133 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 	cs_job_put(job);
 }
 
+/*
+ * hl_staged_cs_find_first - locate the first CS in this staged submission
+ *
+ * @hdev: pointer to device structure
+ * @cs_seq: staged submission sequence number
+ *
+ * @note: This function must be called under 'hdev->cs_mirror_lock'
+ *
+ * Find and return a CS pointer with the given sequence
+ */
+struct hl_cs *hl_staged_cs_find_first(struct hl_device *hdev, u64 cs_seq)
+{
+	struct hl_cs *cs;
+
+	list_for_each_entry_reverse(cs, &hdev->cs_mirror_list, mirror_node)
+		if (cs->staged_cs && cs->staged_first &&
+				cs->sequence == cs_seq)
+			return cs;
+
+	return NULL;
+}
+
+/*
+ * is_staged_cs_last_exists - returns true if the last CS in sequence exists
+ *
+ * @hdev: pointer to device structure
+ * @cs: staged submission member
+ *
+ */
+bool is_staged_cs_last_exists(struct hl_device *hdev, struct hl_cs *cs)
+{
+	struct hl_cs *last_entry;
+
+	last_entry = list_last_entry(&cs->staged_cs_node, struct hl_cs,
+								staged_cs_node);
+
+	if (last_entry->staged_last)
+		return true;
+
+	return false;
+}
+
+/*
+ * staged_cs_get - get CS reference if this CS is a part of a staged CS
+ *
+ * @hdev: pointer to device structure
+ * @cs: current CS
+ * @cs_seq: staged submission sequence number
+ *
+ * Increment CS reference for every CS in this staged submission except for
+ * the CS which get completion.
+ */
+static void staged_cs_get(struct hl_device *hdev, struct hl_cs *cs)
+{
+	/* Only the last CS in this staged submission will get a completion.
+	 * We must increment the reference for all other CS's in this
+	 * staged submission.
+	 * Once we get a completion we will release the whole staged submission.
+	 */
+	if (!cs->staged_last)
+		cs_get(cs);
+}
+
+/*
+ * staged_cs_put - put a CS in case it is part of staged submission
+ *
+ * @hdev: pointer to device structure
+ * @cs: CS to put
+ *
+ * This function decrements a CS reference (for a non completion CS)
+ */
+static void staged_cs_put(struct hl_device *hdev, struct hl_cs *cs)
+{
+	/* We release all CS's in a staged submission except the last
+	 * CS which we have never incremented its reference.
+	 */
+	if (!cs_needs_completion(cs))
+		cs_put(cs);
+}
+
+static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
+{
+	bool next_entry_found = false;
+	struct hl_cs *next;
+
+	if (!cs_needs_timeout(cs))
+		return;
+
+	spin_lock(&hdev->cs_mirror_lock);
+
+	/* We need to handle tdr only once for the complete staged submission.
+	 * Hence, we choose the CS that reaches this function first which is
+	 * the CS marked as 'staged_last'.
+	 */
+	if (cs->staged_cs && cs->staged_last)
+		cs = hl_staged_cs_find_first(hdev, cs->staged_sequence);
+
+	spin_unlock(&hdev->cs_mirror_lock);
+
+	/* Don't cancel TDR in case this CS was timedout because we might be
+	 * running from the TDR context
+	 */
+	if (cs && (cs->timedout ||
+			hdev->timeout_jiffies == MAX_SCHEDULE_TIMEOUT))
+		return;
+
+	if (cs && cs->tdr_active)
+		cancel_delayed_work_sync(&cs->work_tdr);
+
+	spin_lock(&hdev->cs_mirror_lock);
+
+	/* queue TDR for next CS */
+	list_for_each_entry(next, &hdev->cs_mirror_list, mirror_node)
+		if (cs_needs_timeout(next)) {
+			next_entry_found = true;
+			break;
+		}
+
+	if (next_entry_found && !next->tdr_active) {
+		next->tdr_active = true;
+		schedule_delayed_work(&next->work_tdr,
+					hdev->timeout_jiffies);
+	}
+
+	spin_unlock(&hdev->cs_mirror_lock);
+}
+
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs, refcount);
@@ -391,32 +518,29 @@ static void cs_do_release(struct kref *ref)
 	list_del_init(&cs->mirror_node);
 	spin_unlock(&hdev->cs_mirror_lock);
 
-	/* Don't cancel TDR in case this CS was timedout because we might be
-	 * running from the TDR context
-	 */
-	if (!cs->timedout && hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) {
-		bool next_entry_found = false;
-		struct hl_cs *next;
-
-		if (cs->tdr_active)
-			cancel_delayed_work_sync(&cs->work_tdr);
+	cs_handle_tdr(hdev, cs);
 
-		spin_lock(&hdev->cs_mirror_lock);
-
-		/* queue TDR for next CS */
-		list_for_each_entry(next, &hdev->cs_mirror_list, mirror_node)
-			if (cs_needs_timeout(next)) {
-				next_entry_found = true;
-				break;
-			}
+	if (cs->staged_cs) {
+		/* the completion CS decrements reference for the entire
+		 * staged submission
+		 */
+		if (cs->staged_last) {
+			struct hl_cs *staged_cs, *tmp;
 
-		if (next_entry_found && !next->tdr_active) {
-			next->tdr_active = true;
-			schedule_delayed_work(&next->work_tdr,
-						hdev->timeout_jiffies);
+			list_for_each_entry_safe(staged_cs, tmp,
+					&cs->staged_cs_node, staged_cs_node)
+				staged_cs_put(hdev, staged_cs);
 		}
 
-		spin_unlock(&hdev->cs_mirror_lock);
+		/* A staged CS will be a member in the list only after it
+		 * was submitted. We used 'cs_mirror_lock' when inserting
+		 * it to list so we will use it again when removing it
+		 */
+		if (cs->submitted) {
+			spin_lock(&hdev->cs_mirror_lock);
+			list_del(&cs->staged_cs_node);
+			spin_unlock(&hdev->cs_mirror_lock);
+		}
 	}
 
 out:
@@ -614,6 +738,8 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 {
 	struct hl_cs_job *job, *tmp;
 
+	staged_cs_put(hdev, cs);
+
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
 		complete_job(hdev, job);
 }
@@ -623,7 +749,9 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 	int i;
 	struct hl_cs *cs, *tmp;
 
-	/* flush all completions */
+	/* flush all completions before iterating over the CS mirror list in
+	 * order to avoid a race with the release functions
+	 */
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		flush_workqueue(hdev->cq_wq[i]);
 
@@ -632,7 +760,7 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 		cs_get(cs);
 		cs->aborted = true;
 		dev_warn_ratelimited(hdev->dev, "Killing CS %d.%llu\n",
-					cs->ctx->asid, cs->sequence);
+				cs->ctx->asid, cs->sequence);
 		cs_rollback(hdev, cs);
 		cs_put(cs);
 	}
@@ -804,6 +932,12 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 		return -EBUSY;
 	}
 
+	if ((args->in.cs_flags & HL_CS_FLAGS_STAGED_SUBMISSION) &&
+			!hdev->supports_staged_submission) {
+		dev_err(hdev->dev, "staged submission not supported");
+		return -EPERM;
+	}
+
 	cs_type_flags = args->in.cs_flags & HL_CS_FLAGS_TYPE_MASK;
 
 	if (unlikely(cs_type_flags && !is_power_of_2(cs_type_flags))) {
@@ -875,6 +1009,34 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 	return 0;
 }
 
+static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
+				u64 sequence, u32 flags)
+{
+	if (!(flags & HL_CS_FLAGS_STAGED_SUBMISSION))
+		return 0;
+
+	cs->staged_last = !!(flags & HL_CS_FLAGS_STAGED_SUBMISSION_LAST);
+	cs->staged_first = !!(flags & HL_CS_FLAGS_STAGED_SUBMISSION_FIRST);
+
+	if (cs->staged_first) {
+		/* Staged CS sequence is the first CS sequence */
+		INIT_LIST_HEAD(&cs->staged_cs_node);
+		cs->staged_sequence = cs->sequence;
+	} else {
+		/* User sequence will be validated in 'hl_hw_queue_schedule_cs'
+		 * under the cs_mirror_lock
+		 */
+		cs->staged_sequence = sequence;
+	}
+
+	/* Increment CS reference if needed */
+	staged_cs_get(hdev, cs);
+
+	cs->staged_cs = true;
+
+	return 0;
+}
+
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 num_chunks, u64 *cs_seq, u32 flags)
 {
@@ -914,6 +1076,10 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 	hl_debugfs_add_cs(cs);
 
+	rc = cs_staged_submission(hdev, cs, user_sequence, flags);
+	if (rc)
+		goto free_cs_object;
+
 	/* Validate ALL the CS chunks before submitting the CS */
 	for (i = 0 ; i < num_chunks ; i++) {
 		struct hl_cs_chunk *chunk = &cs_chunk_array[i];
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index be7947d69dfa..30f32f2edb8a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1169,8 +1169,11 @@ struct hl_userptr {
  * @finish_work: workqueue object to run when CS is completed by H/W.
  * @work_tdr: delayed work node for TDR.
  * @mirror_node : node in device mirror list of command submissions.
+ * @staged_cs_node: node in the staged cs list.
  * @debugfs_list: node in debugfs list of command submissions.
  * @sequence: the sequence number of this CS.
+ * @staged_sequence: the sequence of the staged submission this CS is part of,
+ *                   relevant only if staged_cs is set.
  * @type: CS_TYPE_*.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
@@ -1195,8 +1198,10 @@ struct hl_cs {
 	struct work_struct	finish_work;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
+	struct list_head	staged_cs_node;
 	struct list_head	debugfs_list;
 	u64			sequence;
+	u64			staged_sequence;
 	enum hl_cs_type		type;
 	u8			submitted;
 	u8			completed;
@@ -1905,6 +1910,7 @@ struct hl_mmu_funcs {
  *                          user processes
  * @device_fini_pending: true if device_fini was called and might be
  *                       waiting for the reset thread to finish
+ * @supports_staged_submission: true if staged submissions are supported
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2010,6 +2016,7 @@ struct hl_device {
 	u8				needs_reset;
 	u8				process_kill_trial_cnt;
 	u8				device_fini_pending;
+	u8				supports_staged_submission;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -2207,6 +2214,8 @@ void hl_fence_get(struct hl_fence *fence);
 void cs_get(struct hl_cs *cs);
 bool cs_needs_completion(struct hl_cs *cs);
 bool cs_needs_timeout(struct hl_cs *cs);
+bool is_staged_cs_last_exists(struct hl_device *hdev, struct hl_cs *cs);
+struct hl_cs *hl_staged_cs_find_first(struct hl_device *hdev, u64 cs_seq);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index ad440ae785a3..0f335182267f 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -596,6 +596,31 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		hdev->asic_funcs->collective_wait_init_cs(cs);
 
 	spin_lock(&hdev->cs_mirror_lock);
+
+	/* Verify staged CS exists and add to the staged list */
+	if (cs->staged_cs && !cs->staged_first) {
+		struct hl_cs *staged_cs;
+
+		staged_cs = hl_staged_cs_find_first(hdev, cs->staged_sequence);
+		if (!staged_cs) {
+			dev_err(hdev->dev,
+				"Cannot find staged submission sequence %llu",
+				cs->staged_sequence);
+			rc = -EINVAL;
+			goto unlock_cs_mirror;
+		}
+
+		if (is_staged_cs_last_exists(hdev, staged_cs)) {
+			dev_err(hdev->dev,
+				"Staged submission sequence %llu already submitted",
+				cs->staged_sequence);
+			rc = -EINVAL;
+			goto unlock_cs_mirror;
+		}
+
+		list_add_tail(&cs->staged_cs_node, &staged_cs->staged_cs_node);
+	}
+
 	list_add_tail(&cs->mirror_node, &hdev->cs_mirror_list);
 
 	/* Queue TDR if the CS is the first entry and if timeout is wanted */
@@ -637,6 +662,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 	goto out;
 
+unlock_cs_mirror:
+	spin_unlock(&hdev->cs_mirror_lock);
 unroll_cq_resv:
 	q = &hdev->kernel_queues[0];
 	for (i = 0 ; (i < max_queues) && (cq_cnt > 0) ; i++, q++) {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9a3d2fb477a8..1348016309e3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1627,6 +1627,7 @@ static int gaudi_sw_init(struct hl_device *hdev)
 
 	hdev->supports_sync_stream = true;
 	hdev->supports_coresight = true;
+	hdev->supports_staged_submission = true;
 
 	return 0;
 
-- 
2.25.1

