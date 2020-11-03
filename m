Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7032A48DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgKCPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgKCPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:01:00 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B314820757;
        Tue,  3 Nov 2020 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415658;
        bh=vVeb+sxfQB6Je75BG3hsfmeLKPG0MTbF0F2mwlwdi0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogOlsFnU1AbMo5YdCBeottvMRNfgZgUNcDMX5KnmTm+GrprgFSTowNRNfVfhVZ/sy
         pqv1LHJUYf2ivK7KrOj18+VoHzA3YdcTX5oPhMnnq7zsbv94un0uvG0xNmbqh1+pVy
         u5xDBYdr3nbGe8okAhseAHgIE6r55ITgFgJFmT7c=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/3] habanalabs: sync stream collective support
Date:   Tue,  3 Nov 2020 17:00:46 +0200
Message-Id: <20201103150046.19074-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103150046.19074-1-ogabbay@kernel.org>
References: <20201103150046.19074-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Implement sync stream collective for GAUDI. Need to allocate additional
resources for that and add ctx_fini() to clean up those resources.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  11 +-
 drivers/misc/habanalabs/common/context.c      |   1 +
 drivers/misc/habanalabs/common/habanalabs.h   |   7 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 853 ++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  40 +-
 drivers/misc/habanalabs/goya/goya.c           |   6 +
 include/uapi/misc/habanalabs.h                |  14 +-
 7 files changed, 867 insertions(+), 65 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index e3fb8f51fefa..f5bf8684f8aa 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -142,7 +142,7 @@ static void hl_fence_init(struct hl_fence *fence)
 	init_completion(&fence->completion);
 }
 
-static void cs_get(struct hl_cs *cs)
+void cs_get(struct hl_cs *cs)
 {
 	kref_get(&cs->refcount);
 }
@@ -917,6 +917,9 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	job->job_cb_size = job->user_cb_size;
 	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
 
+	/* increment refcount as for external queues we get completion */
+	cs_get(cs);
+
 	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
 
 	list_add_tail(&job->cs_node, &cs->job_list);
@@ -1072,11 +1075,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				cs, q_idx, collective_engine_id);
 
 	if (rc)
-		goto put_cs;
-
-
-	/* increment refcount as for external queues we get completion */
-	cs_get(cs);
+		goto free_cs_object;
 
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 7a59dd7c6450..2077bbe3606a 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -40,6 +40,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		if ((hdev->in_debug) && (hdev->compute_ctx == ctx))
 			hl_device_set_debug_mode(hdev, false);
 
+		hdev->asic_funcs->ctx_fini(ctx);
 		hl_cb_va_pool_fini(ctx);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 91a5de1c8805..70d166e4fe09 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -65,8 +65,8 @@
  * HL_RSVD_SOBS 'sync stream' reserved sync objects per QMAN stream
  * HL_RSVD_MONS 'sync stream' reserved monitors per QMAN stream
  */
-#define HL_RSVD_SOBS			4
-#define HL_RSVD_MONS			2
+#define HL_RSVD_SOBS			2
+#define HL_RSVD_MONS			1
 
 /*
  * HL_COLLECTIVE_RSVD_MSTR_MONS 'collective' reserved monitors per QMAN stream
@@ -785,6 +785,7 @@ enum div_select_defs {
  * @wreg: Write a register. Needed for simulator support.
  * @halt_coresight: stop the ETF and ETR traces.
  * @ctx_init: context dependent initialization.
+ * @ctx_fini: context dependent cleanup.
  * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
  * @read_device_fw_version: read the device's firmware versions that are
@@ -891,6 +892,7 @@ struct hl_asic_funcs {
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 	void (*halt_coresight)(struct hl_device *hdev);
 	int (*ctx_init)(struct hl_ctx *ctx);
+	void (*ctx_fini)(struct hl_ctx *ctx);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
 	void (*read_device_fw_version)(struct hl_device *hdev,
@@ -1992,6 +1994,7 @@ void hl_sob_reset_error(struct kref *ref);
 int hl_gen_sob_mask(u16 sob_base, u8 sob_mask, u8 *mask);
 void hl_fence_put(struct hl_fence *fence);
 void hl_fence_get(struct hl_fence *fence);
+void cs_get(struct hl_cs *cs);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2ba15d3470dd..f73e508cf14c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -358,6 +358,31 @@ static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev);
 static int gaudi_cpucp_info_get(struct hl_device *hdev);
 static void gaudi_disable_clock_gating(struct hl_device *hdev);
 static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid);
+static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
+				u32 size);
+static u32 gaudi_gen_wait_cb(struct hl_device *hdev,
+				struct hl_gen_wait_properties *prop);
+
+static inline enum hl_collective_mode
+get_collective_mode(struct hl_device *hdev, u32 queue_id)
+{
+	if (gaudi_queue_type[queue_id] == QUEUE_TYPE_EXT)
+		return HL_COLLECTIVE_MASTER;
+
+	if (queue_id >= GAUDI_QUEUE_ID_DMA_5_0 &&
+			queue_id <= GAUDI_QUEUE_ID_DMA_5_3)
+		return HL_COLLECTIVE_SLAVE;
+
+	if (queue_id >= GAUDI_QUEUE_ID_TPC_7_0 &&
+			queue_id <= GAUDI_QUEUE_ID_TPC_7_3)
+		return HL_COLLECTIVE_SLAVE;
+
+	if (queue_id >= GAUDI_QUEUE_ID_NIC_0_0 &&
+			queue_id <= GAUDI_QUEUE_ID_NIC_9_3)
+		return HL_COLLECTIVE_SLAVE;
+
+	return HL_COLLECTIVE_NOT_SUPPORTED;
+}
 
 static int gaudi_get_fixed_properties(struct hl_device *hdev)
 {
@@ -393,18 +418,28 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->hw_queues_props[i].supports_sync_stream = 0;
 			prop->hw_queues_props[i].cb_alloc_flags =
 				CB_ALLOC_USER;
-		} else if (gaudi_queue_type[i] == QUEUE_TYPE_NA) {
-			prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
-			prop->hw_queues_props[i].driver_only = 0;
-			prop->hw_queues_props[i].supports_sync_stream = 0;
-			prop->hw_queues_props[i].cb_alloc_flags =
-				CB_ALLOC_USER;
+
 		}
+		prop->hw_queues_props[i].collective_mode =
+						get_collective_mode(hdev, i);
 	}
 
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
-	prop->sync_stream_first_sob = 0;
-	prop->sync_stream_first_mon = 0;
+	prop->collective_first_sob = 0;
+	prop->collective_first_mon = 0;
+
+	/* 2 SOBs per internal queue stream are reserved for collective */
+	prop->sync_stream_first_sob =
+			ALIGN(NUMBER_OF_SOBS_IN_GRP, HL_MAX_SOBS_PER_MONITOR)
+			* QMAN_STREAMS * HL_RSVD_SOBS;
+
+	/* 1 monitor per internal queue stream are reserved for collective
+	 * 2 monitors per external queue stream are reserved for collective
+	 */
+	prop->sync_stream_first_mon =
+			(NUMBER_OF_COLLECTIVE_QUEUES * QMAN_STREAMS) +
+			(NUMBER_OF_EXT_HW_QUEUES * 2);
+
 	prop->dram_base_address = DRAM_PHYS_BASE;
 	prop->dram_size = GAUDI_HBM_SIZE_32GB;
 	prop->dram_end_address = prop->dram_base_address +
@@ -790,21 +825,454 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 	return rc;
 }
 
-static void gaudi_reset_sob_group(struct hl_device *hdev, u16 sob_groupt)
+static void gaudi_collective_map_sobs(struct hl_device *hdev, u32 stream)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct gaudi_collective_properties *prop = &gaudi->collective_props;
+	struct hl_hw_queue *q;
+	u32 i, sob_id, sob_group_id, queue_id;
+
+	/* Iterate through SOB groups and assign a SOB for each slave queue */
+	sob_group_id =
+		stream * HL_RSVD_SOBS + prop->curr_sob_group_idx[stream];
+	sob_id = prop->hw_sob_group[sob_group_id].base_sob_id;
+
+	queue_id = GAUDI_QUEUE_ID_NIC_0_0 + stream;
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++) {
+		q = &hdev->kernel_queues[queue_id + (4 * i)];
+		q->sync_stream_prop.collective_sob_id = sob_id + i;
+	}
+
+	/* Both DMA5 and TPC7 use the same resources since only a single
+	 * engine need to participate in the reduction process
+	 */
+	queue_id = GAUDI_QUEUE_ID_DMA_5_0 + stream;
+	q = &hdev->kernel_queues[queue_id];
+	q->sync_stream_prop.collective_sob_id =
+			sob_id + NIC_NUMBER_OF_ENGINES;
+
+	queue_id = GAUDI_QUEUE_ID_TPC_7_0 + stream;
+	q = &hdev->kernel_queues[queue_id];
+	q->sync_stream_prop.collective_sob_id =
+			sob_id + NIC_NUMBER_OF_ENGINES;
+}
+
+static void gaudi_sob_group_hw_reset(struct kref *ref)
+{
+	struct gaudi_hw_sob_group *hw_sob_group =
+		container_of(ref, struct gaudi_hw_sob_group, kref);
+	struct hl_device *hdev = hw_sob_group->hdev;
+	int i;
+
+	for (i = 0 ; i < NUMBER_OF_SOBS_IN_GRP ; i++)
+		WREG32(mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 +
+				(hw_sob_group->base_sob_id + i) * 4, 0);
+
+	kref_init(&hw_sob_group->kref);
+}
+
+static void gaudi_sob_group_reset_error(struct kref *ref)
+{
+	struct gaudi_hw_sob_group *hw_sob_group =
+		container_of(ref, struct gaudi_hw_sob_group, kref);
+	struct hl_device *hdev = hw_sob_group->hdev;
+
+	dev_crit(hdev->dev,
+		"SOB release shouldn't be called here, base_sob_id: %d\n",
+		hw_sob_group->base_sob_id);
+}
+
+static int gaudi_collective_init(struct hl_device *hdev)
+{
+	u32 i, master_monitor_sobs, sob_id, reserved_sobs_per_group;
+	struct gaudi_collective_properties *prop;
+	struct gaudi_device *gaudi;
+
+	gaudi = hdev->asic_specific;
+	prop = &gaudi->collective_props;
+	sob_id = hdev->asic_prop.collective_first_sob;
+
+	/* First sob in group must be aligned to HL_MAX_SOBS_PER_MONITOR */
+	reserved_sobs_per_group =
+		ALIGN(NUMBER_OF_SOBS_IN_GRP, HL_MAX_SOBS_PER_MONITOR);
+
+	/* Init SOB groups */
+	for (i = 0 ; i < NUM_SOB_GROUPS; i++) {
+		prop->hw_sob_group[i].hdev = hdev;
+		prop->hw_sob_group[i].base_sob_id = sob_id;
+		sob_id += reserved_sobs_per_group;
+		gaudi_sob_group_hw_reset(&prop->hw_sob_group[i].kref);
+	}
+
+	for (i = 0 ; i < QMAN_STREAMS; i++) {
+		prop->next_sob_group_val[i] = 1;
+		prop->curr_sob_group_idx[i] = 0;
+		gaudi_collective_map_sobs(hdev, i);
+	}
+
+	prop->mstr_sob_mask[0] = 0;
+	master_monitor_sobs = HL_MAX_SOBS_PER_MONITOR;
+	for (i = 0 ; i < master_monitor_sobs ; i++)
+		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + i))
+			prop->mstr_sob_mask[0] |= BIT(i);
+
+	prop->mstr_sob_mask[1] = 0;
+	master_monitor_sobs =
+		NIC_NUMBER_OF_ENGINES - HL_MAX_SOBS_PER_MONITOR;
+	for (i = 0 ; i < master_monitor_sobs; i++) {
+		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + i))
+			prop->mstr_sob_mask[1] |= BIT(i);
+	}
+
+	/* Set collective engine bit */
+	prop->mstr_sob_mask[1] |= BIT(i);
+
+	return 0;
+}
+
+static void gaudi_reset_sob_group(struct hl_device *hdev, u16 sob_group)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct gaudi_collective_properties *cprop = &gaudi->collective_props;
+
+	kref_put(&cprop->hw_sob_group[sob_group].kref,
+					gaudi_sob_group_hw_reset);
+}
+
+static void gaudi_collective_master_init_job(struct hl_device *hdev,
+		struct hl_cs_job *job, u32 stream, u32 sob_group_offset)
+{
+	u32 master_sob_base, master_monitor, queue_id, cb_size = 0;
+	struct gaudi_collective_properties *cprop;
+	struct hl_gen_wait_properties wait_prop;
+	struct hl_sync_stream_properties *prop;
+	struct gaudi_device *gaudi;
+
+	gaudi = hdev->asic_specific;
+	cprop = &gaudi->collective_props;
+	queue_id = job->hw_queue_id;
+	prop = &hdev->kernel_queues[queue_id].sync_stream_prop;
+
+	master_sob_base =
+		cprop->hw_sob_group[sob_group_offset].base_sob_id;
+	master_monitor = prop->collective_mstr_mon_id[0];
+
+	dev_dbg(hdev->dev,
+		"Generate master wait CBs, sob %d (mask %#x), val:0x%x, mon %u, q %d\n",
+		master_sob_base, cprop->mstr_sob_mask[0],
+		cprop->next_sob_group_val[stream],
+		master_monitor, queue_id);
+
+	wait_prop.data = (void *) job->patched_cb;
+	wait_prop.sob_base = master_sob_base;
+	wait_prop.sob_mask = cprop->mstr_sob_mask[0];
+	wait_prop.sob_val = cprop->next_sob_group_val[stream];
+	wait_prop.mon_id = master_monitor;
+	wait_prop.q_idx = queue_id;
+	wait_prop.size = cb_size;
+	cb_size += gaudi_gen_wait_cb(hdev, &wait_prop);
+
+	master_sob_base += HL_MAX_SOBS_PER_MONITOR;
+	master_monitor = prop->collective_mstr_mon_id[1];
+
+	dev_dbg(hdev->dev,
+		"Generate master wait CBs, sob %d (mask %#x), val:0x%x, mon %u, q %d\n",
+		master_sob_base, cprop->mstr_sob_mask[1],
+		cprop->next_sob_group_val[stream],
+		master_monitor, queue_id);
+
+	wait_prop.sob_base = master_sob_base;
+	wait_prop.sob_mask = cprop->mstr_sob_mask[1];
+	wait_prop.mon_id = master_monitor;
+	wait_prop.size = cb_size;
+	cb_size += gaudi_gen_wait_cb(hdev, &wait_prop);
+}
+
+static void gaudi_collective_slave_init_job(struct hl_device *hdev,
+		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
 {
+	struct hl_gen_wait_properties wait_prop;
+	struct hl_sync_stream_properties *prop;
+	u32 queue_id, cb_size = 0;
+
+	queue_id = job->hw_queue_id;
+	prop = &hdev->kernel_queues[queue_id].sync_stream_prop;
 
+	/* Add to wait CBs using slave monitor */
+	wait_prop.data = (void *) job->user_cb;
+	wait_prop.sob_base = cs_cmpl->hw_sob->sob_id;
+	wait_prop.sob_mask = 0x1;
+	wait_prop.sob_val = cs_cmpl->sob_val;
+	wait_prop.mon_id = prop->collective_slave_mon_id;
+	wait_prop.q_idx = queue_id;
+	wait_prop.size = cb_size;
+
+	dev_dbg(hdev->dev,
+		"Generate slave wait CB, sob %d, val:0x%x, mon %d, q %d\n",
+		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
+		prop->collective_slave_mon_id, queue_id);
+
+	cb_size += gaudi_gen_wait_cb(hdev, &wait_prop);
+
+	dev_dbg(hdev->dev,
+		"generate signal CB, sob_id: %d, sob val: 1, q_idx: %d\n",
+		prop->collective_sob_id, queue_id);
+
+	cb_size += gaudi_gen_signal_cb(hdev, job->user_cb,
+			prop->collective_sob_id, cb_size);
 }
 
 static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
 {
+	struct hl_cs_compl *signal_cs_cmpl =
+		container_of(cs->signal_fence, struct hl_cs_compl, base_fence);
+	struct hl_cs_compl *cs_cmpl =
+		container_of(cs->fence, struct hl_cs_compl, base_fence);
+	struct gaudi_collective_properties *cprop;
+	u32 stream, queue_id, sob_group_offset;
+	struct hl_sync_stream_properties *prop;
+	struct gaudi_device *gaudi;
+	struct hl_device *hdev;
+	struct hl_cs_job *job;
+	struct hl_ctx *ctx;
+
+	ctx = cs->ctx;
+	hdev = ctx->hdev;
+	gaudi = hdev->asic_specific;
+	cprop = &gaudi->collective_props;
+
+	/* copy the SOB id and value of the signal CS */
+	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
+	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+
+	/* Calculate the stream from collective master queue (1st job) */
+	job = list_first_entry(&cs->job_list, struct hl_cs_job, cs_node);
+	stream = job->hw_queue_id % 4;
+	sob_group_offset =
+		stream * HL_RSVD_SOBS + cprop->curr_sob_group_idx[stream];
+
+	list_for_each_entry(job, &cs->job_list, cs_node) {
+		queue_id = job->hw_queue_id;
+		prop = &hdev->kernel_queues[queue_id].sync_stream_prop;
+
+		if (hdev->kernel_queues[queue_id].collective_mode ==
+				HL_COLLECTIVE_MASTER) {
+			gaudi_collective_master_init_job(hdev, job, stream,
+						sob_group_offset);
+		} else {
+			gaudi_collective_slave_init_job(hdev, job, cs_cmpl);
+		}
+	}
+
+	cs_cmpl->sob_group = sob_group_offset;
+
+	/* Handle sob group kref and wraparound */
+	kref_get(&cprop->hw_sob_group[sob_group_offset].kref);
+	cprop->next_sob_group_val[stream]++;
 
+	if (cprop->next_sob_group_val[stream] == HL_MAX_SOB_VAL) {
+		/*
+		 * Decrement as we reached the max value.
+		 * The release function won't be called here as we've
+		 * just incremented the refcount.
+		 */
+		kref_put(&cprop->hw_sob_group[sob_group_offset].kref,
+				gaudi_sob_group_reset_error);
+		cprop->next_sob_group_val[stream] = 1;
+		/* only two SOBs are currently in use */
+		cprop->curr_sob_group_idx[stream] =
+			(cprop->curr_sob_group_idx[stream] + 1) &
+							(HL_RSVD_SOBS - 1);
+
+		gaudi_collective_map_sobs(hdev, stream);
+
+		dev_dbg(hdev->dev, "switched to SOB group %d, stream: %d\n",
+				cprop->curr_sob_group_idx[stream], stream);
+	}
+
+	/* Increment kref since all slave queues are now waiting on it */
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
+static int gaudi_collective_wait_create_job(struct hl_device *hdev,
+		struct hl_ctx *ctx, struct hl_cs *cs,
+		enum hl_collective_mode mode, u32 queue_id, u32 wait_queue_id)
+{
+	struct hw_queue_properties *hw_queue_prop;
+	struct hl_cs_counters_atomic *cntr;
+	struct hl_cs_job *job;
+	struct hl_cb *cb;
+	u32 cb_size;
+	bool patched_cb;
+
+	cntr = &hdev->aggregated_cs_counters;
+
+	if (mode == HL_COLLECTIVE_MASTER) {
+		/* CB size of collective master queue contains
+		 * 4 msg short packets for monitor 1 configuration
+		 * 1 fence packet
+		 * 4 msg short packets for monitor 2 configuration
+		 * 1 fence packet
+		 * 2 msg prot packets for completion and MSI-X
+		 */
+		cb_size = sizeof(struct packet_msg_short) * 8 +
+				sizeof(struct packet_fence) * 2 +
+				sizeof(struct packet_msg_prot) * 2;
+		patched_cb = true;
+	} else {
+		/* CB size of collective slave queues contains
+		 * 4 msg short packets for monitor configuration
+		 * 1 fence packet
+		 * 1 additional msg short packet for sob signal
+		 */
+		cb_size = sizeof(struct packet_msg_short) * 5 +
+				sizeof(struct packet_fence);
+		patched_cb = false;
+	}
+
+	hw_queue_prop = &hdev->asic_prop.hw_queues_props[queue_id];
+	job = hl_cs_allocate_job(hdev, hw_queue_prop->type, true);
+	if (!job) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		return -ENOMEM;
+	}
+
+	/* Allocate internal mapped CB for non patched CBs */
+	cb = hl_cb_kernel_create(hdev, cb_size,
+			hdev->mmu_enable && !patched_cb);
+	if (!cb) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		kfree(job);
+		return -EFAULT;
+	}
+
+	job->id = 0;
+	job->cs = cs;
+	job->user_cb = cb;
+	job->user_cb->cs_cnt++;
+	job->user_cb_size = cb_size;
+	job->hw_queue_id = queue_id;
+
+	/*
+	 * No need in parsing, user CB is the patched CB.
+	 * We call hl_cb_destroy() out of two reasons - we don't need
+	 * the CB in the CB idr anymore and to decrement its refcount as
+	 * it was incremented inside hl_cb_kernel_create().
+	 */
+	if (patched_cb)
+		job->patched_cb = job->user_cb;
+	else
+		job->patched_cb = NULL;
+
+	job->job_cb_size = job->user_cb_size;
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+
+	/* increment refcount as for external queues we get completion */
+	if (hw_queue_prop->type == QUEUE_TYPE_EXT)
+		cs_get(cs);
+
+	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+
+	list_add_tail(&job->cs_node, &cs->job_list);
+
+	hl_debugfs_add_job(hdev, job);
+
+	return 0;
 }
 
 static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
 		struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
 		u32 collective_engine_id)
 {
-	return -EINVAL;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct hw_queue_properties *hw_queue_prop;
+	u32 queue_id, collective_queue, num_jobs;
+	u32 stream, nic_queue, nic_idx = 0;
+	bool skip;
+	int i, rc;
+
+	/* Verify wait queue id is configured as master */
+	hw_queue_prop = &hdev->asic_prop.hw_queues_props[wait_queue_id];
+	if (!(hw_queue_prop->collective_mode == HL_COLLECTIVE_MASTER)) {
+		dev_err(hdev->dev,
+			"Queue %d is not configured as collective master\n",
+			wait_queue_id);
+		return -EINVAL;
+	}
+
+	/* Verify engine id is supported */
+	if (collective_engine_id != GAUDI_ENGINE_ID_DMA_5 &&
+			collective_engine_id != GAUDI_ENGINE_ID_TPC_7) {
+		dev_err(hdev->dev,
+			"Collective wait does not support engine %u\n",
+			collective_engine_id);
+		return -EINVAL;
+	}
+
+	stream = wait_queue_id % 4;
+
+	if (collective_engine_id == GAUDI_ENGINE_ID_DMA_5)
+		collective_queue = GAUDI_QUEUE_ID_DMA_5_0 + stream;
+	else if (collective_engine_id == GAUDI_ENGINE_ID_TPC_7)
+		collective_queue = GAUDI_QUEUE_ID_TPC_7_0 + stream;
+	else
+		return -EINVAL;
+
+	num_jobs = NUMBER_OF_SOBS_IN_GRP + 1;
+	nic_queue = GAUDI_QUEUE_ID_NIC_0_0 + stream;
+
+	/* First job goes to the collective master queue, it will wait for
+	 * the collective slave queues to finish execution.
+	 * The synchronization is done using two monitors:
+	 * First monitor for NICs 0-7, second monitor for NICs 8-9 and the
+	 * reduction engine (DMA5/TPC7).
+	 *
+	 * Rest of the jobs goes to the collective slave queues which will
+	 * all wait for the user to signal sob 'cs_cmpl->sob_val'.
+	 */
+	for (i = 0 ; i < num_jobs ; i++) {
+		if (i == 0) {
+			queue_id = wait_queue_id;
+			rc = gaudi_collective_wait_create_job(hdev, ctx, cs,
+				HL_COLLECTIVE_MASTER, queue_id, wait_queue_id);
+		} else {
+			if (nic_idx < NIC_NUMBER_OF_ENGINES) {
+				if (gaudi->hw_cap_initialized &
+					BIT(HW_CAP_NIC_SHIFT + nic_idx))
+					skip = false;
+				else
+					skip = true;
+
+				queue_id = nic_queue;
+				nic_queue += 4;
+				nic_idx++;
+
+				if (skip)
+					continue;
+			} else {
+				queue_id = collective_queue;
+			}
+
+			rc = gaudi_collective_wait_create_job(hdev, ctx, cs,
+				HL_COLLECTIVE_SLAVE, queue_id, wait_queue_id);
+		}
+
+		if (rc)
+			return rc;
+	}
+
+	return rc;
 }
 
 static int gaudi_late_init(struct hl_device *hdev)
@@ -861,6 +1329,12 @@ static int gaudi_late_init(struct hl_device *hdev)
 		goto disable_pci_access;
 	}
 
+	rc = gaudi_collective_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to init collective\n");
+		goto disable_pci_access;
+	}
+
 	return 0;
 
 disable_pci_access:
@@ -2042,21 +2516,29 @@ static void gaudi_init_pci_dma_qmans(struct hl_device *hdev)
 static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 					int qman_id, u64 qman_base_addr)
 {
-	u32 mtr_base_lo, mtr_base_hi;
-	u32 so_base_lo, so_base_hi;
+	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
+	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 q_off, dma_qm_offset;
 	u32 dma_qm_err_cfg;
 
 	dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 
-	mtr_base_lo = lower_32_bits(CFG_BASE +
-				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	mtr_base_hi = upper_32_bits(CFG_BASE +
+	mtr_base_en_lo = lower_32_bits(CFG_BASE +
+			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_lo = lower_32_bits(CFG_BASE +
+	so_base_en_lo = lower_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
-	so_base_hi = upper_32_bits(CFG_BASE +
+	so_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	mtr_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	so_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
 
 	q_off = dma_qm_offset + qman_id * 4;
 
@@ -2114,10 +2596,22 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 				QMAN_INTERNAL_MAKE_TRUSTED);
 	}
 
-	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_lo);
-	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_hi);
-	WREG32(mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_lo);
-	WREG32(mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_hi);
+	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_en_lo);
+	WREG32(mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_en_hi);
+	WREG32(mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_en_lo);
+	WREG32(mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_en_hi);
+
+	/* Configure DMA5 CP_MSG_BASE 2/3 for sync stream collective */
+	if (gaudi_dma_assignment[dma_id] == GAUDI_ENGINE_ID_DMA_5) {
+		WREG32(mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_0 + q_off,
+				mtr_base_ws_lo);
+		WREG32(mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_0 + q_off,
+				mtr_base_ws_hi);
+		WREG32(mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_0 + q_off,
+				so_base_ws_lo);
+		WREG32(mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_0 + q_off,
+				so_base_ws_hi);
+	}
 }
 
 static void gaudi_init_hbm_dma_qmans(struct hl_device *hdev)
@@ -2280,22 +2774,33 @@ static void gaudi_init_mme_qmans(struct hl_device *hdev)
 static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 				int qman_id, u64 qman_base_addr)
 {
-	u32 mtr_base_lo, mtr_base_hi;
-	u32 so_base_lo, so_base_hi;
+	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
+	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 q_off, tpc_id;
 	u32 tpc_qm_err_cfg;
 
-	mtr_base_lo = lower_32_bits(CFG_BASE +
-				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	mtr_base_hi = upper_32_bits(CFG_BASE +
+	mtr_base_en_lo = lower_32_bits(CFG_BASE +
+			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_lo = lower_32_bits(CFG_BASE +
+	so_base_en_lo = lower_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
-	so_base_hi = upper_32_bits(CFG_BASE +
+	so_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	mtr_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	so_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
 
 	q_off = tpc_offset + qman_id * 4;
 
+	tpc_id = tpc_offset /
+			(mmTPC1_QM_GLBL_CFG0 - mmTPC0_QM_GLBL_CFG0);
+
 	if (qman_id < 4) {
 		WREG32(mmTPC0_QM_PQ_BASE_LO_0 + q_off,
 					lower_32_bits(qman_base_addr));
@@ -2321,9 +2826,6 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 							QMAN_LDMA_DST_OFFSET);
 
 		/* Configure RAZWI IRQ */
-		tpc_id = tpc_offset /
-				(mmTPC1_QM_GLBL_CFG0 - mmTPC0_QM_GLBL_CFG0);
-
 		tpc_qm_err_cfg = TPC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
 		if (hdev->stop_on_err) {
 			tpc_qm_err_cfg |=
@@ -2353,10 +2855,22 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 				QMAN_INTERNAL_MAKE_TRUSTED);
 	}
 
-	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_lo);
-	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_hi);
-	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_lo);
-	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_hi);
+	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_en_lo);
+	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_en_hi);
+	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_en_lo);
+	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_en_hi);
+
+	/* Configure TPC7 CP_MSG_BASE 2/3 for sync stream collective */
+	if (tpc_id == 6) {
+		WREG32(mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_0 + q_off,
+				mtr_base_ws_lo);
+		WREG32(mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_0 + q_off,
+				mtr_base_ws_hi);
+		WREG32(mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_0 + q_off,
+				so_base_ws_lo);
+		WREG32(mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_0 + q_off,
+				so_base_ws_hi);
+	}
 }
 
 static void gaudi_init_tpc_qmans(struct hl_device *hdev)
@@ -2407,19 +2921,27 @@ static void gaudi_init_tpc_qmans(struct hl_device *hdev)
 static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 				int qman_id, u64 qman_base_addr, int nic_id)
 {
-	u32 mtr_base_lo, mtr_base_hi;
-	u32 so_base_lo, so_base_hi;
+	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
+	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 q_off;
 	u32 nic_qm_err_cfg;
 
-	mtr_base_lo = lower_32_bits(CFG_BASE +
-				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	mtr_base_hi = upper_32_bits(CFG_BASE +
+	mtr_base_en_lo = lower_32_bits(CFG_BASE +
+			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_lo = lower_32_bits(CFG_BASE +
+	so_base_en_lo = lower_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
-	so_base_hi = upper_32_bits(CFG_BASE +
+	so_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	mtr_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	so_base_ws_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_ws_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
 
 	q_off = nic_offset + qman_id * 4;
 
@@ -2430,14 +2952,23 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 	WREG32(mmNIC0_QM0_PQ_PI_0 + q_off, 0);
 	WREG32(mmNIC0_QM0_PQ_CI_0 + q_off, 0);
 
-	WREG32(mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
-	WREG32(mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
-	WREG32(mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+	WREG32(mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_0 + q_off,
+							QMAN_LDMA_SIZE_OFFSET);
+	WREG32(mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_SRC_OFFSET);
+	WREG32(mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
+							QMAN_LDMA_DST_OFFSET);
+
+	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_en_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_en_hi);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_en_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_en_hi);
 
-	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_lo);
-	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_hi);
-	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_lo);
-	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_hi);
+	/* Configure NIC CP_MSG_BASE 2/3 for sync stream collective */
+	WREG32(mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_0 + q_off, mtr_base_ws_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_0 + q_off, mtr_base_ws_hi);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_0 + q_off, so_base_ws_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_0 + q_off, so_base_ws_hi);
 
 	if (qman_id == 0) {
 		/* Configure RAZWI IRQ */
@@ -7027,11 +7558,152 @@ static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
+static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
+		struct hl_ctx *ctx)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	bool flush_pte;
+	u64 va, pa;
+	s64 off;
+	int min_alloc_order, rc, collective_cb_size;
+
+	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
+		return 0;
+
+	hdev->internal_cb_pool_virt_addr =
+			hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
+					HOST_SPACE_INTERNAL_CB_SZ,
+					&hdev->internal_cb_pool_dma_addr,
+					GFP_KERNEL | __GFP_ZERO);
+
+	if (!hdev->internal_cb_pool_virt_addr)
+		return -ENOMEM;
+
+	collective_cb_size = sizeof(struct packet_msg_short) * 5 +
+			sizeof(struct packet_fence);
+	min_alloc_order = ilog2(collective_cb_size);
+
+	hdev->internal_cb_pool = gen_pool_create(min_alloc_order, -1);
+	if (!hdev->internal_cb_pool) {
+		dev_err(hdev->dev,
+			"Failed to create internal CB pool\n");
+		rc = -ENOMEM;
+		goto free_internal_cb_pool;
+	}
+
+	rc = gen_pool_add(hdev->internal_cb_pool,
+				(uintptr_t) hdev->internal_cb_pool_virt_addr,
+				HOST_SPACE_INTERNAL_CB_SZ, -1);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to add memory to internal CB pool\n");
+		rc = -EFAULT;
+		goto destroy_internal_cb_pool;
+	}
+
+	hdev->internal_cb_va_base = VA_HOST_SPACE_INTERNAL_CB_START;
+
+	mutex_lock(&ctx->mmu_lock);
+
+	/* The mapping is done page by page since we can't assure allocated ptr
+	 * is aligned to HOST_SPACE_INTERNAL_CB_SZ
+	 */
+	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
+		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+		pa = hdev->internal_cb_pool_dma_addr + off;
+		flush_pte = (off + PAGE_SIZE_4KB) >= HOST_SPACE_INTERNAL_CB_SZ;
+		rc = hl_mmu_map(ctx, va, pa, PAGE_SIZE_4KB, flush_pte);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Map failed for va 0x%llx to pa 0x%llx\n",
+				va, pa);
+			goto unmap;
+		}
+	}
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+	return 0;
+
+unmap:
+	for (; off >= 0 ; off -= PAGE_SIZE_4KB) {
+		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+		flush_pte = (off - (s32) PAGE_SIZE_4KB) < 0;
+		if (hl_mmu_unmap(ctx, va, PAGE_SIZE_4KB, flush_pte))
+			dev_warn_ratelimited(hdev->dev,
+					"failed to unmap va 0x%llx\n", va);
+	}
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+destroy_internal_cb_pool:
+	gen_pool_destroy(hdev->internal_cb_pool);
+
+free_internal_cb_pool:
+	hdev->asic_funcs->asic_dma_free_coherent(hdev,
+			HOST_SPACE_INTERNAL_CB_SZ,
+			hdev->internal_cb_pool_virt_addr,
+			hdev->internal_cb_pool_dma_addr);
+
+	return rc;
+}
+
+static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
+		struct hl_ctx *ctx)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	bool flush_pte = false;
+	u64 va, off;
+
+	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
+		return;
+
+	mutex_lock(&ctx->mmu_lock);
+
+	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
+		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+
+		if (off + PAGE_SIZE_4KB >= HOST_SPACE_INTERNAL_CB_SZ)
+			flush_pte = true;
+
+		if (hl_mmu_unmap(ctx, va, PAGE_SIZE_4KB, flush_pte))
+			dev_warn_ratelimited(hdev->dev,
+					"failed to unmap va 0x%llx\n", va);
+	}
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+	gen_pool_destroy(hdev->internal_cb_pool);
+
+	hdev->asic_funcs->asic_dma_free_coherent(hdev,
+			HOST_SPACE_INTERNAL_CB_SZ,
+			hdev->internal_cb_pool_virt_addr,
+			hdev->internal_cb_pool_dma_addr);
+}
+
 static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
 	gaudi_mmu_prepare(ctx->hdev, ctx->asid);
+	return gaudi_internal_cb_pool_init(ctx->hdev, ctx);
+}
 
-	return 0;
+void gaudi_ctx_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	/* Gaudi will NEVER support more then a single compute context.
+	 * Therefore, don't clear anything unless it is the compute context
+	 */
+	if (hdev->compute_ctx != ctx)
+		return;
+
+	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
 }
 
 static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
@@ -7053,7 +7725,7 @@ static u32 gaudi_get_wait_cb_size(struct hl_device *hdev)
 }
 
 static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
-		u32 size)
+				u32 size)
 {
 	struct hl_cb *cb = (struct hl_cb *) data;
 	struct packet_msg_short *pkt;
@@ -7173,7 +7845,7 @@ static u32 gaudi_add_fence_pkt(struct packet_fence *pkt)
 
 static int gaudi_get_fence_addr(struct hl_device *hdev, u32 queue_id, u64 *addr)
 {
-	u32 offset;
+	u32 offset, nic_index;
 
 	switch (queue_id) {
 	case GAUDI_QUEUE_ID_DMA_0_0:
@@ -7212,6 +7884,78 @@ static int gaudi_get_fence_addr(struct hl_device *hdev, u32 queue_id, u64 *addr)
 	case GAUDI_QUEUE_ID_DMA_5_3:
 		offset = mmDMA5_QM_CP_FENCE2_RDATA_3;
 		break;
+	case GAUDI_QUEUE_ID_TPC_7_0:
+		offset = mmTPC7_QM_CP_FENCE2_RDATA_0;
+		break;
+	case GAUDI_QUEUE_ID_TPC_7_1:
+		offset = mmTPC7_QM_CP_FENCE2_RDATA_1;
+		break;
+	case GAUDI_QUEUE_ID_TPC_7_2:
+		offset = mmTPC7_QM_CP_FENCE2_RDATA_2;
+		break;
+	case GAUDI_QUEUE_ID_TPC_7_3:
+		offset = mmTPC7_QM_CP_FENCE2_RDATA_3;
+		break;
+	case GAUDI_QUEUE_ID_NIC_0_0:
+	case GAUDI_QUEUE_ID_NIC_1_0:
+	case GAUDI_QUEUE_ID_NIC_2_0:
+	case GAUDI_QUEUE_ID_NIC_3_0:
+	case GAUDI_QUEUE_ID_NIC_4_0:
+	case GAUDI_QUEUE_ID_NIC_5_0:
+	case GAUDI_QUEUE_ID_NIC_6_0:
+	case GAUDI_QUEUE_ID_NIC_7_0:
+	case GAUDI_QUEUE_ID_NIC_8_0:
+	case GAUDI_QUEUE_ID_NIC_9_0:
+		nic_index = (queue_id - GAUDI_QUEUE_ID_NIC_0_0) >> 2;
+		offset = mmNIC0_QM0_CP_FENCE2_RDATA_0 +
+				(nic_index >> 1) * NIC_MACRO_QMAN_OFFSET +
+				(nic_index & 0x1) * NIC_ENGINE_QMAN_OFFSET;
+		break;
+	case GAUDI_QUEUE_ID_NIC_0_1:
+	case GAUDI_QUEUE_ID_NIC_1_1:
+	case GAUDI_QUEUE_ID_NIC_2_1:
+	case GAUDI_QUEUE_ID_NIC_3_1:
+	case GAUDI_QUEUE_ID_NIC_4_1:
+	case GAUDI_QUEUE_ID_NIC_5_1:
+	case GAUDI_QUEUE_ID_NIC_6_1:
+	case GAUDI_QUEUE_ID_NIC_7_1:
+	case GAUDI_QUEUE_ID_NIC_8_1:
+	case GAUDI_QUEUE_ID_NIC_9_1:
+		nic_index = (queue_id - GAUDI_QUEUE_ID_NIC_0_1) >> 2;
+		offset = mmNIC0_QM0_CP_FENCE2_RDATA_1 +
+				(nic_index >> 1) * NIC_MACRO_QMAN_OFFSET +
+				(nic_index & 0x1) * NIC_ENGINE_QMAN_OFFSET;
+		break;
+	case GAUDI_QUEUE_ID_NIC_0_2:
+	case GAUDI_QUEUE_ID_NIC_1_2:
+	case GAUDI_QUEUE_ID_NIC_2_2:
+	case GAUDI_QUEUE_ID_NIC_3_2:
+	case GAUDI_QUEUE_ID_NIC_4_2:
+	case GAUDI_QUEUE_ID_NIC_5_2:
+	case GAUDI_QUEUE_ID_NIC_6_2:
+	case GAUDI_QUEUE_ID_NIC_7_2:
+	case GAUDI_QUEUE_ID_NIC_8_2:
+	case GAUDI_QUEUE_ID_NIC_9_2:
+		nic_index = (queue_id - GAUDI_QUEUE_ID_NIC_0_2) >> 2;
+		offset = mmNIC0_QM0_CP_FENCE2_RDATA_2 +
+				(nic_index >> 1) * NIC_MACRO_QMAN_OFFSET +
+				(nic_index & 0x1) * NIC_ENGINE_QMAN_OFFSET;
+		break;
+	case GAUDI_QUEUE_ID_NIC_0_3:
+	case GAUDI_QUEUE_ID_NIC_1_3:
+	case GAUDI_QUEUE_ID_NIC_2_3:
+	case GAUDI_QUEUE_ID_NIC_3_3:
+	case GAUDI_QUEUE_ID_NIC_4_3:
+	case GAUDI_QUEUE_ID_NIC_5_3:
+	case GAUDI_QUEUE_ID_NIC_6_3:
+	case GAUDI_QUEUE_ID_NIC_7_3:
+	case GAUDI_QUEUE_ID_NIC_8_3:
+	case GAUDI_QUEUE_ID_NIC_9_3:
+		nic_index = (queue_id - GAUDI_QUEUE_ID_NIC_0_3) >> 2;
+		offset = mmNIC0_QM0_CP_FENCE2_RDATA_3 +
+				(nic_index >> 1) * NIC_MACRO_QMAN_OFFSET +
+				(nic_index & 0x1) * NIC_ENGINE_QMAN_OFFSET;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -7262,8 +8006,8 @@ static u32 gaudi_add_mon_pkts(void *buf, u16 mon_id, u64 fence_addr)
 	return size;
 }
 
-u32 gaudi_gen_wait_cb(struct hl_device *hdev,
-		struct hl_gen_wait_properties *prop)
+static u32 gaudi_gen_wait_cb(struct hl_device *hdev,
+				struct hl_gen_wait_properties *prop)
 {
 	struct hl_cb *cb = (struct hl_cb *) prop->data;
 	void *buf = (void *) (uintptr_t) cb->kernel_address;
@@ -7377,6 +8121,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.wreg = hl_wreg,
 	.halt_coresight = gaudi_halt_coresight,
 	.ctx_init = gaudi_ctx_init,
+	.ctx_fini = gaudi_ctx_fini,
 	.get_clk_rate = gaudi_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.read_device_fw_version = gaudi_read_device_fw_version,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 73171d8b40d8..1dcf7c41e698 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -23,6 +23,10 @@
 					NUMBER_OF_CPU_HW_QUEUES + \
 					NUMBER_OF_INT_HW_QUEUES)
 
+/* 10 NIC QMANs, DMA5 QMAN, TPC7 QMAN */
+#define NUMBER_OF_COLLECTIVE_QUEUES	12
+#define NUMBER_OF_SOBS_IN_GRP		11
+
 /*
  * Number of MSI interrupts IDS:
  * Each completion queue has 1 ID
@@ -149,10 +153,14 @@
 
 /* Virtual address space */
 #define VA_HOST_SPACE_START	0x1000000000000ull	/* 256TB */
-#define VA_HOST_SPACE_END	0x3FF8000000000ull	/* 1PB - 1TB */
+#define VA_HOST_SPACE_END	0x3FF7FFFE00000ull	/* 1PB - 1TB */
 #define VA_HOST_SPACE_SIZE	(VA_HOST_SPACE_END - \
 					VA_HOST_SPACE_START) /* 767TB */
 
+#define VA_HOST_SPACE_INTERNAL_CB_START	0x3FF7FFFE00000ull /* 1PB - 1TB - 2MB */
+#define VA_HOST_SPACE_INTERNAL_CB_END	0x3FF8000000000ull /* 1PB - 1TB */
+#define HOST_SPACE_INTERNAL_CB_SZ	SZ_2M
+
 #define HW_CAP_PLL		BIT(0)
 #define HW_CAP_HBM		BIT(1)
 #define HW_CAP_MMU		BIT(2)
@@ -240,6 +248,34 @@ enum gaudi_nic_mask {
 	GAUDI_NIC_MASK_ALL = 0x3FF
 };
 
+/*
+ * struct gaudi_hw_sob_group - H/W SOB group info.
+ * @hdev: habanalabs device structure.
+ * @kref: refcount of this SOB group. group will reset once refcount is zero.
+ * @base_sob_id: base sob id of this SOB group.
+ */
+struct gaudi_hw_sob_group {
+	struct hl_device	*hdev;
+	struct kref		kref;
+	u32			base_sob_id;
+};
+
+#define NUM_SOB_GROUPS (HL_RSVD_SOBS * QMAN_STREAMS)
+/**
+ * struct gaudi_collective_properties -
+ *     holds all SOB groups and queues info reserved for the collective
+ * @hw_sob_group: H/W SOB groups.
+ * @next_sob_group_val: the next value to use for the currently used SOB group.
+ * @curr_sob_group_idx: the index of the currently used SOB group.
+ * @mstr_sob_mask: pre-defined masks for collective master monitors
+ */
+struct gaudi_collective_properties {
+	struct gaudi_hw_sob_group hw_sob_group[NUM_SOB_GROUPS];
+	u16			next_sob_group_val[QMAN_STREAMS];
+	u8			curr_sob_group_idx[QMAN_STREAMS];
+	u8			mstr_sob_mask[HL_COLLECTIVE_RSVD_MSTR_MONS];
+};
+
 /**
  * struct gaudi_internal_qman_info - Internal QMAN information.
  * @pq_kernel_addr: Kernel address of the PQ memory area in the host.
@@ -285,6 +321,8 @@ struct gaudi_device {
 
 	struct gaudi_internal_qman_info	internal_qmans[GAUDI_QUEUE_ID_SIZE];
 
+	struct gaudi_collective_properties collective_props;
+
 	u64				hbm_bar_cur_addr;
 	u64				max_freq_value;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 757a55215b0f..0afce8a834af 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5347,6 +5347,11 @@ int goya_collective_wait_create_jobs(struct hl_device *hdev,
 	return -EINVAL;
 }
 
+static void goya_ctx_fini(struct hl_ctx *ctx)
+{
+
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5408,6 +5413,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.wreg = hl_wreg,
 	.halt_coresight = goya_halt_coresight,
 	.ctx_init = goya_ctx_init,
+	.ctx_fini = goya_ctx_fini,
 	.get_clk_rate = goya_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.read_device_fw_version = goya_read_device_fw_version,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 4661a74f0425..0185311b679b 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -18,8 +18,18 @@
 #define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START		0x8000	/* 32KB */
 #define GAUDI_DRIVER_SRAM_RESERVED_SIZE_FROM_START	0x80	/* 128 bytes */
 
-#define GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT		32
-#define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		16
+/*
+ * 128 SOBs reserved for collective wait
+ * 16 SOBs reserved for sync stream
+ */
+#define GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT		144
+
+/*
+ * 64 monitors reserved for collective wait
+ * 8 monitors reserved for sync stream
+ */
+#define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		72
+
 /*
  * Goya queue Numbering
  *
-- 
2.17.1

