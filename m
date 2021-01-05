Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960F72EA390
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbhAEC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:41796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbhAEC70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:26 -0500
IronPort-SDR: 2P12o9IK1R/Y+Me1Xl9vzuCBt83zhkaExlNNqFfcPBdTeLm3gQA+b0ncjL5Ph8QMRDAz1uZr2P
 o1amgVwuqbjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827522"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:17 -0800
IronPort-SDR: jIFNv/KJBx+/bAlO7aCICUiy9k06sk9Z2iQvOQImRrZK0pKO5ltQyB9moIRm8fJktLg1T8b2iY
 YV9FNKwDoepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632150"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:16 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 10/20] dlb: add register operations for queue management
Date:   Mon,  4 Jan 2021 20:58:29 -0600
Message-Id: <20210105025839.23169-11-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the low-level code for configuring a new queue and querying its depth.
When configuring a queue, program the device based on the user-supplied
queue configuration ioctl arguments.

Add low-level code for resetting (draining) a non-empty queue during
scheduling domain reset. Draining a queue is an iterative process of
checking if the queue is empty, and if not then selecting a linked 'victim'
port and dequeueing the queue's events through this port. A port can only
receive a small number of events at a time, usually much fewer than the
queue depth, so draining a queue typically takes multiple iterations. This
process is finite since software cannot enqueue new events to the DLB's
(finite) on-device storage.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_hw_types.h |  46 +++
 drivers/misc/dlb/dlb_resource.c | 553 +++++++++++++++++++++++++++++++-
 2 files changed, 584 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/dlb/dlb_hw_types.h b/drivers/misc/dlb/dlb_hw_types.h
index 5dde91e22de7..43fd93ce50ef 100644
--- a/drivers/misc/dlb/dlb_hw_types.h
+++ b/drivers/misc/dlb/dlb_hw_types.h
@@ -52,6 +52,29 @@
 
 #define PCI_DEVICE_ID_INTEL_DLB_PF		0x2710
 
+/*
+ * Hardware-defined base addresses. Those prefixed 'DLB_DRV' are only used by
+ * the PF driver.
+ */
+#define DLB_DRV_LDB_PP_BASE   0x2300000
+#define DLB_DRV_LDB_PP_STRIDE 0x1000
+#define DLB_DRV_LDB_PP_BOUND  (DLB_DRV_LDB_PP_BASE + \
+				DLB_DRV_LDB_PP_STRIDE * DLB_MAX_NUM_LDB_PORTS)
+#define DLB_DRV_DIR_PP_BASE   0x2200000
+#define DLB_DRV_DIR_PP_STRIDE 0x1000
+#define DLB_DRV_DIR_PP_BOUND  (DLB_DRV_DIR_PP_BASE + \
+				DLB_DRV_DIR_PP_STRIDE * DLB_MAX_NUM_DIR_PORTS)
+#define DLB_LDB_PP_BASE       0x2100000
+#define DLB_LDB_PP_STRIDE     0x1000
+#define DLB_LDB_PP_BOUND      (DLB_LDB_PP_BASE + \
+				DLB_LDB_PP_STRIDE * DLB_MAX_NUM_LDB_PORTS)
+#define DLB_LDB_PP_OFFS(id)   (DLB_LDB_PP_BASE + (id) * DLB_PP_SIZE)
+#define DLB_DIR_PP_BASE       0x2000000
+#define DLB_DIR_PP_STRIDE     0x1000
+#define DLB_DIR_PP_BOUND      (DLB_DIR_PP_BASE + \
+				DLB_DIR_PP_STRIDE * DLB_MAX_NUM_DIR_PORTS)
+#define DLB_DIR_PP_OFFS(id)   (DLB_DIR_PP_BASE + (id) * DLB_PP_SIZE)
+
 struct dlb_resource_id {
 	u32 phys_id;
 	u32 virt_id;
@@ -70,6 +93,29 @@ static inline u32 dlb_freelist_count(struct dlb_freelist *list)
 	return list->bound - list->base - list->offset;
 }
 
+struct dlb_hcw {
+	u64 data;
+	/* Word 3 */
+	u16 opaque;
+	u8 qid;
+	u8 sched_type:2;
+	u8 priority:3;
+	u8 msg_type:3;
+	/* Word 4 */
+	u16 lock_id;
+	u8 ts_flag:1;
+	u8 rsvd1:2;
+	u8 no_dec:1;
+	u8 cmp_id:4;
+	u8 cq_token:1;
+	u8 qe_comp:1;
+	u8 qe_frag:1;
+	u8 qe_valid:1;
+	u8 int_arm:1;
+	u8 error:1;
+	u8 rsvd:2;
+};
+
 struct dlb_ldb_queue {
 	struct list_head domain_list;
 	struct list_head func_list;
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index e1f2cb581cf9..c022f67a1366 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -1,12 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
 
+#include <linux/log2.h>
 #include "dlb_bitmap.h"
 #include "dlb_hw_types.h"
 #include "dlb_main.h"
 #include "dlb_regs.h"
 #include "dlb_resource.h"
 
+/*
+ * The PF driver cannot assume that a register write will affect subsequent HCW
+ * writes. To ensure a write completes, the driver must read back a CSR. This
+ * function only need be called for configuration that can occur after the
+ * domain has started; prior to starting, applications can't send HCWs.
+ */
+static inline void dlb_flush_csr(struct dlb_hw *hw)
+{
+	DLB_CSR_RD(hw, SYS_TOTAL_VAS);
+}
+
 static void dlb_init_fn_rsrc_lists(struct dlb_function_resources *rsrc)
 {
 	int i;
@@ -883,7 +895,99 @@ static void dlb_configure_ldb_queue(struct dlb_hw *hw,
 				    bool vdev_req,
 				    unsigned int vdev_id)
 {
-	/* Placeholder */
+	struct dlb_sn_group *sn_group;
+	unsigned int offs;
+	u32 reg = 0;
+	u32 alimit;
+	u32 level;
+
+	/* QID write permissions are turned on when the domain is started */
+	offs = domain->id.phys_id * DLB_MAX_NUM_LDB_QUEUES + queue->id.phys_id;
+
+	DLB_CSR_WR(hw, SYS_LDB_VASQID_V(offs), reg);
+
+	/*
+	 * Unordered QIDs get 4K inflights, ordered get as many as the number
+	 * of sequence numbers.
+	 */
+	BITS_SET(reg, args->num_qid_inflights, LSP_QID_LDB_INFL_LIM_LIMIT);
+	DLB_CSR_WR(hw, LSP_QID_LDB_INFL_LIM(queue->id.phys_id), reg);
+
+	alimit = queue->aqed_limit;
+
+	if (alimit > DLB_MAX_NUM_AQED_ENTRIES)
+		alimit = DLB_MAX_NUM_AQED_ENTRIES;
+
+	reg = 0;
+	BITS_SET(reg, alimit, LSP_QID_AQED_ACTIVE_LIM_LIMIT);
+	DLB_CSR_WR(hw, LSP_QID_AQED_ACTIVE_LIM(queue->id.phys_id), reg);
+
+	level = args->lock_id_comp_level;
+	if (level >= 64 && level <= 4096)
+		BITS_SET(reg, ilog2(level) - 5, AQED_QID_HID_WIDTH_COMPRESS_CODE);
+	else
+		reg = 0;
+
+	DLB_CSR_WR(hw, AQED_QID_HID_WIDTH(queue->id.phys_id), reg);
+
+	reg = 0;
+	/* Don't timestamp QEs that pass through this queue */
+	DLB_CSR_WR(hw, SYS_LDB_QID_ITS(queue->id.phys_id), reg);
+
+	BITS_SET(reg, args->depth_threshold, LSP_QID_ATM_DEPTH_THRSH_THRESH);
+	DLB_CSR_WR(hw, LSP_QID_ATM_DEPTH_THRSH(queue->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, args->depth_threshold, LSP_QID_NALDB_DEPTH_THRSH_THRESH);
+	DLB_CSR_WR(hw, LSP_QID_NALDB_DEPTH_THRSH(queue->id.phys_id), reg);
+
+	/*
+	 * This register limits the number of inflight flows a queue can have
+	 * at one time.  It has an upper bound of 2048, but can be
+	 * over-subscribed. 512 is chosen so that a single queue doesn't use
+	 * the entire atomic storage, but can use a substantial portion if
+	 * needed.
+	 */
+	reg = 0;
+	BITS_SET(reg, 512, AQED_QID_FID_LIM_QID_FID_LIMIT);
+	DLB_CSR_WR(hw, AQED_QID_FID_LIM(queue->id.phys_id), reg);
+
+	/* Configure SNs */
+	reg = 0;
+	sn_group = &hw->rsrcs.sn_groups[queue->sn_group];
+	BITS_SET(reg, sn_group->mode, CHP_ORD_QID_SN_MAP_MODE);
+	BITS_SET(reg, queue->sn_slot, CHP_ORD_QID_SN_MAP_SLOT);
+	BITS_SET(reg, sn_group->id, CHP_ORD_QID_SN_MAP_GRP);
+
+	DLB_CSR_WR(hw, CHP_ORD_QID_SN_MAP(queue->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, (u32)(args->num_sequence_numbers != 0),
+		 SYS_LDB_QID_CFG_V_SN_CFG_V);
+	BITS_SET(reg, (u32)(args->num_atomic_inflights != 0),
+		 SYS_LDB_QID_CFG_V_FID_CFG_V);
+
+	DLB_CSR_WR(hw, SYS_LDB_QID_CFG_V(queue->id.phys_id), reg);
+
+	if (vdev_req) {
+		offs = vdev_id * DLB_MAX_NUM_LDB_QUEUES + queue->id.virt_id;
+
+		reg = 0;
+		BIT_SET(reg, SYS_VF_LDB_VQID_V_VQID_V);
+		DLB_CSR_WR(hw, SYS_VF_LDB_VQID_V(offs), reg);
+
+		reg = 0;
+		BITS_SET(reg, queue->id.phys_id, SYS_VF_LDB_VQID2QID_QID);
+		DLB_CSR_WR(hw, SYS_VF_LDB_VQID2QID(offs), reg);
+
+		reg = 0;
+		BITS_SET(reg, queue->id.virt_id, SYS_LDB_QID2VQID_VQID);
+		DLB_CSR_WR(hw, SYS_LDB_QID2VQID(queue->id.phys_id), reg);
+	}
+
+	reg = 0;
+	BIT_SET(reg, SYS_LDB_QID_V_QID_V);
+	DLB_CSR_WR(hw, SYS_LDB_QID_V(queue->id.phys_id), reg);
 }
 
 static void dlb_configure_dir_queue(struct dlb_hw *hw,
@@ -893,7 +997,39 @@ static void dlb_configure_dir_queue(struct dlb_hw *hw,
 				    bool vdev_req,
 				    unsigned int vdev_id)
 {
-	/* Placeholder */
+	unsigned int offs;
+	u32 reg = 0;
+
+	/* QID write permissions are turned on when the domain is started */
+	offs = domain->id.phys_id * DLB_MAX_NUM_DIR_QUEUES +
+		queue->id.phys_id;
+
+	DLB_CSR_WR(hw, SYS_DIR_VASQID_V(offs), reg);
+
+	/* Don't timestamp QEs that pass through this queue */
+	DLB_CSR_WR(hw, SYS_DIR_QID_ITS(queue->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, args->depth_threshold, LSP_QID_DIR_DEPTH_THRSH_THRESH);
+	DLB_CSR_WR(hw, LSP_QID_DIR_DEPTH_THRSH(queue->id.phys_id), reg);
+
+	if (vdev_req) {
+		offs = vdev_id * DLB_MAX_NUM_DIR_QUEUES + queue->id.virt_id;
+
+		reg = 0;
+		BIT_SET(reg, SYS_VF_DIR_VQID_V_VQID_V);
+		DLB_CSR_WR(hw, SYS_VF_DIR_VQID_V(offs), reg);
+
+		reg = 0;
+		BITS_SET(reg, queue->id.phys_id, SYS_VF_DIR_VQID2QID_QID);
+		DLB_CSR_WR(hw, SYS_VF_DIR_VQID2QID(offs), reg);
+	}
+
+	reg = 0;
+	BIT_SET(reg, SYS_DIR_QID_V_QID_V);
+	DLB_CSR_WR(hw, SYS_DIR_QID_V(queue->id.phys_id), reg);
+
+	queue->queue_configured = true;
 }
 
 static void dlb_configure_domain_credits(struct dlb_hw *hw,
@@ -1043,6 +1179,56 @@ dlb_ldb_queue_attach_resources(struct dlb_hw *hw,
 	return 0;
 }
 
+static void dlb_ldb_port_cq_enable(struct dlb_hw *hw,
+				   struct dlb_ldb_port *port)
+{
+	u32 reg = 0;
+
+	/*
+	 * Don't re-enable the port if a removal is pending. The caller should
+	 * mark this port as enabled (if it isn't already), and when the
+	 * removal completes the port will be enabled.
+	 */
+	if (port->num_pending_removals)
+		return;
+
+	DLB_CSR_WR(hw, LSP_CQ_LDB_DSBL(port->id.phys_id), reg);
+
+	dlb_flush_csr(hw);
+}
+
+static void dlb_ldb_port_cq_disable(struct dlb_hw *hw,
+				    struct dlb_ldb_port *port)
+{
+	u32 reg = 0;
+
+	BIT_SET(reg, LSP_CQ_LDB_DSBL_DISABLED);
+	DLB_CSR_WR(hw, LSP_CQ_LDB_DSBL(port->id.phys_id), reg);
+
+	dlb_flush_csr(hw);
+}
+
+static void dlb_dir_port_cq_enable(struct dlb_hw *hw,
+				   struct dlb_dir_pq_pair *port)
+{
+	u32 reg = 0;
+
+	DLB_CSR_WR(hw, LSP_CQ_DIR_DSBL(port->id.phys_id), reg);
+
+	dlb_flush_csr(hw);
+}
+
+static void dlb_dir_port_cq_disable(struct dlb_hw *hw,
+				    struct dlb_dir_pq_pair *port)
+{
+	u32 reg = 0;
+
+	BIT_SET(reg, LSP_CQ_DIR_DSBL_DISABLED);
+	DLB_CSR_WR(hw, LSP_CQ_DIR_DSBL(port->id.phys_id), reg);
+
+	dlb_flush_csr(hw);
+}
+
 static void
 dlb_log_create_sched_domain_args(struct dlb_hw *hw,
 				 struct dlb_create_sched_domain_args *args,
@@ -1338,6 +1524,94 @@ int dlb_hw_create_dir_queue(struct dlb_hw *hw,
 	return 0;
 }
 
+static u32 dlb_ldb_cq_inflight_count(struct dlb_hw *hw,
+				     struct dlb_ldb_port *port)
+{
+	u32 cnt;
+
+	cnt = DLB_CSR_RD(hw, LSP_CQ_LDB_INFL_CNT(port->id.phys_id));
+
+	return BITS_GET(cnt, LSP_CQ_LDB_INFL_CNT_COUNT);
+}
+
+static u32 dlb_ldb_cq_token_count(struct dlb_hw *hw,
+				  struct dlb_ldb_port *port)
+{
+	u32 cnt;
+
+	cnt = DLB_CSR_RD(hw, LSP_CQ_LDB_TKN_CNT(port->id.phys_id));
+
+	/*
+	 * Account for the initial token count, which is used in order to
+	 * provide a CQ with depth less than 8.
+	 */
+
+	return BITS_GET(cnt, LSP_CQ_LDB_TKN_CNT_TOKEN_COUNT) - port->init_tkn_cnt;
+}
+
+static void __iomem *dlb_producer_port_addr(struct dlb_hw *hw,
+					    u8 port_id,
+					    bool is_ldb)
+{
+	struct dlb *dlb = container_of(hw, struct dlb, hw);
+	uintptr_t address = (uintptr_t)dlb->hw.func_kva;
+	unsigned long size;
+
+	if (is_ldb) {
+		size = DLB_LDB_PP_STRIDE;
+		address += DLB_DRV_LDB_PP_BASE + size * port_id;
+	} else {
+		size = DLB_DIR_PP_STRIDE;
+		address += DLB_DRV_DIR_PP_BASE + size * port_id;
+	}
+
+	return (void __iomem *)address;
+}
+
+static void dlb_drain_ldb_cq(struct dlb_hw *hw, struct dlb_ldb_port *port)
+{
+	u32 infl_cnt, tkn_cnt;
+	unsigned int i;
+
+	infl_cnt = dlb_ldb_cq_inflight_count(hw, port);
+	tkn_cnt = dlb_ldb_cq_token_count(hw, port);
+
+	if (infl_cnt || tkn_cnt) {
+		struct dlb_hcw hcw_mem[8], *hcw;
+		void __iomem *pp_addr;
+
+		pp_addr = dlb_producer_port_addr(hw, port->id.phys_id, true);
+
+		/* Point hcw to a 64B-aligned location */
+		hcw = (struct dlb_hcw *)((uintptr_t)&hcw_mem[4] & ~0x3F);
+
+		/*
+		 * Program the first HCW for a completion and token return and
+		 * the other HCWs as NOOPS
+		 */
+
+		memset(hcw, 0, 4 * sizeof(*hcw));
+		hcw->qe_comp = (infl_cnt > 0);
+		hcw->cq_token = (tkn_cnt > 0);
+		hcw->lock_id = tkn_cnt - 1;
+
+		/* Return tokens in the first HCW */
+		iosubmit_cmds512(pp_addr, hcw, 1);
+
+		hcw->cq_token = 0;
+
+		/* Issue remaining completions (if any) */
+		for (i = 1; i < infl_cnt; i++)
+			iosubmit_cmds512(pp_addr, hcw, 1);
+
+		/*
+		 * To ensure outstanding HCWs reach the device before subsequent device
+		 * accesses, fence them.
+		 */
+		mb();
+	}
+}
+
 static int dlb_domain_reset_software_state(struct dlb_hw *hw,
 					   struct dlb_hw_domain *domain)
 {
@@ -1486,8 +1760,17 @@ static int dlb_domain_reset_software_state(struct dlb_hw *hw,
 static u32 dlb_dir_queue_depth(struct dlb_hw *hw,
 			       struct dlb_dir_pq_pair *queue)
 {
-	/* Placeholder */
-	return 0;
+	u32 cnt;
+
+	cnt = DLB_CSR_RD(hw, LSP_QID_DIR_ENQUEUE_CNT(queue->id.phys_id));
+
+	return BITS_GET(cnt, LSP_QID_DIR_ENQUEUE_CNT_COUNT);
+}
+
+static bool dlb_dir_queue_is_empty(struct dlb_hw *hw,
+				   struct dlb_dir_pq_pair *queue)
+{
+	return dlb_dir_queue_depth(hw, queue) == 0;
 }
 
 static void dlb_log_get_dir_queue_depth(struct dlb_hw *hw,
@@ -1563,15 +1846,21 @@ int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
 static u32 dlb_ldb_queue_depth(struct dlb_hw *hw,
 			       struct dlb_ldb_queue *queue)
 {
-	/* Placeholder */
-	return 0;
+	u32 aqed, ldb, atm;
+
+	aqed = DLB_CSR_RD(hw, LSP_QID_AQED_ACTIVE_CNT(queue->id.phys_id));
+	ldb = DLB_CSR_RD(hw, LSP_QID_LDB_ENQUEUE_CNT(queue->id.phys_id));
+	atm = DLB_CSR_RD(hw, LSP_QID_ATM_ACTIVE(queue->id.phys_id));
+
+	return BITS_GET(aqed, LSP_QID_AQED_ACTIVE_CNT_COUNT)
+	       + BITS_GET(ldb, LSP_QID_LDB_ENQUEUE_CNT_COUNT)
+	       + BITS_GET(atm, LSP_QID_ATM_ACTIVE_COUNT);
 }
 
 static bool dlb_ldb_queue_is_empty(struct dlb_hw *hw,
 				   struct dlb_ldb_queue *queue)
 {
-	/* Placeholder */
-	return true;
+	return dlb_ldb_queue_depth(hw, queue) == 0;
 }
 
 static void dlb_log_get_ldb_queue_depth(struct dlb_hw *hw,
@@ -2003,6 +2292,21 @@ static void dlb_domain_reset_dir_queue_registers(struct dlb_hw *hw,
 	}
 }
 
+static u32 dlb_dir_cq_token_count(struct dlb_hw *hw,
+				  struct dlb_dir_pq_pair *port)
+{
+	u32 cnt;
+
+	cnt = DLB_CSR_RD(hw, LSP_CQ_DIR_TKN_CNT(port->id.phys_id));
+
+	/*
+	 * Account for the initial token count, which is used in order to
+	 * provide a CQ with depth less than 8.
+	 */
+
+	return BITS_GET(cnt, LSP_CQ_DIR_TKN_CNT_COUNT) - port->init_tkn_cnt;
+}
+
 static int dlb_domain_verify_reset_success(struct dlb_hw *hw,
 					   struct dlb_hw_domain *domain)
 {
@@ -2044,17 +2348,198 @@ static void dlb_domain_reset_registers(struct dlb_hw *hw,
 		   CHP_CFG_DIR_VAS_CRD_RST);
 }
 
+static void dlb_domain_drain_ldb_cqs(struct dlb_hw *hw,
+				     struct dlb_hw_domain *domain,
+				     bool toggle_port)
+{
+	struct dlb_ldb_port *port;
+	int i;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			if (toggle_port)
+				dlb_ldb_port_cq_disable(hw, port);
+
+			dlb_drain_ldb_cq(hw, port);
+
+			if (toggle_port)
+				dlb_ldb_port_cq_enable(hw, port);
+		}
+	}
+}
+
+static bool dlb_domain_mapped_queues_empty(struct dlb_hw *hw,
+					   struct dlb_hw_domain *domain)
+{
+	struct dlb_ldb_queue *queue;
+
+	list_for_each_entry(queue, &domain->used_ldb_queues, domain_list) {
+		if (queue->num_mappings == 0)
+			continue;
+
+		if (!dlb_ldb_queue_is_empty(hw, queue))
+			return false;
+	}
+
+	return true;
+}
+
 static int dlb_domain_drain_mapped_queues(struct dlb_hw *hw,
 					  struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	int i;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	if (domain->num_pending_removals > 0) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: failed to unmap domain queues\n",
+			   __func__);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < DLB_MAX_QID_EMPTY_CHECK_LOOPS; i++) {
+		dlb_domain_drain_ldb_cqs(hw, domain, true);
+
+		if (dlb_domain_mapped_queues_empty(hw, domain))
+			break;
+	}
+
+	if (i == DLB_MAX_QID_EMPTY_CHECK_LOOPS) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: failed to empty queues\n",
+			   __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * Drain the CQs one more time. For the queues to go empty, they would
+	 * have scheduled one or more QEs.
+	 */
+	dlb_domain_drain_ldb_cqs(hw, domain, true);
+
+	return 0;
+}
+
+static int dlb_drain_dir_cq(struct dlb_hw *hw,
+			    struct dlb_dir_pq_pair *port)
+{
+	unsigned int port_id = port->id.phys_id;
+	u32 cnt;
+
+	/* Return any outstanding tokens */
+	cnt = dlb_dir_cq_token_count(hw, port);
+
+	if (cnt != 0) {
+		struct dlb_hcw hcw_mem[8], *hcw;
+		void __iomem *pp_addr;
+
+		pp_addr = dlb_producer_port_addr(hw, port_id, false);
+
+		/* Point hcw to a 64B-aligned location */
+		hcw = (struct dlb_hcw *)((uintptr_t)&hcw_mem[4] & ~0x3F);
+
+		/*
+		 * Program the first HCW for a batch token return and
+		 * the rest as NOOPS
+		 */
+		memset(hcw, 0, 4 * sizeof(*hcw));
+		hcw->cq_token = 1;
+		hcw->lock_id = cnt - 1;
+
+		iosubmit_cmds512(pp_addr, hcw, 1);
+
+		/*
+		 * To ensure outstanding HCWs reach the device before subsequent device
+		 * accesses, fence them.
+		 */
+		mb();
+	}
+
+	return 0;
+}
+
+static int dlb_domain_drain_dir_cqs(struct dlb_hw *hw,
+				    struct dlb_hw_domain *domain,
+				    bool toggle_port)
+{
+	struct dlb_dir_pq_pair *port;
+	int ret;
+
+	list_for_each_entry(port, &domain->used_dir_pq_pairs, domain_list) {
+		/*
+		 * Can't drain a port if it's not configured, and there's
+		 * nothing to drain if its queue is unconfigured.
+		 */
+		if (!port->port_configured || !port->queue_configured)
+			continue;
+
+		if (toggle_port)
+			dlb_dir_port_cq_disable(hw, port);
+
+		ret = dlb_drain_dir_cq(hw, port);
+		if (ret)
+			return ret;
+
+		if (toggle_port)
+			dlb_dir_port_cq_enable(hw, port);
+	}
+
 	return 0;
 }
 
+static bool dlb_domain_dir_queues_empty(struct dlb_hw *hw,
+					struct dlb_hw_domain *domain)
+{
+	struct dlb_dir_pq_pair *queue;
+
+	list_for_each_entry(queue, &domain->used_dir_pq_pairs, domain_list) {
+		if (!dlb_dir_queue_is_empty(hw, queue))
+			return false;
+	}
+
+	return true;
+}
+
 static int dlb_domain_drain_dir_queues(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	int i, ret;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	for (i = 0; i < DLB_MAX_QID_EMPTY_CHECK_LOOPS; i++) {
+		ret = dlb_domain_drain_dir_cqs(hw, domain, true);
+		if (ret)
+			return ret;
+
+		if (dlb_domain_dir_queues_empty(hw, domain))
+			break;
+	}
+
+	if (i == DLB_MAX_QID_EMPTY_CHECK_LOOPS) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: failed to empty queues\n",
+			   __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * Drain the CQs one more time. For the queues to go empty, they would
+	 * have scheduled one or more QEs.
+	 */
+	ret = dlb_domain_drain_dir_cqs(hw, domain, true);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2062,32 +2547,70 @@ static void
 dlb_domain_disable_ldb_queue_write_perms(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	int domain_offset = domain->id.phys_id * DLB_MAX_NUM_LDB_QUEUES;
+	struct dlb_ldb_queue *queue;
+
+	list_for_each_entry(queue, &domain->used_ldb_queues, domain_list) {
+		int idx = domain_offset + queue->id.phys_id;
+
+		DLB_CSR_WR(hw, SYS_LDB_VASQID_V(idx), 0);
+	}
 }
 
 static void
 dlb_domain_disable_dir_queue_write_perms(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	int domain_offset = domain->id.phys_id * DLB_MAX_NUM_DIR_PORTS;
+	struct dlb_dir_pq_pair *queue;
+
+	list_for_each_entry(queue, &domain->used_dir_pq_pairs, domain_list) {
+		int idx = domain_offset + queue->id.phys_id;
+
+		DLB_CSR_WR(hw, SYS_DIR_VASQID_V(idx), 0);
+	}
 }
 
 static void dlb_domain_disable_dir_cqs(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_dir_pq_pair *port;
+
+	list_for_each_entry(port, &domain->used_dir_pq_pairs, domain_list) {
+		port->enabled = false;
+
+		dlb_dir_port_cq_disable(hw, port);
+	}
 }
 
 static void dlb_domain_disable_ldb_cqs(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			port->enabled = false;
+
+			dlb_ldb_port_cq_disable(hw, port);
+		}
+	}
 }
 
 static void dlb_domain_enable_ldb_cqs(struct dlb_hw *hw,
 				      struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			port->enabled = true;
+
+			dlb_ldb_port_cq_enable(hw, port);
+		}
+	}
 }
 
 static void dlb_log_reset_domain(struct dlb_hw *hw,
-- 
2.17.1

