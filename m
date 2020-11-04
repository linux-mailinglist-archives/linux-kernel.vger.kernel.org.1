Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EEC2A65EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKDOJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbgKDOJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:36 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939D7223C7;
        Wed,  4 Nov 2020 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498975;
        bh=hVCnHDSSmCcv39NT2usQrnHj9E1gI13s6YDBBGBPctg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDwUUXlFAnxAs4TRCuSMOIl8uaZXOzBbc1LPipI/RqCvAwAqnxpKN3BRz1depIQpU
         6ppmnXxav61lgLX7zrOD+0F2z7IrF56ixwaKukGTtLqxm/kROBCV04yfECuAwxDsNR
         jOtGbc++FGyoWYE6nfKMEuHnpwivzI1Fd4PdEQdY=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Small refactoring of cs_do_release()
Date:   Wed,  4 Nov 2020 16:09:08 +0200
Message-Id: <20201104140908.10178-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Slightly refactor the cs_do_release() function, to reduce nesting level
and to ease the handling of future CS types.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 99 +++++++++----------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 3e6f4e5ef7ec..18cd20eec4c5 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -281,8 +281,7 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 
 static void cs_do_release(struct kref *ref)
 {
-	struct hl_cs *cs = container_of(ref, struct hl_cs,
-						refcount);
+	struct hl_cs *cs = container_of(ref, struct hl_cs, refcount);
 	struct hl_device *hdev = cs->ctx->hdev;
 	struct hl_cs_job *job, *tmp;
 
@@ -299,69 +298,69 @@ static void cs_do_release(struct kref *ref)
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
 		free_job(hdev, job);
 
-	/* We also need to update CI for internal queues */
-	if (cs->submitted) {
-		hdev->asic_funcs->hw_queues_lock(hdev);
+	if (!cs->submitted) {
+		/* In case the wait for signal CS was submitted, the put occurs
+		 * in init_signal_wait_cs() right before hanging on the PQ.
+		 */
+		if (cs->type == CS_TYPE_WAIT)
+			hl_fence_put(cs->signal_fence);
 
-		hdev->cs_active_cnt--;
-		if (!hdev->cs_active_cnt) {
-			struct hl_device_idle_busy_ts *ts;
+		goto out;
+	}
 
-			ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx++];
-			ts->busy_to_idle_ts = ktime_get();
+	hdev->asic_funcs->hw_queues_lock(hdev);
 
-			if (hdev->idle_busy_ts_idx == HL_IDLE_BUSY_TS_ARR_SIZE)
-				hdev->idle_busy_ts_idx = 0;
-		} else if (hdev->cs_active_cnt < 0) {
-			dev_crit(hdev->dev, "CS active cnt %d is negative\n",
-				hdev->cs_active_cnt);
-		}
+	hdev->cs_active_cnt--;
+	if (!hdev->cs_active_cnt) {
+		struct hl_device_idle_busy_ts *ts;
 
-		hdev->asic_funcs->hw_queues_unlock(hdev);
+		ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx++];
+		ts->busy_to_idle_ts = ktime_get();
 
-		hl_int_hw_queue_update_ci(cs);
+		if (hdev->idle_busy_ts_idx == HL_IDLE_BUSY_TS_ARR_SIZE)
+			hdev->idle_busy_ts_idx = 0;
+	} else if (hdev->cs_active_cnt < 0) {
+		dev_crit(hdev->dev, "CS active cnt %d is negative\n",
+			hdev->cs_active_cnt);
+	}
 
-		spin_lock(&hdev->hw_queues_mirror_lock);
-		/* remove CS from hw_queues mirror list */
-		list_del_init(&cs->mirror_node);
-		spin_unlock(&hdev->hw_queues_mirror_lock);
+	hdev->asic_funcs->hw_queues_unlock(hdev);
 
-		/*
-		 * Don't cancel TDR in case this CS was timedout because we
-		 * might be running from the TDR context
-		 */
-		if ((!cs->timedout) &&
-			(hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT)) {
-			struct hl_cs *next;
+	/* Need to update CI for internal queues */
+	hl_int_hw_queue_update_ci(cs);
 
-			if (cs->tdr_active)
-				cancel_delayed_work_sync(&cs->work_tdr);
+	spin_lock(&hdev->hw_queues_mirror_lock);
+	/* remove CS from hw_queues mirror list */
+	list_del_init(&cs->mirror_node);
+	spin_unlock(&hdev->hw_queues_mirror_lock);
 
-			spin_lock(&hdev->hw_queues_mirror_lock);
+	/* Don't cancel TDR in case this CS was timedout because we might be
+	 * running from the TDR context
+	 */
+	if (!cs->timedout &&
+			hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) {
+		struct hl_cs *next;
 
-			/* queue TDR for next CS */
-			next = list_first_entry_or_null(
-					&hdev->hw_queues_mirror_list,
-					struct hl_cs, mirror_node);
+		if (cs->tdr_active)
+			cancel_delayed_work_sync(&cs->work_tdr);
 
-			if ((next) && (!next->tdr_active)) {
-				next->tdr_active = true;
-				schedule_delayed_work(&next->work_tdr,
-							hdev->timeout_jiffies);
-			}
+		spin_lock(&hdev->hw_queues_mirror_lock);
+
+		/* queue TDR for next CS */
+		next = list_first_entry_or_null(&hdev->hw_queues_mirror_list,
+						struct hl_cs, mirror_node);
 
-			spin_unlock(&hdev->hw_queues_mirror_lock);
+		if (next && !next->tdr_active) {
+			next->tdr_active = true;
+			schedule_delayed_work(&next->work_tdr,
+						hdev->timeout_jiffies);
 		}
-	} else if (cs->type == CS_TYPE_WAIT) {
-		/*
-		 * In case the wait for signal CS was submitted, the put occurs
-		 * in init_signal_wait_cs() right before hanging on the PQ.
-		 */
-		hl_fence_put(cs->signal_fence);
+
+		spin_unlock(&hdev->hw_queues_mirror_lock);
 	}
 
-	/*
-	 * Must be called before hl_ctx_put because inside we use ctx to get
+out:
+	/* Must be called before hl_ctx_put because inside we use ctx to get
 	 * the device
 	 */
 	hl_debugfs_remove_cs(cs);
-- 
2.17.1

