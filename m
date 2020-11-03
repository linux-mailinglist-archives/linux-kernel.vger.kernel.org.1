Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD52A48D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgKCPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgKCPAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:00:55 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3F220757;
        Tue,  3 Nov 2020 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415653;
        bh=Cr38lomBRHvEyeZocOPCOYVtlURSMv0zRJyvhc5gcwU=;
        h=From:To:Cc:Subject:Date:From;
        b=pWHsEMnHZRvKkmxvIo/ldy3sGv4M0AxoJVRS1G9BmdZkXLkqC60lcnKiaNAE4HHk/
         oV+PF769mNC8fdu7TRgdoF9Ow8P2vE3cEEWvyHhMpQn6ATcscMU1lFAL3JQEKsnxVT
         mJSHe+EDVEjsno5XhwsEmYkc8vmWjIBfzn+1tB70=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: sync stream collective infrastructure
Date:   Tue,  3 Nov 2020 17:00:43 +0200
Message-Id: <20201103150046.19074-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Define new API for collective wait support and modify sync stream
common flow. In addition add kernel CB allocation support for
internal queues.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 38 ++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h   | 55 +++++++++++++++++--
 drivers/misc/habanalabs/common/hw_queue.c     | 44 ++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 22 +++++++-
 drivers/misc/habanalabs/goya/goya.c           | 22 +++++++-
 include/uapi/misc/habanalabs.h                | 17 ++++--
 6 files changed, 176 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ea480b14703f..e3fb8f51fefa 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -85,7 +85,8 @@ static void hl_fence_release(struct kref *kref)
 		goto free;
 
 	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
-			(hl_cs_cmpl->type == CS_TYPE_WAIT)) {
+		(hl_cs_cmpl->type == CS_TYPE_WAIT) ||
+		(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)) {
 
 		dev_dbg(hdev->dev,
 			"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
@@ -112,6 +113,10 @@ static void hl_fence_release(struct kref *kref)
 		 * hence the above scenario is avoided.
 		 */
 		kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
+
+		if (hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)
+			hdev->asic_funcs->reset_sob_group(hdev,
+					hl_cs_cmpl->sob_group);
 	}
 
 free:
@@ -247,9 +252,11 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	/* For H/W queue jobs, if a user CB was allocated by driver and MMU is
 	 * enabled, the user CB isn't released in cs_parser() and thus should be
 	 * released here.
+	 * This is also true for INT queues jobs which were allocated by driver
 	 */
-	if (job->queue_type == QUEUE_TYPE_HW &&
-			job->is_kernel_allocated_cb && hdev->mmu_enable) {
+	if (job->is_kernel_allocated_cb &&
+		((job->queue_type == QUEUE_TYPE_HW && hdev->mmu_enable) ||
+				job->queue_type == QUEUE_TYPE_INT)) {
 		spin_lock(&job->user_cb->lock);
 		job->user_cb->cs_cnt--;
 		spin_unlock(&job->user_cb->lock);
@@ -932,7 +939,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_cs_compl *sig_waitcs_cmpl;
 	struct hl_cs *cs;
 	enum hl_queue_type q_type;
-	u32 size_to_copy, q_idx;
+	u32 size_to_copy, q_idx, collective_engine_id;
 	u64 signal_seq;
 	int rc;
 
@@ -983,7 +990,18 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto free_cs_chunk_array;
 	}
 
-	if (cs_type == CS_TYPE_WAIT) {
+	if (cs_type == CS_TYPE_COLLECTIVE_WAIT) {
+		if (!(hw_queue_prop->collective_mode == HL_COLLECTIVE_MASTER)) {
+			dev_err(hdev->dev,
+				"Queue index %d is invalid\n", q_idx);
+			rc = -EINVAL;
+			goto free_cs_chunk_array;
+		}
+
+		collective_engine_id = chunk->collective_engine_id;
+	}
+
+	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT) {
 		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq);
 		if (rc)
 			goto free_cs_chunk_array;
@@ -1028,7 +1046,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	rc = allocate_cs(hdev, ctx, cs_type, &cs);
 	if (rc) {
-		if (cs_type == CS_TYPE_WAIT)
+		if (cs_type == CS_TYPE_WAIT ||
+			cs_type == CS_TYPE_COLLECTIVE_WAIT)
 			hl_fence_put(sig_fence);
 		hl_ctx_put(ctx);
 		goto free_cs_chunk_array;
@@ -1038,7 +1057,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	 * Save the signal CS fence for later initialization right before
 	 * hanging the wait CS on the queue.
 	 */
-	if (cs_type == CS_TYPE_WAIT)
+	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT)
 		cs->signal_fence = sig_fence;
 
 	hl_debugfs_add_cs(cs);
@@ -1048,6 +1067,9 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_SIGNAL)
 		rc = cs_ioctl_signal_wait_create_jobs(hdev, ctx, cs, q_type,
 				q_idx);
+	else
+		rc = hdev->asic_funcs->collective_wait_create_jobs(hdev, ctx,
+				cs, q_idx, collective_engine_id);
 
 	if (rc)
 		goto put_cs;
@@ -1122,6 +1144,8 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		cs_type = CS_TYPE_SIGNAL;
 	else if (args->in.cs_flags & HL_CS_FLAGS_WAIT)
 		cs_type = CS_TYPE_WAIT;
+	else if (args->in.cs_flags & HL_CS_FLAGS_COLLECTIVE_WAIT)
+		cs_type = CS_TYPE_COLLECTIVE_WAIT;
 	else
 		cs_type = CS_TYPE_DEFAULT;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5983850d3f8f..91a5de1c8805 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -68,6 +68,11 @@
 #define HL_RSVD_SOBS			4
 #define HL_RSVD_MONS			2
 
+/*
+ * HL_COLLECTIVE_RSVD_MSTR_MONS 'collective' reserved monitors per QMAN stream
+ */
+#define HL_COLLECTIVE_RSVD_MSTR_MONS	2
+
 #define HL_MAX_SOB_VAL			(1 << 15)
 
 #define IS_POWER_OF_2(n)		(n != 0 && ((n & (n - 1)) == 0))
@@ -177,7 +182,8 @@ enum hl_queue_type {
 enum hl_cs_type {
 	CS_TYPE_DEFAULT,
 	CS_TYPE_SIGNAL,
-	CS_TYPE_WAIT
+	CS_TYPE_WAIT,
+	CS_TYPE_COLLECTIVE_WAIT
 };
 
 /*
@@ -231,6 +237,12 @@ struct hl_hw_sob {
 	u32			q_idx;
 };
 
+enum hl_collective_mode {
+	HL_COLLECTIVE_NOT_SUPPORTED = 0x0,
+	HL_COLLECTIVE_MASTER = 0x1,
+	HL_COLLECTIVE_SLAVE = 0x2
+};
+
 /**
  * struct hw_queue_properties - queue information.
  * @type: queue type.
@@ -238,6 +250,7 @@ struct hl_hw_sob {
  *                        that allocated by the Kernel driver and therefore,
  *                        a CB handle can be provided for jobs on this queue.
  *                        Otherwise, a CB address must be provided.
+ * @collective_mode: collective mode of current queue
  * @driver_only: true if only the driver is allowed to send a job to this queue,
  *               false otherwise.
  * @supports_sync_stream: True if queue supports sync stream
@@ -245,6 +258,7 @@ struct hl_hw_sob {
 struct hw_queue_properties {
 	enum hl_queue_type	type;
 	enum queue_cb_alloc_flags cb_alloc_flags;
+	enum hl_collective_mode	collective_mode;
 	u8			driver_only;
 	u8			supports_sync_stream;
 };
@@ -358,6 +372,8 @@ struct hl_mmu_properties {
  * @cb_pool_cb_size: size of each CB in the CB pool.
  * @max_pending_cs: maximum of concurrent pending command submissions
  * @max_queues: maximum amount of queues in the system
+ * @collective_first_sob: first sync object available for collective use
+ * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
  * @sync_stream_first_mon: first monitor available for sync stream use
  * @first_available_user_sob: first sob available for the user
@@ -410,6 +426,8 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
 	u32				max_queues;
+	u16				collective_first_sob;
+	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
 	u16				sync_stream_first_mon;
 	u16				first_available_user_sob[HL_MAX_DCORES];
@@ -441,6 +459,7 @@ struct hl_fence {
  * @cs_seq: command submission sequence number.
  * @type: type of the CS - signal/wait.
  * @sob_val: the SOB value that is used in this signal/wait CS.
+ * @sob_group: the SOB group that is used in this collective wait CS.
  */
 struct hl_cs_compl {
 	struct hl_fence		base_fence;
@@ -450,6 +469,7 @@ struct hl_cs_compl {
 	u64			cs_seq;
 	enum hl_cs_type		type;
 	u16			sob_val;
+	u16			sob_group;
 };
 
 /*
@@ -512,6 +532,7 @@ struct hl_cb {
  * QUEUES
  */
 
+struct hl_cs;
 struct hl_cs_job;
 
 /* Queue length of external and HW queues */
@@ -540,15 +561,24 @@ struct hl_cs_job;
  * @next_sob_val: the next value to use for the currently used SOB.
  * @base_sob_id: the base SOB id of the SOBs used by this queue.
  * @base_mon_id: the base MON id of the MONs used by this queue.
+ * @collective_mstr_mon_id: the MON ids of the MONs used by this master queue
+ *                          in order to sync with all slave queues.
+ * @collective_slave_mon_id: the MON id used by this slave queue in order to
+ *                           sync with its master queue.
+ * @collective_sob_id: current SOB id used by this collective slave queue
+ *                     to signal its collective master queue upon completion.
  * @curr_sob_offset: the id offset to the currently used SOB from the
  *                   HL_RSVD_SOBS that are being used by this queue.
  */
 struct hl_sync_stream_properties {
-	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
-	u16			next_sob_val;
-	u16			base_sob_id;
-	u16			base_mon_id;
-	u8			curr_sob_offset;
+	struct hl_hw_sob hw_sob[HL_RSVD_SOBS];
+	u16		next_sob_val;
+	u16		base_sob_id;
+	u16		base_mon_id;
+	u16		collective_mstr_mon_id[HL_COLLECTIVE_RSVD_MSTR_MONS];
+	u16		collective_slave_mon_id;
+	u16		collective_sob_id;
+	u8		curr_sob_offset;
 };
 
 /**
@@ -556,6 +586,7 @@ struct hl_sync_stream_properties {
  * @shadow_queue: pointer to a shadow queue that holds pointers to jobs.
  * @sync_stream_prop: sync stream queue properties
  * @queue_type: type of queue.
+ * @collective_mode: collective mode of current queue
  * @kernel_address: holds the queue's kernel virtual address.
  * @bus_address: holds the queue's DMA address.
  * @pi: holds the queue's pi value.
@@ -572,6 +603,7 @@ struct hl_hw_queue {
 	struct hl_cs_job			**shadow_queue;
 	struct hl_sync_stream_properties	sync_stream_prop;
 	enum hl_queue_type			queue_type;
+	enum hl_collective_mode			collective_mode;
 	u64					kernel_address;
 	dma_addr_t				bus_address;
 	u32					pi;
@@ -764,9 +796,13 @@ enum div_select_defs {
  * @gen_signal_cb: Generate a signal CB.
  * @gen_wait_cb: Generate a wait CB.
  * @reset_sob: Reset a SOB.
+ * @reset_sob_group: Reset SOB group
  * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
  *                        firmware configuration
  * @get_device_time: Get the device time.
+ * @collective_wait_init_cs: Generate collective master/slave packets
+ *                           and place them in the relevant cs jobs
+ * @collective_wait_create_jobs: allocate collective wait cs jobs
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -868,8 +904,13 @@ struct hl_asic_funcs {
 	u32 (*gen_wait_cb)(struct hl_device *hdev,
 			struct hl_gen_wait_properties *prop);
 	void (*reset_sob)(struct hl_device *hdev, void *data);
+	void (*reset_sob_group)(struct hl_device *hdev, u16 sob_group);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
+	void (*collective_wait_init_cs)(struct hl_cs *cs);
+	int (*collective_wait_create_jobs)(struct hl_device *hdev,
+			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
+			u32 collective_engine_id);
 };
 
 
@@ -1656,6 +1697,7 @@ struct hl_mmu_funcs {
  * @stop_on_err: true if engines should stop on error.
  * @supports_sync_stream: is sync stream supported.
  * @sync_stream_queue_idx: helper index for sync stream queues initialization.
+ * @collective_mon_idx: helper index for collective initialization
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
@@ -1756,6 +1798,7 @@ struct hl_device {
 	u8				stop_on_err;
 	u8				supports_sync_stream;
 	u8				sync_stream_queue_idx;
+	u8				collective_mon_idx;
 	u8				supports_coresight;
 	u8				supports_soft_reset;
 	u8				supports_cb_mapping;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index ca625789d78d..8a15db724116 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -333,7 +333,14 @@ static void int_queue_schedule_job(struct hl_cs_job *job)
 
 	bd.ctl = 0;
 	bd.len = cpu_to_le32(job->job_cb_size);
-	bd.ptr = cpu_to_le64((u64) (uintptr_t) job->user_cb);
+
+	if (job->is_kernel_allocated_cb)
+		/* bus_address is actually a mmu mapped address
+		 * allocated from an internal pool
+		 */
+		bd.ptr = cpu_to_le64(job->user_cb->bus_address);
+	else
+		bd.ptr = cpu_to_le64((u64) (uintptr_t) job->user_cb);
 
 	pi = (__le64 *) (uintptr_t) (q->kernel_address +
 		((q->pi & (q->int_queue_len - 1)) * sizeof(bd)));
@@ -563,6 +570,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 	if ((cs->type == CS_TYPE_SIGNAL) || (cs->type == CS_TYPE_WAIT))
 		init_signal_wait_cs(cs);
+	else if (cs->type == CS_TYPE_COLLECTIVE_WAIT)
+		hdev->asic_funcs->collective_wait_init_cs(cs);
 
 	spin_lock(&hdev->hw_queues_mirror_lock);
 	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
@@ -742,12 +751,40 @@ static void sync_stream_queue_init(struct hl_device *hdev, u32 q_idx)
 	struct hl_sync_stream_properties *sync_stream_prop;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_hw_sob *hw_sob;
-	int sob, queue_idx;
+	int sob, reserved_mon_idx, queue_idx;
+
+	sync_stream_prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+
+	/* We use 'collective_mon_idx' as a running index in order to reserve
+	 * monitors for collective master/slave queues.
+	 * collective master queue gets 2 reserved monitors
+	 * collective slave queue gets 1 reserved monitor
+	 */
+	if (hdev->kernel_queues[q_idx].collective_mode ==
+			HL_COLLECTIVE_MASTER) {
+		reserved_mon_idx = hdev->collective_mon_idx;
+
+		/* reserve the first monitor for collective master queue */
+		sync_stream_prop->collective_mstr_mon_id[0] =
+			prop->collective_first_mon + reserved_mon_idx;
+
+		/* reserve the second monitor for collective master queue */
+		sync_stream_prop->collective_mstr_mon_id[1] =
+			prop->collective_first_mon + reserved_mon_idx + 1;
+
+		hdev->collective_mon_idx += HL_COLLECTIVE_RSVD_MSTR_MONS;
+	} else if (hdev->kernel_queues[q_idx].collective_mode ==
+			HL_COLLECTIVE_SLAVE) {
+		reserved_mon_idx = hdev->collective_mon_idx++;
+
+		/* reserve a monitor for collective slave queue */
+		sync_stream_prop->collective_slave_mon_id =
+			prop->collective_first_mon + reserved_mon_idx;
+	}
 
 	if (!hdev->kernel_queues[q_idx].supports_sync_stream)
 		return;
 
-	sync_stream_prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
 	queue_idx = hdev->sync_stream_queue_idx++;
 
 	sync_stream_prop->base_sob_id = prop->sync_stream_first_sob +
@@ -898,6 +935,7 @@ int hl_hw_queues_create(struct hl_device *hdev)
 		q->queue_type = asic->hw_queues_props[i].type;
 		q->supports_sync_stream =
 				asic->hw_queues_props[i].supports_sync_stream;
+		q->collective_mode = asic->hw_queues_props[i].collective_mode;
 		rc = queue_init(hdev, q, i);
 		if (rc) {
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 559e22a5696c..91916040faac 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -794,6 +794,23 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 	return rc;
 }
 
+static void gaudi_reset_sob_group(struct hl_device *hdev, u16 sob_groupt)
+{
+
+}
+
+static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
+{
+
+}
+
+static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
+		struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
+		u32 collective_engine_id)
+{
+	return -EINVAL;
+}
+
 static int gaudi_late_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -7375,8 +7392,11 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.gen_signal_cb = gaudi_gen_signal_cb,
 	.gen_wait_cb = gaudi_gen_wait_cb,
 	.reset_sob = gaudi_reset_sob,
+	.reset_sob_group = gaudi_reset_sob_group,
 	.set_dma_mask_from_fw = gaudi_set_dma_mask_from_fw,
-	.get_device_time = gaudi_get_device_time
+	.get_device_time = gaudi_get_device_time,
+	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
+	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7012fcdab837..757a55215b0f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5309,6 +5309,11 @@ static void goya_reset_sob(struct hl_device *hdev, void *data)
 
 }
 
+void goya_reset_sob_group(struct hl_device *hdev, u16 sob_group)
+{
+
+}
+
 static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
 {
 	if (RREG32(mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_0) ==
@@ -5330,6 +5335,18 @@ u64 goya_get_device_time(struct hl_device *hdev)
 	return device_time | RREG32(mmPSOC_TIMESTAMP_CNTCVL);
 }
 
+void goya_collective_wait_init_cs(struct hl_cs *cs)
+{
+
+}
+
+int goya_collective_wait_create_jobs(struct hl_device *hdev,
+		struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
+		u32 collective_engine_id)
+{
+	return -EINVAL;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5401,8 +5418,11 @@ static const struct hl_asic_funcs goya_funcs = {
 	.gen_signal_cb = goya_gen_signal_cb,
 	.gen_wait_cb = goya_gen_wait_cb,
 	.reset_sob = goya_reset_sob,
+	.reset_sob_group = goya_reset_sob_group,
 	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
-	.get_device_time = goya_get_device_time
+	.get_device_time = goya_get_device_time,
+	.collective_wait_init_cs = goya_collective_wait_init_cs,
+	.collective_wait_create_jobs = goya_collective_wait_create_jobs
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 5753157e71b3..2b244d0bdc26 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -523,7 +523,8 @@ struct hl_cs_chunk {
 		 */
 		__u64 cb_handle;
 
-		/* Relevant only when HL_CS_FLAGS_WAIT is set.
+		/* Relevant only when HL_CS_FLAGS_WAIT or
+		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set.
 		 * This holds address of array of u64 values that contain
 		 * signal CS sequence numbers. The wait described by this job
 		 * will listen on all those signals (wait event per signal)
@@ -541,7 +542,8 @@ struct hl_cs_chunk {
 		 */
 		__u32 cb_size;
 
-		/* Relevant only when HL_CS_FLAGS_WAIT is set.
+		/* Relevant only when HL_CS_FLAGS_WAIT or
+		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set.
 		 * Number of entries in signal_seq_arr
 		 */
 		__u32 num_signal_seq_arr;
@@ -550,14 +552,21 @@ struct hl_cs_chunk {
 	/* HL_CS_CHUNK_FLAGS_* */
 	__u32 cs_chunk_flags;
 
+	/* Relevant only when HL_CS_FLAGS_COLLECTIVE_WAIT is set.
+	 * This holds the collective engine ID. The wait described by this job
+	 * will sync with this engine and with all NICs before completion.
+	 */
+	__u32 collective_engine_id;
+
 	/* Align structure to 64 bytes */
-	__u32 pad[11];
+	__u32 pad[10];
 };
 
-/* SIGNAL and WAIT flags are mutually exclusive */
+/* SIGNAL and WAIT/COLLECTIVE_WAIT flags are mutually exclusive */
 #define HL_CS_FLAGS_FORCE_RESTORE	0x1
 #define HL_CS_FLAGS_SIGNAL		0x2
 #define HL_CS_FLAGS_WAIT		0x4
+#define HL_CS_FLAGS_COLLECTIVE_WAIT	0x8
 
 #define HL_CS_STATUS_SUCCESS		0
 
-- 
2.17.1

