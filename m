Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8B2EA398
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbhAEDAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:00:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:41800 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbhAEDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:00:05 -0500
IronPort-SDR: D0EaBKEpWTTv7QrPNE/Plu8eDvrd9TTix5G19+pHXAkaairp7EeFO95S0KtfPjIZ1w+CWqBtIU
 ARGuYxuv/ipA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827537"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:20 -0800
IronPort-SDR: 5LpBP2McxVRrFyjtv2iDG0rkKl6VedWF8krCJeDGTVpSYBQ6doKBiQvfQNYMa4ZmaIvWgVvOwY
 TySFnH73b5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632189"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:20 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 19/20] dlb: add queue unmap register operations
Date:   Mon,  4 Jan 2021 20:58:38 -0600
Message-Id: <20210105025839.23169-20-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "dynamic" unmap procedure and associated register operations.
Unmapping a load-balanced queue from a port removes that port from the
queue's load-balancing candidates. If a queue unmap is requested after the
domain is started, the driver must disable the requested queue and wait for
it to quiesce before mapping it to the requested port.

Add the code to drain unmapped queues during domain reset. This consists of
mapping a port to the queue, then calling the function to drain a mapped
queue.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_resource.c | 259 +++++++++++++++++++++++++++++++-
 1 file changed, 255 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 776285ee92d7..6994fe90bb25 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -2412,6 +2412,29 @@ static int dlb_ldb_port_set_has_work_bits(struct dlb_hw *hw,
 	return 0;
 }
 
+static void dlb_ldb_port_clear_has_work_bits(struct dlb_hw *hw,
+					     struct dlb_ldb_port *port,
+					     u8 slot)
+{
+	u32 ctrl = 0;
+
+	BITS_SET(ctrl, port->id.phys_id, LSP_LDB_SCHED_CTRL_CQ);
+	BITS_SET(ctrl, slot, LSP_LDB_SCHED_CTRL_QIDIX);
+	BIT_SET(ctrl, LSP_LDB_SCHED_CTRL_RLIST_HASWORK_V);
+
+	DLB_CSR_WR(hw, LSP_LDB_SCHED_CTRL, ctrl);
+
+	memset(&ctrl, 0, sizeof(ctrl));
+
+	BITS_SET(ctrl, port->id.phys_id, LSP_LDB_SCHED_CTRL_CQ);
+	BITS_SET(ctrl, slot, LSP_LDB_SCHED_CTRL_QIDIX);
+	BIT_SET(ctrl, LSP_LDB_SCHED_CTRL_NALB_HASWORK_V);
+
+	DLB_CSR_WR(hw, LSP_LDB_SCHED_CTRL, ctrl);
+
+	dlb_flush_csr(hw);
+}
+
 static void dlb_ldb_port_clear_queue_if_status(struct dlb_hw *hw,
 					       struct dlb_ldb_port *port,
 					       int slot)
@@ -2673,6 +2696,88 @@ static int dlb_ldb_port_map_qid(struct dlb_hw *hw,
 		return dlb_ldb_port_map_qid_static(hw, port, queue, prio);
 }
 
+static int dlb_ldb_port_unmap_qid(struct dlb_hw *hw,
+				  struct dlb_ldb_port *port,
+				  struct dlb_ldb_queue *queue)
+{
+	enum dlb_qid_map_state mapped, in_progress, pending_map, unmapped;
+	u32 lsp_qid2cq2;
+	u32 lsp_qid2cq;
+	u32 atm_qid2cq;
+	u32 cq2priov;
+	u32 queue_id;
+	u32 port_id;
+	int i;
+
+	/* Find the queue's slot */
+	mapped = DLB_QUEUE_MAPPED;
+	in_progress = DLB_QUEUE_UNMAP_IN_PROG;
+	pending_map = DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP;
+
+	if (!dlb_port_find_slot_queue(port, mapped, queue, &i) &&
+	    !dlb_port_find_slot_queue(port, in_progress, queue, &i) &&
+	    !dlb_port_find_slot_queue(port, pending_map, queue, &i)) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: QID %d isn't mapped\n",
+			   __func__, __LINE__, queue->id.phys_id);
+		return -EFAULT;
+	}
+
+	port_id = port->id.phys_id;
+	queue_id = queue->id.phys_id;
+
+	/* Read-modify-write the priority and valid bit register */
+	cq2priov = DLB_CSR_RD(hw, LSP_CQ2PRIOV(port_id));
+
+	cq2priov &= ~(1 << (i + LSP_CQ2PRIOV_V_LOC));
+
+	DLB_CSR_WR(hw, LSP_CQ2PRIOV(port_id), cq2priov);
+
+	atm_qid2cq = DLB_CSR_RD(hw, ATM_QID2CQIDIX(queue_id, port_id / 4));
+
+	lsp_qid2cq = DLB_CSR_RD(hw, LSP_QID2CQIDIX(queue_id, port_id / 4));
+
+	lsp_qid2cq2 = DLB_CSR_RD(hw, LSP_QID2CQIDIX2(queue_id, port_id / 4));
+
+	switch (port_id % 4) {
+	case 0:
+		atm_qid2cq &= ~(1 << (i + ATM_QID2CQIDIX_00_CQ_P0_LOC));
+		lsp_qid2cq &= ~(1 << (i + LSP_QID2CQIDIX_00_CQ_P0_LOC));
+		lsp_qid2cq2 &= ~(1 << (i + LSP_QID2CQIDIX2_00_CQ_P0_LOC));
+		break;
+
+	case 1:
+		atm_qid2cq &= ~(1 << (i + ATM_QID2CQIDIX_00_CQ_P1_LOC));
+		lsp_qid2cq &= ~(1 << (i + LSP_QID2CQIDIX_00_CQ_P1_LOC));
+		lsp_qid2cq2 &= ~(1 << (i + LSP_QID2CQIDIX2_00_CQ_P1_LOC));
+		break;
+
+	case 2:
+		atm_qid2cq &= ~(1 << (i + ATM_QID2CQIDIX_00_CQ_P2_LOC));
+		lsp_qid2cq &= ~(1 << (i + LSP_QID2CQIDIX_00_CQ_P2_LOC));
+		lsp_qid2cq2 &= ~(1 << (i + LSP_QID2CQIDIX2_00_CQ_P2_LOC));
+		break;
+
+	case 3:
+		atm_qid2cq &= ~(1 << (i + ATM_QID2CQIDIX_00_CQ_P3_LOC));
+		lsp_qid2cq &= ~(1 << (i + LSP_QID2CQIDIX_00_CQ_P3_LOC));
+		lsp_qid2cq2 &= ~(1 << (i + LSP_QID2CQIDIX2_00_CQ_P3_LOC));
+		break;
+	}
+
+	DLB_CSR_WR(hw, ATM_QID2CQIDIX(queue_id, port_id / 4), atm_qid2cq);
+
+	DLB_CSR_WR(hw, LSP_QID2CQIDIX(queue_id, port_id / 4), lsp_qid2cq);
+
+	DLB_CSR_WR(hw, LSP_QID2CQIDIX2(queue_id, port_id / 4), lsp_qid2cq2);
+
+	dlb_flush_csr(hw);
+
+	unmapped = DLB_QUEUE_UNMAPPED;
+
+	return dlb_port_slot_state_transition(hw, port, queue, i, unmapped);
+}
+
 static void
 dlb_log_create_sched_domain_args(struct dlb_hw *hw,
 				 struct dlb_create_sched_domain_args *args,
@@ -3188,11 +3293,86 @@ int dlb_hw_create_dir_port(struct dlb_hw *hw,
 	return 0;
 }
 
+static void
+dlb_domain_finish_unmap_port_slot(struct dlb_hw *hw,
+				  struct dlb_hw_domain *domain,
+				  struct dlb_ldb_port *port,
+				  int slot)
+{
+	enum dlb_qid_map_state state;
+	struct dlb_ldb_queue *queue;
+
+	queue = &hw->rsrcs.ldb_queues[port->qid_map[slot].qid];
+
+	state = port->qid_map[slot].state;
+
+	/* Update the QID2CQIDX and CQ2QID vectors */
+	dlb_ldb_port_unmap_qid(hw, port, queue);
+
+	/*
+	 * Ensure the QID will not be serviced by this {CQ, slot} by clearing
+	 * the has_work bits
+	 */
+	dlb_ldb_port_clear_has_work_bits(hw, port, slot);
+
+	/* Reset the {CQ, slot} to its default state */
+	dlb_ldb_port_set_queue_if_status(hw, port, slot);
+
+	/* Re-enable the CQ if it wasn't manually disabled by the user */
+	if (port->enabled)
+		dlb_ldb_port_cq_enable(hw, port);
+
+	/*
+	 * If there is a mapping that is pending this slot's removal, perform
+	 * the mapping now.
+	 */
+	if (state == DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP) {
+		struct dlb_ldb_port_qid_map *map;
+		struct dlb_ldb_queue *map_queue;
+		u8 prio;
+
+		map = &port->qid_map[slot];
+
+		map->qid = map->pending_qid;
+		map->priority = map->pending_priority;
+
+		map_queue = &hw->rsrcs.ldb_queues[map->qid];
+		prio = map->priority;
+
+		dlb_ldb_port_map_qid(hw, domain, port, map_queue, prio);
+	}
+}
+
 static bool dlb_domain_finish_unmap_port(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain,
 					 struct dlb_ldb_port *port)
 {
-	/* Placeholder */
+	u32 infl_cnt;
+	int i;
+
+	if (port->num_pending_removals == 0)
+		return false;
+
+	/*
+	 * The unmap requires all the CQ's outstanding inflights to be
+	 * completed.
+	 */
+	infl_cnt = DLB_CSR_RD(hw, LSP_CQ_LDB_INFL_CNT(port->id.phys_id));
+	if (BITS_GET(infl_cnt, LSP_CQ_LDB_INFL_CNT_COUNT) > 0)
+		return false;
+
+	for (i = 0; i < DLB_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		struct dlb_ldb_port_qid_map *map;
+
+		map = &port->qid_map[i];
+
+		if (map->state != DLB_QUEUE_UNMAP_IN_PROG &&
+		    map->state != DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP)
+			continue;
+
+		dlb_domain_finish_unmap_port_slot(hw, domain, port, i);
+	}
+
 	return true;
 }
 
@@ -3200,8 +3380,18 @@ static unsigned int
 dlb_domain_finish_unmap_qid_procedures(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
-	return 0;
+	struct dlb_ldb_port *port;
+	int i;
+
+	if (!domain->configured || domain->num_pending_removals == 0)
+		return 0;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list)
+			dlb_domain_finish_unmap_port(hw, domain, port);
+	}
+
+	return domain->num_pending_removals;
 }
 
 static void dlb_domain_finish_map_port(struct dlb_hw *hw,
@@ -4767,10 +4957,71 @@ static int dlb_domain_drain_mapped_queues(struct dlb_hw *hw,
 	return 0;
 }
 
+static int dlb_domain_drain_unmapped_queue(struct dlb_hw *hw,
+					   struct dlb_hw_domain *domain,
+					   struct dlb_ldb_queue *queue)
+{
+	struct dlb_ldb_port *port = NULL;
+	int ret, i;
+
+	/* If a domain has LDB queues, it must have LDB ports */
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		port = list_first_entry_or_null(&domain->used_ldb_ports[i],
+						typeof(*port), domain_list);
+		if (port)
+			break;
+	}
+
+	if (!port) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: No configured LDB ports\n",
+			   __func__);
+		return -EFAULT;
+	}
+
+	/* If necessary, free up a QID slot in this CQ */
+	if (port->num_mappings == DLB_MAX_NUM_QIDS_PER_LDB_CQ) {
+		struct dlb_ldb_queue *mapped_queue;
+
+		mapped_queue = &hw->rsrcs.ldb_queues[port->qid_map[0].qid];
+
+		ret = dlb_ldb_port_unmap_qid(hw, port, mapped_queue);
+		if (ret)
+			return ret;
+	}
+
+	ret = dlb_ldb_port_map_qid_dynamic(hw, port, queue, 0);
+	if (ret)
+		return ret;
+
+	return dlb_domain_drain_mapped_queues(hw, domain);
+}
+
 static int dlb_domain_drain_unmapped_queues(struct dlb_hw *hw,
 					    struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_queue *queue;
+	int ret;
+
+	/* If the domain hasn't been started, there's no traffic to drain */
+	if (!domain->started)
+		return 0;
+
+	/*
+	 * Pre-condition: the unattached queue must not have any outstanding
+	 * completions. This is ensured by calling dlb_domain_drain_ldb_cqs()
+	 * prior to this in dlb_domain_drain_mapped_queues().
+	 */
+	list_for_each_entry(queue, &domain->used_ldb_queues, domain_list) {
+		if (queue->num_mappings != 0 ||
+		    dlb_ldb_queue_is_empty(hw, queue))
+			continue;
+
+		ret = dlb_domain_drain_unmapped_queue(hw, domain, queue);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

