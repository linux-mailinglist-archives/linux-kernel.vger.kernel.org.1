Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C62EA39A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbhAEDAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:00:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:41795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbhAEC75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:57 -0500
IronPort-SDR: njL0iGto4SlnGaCcmwR5oLwzgLmYS6Qxt9KjIL7BdDSDLQgv9Cm4ke2iviLZwKG/9AO7L4TDij
 XP7inr7SkOfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827532"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:20 -0800
IronPort-SDR: s7jeVhx7UlKimJNbmrrqzgE/jVYgMiOnNpkeTo0U75NiLmOJ5VLEMPS9ZqVNdlhT38TaIp3Tl7
 mNdBx7puDwkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632183"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:19 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 17/20] dlb: add static queue map register operations
Date:   Mon,  4 Jan 2021 20:58:36 -0600
Message-Id: <20210105025839.23169-18-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the register accesses that implement the static queue map operation and
handle an unmap request when a queue map operation is in progress.

If a queue map operation is requested before the domain is started, it is a
synchronous procedure on "static"/unchanging hardware. (The "dynamic"
operation, when traffic is flowing in the device, will be added in a later
commit.)

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_resource.c | 146 +++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 3acb9ada964e..67ecbd4150c5 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -2208,12 +2208,146 @@ static int dlb_configure_dir_port(struct dlb_hw *hw,
 	return 0;
 }
 
+static int dlb_ldb_port_map_qid_static(struct dlb_hw *hw,
+				       struct dlb_ldb_port *p,
+				       struct dlb_ldb_queue *q,
+				       u8 priority)
+{
+	enum dlb_qid_map_state state;
+	u32 lsp_qid2cq2;
+	u32 lsp_qid2cq;
+	u32 atm_qid2cq;
+	u32 cq2priov;
+	u32 cq2qid;
+	int i;
+
+	/* Look for a pending or already mapped slot, else an unused slot */
+	if (!dlb_port_find_slot_queue(p, DLB_QUEUE_MAP_IN_PROG, q, &i) &&
+	    !dlb_port_find_slot_queue(p, DLB_QUEUE_MAPPED, q, &i) &&
+	    !dlb_port_find_slot(p, DLB_QUEUE_UNMAPPED, &i)) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: CQ has no available QID mapping slots\n",
+			   __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* Read-modify-write the priority and valid bit register */
+	cq2priov = DLB_CSR_RD(hw, LSP_CQ2PRIOV(p->id.phys_id));
+
+	cq2priov |= (1U << (i + LSP_CQ2PRIOV_V_LOC)) & LSP_CQ2PRIOV_V;
+	cq2priov |= ((priority & 0x7) << (i + LSP_CQ2PRIOV_PRIO_LOC) * 3)
+		    & LSP_CQ2PRIOV_PRIO;
+
+	DLB_CSR_WR(hw, LSP_CQ2PRIOV(p->id.phys_id), cq2priov);
+
+	/* Read-modify-write the QID map register */
+	if (i < 4)
+		cq2qid = DLB_CSR_RD(hw, LSP_CQ2QID0(p->id.phys_id));
+	else
+		cq2qid = DLB_CSR_RD(hw, LSP_CQ2QID1(p->id.phys_id));
+
+	if (i == 0 || i == 4)
+		BITS_SET(cq2qid, q->id.phys_id, LSP_CQ2QID0_QID_P0);
+	if (i == 1 || i == 5)
+		BITS_SET(cq2qid, q->id.phys_id, LSP_CQ2QID0_QID_P1);
+	if (i == 2 || i == 6)
+		BITS_SET(cq2qid, q->id.phys_id, LSP_CQ2QID0_QID_P2);
+	if (i == 3 || i == 7)
+		BITS_SET(cq2qid, q->id.phys_id, LSP_CQ2QID0_QID_P3);
+
+	if (i < 4)
+		DLB_CSR_WR(hw, LSP_CQ2QID0(p->id.phys_id), cq2qid);
+	else
+		DLB_CSR_WR(hw, LSP_CQ2QID1(p->id.phys_id), cq2qid);
+
+	atm_qid2cq = DLB_CSR_RD(hw,
+				ATM_QID2CQIDIX(q->id.phys_id,
+					       p->id.phys_id / 4));
+
+	lsp_qid2cq = DLB_CSR_RD(hw,
+				LSP_QID2CQIDIX(q->id.phys_id,
+					       p->id.phys_id / 4));
+
+	lsp_qid2cq2 = DLB_CSR_RD(hw,
+				 LSP_QID2CQIDIX2(q->id.phys_id,
+						 p->id.phys_id / 4));
+
+	switch (p->id.phys_id % 4) {
+	case 0:
+		BIT_SET(atm_qid2cq, 1 << (i + ATM_QID2CQIDIX_00_CQ_P0_LOC));
+		BIT_SET(lsp_qid2cq, 1 << (i + LSP_QID2CQIDIX_00_CQ_P0_LOC));
+		BIT_SET(lsp_qid2cq2, 1 << (i + LSP_QID2CQIDIX2_00_CQ_P0_LOC));
+		break;
+
+	case 1:
+		BIT_SET(atm_qid2cq, 1 << (i + ATM_QID2CQIDIX_00_CQ_P1_LOC));
+		BIT_SET(lsp_qid2cq, 1 << (i + LSP_QID2CQIDIX_00_CQ_P1_LOC));
+		BIT_SET(lsp_qid2cq2, 1 << (i + LSP_QID2CQIDIX2_00_CQ_P1_LOC));
+		break;
+
+	case 2:
+		BIT_SET(atm_qid2cq, 1 << (i + ATM_QID2CQIDIX_00_CQ_P2_LOC));
+		BIT_SET(lsp_qid2cq, 1 << (i + LSP_QID2CQIDIX_00_CQ_P2_LOC));
+		BIT_SET(lsp_qid2cq2, 1 << (i + LSP_QID2CQIDIX2_00_CQ_P2_LOC));
+		break;
+
+	case 3:
+		BIT_SET(atm_qid2cq, 1 << (i + ATM_QID2CQIDIX_00_CQ_P3_LOC));
+		BIT_SET(lsp_qid2cq, 1 << (i + LSP_QID2CQIDIX_00_CQ_P3_LOC));
+		BIT_SET(lsp_qid2cq2, 1 << (i + LSP_QID2CQIDIX2_00_CQ_P3_LOC));
+		break;
+	}
+
+	DLB_CSR_WR(hw,
+		   ATM_QID2CQIDIX(q->id.phys_id, p->id.phys_id / 4),
+		   atm_qid2cq);
+
+	DLB_CSR_WR(hw,
+		   LSP_QID2CQIDIX(q->id.phys_id, p->id.phys_id / 4),
+		   lsp_qid2cq);
+
+	DLB_CSR_WR(hw,
+		   LSP_QID2CQIDIX2(q->id.phys_id, p->id.phys_id / 4),
+		   lsp_qid2cq2);
+
+	dlb_flush_csr(hw);
+
+	p->qid_map[i].qid = q->id.phys_id;
+	p->qid_map[i].priority = priority;
+
+	state = DLB_QUEUE_MAPPED;
+
+	return dlb_port_slot_state_transition(hw, p, q, i, state);
+}
+
 static void dlb_ldb_port_change_qid_priority(struct dlb_hw *hw,
 					     struct dlb_ldb_port *port,
 					     int slot,
 					     struct dlb_map_qid_args *args)
 {
-	/* Placeholder */
+	u32 cq2priov;
+
+	/* Read-modify-write the priority and valid bit register */
+	cq2priov = DLB_CSR_RD(hw, LSP_CQ2PRIOV(port->id.phys_id));
+
+	cq2priov |= (1 << (slot + LSP_CQ2PRIOV_V_LOC)) & LSP_CQ2PRIOV_V;
+	cq2priov |= ((args->priority & 0x7) << slot * 3) & LSP_CQ2PRIOV_PRIO;
+
+	DLB_CSR_WR(hw, LSP_CQ2PRIOV(port->id.phys_id), cq2priov);
+
+	dlb_flush_csr(hw);
+
+	port->qid_map[slot].priority = args->priority;
+}
+
+static void dlb_ldb_queue_set_inflight_limit(struct dlb_hw *hw,
+					     struct dlb_ldb_queue *queue)
+{
+	u32 infl_lim = 0;
+
+	BITS_SET(infl_lim, queue->num_qid_inflights, LSP_QID_LDB_INFL_LIM_LIMIT);
+
+	DLB_CSR_WR(hw, LSP_QID_LDB_INFL_LIM(queue->id.phys_id), infl_lim);
 }
 
 static int dlb_ldb_port_map_qid(struct dlb_hw *hw,
@@ -2222,8 +2356,7 @@ static int dlb_ldb_port_map_qid(struct dlb_hw *hw,
 				struct dlb_ldb_queue *queue,
 				u8 prio)
 {
-	/* Placeholder */
-	return 0;
+	return dlb_ldb_port_map_qid_static(hw, port, queue, prio);
 }
 
 static void
@@ -3071,6 +3204,13 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw,
 	 */
 	st = DLB_QUEUE_MAP_IN_PROG;
 	if (dlb_port_find_slot_queue(port, st, queue, &i)) {
+		/*
+		 * Since the in-progress map was aborted, re-enable the QID's
+		 * inflights.
+		 */
+		if (queue->num_pending_additions == 0)
+			dlb_ldb_queue_set_inflight_limit(hw, queue);
+
 		st = DLB_QUEUE_UNMAPPED;
 		ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
 		if (ret)
-- 
2.17.1

