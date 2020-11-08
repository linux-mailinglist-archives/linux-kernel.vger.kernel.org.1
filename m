Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BF2AAC4D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgKHQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgKHQvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:51:39 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0904122240;
        Sun,  8 Nov 2020 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854298;
        bh=eZ0k0xIIuX1RrkhqZukVjOvR52MoBHvrBRufhHJIaOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJyoMEcoMRpctKeEJBcjTU5D5ExeIJaRX3334oJ7OyrIUdG1m1bKkm9VZpYo43IWQ
         rA6PwVAg82msoGojSR0UJWc/W4uAsw2zcd78EpOPfpRcW3msFfdn/jt6MZNEdpc+xx
         DMT5xTOK6CoACXPV2hw9mp2DlV1bzYzDxhaj0p1g=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Rename hw_queues_mirror to cs_mirror
Date:   Sun,  8 Nov 2020 18:51:29 +0200
Message-Id: <20201108165129.13100-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108165129.13100-1-ogabbay@kernel.org>
References: <20201108165129.13100-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Future command submission types might be submitted to HW not via the
QMAN queues path. However, it would be still required to have the TDR
mechanism for these CS, and thus the patch renames the TDR fields and
replaces the hw_queues_ prefix with cs_.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c     | 18 ++++++++----------
 drivers/misc/habanalabs/common/device.c        |  4 ++--
 drivers/misc/habanalabs/common/habanalabs.h    |  8 ++++----
 drivers/misc/habanalabs/common/hw_queue.c      | 12 ++++++------
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ec014ef39484..516cbaacc03e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -343,25 +343,24 @@ static void cs_do_release(struct kref *ref)
 	/* Need to update CI for internal queues */
 	hl_int_hw_queue_update_ci(cs);
 
-	spin_lock(&hdev->hw_queues_mirror_lock);
-	/* remove CS from hw_queues mirror list */
+	/* remove CS from CS mirror list */
+	spin_lock(&hdev->cs_mirror_lock);
 	list_del_init(&cs->mirror_node);
-	spin_unlock(&hdev->hw_queues_mirror_lock);
+	spin_unlock(&hdev->cs_mirror_lock);
 
 	/* Don't cancel TDR in case this CS was timedout because we might be
 	 * running from the TDR context
 	 */
-	if (!cs->timedout &&
-			hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) {
+	if (!cs->timedout && hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) {
 		struct hl_cs *next;
 
 		if (cs->tdr_active)
 			cancel_delayed_work_sync(&cs->work_tdr);
 
-		spin_lock(&hdev->hw_queues_mirror_lock);
+		spin_lock(&hdev->cs_mirror_lock);
 
 		/* queue TDR for next CS */
-		next = list_first_entry_or_null(&hdev->hw_queues_mirror_list,
+		next = list_first_entry_or_null(&hdev->cs_mirror_list,
 						struct hl_cs, mirror_node);
 
 		if (next && !next->tdr_active) {
@@ -370,7 +369,7 @@ static void cs_do_release(struct kref *ref)
 						hdev->timeout_jiffies);
 		}
 
-		spin_unlock(&hdev->hw_queues_mirror_lock);
+		spin_unlock(&hdev->cs_mirror_lock);
 	}
 
 out:
@@ -534,8 +533,7 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 		flush_workqueue(hdev->cq_wq[i]);
 
 	/* Make sure we don't have leftovers in the H/W queues mirror list */
-	list_for_each_entry_safe(cs, tmp, &hdev->hw_queues_mirror_list,
-				mirror_node) {
+	list_for_each_entry_safe(cs, tmp, &hdev->cs_mirror_list, mirror_node) {
 		cs_get(cs);
 		cs->aborted = true;
 		dev_warn_ratelimited(hdev->dev, "Killing CS %d.%llu\n",
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 348faf31668b..ce0a1270e5ff 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -343,8 +343,8 @@ static int device_early_init(struct hl_device *hdev)
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	mutex_init(&hdev->mmu_cache_lock);
-	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
-	spin_lock_init(&hdev->hw_queues_mirror_lock);
+	INIT_LIST_HEAD(&hdev->cs_mirror_list);
+	spin_lock_init(&hdev->cs_mirror_lock);
 	INIT_LIST_HEAD(&hdev->fpriv_list);
 	mutex_init(&hdev->fpriv_list_lock);
 	atomic_set(&hdev->in_reset, 0);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 40b566c4b791..eb968c30adb9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1699,8 +1699,8 @@ struct hl_mmu_funcs {
  * @eq_wq: work queue of event queue for executing work in process context.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
- * @hw_queues_mirror_list: CS mirror list for TDR.
- * @hw_queues_mirror_lock: protects hw_queues_mirror_list.
+ * @cs_mirror_list: CS mirror list for TDR.
+ * @cs_mirror_lock: protects cs_mirror_list.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
  * @event_queue: event queue for IRQ from CPU-CP.
  * @dma_pool: DMA pool for small allocations.
@@ -1810,8 +1810,8 @@ struct hl_device {
 	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
-	struct list_head		hw_queues_mirror_list;
-	spinlock_t			hw_queues_mirror_lock;
+	struct list_head		cs_mirror_list;
+	spinlock_t			cs_mirror_lock;
 	struct hl_cb_mgr		kernel_cb_mgr;
 	struct hl_eq			event_queue;
 	struct dma_pool			*dma_pool;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index f9550fcf5500..d1d30fb36410 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -578,20 +578,20 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	else if (cs->type == CS_TYPE_COLLECTIVE_WAIT)
 		hdev->asic_funcs->collective_wait_init_cs(cs);
 
-	spin_lock(&hdev->hw_queues_mirror_lock);
-	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
+	spin_lock(&hdev->cs_mirror_lock);
+	list_add_tail(&cs->mirror_node, &hdev->cs_mirror_list);
 
 	/* Queue TDR if the CS is the first entry and if timeout is wanted */
 	if ((hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) &&
-			(list_first_entry(&hdev->hw_queues_mirror_list,
+			(list_first_entry(&hdev->cs_mirror_list,
 					struct hl_cs, mirror_node) == cs)) {
 		cs->tdr_active = true;
 		schedule_delayed_work(&cs->work_tdr, hdev->timeout_jiffies);
-		spin_unlock(&hdev->hw_queues_mirror_lock);
-	} else {
-		spin_unlock(&hdev->hw_queues_mirror_lock);
+
 	}
 
+	spin_unlock(&hdev->cs_mirror_lock);
+
 	if (!hdev->cs_active_cnt++) {
 		struct hl_device_idle_busy_ts *ts;
 
-- 
2.17.1

