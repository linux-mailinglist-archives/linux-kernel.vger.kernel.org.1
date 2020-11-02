Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69922A34B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgKBT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgKBT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:58:13 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37329222BA;
        Mon,  2 Nov 2020 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347091;
        bh=3Z1oLhIa6PggvXfq1wOChmnuJkbye4s229taEOaJNyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTOLLZ56B5YLPsjoQuqUMIrqPEhyIWsGKhWG5eLYldqVU0T7IwxIDqbXnNAxQxF+H
         CoNAFyXoLpyqWoo7jBokmUaDUK0meAmRIDx/YPyHQpN1XiGoEzbw9AOEMcEuwvnJwl
         /mIds63pqHQH3vlK+ZhWRjJxOC3IYZjWgEvNmGQQ=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/4] habanalabs: sync stream structures refactor
Date:   Mon,  2 Nov 2020 21:57:59 +0200
Message-Id: <20201102195802.10608-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102195802.10608-1-ogabbay@kernel.org>
References: <20201102195802.10608-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Refactor sync stream implementation by adding more structures for
better readability. In addition reducing allocated resources.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  78 +++++---
 drivers/misc/habanalabs/common/hw_queue.c   | 197 +++++++++++---------
 drivers/misc/habanalabs/gaudi/gaudi.c       |  37 ++--
 drivers/misc/habanalabs/goya/goya.c         |   4 +-
 4 files changed, 180 insertions(+), 136 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d12f11bdaacf..58b4097235d9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -68,9 +68,6 @@
 #define HL_RSVD_SOBS			4
 #define HL_RSVD_MONS			2
 
-#define HL_RSVD_SOBS_IN_USE		2
-#define HL_RSVD_MONS_IN_USE		1
-
 #define HL_MAX_SOB_VAL			(1 << 15)
 
 #define IS_POWER_OF_2(n)		(n != 0 && ((n & (n - 1)) == 0))
@@ -80,6 +77,22 @@
 
 #define HL_MAX_DCORES			4
 
+/**
+ * struct hl_gen_wait_properties - properties for generating a wait CB
+ * @data: command buffer
+ * @q_idx: queue id is used to extract fence register address
+ * @sob_id: SOB id to use in this wait CB
+ * @sob_val: SOB value to wait for
+ * @mon_id: monitor to use in this wait CB
+ */
+struct hl_gen_wait_properties {
+	void	*data;
+	u32	q_idx;
+	u16	sob_id;
+	u16	sob_val;
+	u16	mon_id;
+};
+
 /**
  * struct pgt_info - MMU hop page info.
  * @node: hash linked-list node for the pgts shadow hash of pgts.
@@ -502,9 +515,27 @@ struct hl_cs_job;
 #define HL_CPU_ACCESSIBLE_MEM_SIZE	SZ_2M
 
 /**
- * struct hl_hw_queue - describes a H/W transport queue.
+ * struct hl_sync_stream_properties -
+ *     describes a H/W queue sync stream properties
  * @hw_sob: array of the used H/W SOBs by this H/W queue.
+ * @next_sob_val: the next value to use for the currently used SOB.
+ * @base_sob_id: the base SOB id of the SOBs used by this queue.
+ * @base_mon_id: the base MON id of the MONs used by this queue.
+ * @curr_sob_offset: the id offset to the currently used SOB from the
+ *                   HL_RSVD_SOBS that are being used by this queue.
+ */
+struct hl_sync_stream_properties {
+	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
+	u16			next_sob_val;
+	u16			base_sob_id;
+	u16			base_mon_id;
+	u8			curr_sob_offset;
+};
+
+/**
+ * struct hl_hw_queue - describes a H/W transport queue.
  * @shadow_queue: pointer to a shadow queue that holds pointers to jobs.
+ * @sync_stream_prop: sync stream queue properties
  * @queue_type: type of queue.
  * @kernel_address: holds the queue's kernel virtual address.
  * @bus_address: holds the queue's DMA address.
@@ -514,33 +545,24 @@ struct hl_cs_job;
  * @cq_id: the id for the corresponding CQ for this H/W queue.
  * @msi_vec: the IRQ number of the H/W queue.
  * @int_queue_len: length of internal queue (number of entries).
- * @next_sob_val: the next value to use for the currently used SOB.
- * @base_sob_id: the base SOB id of the SOBs used by this queue.
- * @base_mon_id: the base MON id of the MONs used by this queue.
  * @valid: is the queue valid (we have array of 32 queues, not all of them
  *         exist).
- * @curr_sob_offset: the id offset to the currently used SOB from the
- *                   HL_RSVD_SOBS that are being used by this queue.
  * @supports_sync_stream: True if queue supports sync stream
  */
 struct hl_hw_queue {
-	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
-	struct hl_cs_job	**shadow_queue;
-	enum hl_queue_type	queue_type;
-	u64			kernel_address;
-	dma_addr_t		bus_address;
-	u32			pi;
-	atomic_t		ci;
-	u32			hw_queue_id;
-	u32			cq_id;
-	u32			msi_vec;
-	u16			int_queue_len;
-	u16			next_sob_val;
-	u16			base_sob_id;
-	u16			base_mon_id;
-	u8			valid;
-	u8			curr_sob_offset;
-	u8			supports_sync_stream;
+	struct hl_cs_job			**shadow_queue;
+	struct hl_sync_stream_properties	sync_stream_prop;
+	enum hl_queue_type			queue_type;
+	u64					kernel_address;
+	dma_addr_t				bus_address;
+	u32					pi;
+	atomic_t				ci;
+	u32					hw_queue_id;
+	u32					cq_id;
+	u32					msi_vec;
+	u16					int_queue_len;
+	u8					valid;
+	u8					supports_sync_stream;
 };
 
 /**
@@ -823,8 +845,8 @@ struct hl_asic_funcs {
 	u32 (*get_signal_cb_size)(struct hl_device *hdev);
 	u32 (*get_wait_cb_size)(struct hl_device *hdev);
 	void (*gen_signal_cb)(struct hl_device *hdev, void *data, u16 sob_id);
-	void (*gen_wait_cb)(struct hl_device *hdev, void *data, u16 sob_id,
-				u16 sob_val, u16 mon_id, u32 q_idx);
+	void (*gen_wait_cb)(struct hl_device *hdev,
+			struct hl_gen_wait_properties *prop);
 	void (*reset_sob)(struct hl_device *hdev, void *data);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index adb61f9eb2b5..613681c2cdcc 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -389,6 +389,89 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
 
+static void init_signal_cs(struct hl_device *hdev,
+		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
+{
+	struct hl_sync_stream_properties *prop;
+	struct hl_hw_sob *hw_sob;
+	u32 q_idx;
+
+	q_idx = job->hw_queue_id;
+	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+	hw_sob = &prop->hw_sob[prop->curr_sob_offset];
+
+	cs_cmpl->hw_sob = hw_sob;
+	cs_cmpl->sob_val = prop->next_sob_val++;
+
+	dev_dbg(hdev->dev,
+		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
+		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx);
+
+	hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
+				cs_cmpl->hw_sob->sob_id);
+
+	kref_get(&hw_sob->kref);
+
+	/* check for wraparound */
+	if (prop->next_sob_val == HL_MAX_SOB_VAL) {
+		/*
+		 * Decrement as we reached the max value.
+		 * The release function won't be called here as we've
+		 * just incremented the refcount.
+		 */
+		kref_put(&hw_sob->kref, hl_sob_reset_error);
+		prop->next_sob_val = 1;
+		/* only two SOBs are currently in use */
+		prop->curr_sob_offset =
+			(prop->curr_sob_offset + 1) % HL_RSVD_SOBS;
+
+		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
+				prop->curr_sob_offset, q_idx);
+	}
+}
+
+static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
+		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
+{
+	struct hl_cs_compl *signal_cs_cmpl;
+	struct hl_sync_stream_properties *prop;
+	struct hl_gen_wait_properties wait_prop;
+	u32 q_idx;
+
+	q_idx = job->hw_queue_id;
+	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+
+	signal_cs_cmpl = container_of(cs->signal_fence,
+					struct hl_cs_compl,
+					base_fence);
+
+	/* copy the SOB id and value of the signal CS */
+	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
+	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+
+	dev_dbg(hdev->dev,
+		"generate wait CB, sob_id: %d, sob_val: 0x%x, mon_id: %d, q_idx: %d\n",
+		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
+		prop->base_mon_id, q_idx);
+
+	wait_prop.data = (void *) job->patched_cb;
+	wait_prop.sob_id = cs_cmpl->hw_sob->sob_id;
+	wait_prop.sob_val = cs_cmpl->sob_val;
+	wait_prop.mon_id = prop->base_mon_id;
+	wait_prop.q_idx = q_idx;
+	hdev->asic_funcs->gen_wait_cb(hdev, &wait_prop);
+
+	kref_get(&cs_cmpl->hw_sob->kref);
+	/*
+	 * Must put the signal fence after the SOB refcnt increment so
+	 * the SOB refcnt won't turn 0 and reset the SOB before the
+	 * wait CS was submitted.
+	 */
+	mb();
+	hl_fence_put(cs->signal_fence);
+	cs->signal_fence = NULL;
+}
+
 /*
  * init_signal_wait_cs - initialize a signal/wait CS
  * @cs: pointer to the signal/wait CS
@@ -399,84 +482,18 @@ static void init_signal_wait_cs(struct hl_cs *cs)
 {
 	struct hl_ctx *ctx = cs->ctx;
 	struct hl_device *hdev = ctx->hdev;
-	struct hl_hw_queue *hw_queue;
+	struct hl_cs_job *job;
 	struct hl_cs_compl *cs_cmpl =
 			container_of(cs->fence, struct hl_cs_compl, base_fence);
 
-	struct hl_hw_sob *hw_sob;
-	struct hl_cs_job *job;
-	u32 q_idx;
-
 	/* There is only one job in a signal/wait CS */
 	job = list_first_entry(&cs->job_list, struct hl_cs_job,
 				cs_node);
-	q_idx = job->hw_queue_id;
-	hw_queue = &hdev->kernel_queues[q_idx];
-
-	if (cs->type & CS_TYPE_SIGNAL) {
-		hw_sob = &hw_queue->hw_sob[hw_queue->curr_sob_offset];
-
-		cs_cmpl->hw_sob = hw_sob;
-		cs_cmpl->sob_val = hw_queue->next_sob_val++;
-
-		dev_dbg(hdev->dev,
-			"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
-			cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx);
-
-		hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
-					cs_cmpl->hw_sob->sob_id);
-
-		kref_get(&hw_sob->kref);
-
-		/* check for wraparound */
-		if (hw_queue->next_sob_val == HL_MAX_SOB_VAL) {
-			/*
-			 * Decrement as we reached the max value.
-			 * The release function won't be called here as we've
-			 * just incremented the refcount.
-			 */
-			kref_put(&hw_sob->kref, hl_sob_reset_error);
-			hw_queue->next_sob_val = 1;
-			/* only two SOBs are currently in use */
-			hw_queue->curr_sob_offset =
-					(hw_queue->curr_sob_offset + 1) %
-						HL_RSVD_SOBS_IN_USE;
-
-			dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
-					hw_queue->curr_sob_offset, q_idx);
-		}
-	} else if (cs->type & CS_TYPE_WAIT) {
-		struct hl_cs_compl *signal_cs_cmpl;
-
-		signal_cs_cmpl = container_of(cs->signal_fence,
-						struct hl_cs_compl,
-						base_fence);
-
-		/* copy the the SOB id and value of the signal CS */
-		cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
-		cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
 
-		dev_dbg(hdev->dev,
-			"generate wait CB, sob_id: %d, sob_val: 0x%x, mon_id: %d, q_idx: %d\n",
-			cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
-			hw_queue->base_mon_id, q_idx);
-
-		hdev->asic_funcs->gen_wait_cb(hdev, job->patched_cb,
-						cs_cmpl->hw_sob->sob_id,
-						cs_cmpl->sob_val,
-						hw_queue->base_mon_id,
-						q_idx);
-
-		kref_get(&cs_cmpl->hw_sob->kref);
-		/*
-		 * Must put the signal fence after the SOB refcnt increment so
-		 * the SOB refcnt won't turn 0 and reset the SOB before the
-		 * wait CS was submitted.
-		 */
-		mb();
-		hl_fence_put(cs->signal_fence);
-		cs->signal_fence = NULL;
-	}
+	if (cs->type & CS_TYPE_SIGNAL)
+		init_signal_cs(hdev, job, cs_cmpl);
+	else if (cs->type & CS_TYPE_WAIT)
+		init_wait_cs(hdev, cs, job, cs_cmpl);
 }
 
 /*
@@ -720,22 +737,28 @@ static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 
 static void sync_stream_queue_init(struct hl_device *hdev, u32 q_idx)
 {
-	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
+	struct hl_sync_stream_properties *sync_stream_prop;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_hw_sob *hw_sob;
-	int sob, queue_idx = hdev->sync_stream_queue_idx++;
+	int sob, queue_idx;
+
+	if (!hdev->kernel_queues[q_idx].supports_sync_stream)
+		return;
+
+	sync_stream_prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+	queue_idx = hdev->sync_stream_queue_idx++;
 
-	hw_queue->base_sob_id =
-		prop->sync_stream_first_sob + queue_idx * HL_RSVD_SOBS;
-	hw_queue->base_mon_id =
-		prop->sync_stream_first_mon + queue_idx * HL_RSVD_MONS;
-	hw_queue->next_sob_val = 1;
-	hw_queue->curr_sob_offset = 0;
+	sync_stream_prop->base_sob_id = prop->sync_stream_first_sob +
+			(queue_idx * HL_RSVD_SOBS);
+	sync_stream_prop->base_mon_id = prop->sync_stream_first_mon +
+			(queue_idx * HL_RSVD_MONS);
+	sync_stream_prop->next_sob_val = 1;
+	sync_stream_prop->curr_sob_offset = 0;
 
 	for (sob = 0 ; sob < HL_RSVD_SOBS ; sob++) {
-		hw_sob = &hw_queue->hw_sob[sob];
+		hw_sob = &sync_stream_prop->hw_sob[sob];
 		hw_sob->hdev = hdev;
-		hw_sob->sob_id = hw_queue->base_sob_id + sob;
+		hw_sob->sob_id = sync_stream_prop->base_sob_id + sob;
 		hw_sob->q_idx = q_idx;
 		kref_init(&hw_sob->kref);
 	}
@@ -743,15 +766,16 @@ static void sync_stream_queue_init(struct hl_device *hdev, u32 q_idx)
 
 static void sync_stream_queue_reset(struct hl_device *hdev, u32 q_idx)
 {
-	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
+	struct hl_sync_stream_properties *prop =
+			&hdev->kernel_queues[q_idx].sync_stream_prop;
 
 	/*
 	 * In case we got here due to a stuck CS, the refcnt might be bigger
 	 * than 1 and therefore we reset it.
 	 */
-	kref_init(&hw_queue->hw_sob[hw_queue->curr_sob_offset].kref);
-	hw_queue->curr_sob_offset = 0;
-	hw_queue->next_sob_val = 1;
+	kref_init(&prop->hw_sob[prop->curr_sob_offset].kref);
+	prop->curr_sob_offset = 0;
+	prop->next_sob_val = 1;
 }
 
 /*
@@ -794,8 +818,7 @@ static int queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 		break;
 	}
 
-	if (q->supports_sync_stream)
-		sync_stream_queue_init(hdev, q->hw_queue_id);
+	sync_stream_queue_init(hdev, q->hw_queue_id);
 
 	if (rc)
 		return rc;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9d9d22c4452c..46dced9d1eec 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -472,9 +472,11 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
 
 	prop->first_available_user_sob[HL_GAUDI_WS_DCORE] =
-			num_sync_stream_queues * HL_RSVD_SOBS;
+			prop->sync_stream_first_sob +
+			(num_sync_stream_queues * HL_RSVD_SOBS);
 	prop->first_available_user_mon[HL_GAUDI_WS_DCORE] =
-			num_sync_stream_queues * HL_RSVD_MONS;
+			prop->sync_stream_first_mon +
+			(num_sync_stream_queues * HL_RSVD_MONS);
 
 	return 0;
 }
@@ -6472,16 +6474,16 @@ static u32 gaudi_add_fence_pkt(struct packet_fence *pkt)
 	return pkt_size;
 }
 
-static void gaudi_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
-			u16 sob_val, u16 mon_id, u32 q_idx)
+static void gaudi_gen_wait_cb(struct hl_device *hdev,
+		struct hl_gen_wait_properties *prop)
 {
-	struct hl_cb *cb = (struct hl_cb *) data;
+	struct hl_cb *cb = (struct hl_cb *) prop->data;
 	void *buf = (void *) (uintptr_t) cb->kernel_address;
 	u64 monitor_base, fence_addr = 0;
 	u32 size = 0;
 	u16 msg_addr_offset;
 
-	switch (q_idx) {
+	switch (prop->q_idx) {
 	case GAUDI_QUEUE_ID_DMA_0_0:
 		fence_addr = mmDMA0_QM_CP_FENCE2_RDATA_0;
 		break;
@@ -6521,7 +6523,7 @@ static void gaudi_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
 	default:
 		/* queue index should be valid here */
 		dev_crit(hdev->dev, "wrong queue id %d for wait packet\n",
-				q_idx);
+				prop->q_idx);
 		return;
 	}
 
@@ -6534,17 +6536,15 @@ static void gaudi_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
 	monitor_base = mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0;
 
 	/* First monitor config packet: low address of the sync */
-	msg_addr_offset =
-		(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + mon_id * 4) -
-				monitor_base;
+	msg_addr_offset = (mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 +
+			prop->mon_id * 4) - monitor_base;
 
 	size += gaudi_add_mon_msg_short(buf + size, (u32) fence_addr,
 					msg_addr_offset);
 
 	/* Second monitor config packet: high address of the sync */
-	msg_addr_offset =
-		(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 + mon_id * 4) -
-				monitor_base;
+	msg_addr_offset = (mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 +
+			prop->mon_id * 4) - monitor_base;
 
 	size += gaudi_add_mon_msg_short(buf + size, (u32) (fence_addr >> 32),
 					msg_addr_offset);
@@ -6553,18 +6553,17 @@ static void gaudi_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
 	 * Third monitor config packet: the payload, i.e. what to write when the
 	 * sync triggers
 	 */
-	msg_addr_offset =
-		(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + mon_id * 4) -
-				monitor_base;
+	msg_addr_offset = (mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_DATA_0 +
+			prop->mon_id * 4) - monitor_base;
 
 	size += gaudi_add_mon_msg_short(buf + size, 1, msg_addr_offset);
 
 	/* Fourth monitor config packet: bind the monitor to a sync object */
 	msg_addr_offset =
-		(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0 + mon_id * 4) -
+		(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0 + prop->mon_id * 4) -
 				monitor_base;
-	size += gaudi_add_arm_monitor_pkt(buf + size, sob_id, sob_val,
-						msg_addr_offset);
+	size += gaudi_add_arm_monitor_pkt(buf + size, prop->sob_id,
+			prop->sob_val, msg_addr_offset);
 
 	/* Fence packet */
 	size += gaudi_add_fence_pkt(buf + size);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f41fe748f1ca..cd1366f10fbe 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5297,8 +5297,8 @@ static void goya_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id)
 
 }
 
-static void goya_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
-			u16 sob_val, u16 mon_id, u32 q_idx)
+static void goya_gen_wait_cb(struct hl_device *hdev,
+		struct hl_gen_wait_properties *prop)
 {
 
 }
-- 
2.17.1

