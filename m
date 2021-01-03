Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4780A2E8E19
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhACUaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhACU37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:29:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C80F207FB;
        Sun,  3 Jan 2021 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609705758;
        bh=xyTq1ZFzk+HtL+V5RGAjgz1MBuiZzDZGzFQA1npBlv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYRcyLerkKi+xkJErpnSMYJUwaQYlmNd9WInKNavx+ZdaUbhzEujZ3d+xjbDmf92X
         v80A/9NfOEye0sFfKDaofTrU9+QpvXDEAXtwSpw+ehZIl9fNUGdSLGRPhkKVh3YGN1
         eZQ5/Zc6z2IkPV1QKK5xDTQrrga9ZJ9VaEA2hRtdZEvsxOnPboDkuorMiopRX57L5t
         5iTnf80q0l0DaTqxVEApgIMVCktNFv0fX2re/hI43tKue32LZojHGs6IAztzREiNZt
         bDVyc1SKah84/sh278VccgnHrNwDRR0YMtQr3zYEdDYyFLhB+Xl5SBWRIcCo04a2c6
         6qq5N7ef3I9GA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/4] habanalabs/gaudi: remove PCI access to SM block
Date:   Sun,  3 Jan 2021 22:29:09 +0200
Message-Id: <20210103202909.243-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103202909.243-1-ogabbay@kernel.org>
References: <20210103202909.243-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

due to HW limitation we must remove all direct access to SM
registers, in order to do that we will access SM registers using
the HW QMANS.
When possible and no user context is present, we can directly access
the HW QMANS, whenever there is an active user, driver will
prepare a pending command buffer list which will be sent upon
user submissions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 246 ++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   2 +
 .../habanalabs/include/gaudi/gaudi_packets.h  |   3 +
 3 files changed, 225 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f9a99872a56e..611a691206f1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -354,6 +354,10 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 					struct hl_cs_job *job);
 static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 					u32 size, u64 val);
+static int gaudi_memset_registers(struct hl_device *hdev, u64 reg_base,
+					u32 num_regs, u32 val);
+static int gaudi_schedule_register_memset(struct hl_device *hdev,
+		u32 hw_queue_id, u64 reg_base, u32 num_regs, u32 val);
 static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 				u32 tpc_id);
 static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev);
@@ -913,11 +917,17 @@ static void gaudi_sob_group_hw_reset(struct kref *ref)
 	struct gaudi_hw_sob_group *hw_sob_group =
 		container_of(ref, struct gaudi_hw_sob_group, kref);
 	struct hl_device *hdev = hw_sob_group->hdev;
-	int i;
+	u64 base_addr;
+	int rc;
 
-	for (i = 0 ; i < NUMBER_OF_SOBS_IN_GRP ; i++)
-		WREG32(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 +
-				(hw_sob_group->base_sob_id + i) * 4, 0);
+	base_addr = CFG_BASE + mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 +
+			hw_sob_group->base_sob_id * 4;
+	rc = gaudi_schedule_register_memset(hdev, hw_sob_group->queue_id,
+			base_addr, NUMBER_OF_SOBS_IN_GRP, 0);
+	if (rc)
+		dev_err(hdev->dev,
+			"failed resetting sob group - sob base %u, count %u",
+			hw_sob_group->base_sob_id, NUMBER_OF_SOBS_IN_GRP);
 
 	kref_init(&hw_sob_group->kref);
 }
@@ -1008,6 +1018,8 @@ static void gaudi_collective_master_init_job(struct hl_device *hdev,
 		cprop->hw_sob_group[sob_group_offset].base_sob_id;
 	master_monitor = prop->collective_mstr_mon_id[0];
 
+	cprop->hw_sob_group[sob_group_offset].queue_id = queue_id;
+
 	dev_dbg(hdev->dev,
 		"Generate master wait CBs, sob %d (mask %#x), val:0x%x, mon %u, q %d\n",
 		master_sob_base, cprop->mstr_sob_mask[0],
@@ -5582,31 +5594,204 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	return rc;
 }
 
-static void gaudi_restore_sm_registers(struct hl_device *hdev)
+static int gaudi_memset_registers(struct hl_device *hdev, u64 reg_base,
+					u32 num_regs, u32 val)
+{
+	struct packet_msg_long *pkt;
+	struct hl_cs_job *job;
+	u32 cb_size, ctl;
+	struct hl_cb *cb;
+	int i, rc;
+
+	cb_size = (sizeof(*pkt) * num_regs) + sizeof(struct packet_msg_prot);
+
+	if (cb_size > SZ_2M) {
+		dev_err(hdev->dev, "CB size must be smaller than %uMB", SZ_2M);
+		return -ENOMEM;
+	}
+
+	cb = hl_cb_kernel_create(hdev, cb_size, false);
+	if (!cb)
+		return -EFAULT;
+
+	pkt = cb->kernel_address;
+
+	ctl = FIELD_PREP(GAUDI_PKT_LONG_CTL_OP_MASK, 0); /* write the value */
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_LONG);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
+
+	for (i = 0; i < num_regs ; i++, pkt++) {
+		pkt->ctl = cpu_to_le32(ctl);
+		pkt->value = cpu_to_le32(val);
+		pkt->addr = cpu_to_le64(reg_base + (i * 4));
+	}
+
+	job = hl_cs_allocate_job(hdev, QUEUE_TYPE_EXT, true);
+	if (!job) {
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		rc = -ENOMEM;
+		goto release_cb;
+	}
+
+	job->id = 0;
+	job->user_cb = cb;
+	atomic_inc(&job->user_cb->cs_cnt);
+	job->user_cb_size = cb_size;
+	job->hw_queue_id = GAUDI_QUEUE_ID_DMA_0_0;
+	job->patched_cb = job->user_cb;
+	job->job_cb_size = cb_size;
+
+	hl_debugfs_add_job(hdev, job);
+
+	rc = gaudi_send_job_on_qman0(hdev, job);
+	hl_debugfs_remove_job(hdev, job);
+	kfree(job);
+	atomic_dec(&cb->cs_cnt);
+
+release_cb:
+	hl_cb_put(cb);
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+
+	return rc;
+}
+
+static int gaudi_schedule_register_memset(struct hl_device *hdev,
+		u32 hw_queue_id, u64 reg_base, u32 num_regs, u32 val)
 {
+	struct hl_ctx *ctx = hdev->compute_ctx;
+	struct hl_pending_cb *pending_cb;
+	struct packet_msg_long *pkt;
+	u32 cb_size, ctl;
+	struct hl_cb *cb;
 	int i;
 
-	for (i = 0 ; i < NUM_OF_SOB_IN_BLOCK << 2 ; i += 4) {
-		WREG32(mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0 + i, 0);
-		WREG32(mmSYNC_MNGR_E_S_SYNC_MNGR_OBJS_SOB_OBJ_0 + i, 0);
-		WREG32(mmSYNC_MNGR_W_N_SYNC_MNGR_OBJS_SOB_OBJ_0 + i, 0);
+	/* If no compute context available memset registers directly */
+	if (!ctx)
+		return gaudi_memset_registers(hdev, reg_base, num_regs, val);
+
+	cb_size = (sizeof(*pkt) * num_regs) +
+			sizeof(struct packet_msg_prot) * 2;
+
+	if (cb_size > SZ_2M) {
+		dev_err(hdev->dev, "CB size must be smaller than %uMB", SZ_2M);
+		return -ENOMEM;
 	}
 
-	for (i = 0 ; i < NUM_OF_MONITORS_IN_BLOCK << 2 ; i += 4) {
-		WREG32(mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_0 + i, 0);
-		WREG32(mmSYNC_MNGR_E_S_SYNC_MNGR_OBJS_MON_STATUS_0 + i, 0);
-		WREG32(mmSYNC_MNGR_W_N_SYNC_MNGR_OBJS_MON_STATUS_0 + i, 0);
+	pending_cb = kzalloc(sizeof(*pending_cb), GFP_KERNEL);
+	if (!pending_cb)
+		return -ENOMEM;
+
+	cb = hl_cb_kernel_create(hdev, cb_size, false);
+	if (!cb) {
+		kfree(pending_cb);
+		return -EFAULT;
 	}
 
-	i = GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT * 4;
+	pkt = cb->kernel_address;
+
+	ctl = FIELD_PREP(GAUDI_PKT_LONG_CTL_OP_MASK, 0); /* write the value */
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_LONG);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
+
+	for (i = 0; i < num_regs ; i++, pkt++) {
+		pkt->ctl = cpu_to_le32(ctl);
+		pkt->value = cpu_to_le32(val);
+		pkt->addr = cpu_to_le64(reg_base + (i * 4));
+	}
 
-	for (; i < NUM_OF_SOB_IN_BLOCK << 2 ; i += 4)
-		WREG32(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 + i, 0);
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
 
-	i = GAUDI_FIRST_AVAILABLE_W_S_MONITOR * 4;
+	pending_cb->cb = cb;
+	pending_cb->cb_size = cb_size;
+	/* The queue ID MUST be an external queue ID. Otherwise, we will
+	 * have undefined behavior
+	 */
+	pending_cb->hw_queue_id = hw_queue_id;
 
-	for (; i < NUM_OF_MONITORS_IN_BLOCK << 2 ; i += 4)
-		WREG32(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0 + i, 0);
+	spin_lock(&ctx->pending_cb_lock);
+	list_add_tail(&pending_cb->cb_node, &ctx->pending_cb_list);
+	spin_unlock(&ctx->pending_cb_lock);
+
+	return 0;
+}
+
+static int gaudi_restore_sm_registers(struct hl_device *hdev)
+{
+	u64 base_addr;
+	u32 num_regs;
+	int rc;
+
+	base_addr = CFG_BASE + mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0;
+	num_regs = NUM_OF_SOB_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_E_S_SYNC_MNGR_OBJS_SOB_OBJ_0;
+	num_regs = NUM_OF_SOB_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_W_N_SYNC_MNGR_OBJS_SOB_OBJ_0;
+	num_regs = NUM_OF_SOB_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_0;
+	num_regs = NUM_OF_MONITORS_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_E_S_SYNC_MNGR_OBJS_MON_STATUS_0;
+	num_regs = NUM_OF_MONITORS_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_W_N_SYNC_MNGR_OBJS_MON_STATUS_0;
+	num_regs = NUM_OF_MONITORS_IN_BLOCK;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 +
+			(GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT * 4);
+	num_regs = NUM_OF_SOB_IN_BLOCK - GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	base_addr = CFG_BASE +  mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0 +
+			(GAUDI_FIRST_AVAILABLE_W_S_MONITOR * 4);
+	num_regs = NUM_OF_MONITORS_IN_BLOCK - GAUDI_FIRST_AVAILABLE_W_S_MONITOR;
+	rc = gaudi_memset_registers(hdev, base_addr, num_regs, 0);
+	if (rc) {
+		dev_err(hdev->dev, "failed resetting SM registers");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static void gaudi_restore_dma_registers(struct hl_device *hdev)
@@ -5663,18 +5848,23 @@ static void gaudi_restore_qm_registers(struct hl_device *hdev)
 	}
 }
 
-static void gaudi_restore_user_registers(struct hl_device *hdev)
+static int gaudi_restore_user_registers(struct hl_device *hdev)
 {
-	gaudi_restore_sm_registers(hdev);
+	int rc;
+
+	rc = gaudi_restore_sm_registers(hdev);
+	if (rc)
+		return rc;
+
 	gaudi_restore_dma_registers(hdev);
 	gaudi_restore_qm_registers(hdev);
+
+	return 0;
 }
 
 static int gaudi_context_switch(struct hl_device *hdev, u32 asid)
 {
-	gaudi_restore_user_registers(hdev);
-
-	return 0;
+	return gaudi_restore_user_registers(hdev);
 }
 
 static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev)
@@ -8202,12 +8392,16 @@ static u32 gaudi_gen_wait_cb(struct hl_device *hdev,
 static void gaudi_reset_sob(struct hl_device *hdev, void *data)
 {
 	struct hl_hw_sob *hw_sob = (struct hl_hw_sob *) data;
+	int rc;
 
 	dev_dbg(hdev->dev, "reset SOB, q_idx: %d, sob_id: %d\n", hw_sob->q_idx,
 		hw_sob->sob_id);
 
-	WREG32(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 + hw_sob->sob_id * 4,
-		0);
+	rc = gaudi_schedule_register_memset(hdev, hw_sob->q_idx,
+			CFG_BASE + mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 +
+			hw_sob->sob_id * 4, 1, 0);
+	if (rc)
+		dev_err(hdev->dev, "failed resetting sob %u", hw_sob->sob_id);
 
 	kref_init(&hw_sob->kref);
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index a7ab2d7e57d4..78830443341d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -251,11 +251,13 @@ enum gaudi_nic_mask {
  * @hdev: habanalabs device structure.
  * @kref: refcount of this SOB group. group will reset once refcount is zero.
  * @base_sob_id: base sob id of this SOB group.
+ * @queue_id: id of the queue that waits on this sob group
  */
 struct gaudi_hw_sob_group {
 	struct hl_device	*hdev;
 	struct kref		kref;
 	u32			base_sob_id;
+	u32			queue_id;
 };
 
 #define NUM_SOB_GROUPS (HL_RSVD_SOBS * QMAN_STREAMS)
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
index 784b5bc8d0ba..6e097ace2e96 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
@@ -78,6 +78,9 @@ struct packet_wreg_bulk {
 	__le64 values[0]; /* data starts here */
 };
 
+#define GAUDI_PKT_LONG_CTL_OP_SHIFT		20
+#define GAUDI_PKT_LONG_CTL_OP_MASK		0x00300000
+
 struct packet_msg_long {
 	__le32 value;
 	__le32 ctl;
-- 
2.25.1

