Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850412EA392
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAEC7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:41794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbhAEC7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:39 -0500
IronPort-SDR: +AZywmghkAi0aoP7uNXVGxNPq1qKe/9NsuXw2RzBceGNUFfeQSm2YEACdbgKVC+AaOrig6fALm
 agfFV/jTOOYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827524"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:17 -0800
IronPort-SDR: QGTRwBjDZjj5jhMEmIcO/lBC1zaquoKYssu3VBZIZuxMI5nd52/+k5jWj8wDquJWvdtQPsYa0+
 1J+hTWLTGILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632161"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:17 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 12/20] dlb: add register operations for port management
Date:   Mon,  4 Jan 2021 20:58:31 -0600
Message-Id: <20210105025839.23169-13-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the low-level code for configuring a new port, programming the
device-wide poll mode setting, and resetting a port.

The low-level port configuration functions program the device based on the
user-supplied ioctl arguments. These arguments are first verified, e.g.
to ensure that the port's CQ base address is properly cache-line aligned.

During domain reset, each port is drained until its inflight count and
owed-token count reaches 0, reflecting an empty CQ. Once the ports are
drained, the domain reset operation disables them from being candidates
for future scheduling decisions -- until they are re-assigned to a new
scheduling domain in the future and re-enabled.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_resource.c | 412 +++++++++++++++++++++++++++++++-
 1 file changed, 400 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 1abbca56aa49..d9d1c0e164e8 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -923,7 +923,7 @@ static void dlb_configure_ldb_queue(struct dlb_hw *hw,
 	DLB_CSR_WR(hw, LSP_QID_AQED_ACTIVE_LIM(queue->id.phys_id), reg);
 
 	level = args->lock_id_comp_level;
-	if (level >= 64 && level <= 4096)
+	if (level >= 64 && level <= 4096 && is_power_of_2(level))
 		BITS_SET(reg, ilog2(level) - 5, AQED_QID_HID_WIDTH_COMPRESS_CODE);
 	else
 		reg = 0;
@@ -1035,12 +1035,10 @@ static void dlb_configure_dir_queue(struct dlb_hw *hw,
 static bool
 dlb_cq_depth_is_valid(u32 depth)
 {
-	u32 n = ilog2(depth);
-
 	/* Valid values for depth are
 	 * 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, and 1024.
 	 */
-	if (depth > 1024 || ((1U << n) != depth))
+	if (!is_power_of_2(depth) || depth > 1024)
 		return false;
 
 	return true;
@@ -1406,6 +1404,144 @@ static void dlb_dir_port_cq_disable(struct dlb_hw *hw,
 	dlb_flush_csr(hw);
 }
 
+static void dlb_ldb_port_configure_pp(struct dlb_hw *hw,
+				      struct dlb_hw_domain *domain,
+				      struct dlb_ldb_port *port)
+{
+	u32 reg = 0;
+
+	BITS_SET(reg, domain->id.phys_id, SYS_LDB_PP2VAS_VAS);
+	DLB_CSR_WR(hw, SYS_LDB_PP2VAS(port->id.phys_id), reg);
+
+	reg = 0;
+	BIT_SET(reg, SYS_LDB_PP_V_PP_V);
+	DLB_CSR_WR(hw, SYS_LDB_PP_V(port->id.phys_id), reg);
+}
+
+static int dlb_ldb_port_configure_cq(struct dlb_hw *hw,
+				     struct dlb_hw_domain *domain,
+				     struct dlb_ldb_port *port,
+				     uintptr_t cq_dma_base,
+				     struct dlb_create_ldb_port_args *args,
+				     bool vdev_req,
+				     unsigned int vdev_id)
+{
+	u32 hl_base = 0;
+	u32 reg = 0;
+	u32 ds = 0;
+	u32 n;
+
+	/* The CQ address is 64B-aligned, and the DLB only wants bits [63:6] */
+	BITS_SET(reg, cq_dma_base >> 6, SYS_LDB_CQ_ADDR_L_ADDR_L);
+	DLB_CSR_WR(hw, SYS_LDB_CQ_ADDR_L(port->id.phys_id), reg);
+
+	reg = cq_dma_base >> 32;
+	DLB_CSR_WR(hw, SYS_LDB_CQ_ADDR_U(port->id.phys_id), reg);
+
+	/*
+	 * 'ro' == relaxed ordering. This setting allows DLB to write
+	 * cache lines out-of-order (but QEs within a cache line are always
+	 * updated in-order).
+	 */
+	reg = 0;
+	BITS_SET(reg, vdev_id, SYS_LDB_CQ2VF_PF_RO_VF);
+	BITS_SET(reg, (u32)(!vdev_req), SYS_LDB_CQ2VF_PF_RO_IS_PF);
+	BIT_SET(reg, SYS_LDB_CQ2VF_PF_RO_RO);
+
+	DLB_CSR_WR(hw, SYS_LDB_CQ2VF_PF_RO(port->id.phys_id), reg);
+
+	if (!dlb_cq_depth_is_valid(args->cq_depth)) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: invalid CQ depth\n",
+			   __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	if (args->cq_depth <= 8) {
+		ds = 1;
+	} else {
+		n = ilog2(args->cq_depth);
+		ds = n - 2;
+	}
+
+	reg = 0;
+	BITS_SET(reg, ds, CHP_LDB_CQ_TKN_DEPTH_SEL_TOKEN_DEPTH_SELECT);
+	DLB_CSR_WR(hw, CHP_LDB_CQ_TKN_DEPTH_SEL(port->id.phys_id), reg);
+
+	/*
+	 * To support CQs with depth less than 8, program the token count
+	 * register with a non-zero initial value. Operations such as domain
+	 * reset must take this initial value into account when quiescing the
+	 * CQ.
+	 */
+	port->init_tkn_cnt = 0;
+
+	if (args->cq_depth < 8) {
+		reg = 0;
+		port->init_tkn_cnt = 8 - args->cq_depth;
+
+		BITS_SET(reg, port->init_tkn_cnt, LSP_CQ_LDB_TKN_CNT_TOKEN_COUNT);
+		DLB_CSR_WR(hw, LSP_CQ_LDB_TKN_CNT(port->id.phys_id), reg);
+	} else {
+		DLB_CSR_WR(hw,
+			   LSP_CQ_LDB_TKN_CNT(port->id.phys_id),
+			   LSP_CQ_LDB_TKN_CNT_RST);
+	}
+
+	reg = 0;
+	BITS_SET(reg, ds, LSP_CQ_LDB_TKN_DEPTH_SEL_TOKEN_DEPTH_SELECT);
+	DLB_CSR_WR(hw, LSP_CQ_LDB_TKN_DEPTH_SEL(port->id.phys_id), reg);
+
+	/* Reset the CQ write pointer */
+	DLB_CSR_WR(hw,
+		   CHP_LDB_CQ_WPTR(port->id.phys_id),
+		   CHP_LDB_CQ_WPTR_RST);
+
+	reg = 0;
+	BITS_SET(reg, port->hist_list_entry_limit - 1, CHP_HIST_LIST_LIM_LIMIT);
+	DLB_CSR_WR(hw, CHP_HIST_LIST_LIM(port->id.phys_id), reg);
+
+	BITS_SET(hl_base, port->hist_list_entry_base, CHP_HIST_LIST_BASE_BASE);
+	DLB_CSR_WR(hw, CHP_HIST_LIST_BASE(port->id.phys_id), hl_base);
+
+	/*
+	 * The inflight limit sets a cap on the number of QEs for which this CQ
+	 * can owe completions at one time.
+	 */
+	reg = 0;
+	BITS_SET(reg, args->cq_history_list_size, LSP_CQ_LDB_INFL_LIM_LIMIT);
+	DLB_CSR_WR(hw, LSP_CQ_LDB_INFL_LIM(port->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, BITS_GET(hl_base, CHP_HIST_LIST_BASE_BASE),
+		 CHP_HIST_LIST_PUSH_PTR_PUSH_PTR);
+	DLB_CSR_WR(hw, CHP_HIST_LIST_PUSH_PTR(port->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, BITS_GET(hl_base, CHP_HIST_LIST_BASE_BASE),
+		 CHP_HIST_LIST_POP_PTR_POP_PTR);
+	DLB_CSR_WR(hw, CHP_HIST_LIST_POP_PTR(port->id.phys_id), reg);
+
+	/*
+	 * Address translation (AT) settings: 0: untranslated, 2: translated
+	 * (see ATS spec regarding Address Type field for more details)
+	 */
+
+	reg = 0;
+	DLB_CSR_WR(hw, SYS_LDB_CQ_AT(port->id.phys_id), reg);
+	DLB_CSR_WR(hw, SYS_LDB_CQ_PASID(port->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, domain->id.phys_id, CHP_LDB_CQ2VAS_CQ2VAS);
+	DLB_CSR_WR(hw, CHP_LDB_CQ2VAS(port->id.phys_id), reg);
+
+	/* Disable the port's QID mappings */
+	reg = 0;
+	DLB_CSR_WR(hw, LSP_CQ2PRIOV(port->id.phys_id), reg);
+
+	return 0;
+}
+
 static int dlb_configure_ldb_port(struct dlb_hw *hw,
 				  struct dlb_hw_domain *domain,
 				  struct dlb_ldb_port *port,
@@ -1414,7 +1550,150 @@ static int dlb_configure_ldb_port(struct dlb_hw *hw,
 				  bool vdev_req,
 				  unsigned int vdev_id)
 {
-	/* Placeholder */
+	int ret, i;
+
+	port->hist_list_entry_base = domain->hist_list_entry_base +
+				     domain->hist_list_entry_offset;
+	port->hist_list_entry_limit = port->hist_list_entry_base +
+				      args->cq_history_list_size;
+
+	domain->hist_list_entry_offset += args->cq_history_list_size;
+	domain->avail_hist_list_entries -= args->cq_history_list_size;
+
+	ret = dlb_ldb_port_configure_cq(hw,
+					domain,
+					port,
+					cq_dma_base,
+					args,
+					vdev_req,
+					vdev_id);
+	if (ret)
+		return ret;
+
+	dlb_ldb_port_configure_pp(hw, domain, port);
+
+	dlb_ldb_port_cq_enable(hw, port);
+
+	for (i = 0; i < DLB_MAX_NUM_QIDS_PER_LDB_CQ; i++)
+		port->qid_map[i].state = DLB_QUEUE_UNMAPPED;
+	port->num_mappings = 0;
+
+	port->enabled = true;
+
+	port->configured = true;
+
+	return 0;
+}
+
+static void dlb_dir_port_configure_pp(struct dlb_hw *hw,
+				      struct dlb_hw_domain *domain,
+				      struct dlb_dir_pq_pair *port)
+{
+	u32 reg = 0;
+
+	BITS_SET(reg, domain->id.phys_id, SYS_DIR_PP2VAS_VAS);
+	DLB_CSR_WR(hw, SYS_DIR_PP2VAS(port->id.phys_id), reg);
+
+	reg = 0;
+	BIT_SET(reg, SYS_DIR_PP_V_PP_V);
+	DLB_CSR_WR(hw, SYS_DIR_PP_V(port->id.phys_id), reg);
+}
+
+static int dlb_dir_port_configure_cq(struct dlb_hw *hw,
+				     struct dlb_hw_domain *domain,
+				     struct dlb_dir_pq_pair *port,
+				     uintptr_t cq_dma_base,
+				     struct dlb_create_dir_port_args *args,
+				     bool vdev_req,
+				     unsigned int vdev_id)
+{
+	u32 reg = 0;
+	u32 ds = 0;
+	u32 n;
+
+	/* The CQ address is 64B-aligned, and the DLB only wants bits [63:6] */
+	BITS_SET(reg, cq_dma_base >> 6, SYS_DIR_CQ_ADDR_L_ADDR_L);
+	DLB_CSR_WR(hw, SYS_DIR_CQ_ADDR_L(port->id.phys_id), reg);
+
+	reg = cq_dma_base >> 32;
+	DLB_CSR_WR(hw, SYS_DIR_CQ_ADDR_U(port->id.phys_id), reg);
+
+	/*
+	 * 'ro' == relaxed ordering. This setting allows DLB to write
+	 * cache lines out-of-order (but QEs within a cache line are always
+	 * updated in-order).
+	 */
+	reg = 0;
+	BITS_SET(reg, vdev_id, SYS_DIR_CQ2VF_PF_RO_VF);
+	BITS_SET(reg, (u32)(!vdev_req), SYS_DIR_CQ2VF_PF_RO_IS_PF);
+	BIT_SET(reg, SYS_DIR_CQ2VF_PF_RO_RO);
+
+	DLB_CSR_WR(hw, SYS_DIR_CQ2VF_PF_RO(port->id.phys_id), reg);
+
+	if (!dlb_cq_depth_is_valid(args->cq_depth)) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: invalid CQ depth\n",
+			   __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	if (args->cq_depth <= 8) {
+		ds = 1;
+	} else {
+		n = ilog2(args->cq_depth);
+		ds = n - 2;
+	}
+
+	reg = 0;
+	BITS_SET(reg, ds, CHP_DIR_CQ_TKN_DEPTH_SEL_TOKEN_DEPTH_SELECT);
+	DLB_CSR_WR(hw, CHP_DIR_CQ_TKN_DEPTH_SEL(port->id.phys_id), reg);
+
+	/*
+	 * To support CQs with depth less than 8, program the token count
+	 * register with a non-zero initial value. Operations such as domain
+	 * reset must take this initial value into account when quiescing the
+	 * CQ.
+	 */
+	port->init_tkn_cnt = 0;
+
+	if (args->cq_depth < 8) {
+		reg = 0;
+		port->init_tkn_cnt = 8 - args->cq_depth;
+
+		BITS_SET(reg, port->init_tkn_cnt, LSP_CQ_DIR_TKN_CNT_COUNT);
+		DLB_CSR_WR(hw, LSP_CQ_DIR_TKN_CNT(port->id.phys_id), reg);
+	} else {
+		DLB_CSR_WR(hw,
+			   LSP_CQ_DIR_TKN_CNT(port->id.phys_id),
+			   LSP_CQ_DIR_TKN_CNT_RST);
+	}
+
+	reg = 0;
+	BITS_SET(reg, ds, LSP_CQ_DIR_TKN_DEPTH_SEL_DSI_TOKEN_DEPTH_SELECT);
+	DLB_CSR_WR(hw, LSP_CQ_DIR_TKN_DEPTH_SEL_DSI(port->id.phys_id), reg);
+
+	/* Reset the CQ write pointer */
+	DLB_CSR_WR(hw,
+		   CHP_DIR_CQ_WPTR(port->id.phys_id),
+		   CHP_DIR_CQ_WPTR_RST);
+
+	/* Virtualize the PPID */
+	reg = 0;
+	DLB_CSR_WR(hw, SYS_DIR_CQ_FMT(port->id.phys_id), reg);
+
+	/*
+	 * Address translation (AT) settings: 0: untranslated, 2: translated
+	 * (see ATS spec regarding Address Type field for more details)
+	 */
+	reg = 0;
+	DLB_CSR_WR(hw, SYS_DIR_CQ_AT(port->id.phys_id), reg);
+
+	DLB_CSR_WR(hw, SYS_DIR_CQ_PASID(port->id.phys_id), reg);
+
+	reg = 0;
+	BITS_SET(reg, domain->id.phys_id, CHP_DIR_CQ2VAS_CQ2VAS);
+	DLB_CSR_WR(hw, CHP_DIR_CQ2VAS(port->id.phys_id), reg);
+
 	return 0;
 }
 
@@ -1426,7 +1705,27 @@ static int dlb_configure_dir_port(struct dlb_hw *hw,
 				  bool vdev_req,
 				  unsigned int vdev_id)
 {
-	/* Placeholder */
+	int ret;
+
+	ret = dlb_dir_port_configure_cq(hw,
+					domain,
+					port,
+					cq_dma_base,
+					args,
+					vdev_req,
+					vdev_id);
+
+	if (ret)
+		return ret;
+
+	dlb_dir_port_configure_pp(hw, domain, port);
+
+	dlb_dir_port_cq_enable(hw, port);
+
+	port->enabled = true;
+
+	port->port_configured = true;
+
 	return 0;
 }
 
@@ -2036,7 +2335,27 @@ static void dlb_drain_ldb_cq(struct dlb_hw *hw, struct dlb_ldb_port *port)
 static int dlb_domain_wait_for_ldb_cqs_to_empty(struct dlb_hw *hw,
 						struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_port *port;
+	int i;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			int j;
+
+			for (j = 0; j < DLB_MAX_CQ_COMP_CHECK_LOOPS; j++) {
+				if (dlb_ldb_cq_inflight_count(hw, port) == 0)
+					break;
+			}
+
+			if (j == DLB_MAX_CQ_COMP_CHECK_LOOPS) {
+				DLB_HW_ERR(hw,
+					   "[%s()] Internal error: failed to flush load-balanced port %d's completions.\n",
+					   __func__, port->id.phys_id);
+				return -EFAULT;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -2738,7 +3057,10 @@ static u32 dlb_dir_cq_token_count(struct dlb_hw *hw,
 static int dlb_domain_verify_reset_success(struct dlb_hw *hw,
 					   struct dlb_hw_domain *domain)
 {
+	struct dlb_dir_pq_pair *dir_port;
+	struct dlb_ldb_port *ldb_port;
 	struct dlb_ldb_queue *queue;
+	int i;
 
 	/*
 	 * Confirm that all the domain's queue's inflight counts and AQED
@@ -2753,6 +3075,35 @@ static int dlb_domain_verify_reset_success(struct dlb_hw *hw,
 		}
 	}
 
+	/* Confirm that all the domain's CQs inflight and token counts are 0. */
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(ldb_port, &domain->used_ldb_ports[i], domain_list) {
+			if (dlb_ldb_cq_inflight_count(hw, ldb_port) ||
+			    dlb_ldb_cq_token_count(hw, ldb_port)) {
+				DLB_HW_ERR(hw,
+					   "[%s()] Internal error: failed to empty ldb port %d\n",
+					   __func__, ldb_port->id.phys_id);
+				return -EFAULT;
+			}
+		}
+	}
+
+	list_for_each_entry(dir_port, &domain->used_dir_pq_pairs, domain_list) {
+		if (!dlb_dir_queue_is_empty(hw, dir_port)) {
+			DLB_HW_ERR(hw,
+				   "[%s()] Internal error: failed to empty dir queue %d\n",
+				   __func__, dir_port->id.phys_id);
+			return -EFAULT;
+		}
+
+		if (dlb_dir_cq_token_count(hw, dir_port)) {
+			DLB_HW_ERR(hw,
+				   "[%s()] Internal error: failed to empty dir port %d\n",
+				   __func__, dir_port->id.phys_id);
+			return -EFAULT;
+		}
+	}
+
 	return 0;
 }
 
@@ -2975,20 +3326,45 @@ static void
 dlb_domain_disable_dir_producer_ports(struct dlb_hw *hw,
 				      struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_dir_pq_pair *port;
+	u32 pp_v = 0;
+
+	list_for_each_entry(port, &domain->used_dir_pq_pairs, domain_list) {
+		DLB_CSR_WR(hw, SYS_DIR_PP_V(port->id.phys_id), pp_v);
+	}
 }
 
 static void
 dlb_domain_disable_ldb_producer_ports(struct dlb_hw *hw,
 				      struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_port *port;
+	u32 pp_v = 0;
+	int i;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			DLB_CSR_WR(hw,
+				   SYS_LDB_PP_V(port->id.phys_id),
+				   pp_v);
+		}
+	}
 }
 
 static void dlb_domain_disable_ldb_seq_checks(struct dlb_hw *hw,
 					      struct dlb_hw_domain *domain)
 {
-	/* Placeholder */
+	struct dlb_ldb_port *port;
+	u32 chk_en = 0;
+	int i;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			DLB_CSR_WR(hw,
+				   CHP_SN_CHK_ENBL(port->id.phys_id),
+				   chk_en);
+		}
+	}
 }
 
 static void
@@ -3257,7 +3633,13 @@ void dlb_clr_pmcsr_disable(struct dlb_hw *hw)
  */
 void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw)
 {
-	/* Placeholder */
+	u32 ctrl;
+
+	ctrl = DLB_CSR_RD(hw, CHP_CFG_CHP_CSR_CTRL);
+
+	BIT_SET(ctrl, CHP_CFG_CHP_CSR_CTRL_CFG_64BYTES_QE_LDB_CQ_MODE);
+
+	DLB_CSR_WR(hw, CHP_CFG_CHP_CSR_CTRL, ctrl);
 }
 
 /**
@@ -3268,5 +3650,11 @@ void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw)
  */
 void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw)
 {
-	/* Placeholder */
+	u32 ctrl;
+
+	ctrl = DLB_CSR_RD(hw, CHP_CFG_CHP_CSR_CTRL);
+
+	BIT_SET(ctrl, CHP_CFG_CHP_CSR_CTRL_CFG_64BYTES_QE_DIR_CQ_MODE);
+
+	DLB_CSR_WR(hw, CHP_CFG_CHP_CSR_CTRL, ctrl);
 }
-- 
2.17.1

