Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8CD2A3C94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCGHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCGHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:19 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B9A223AB;
        Tue,  3 Nov 2020 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604383636;
        bh=G+U48OF640hCKSdO1Wbrusuo/bpgFGN6CK9MDWElUR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSWMmP1FyR1V05SkkFCuZboG0zReqzk6nat2+kroY0mBBlj7/xeYeGYDBR0pC0kX4
         Fs8PoWXoXodXhHh7jUhi+M8KsyFF1Rf8yKCLB7a2GocScc3tKDQvg2/7nhxiRXr7SD
         o5P2dy70szK1OA4pd1E/YL3g+12LsRO9yANWnAJQ=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     SW_Drivers@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 4/4] habanalabs/gaudi: add support for NIC QMANs
Date:   Tue,  3 Nov 2020 08:07:01 +0200
Message-Id: <20201103060701.25852-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103060701.25852-1-ogabbay@kernel.org>
References: <20201103060701.25852-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the QMANs that are responsible to submit doorbells to the NIC
engines. Add support for stopping and disabling them, and reset them as
part of the hard-reset procedure of GAUDI. This will allow the user to
submit work to the NICs.

Add support for receiving events on QMAN errors from the firmware.

However, the nic_ports_mask is still initialized to 0. That means this code
won't initialize the QMANs just yet. That will be in a later patch.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |   3 +-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 741 ++++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h      |  32 +
 3 files changed, 731 insertions(+), 45 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7307e0b88b44..968431c7ce20 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1633,8 +1633,6 @@ struct hl_mmu_funcs {
  * @pmmu_huge_range: is a different virtual addresses range used for PMMU with
  *                   huge pages.
  * @init_done: is the initialization of the device done.
- * @mmu_enable: is MMU enabled.
- * @mmu_huge_page_opt: is MMU huge pages optimization enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fpriv_list, enforces
@@ -1750,6 +1748,7 @@ struct hl_device {
 	u8				supports_cb_mapping;
 
 	/* Parameters for bring-up */
+	u64				nic_ports_mask;
 	u64				fw_loading;
 	u8				mmu_enable;
 	u8				mmu_huge_page_opt;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 930b26b1f445..065c2377c1fa 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -301,46 +301,46 @@ static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_TPC_7_1 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_TPC_7_2 */
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_TPC_7_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_0_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_0_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_0_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_0_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_1_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_1_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_1_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_1_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_2_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_2_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_2_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_2_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_3_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_3_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_3_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_3_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_4_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_4_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_4_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_4_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_5_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_5_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_5_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_5_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_6_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_6_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_6_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_6_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_7_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_7_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_7_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_7_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_8_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_8_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_8_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_8_3 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_9_0 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_9_1 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_9_2 */
-	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_9_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_0_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_0_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_0_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_0_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_1_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_1_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_1_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_1_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_2_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_2_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_2_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_2_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_3_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_3_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_3_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_3_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_4_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_4_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_4_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_4_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_5_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_5_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_5_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_5_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_6_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_6_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_6_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_6_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_7_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_7_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_7_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_7_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_8_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_8_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_8_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_8_3 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_0 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_1 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_2 */
+	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_3 */
 };
 
 struct ecc_info_extract_params {
@@ -800,6 +800,27 @@ static int gaudi_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	if ((hdev->card_type == cpucp_card_type_pci) &&
+			(hdev->nic_ports_mask & 0x3)) {
+		dev_info(hdev->dev,
+			"PCI card detected, only 8 ports are enabled\n");
+		hdev->nic_ports_mask &= ~0x3;
+
+		/* Stop and disable unused NIC QMANs */
+		WREG32(mmNIC0_QM0_GLBL_CFG1, NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+					NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+					NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+		WREG32(mmNIC0_QM1_GLBL_CFG1, NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+					NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+					NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+		WREG32(mmNIC0_QM0_GLBL_CFG0, 0);
+		WREG32(mmNIC0_QM1_GLBL_CFG0, 0);
+
+		gaudi->hw_cap_initialized &= ~(HW_CAP_NIC0 | HW_CAP_NIC1);
+	}
+
 	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
@@ -946,6 +967,9 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 		case GAUDI_QUEUE_ID_TPC_0_0 ... GAUDI_QUEUE_ID_TPC_7_3:
 			q->pq_size = TPC_QMAN_SIZE_IN_BYTES;
 			break;
+		case GAUDI_QUEUE_ID_NIC_0_0 ... GAUDI_QUEUE_ID_NIC_9_3:
+			q->pq_size = NIC_QMAN_SIZE_IN_BYTES;
+			break;
 		default:
 			dev_err(hdev->dev, "Bad internal queue index %d", i);
 			rc = -EINVAL;
@@ -2363,6 +2387,133 @@ static void gaudi_init_tpc_qmans(struct hl_device *hdev)
 	}
 }
 
+static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
+				int qman_id, u64 qman_base_addr, int nic_id)
+{
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 q_off;
+	u32 nic_qm_err_cfg;
+
+	mtr_base_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE +
+				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE +
+				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
+
+	q_off = nic_offset + qman_id * 4;
+
+	WREG32(mmNIC0_QM0_PQ_BASE_LO_0 + q_off, lower_32_bits(qman_base_addr));
+	WREG32(mmNIC0_QM0_PQ_BASE_HI_0 + q_off, upper_32_bits(qman_base_addr));
+
+	WREG32(mmNIC0_QM0_PQ_SIZE_0 + q_off, ilog2(NIC_QMAN_LENGTH));
+	WREG32(mmNIC0_QM0_PQ_PI_0 + q_off, 0);
+	WREG32(mmNIC0_QM0_PQ_CI_0 + q_off, 0);
+
+	WREG32(mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_0 + q_off, 0x74);
+	WREG32(mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off, 0x14);
+	WREG32(mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off, 0x1C);
+
+	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_0 + q_off, mtr_base_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_0 + q_off, mtr_base_hi);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_0 + q_off, so_base_lo);
+	WREG32(mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_0 + q_off, so_base_hi);
+
+	if (qman_id == 0) {
+		/* Configure RAZWI IRQ */
+		nic_qm_err_cfg = NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
+		if (hdev->stop_on_err) {
+			nic_qm_err_cfg |=
+				NIC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
+		}
+
+		WREG32(mmNIC0_QM0_GLBL_ERR_CFG + nic_offset, nic_qm_err_cfg);
+		WREG32(mmNIC0_QM0_GLBL_ERR_ADDR_LO + nic_offset,
+			lower_32_bits(CFG_BASE +
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+		WREG32(mmNIC0_QM0_GLBL_ERR_ADDR_HI + nic_offset,
+			upper_32_bits(CFG_BASE +
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+		WREG32(mmNIC0_QM0_GLBL_ERR_WDATA + nic_offset,
+			gaudi_irq_map_table[GAUDI_EVENT_NIC0_QM0].cpu_id +
+									nic_id);
+
+		WREG32(mmNIC0_QM0_ARB_ERR_MSG_EN + nic_offset,
+				QM_ARB_ERR_MSG_EN_MASK);
+
+		/* Increase ARB WDT to support streams architecture */
+		WREG32(mmNIC0_QM0_ARB_SLV_CHOISE_WDT + nic_offset,
+				GAUDI_ARB_WDT_TIMEOUT);
+
+		WREG32(mmNIC0_QM0_GLBL_CFG1 + nic_offset, 0);
+		WREG32(mmNIC0_QM0_GLBL_PROT + nic_offset,
+				QMAN_INTERNAL_MAKE_TRUSTED);
+	}
+}
+
+/**
+ * gaudi_init_nic_qmans - Initialize NIC QMAN registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Initialize the H/W registers of the NIC QMANs
+ *
+ */
+void gaudi_init_nic_qmans(struct hl_device *hdev)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct gaudi_internal_qman_info *q;
+	u64 qman_base_addr;
+	u32 nic_offset = 0;
+	u32 nic_delta_between_qmans =
+			mmNIC0_QM1_GLBL_CFG0 - mmNIC0_QM0_GLBL_CFG0;
+	u32 nic_delta_between_nics =
+			mmNIC1_QM0_GLBL_CFG0 - mmNIC0_QM0_GLBL_CFG0;
+	int i, nic_id, internal_q_index;
+
+	if (!hdev->nic_ports_mask)
+		return;
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC_MASK)
+		return;
+
+	dev_dbg(hdev->dev, "Initializing NIC QMANs\n");
+
+	for (nic_id = 0 ; nic_id < NIC_NUMBER_OF_ENGINES ; nic_id++) {
+		if (!(hdev->nic_ports_mask & (1 << nic_id))) {
+			nic_offset += nic_delta_between_qmans;
+			if (nic_id & 1) {
+				nic_offset -= (nic_delta_between_qmans * 2);
+				nic_offset += nic_delta_between_nics;
+			}
+			continue;
+		}
+
+		for (i = 0 ; i < QMAN_STREAMS ; i++) {
+			internal_q_index = GAUDI_QUEUE_ID_NIC_0_0 +
+						nic_id * QMAN_STREAMS + i;
+			q = &gaudi->internal_qmans[internal_q_index];
+			qman_base_addr = (u64) q->pq_dma_addr;
+			gaudi_init_nic_qman(hdev, nic_offset, (i & 0x3),
+						qman_base_addr, nic_id);
+		}
+
+		/* Enable the QMAN */
+		WREG32(mmNIC0_QM0_GLBL_CFG0 + nic_offset, NIC_QMAN_ENABLE);
+
+		nic_offset += nic_delta_between_qmans;
+		if (nic_id & 1) {
+			nic_offset -= (nic_delta_between_qmans * 2);
+			nic_offset += nic_delta_between_nics;
+		}
+
+		gaudi->hw_cap_initialized |= 1 << (HW_CAP_NIC_SHIFT + nic_id);
+	}
+}
+
 static void gaudi_disable_pci_dma_qmans(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -2415,6 +2566,30 @@ static void gaudi_disable_tpc_qmans(struct hl_device *hdev)
 	}
 }
 
+static void gaudi_disable_nic_qmans(struct hl_device *hdev)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	u32 nic_mask, nic_offset = 0;
+	u32 nic_delta_between_qmans =
+			mmNIC0_QM1_GLBL_CFG0 - mmNIC0_QM0_GLBL_CFG0;
+	u32 nic_delta_between_nics =
+			mmNIC1_QM0_GLBL_CFG0 - mmNIC0_QM0_GLBL_CFG0;
+	int nic_id;
+
+	for (nic_id = 0 ; nic_id < NIC_NUMBER_OF_ENGINES ; nic_id++) {
+		nic_mask = 1 << (HW_CAP_NIC_SHIFT + nic_id);
+
+		if (gaudi->hw_cap_initialized & nic_mask)
+			WREG32(mmNIC0_QM0_GLBL_CFG0 + nic_offset, 0);
+
+		nic_offset += nic_delta_between_qmans;
+		if (nic_id & 1) {
+			nic_offset -= (nic_delta_between_qmans * 2);
+			nic_offset += nic_delta_between_nics;
+		}
+	}
+}
+
 static void gaudi_stop_pci_dma_qmans(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -2473,6 +2648,73 @@ static void gaudi_stop_tpc_qmans(struct hl_device *hdev)
 	WREG32(mmTPC7_QM_GLBL_CFG1, 0x1F << TPC0_QM_GLBL_CFG1_CP_STOP_SHIFT);
 }
 
+static void gaudi_stop_nic_qmans(struct hl_device *hdev)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
+	/* Stop upper CPs of QMANs */
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC0)
+		WREG32(mmNIC0_QM0_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC1)
+		WREG32(mmNIC0_QM1_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC2)
+		WREG32(mmNIC1_QM0_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC3)
+		WREG32(mmNIC1_QM1_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC4)
+		WREG32(mmNIC2_QM0_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC5)
+		WREG32(mmNIC2_QM1_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC6)
+		WREG32(mmNIC3_QM0_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC7)
+		WREG32(mmNIC3_QM1_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC8)
+		WREG32(mmNIC4_QM0_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC9)
+		WREG32(mmNIC4_QM1_GLBL_CFG1,
+				NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK |
+				NIC0_QM0_GLBL_CFG1_CP_STOP_MASK);
+}
+
 static void gaudi_pci_dma_stall(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -2662,6 +2904,7 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 	else
 		wait_timeout_ms = GAUDI_RESET_WAIT_MSEC;
 
+	gaudi_stop_nic_qmans(hdev);
 
 	gaudi_stop_mme_qmans(hdev);
 	gaudi_stop_tpc_qmans(hdev);
@@ -2679,6 +2922,7 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 
 	msleep(wait_timeout_ms);
 
+	gaudi_disable_nic_qmans(hdev);
 	gaudi_disable_mme_qmans(hdev);
 	gaudi_disable_tpc_qmans(hdev);
 	gaudi_disable_hbm_dma_qmans(hdev);
@@ -2979,11 +3223,13 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_init_tpc_qmans(hdev);
 
+	gaudi_init_nic_qmans(hdev);
+
 	hdev->asic_funcs->set_clock_gating(hdev);
 
 	gaudi_enable_timestamp(hdev);
 
-	/* MSI must be enabled before CPU queues are initialized */
+	/* MSI must be enabled before CPU queues and NIC are initialized */
 	rc = gaudi_enable_msi(hdev);
 	if (rc)
 		goto disable_queues;
@@ -3082,7 +3328,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 					HW_CAP_HBM | HW_CAP_PCI_DMA |
 					HW_CAP_MME | HW_CAP_TPC_MASK |
 					HW_CAP_HBM_DMA | HW_CAP_PLL |
-					HW_CAP_MMU |
+					HW_CAP_NIC_MASK | HW_CAP_MMU |
 					HW_CAP_SRAM_SCRAMBLER |
 					HW_CAP_HBM_SCRAMBLER |
 					HW_CAP_CLK_GATE);
@@ -3352,6 +3598,166 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 		db_reg_offset = mmTPC7_QM_PQ_PI_3;
 		break;
 
+	case GAUDI_QUEUE_ID_NIC_0_0:
+		db_reg_offset = mmNIC0_QM0_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_0_1:
+		db_reg_offset = mmNIC0_QM0_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_0_2:
+		db_reg_offset = mmNIC0_QM0_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_0_3:
+		db_reg_offset = mmNIC0_QM0_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_1_0:
+		db_reg_offset = mmNIC0_QM1_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_1_1:
+		db_reg_offset = mmNIC0_QM1_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_1_2:
+		db_reg_offset = mmNIC0_QM1_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_1_3:
+		db_reg_offset = mmNIC0_QM1_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_2_0:
+		db_reg_offset = mmNIC1_QM0_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_2_1:
+		db_reg_offset = mmNIC1_QM0_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_2_2:
+		db_reg_offset = mmNIC1_QM0_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_2_3:
+		db_reg_offset = mmNIC1_QM0_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_3_0:
+		db_reg_offset = mmNIC1_QM1_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_3_1:
+		db_reg_offset = mmNIC1_QM1_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_3_2:
+		db_reg_offset = mmNIC1_QM1_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_3_3:
+		db_reg_offset = mmNIC1_QM1_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_4_0:
+		db_reg_offset = mmNIC2_QM0_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_4_1:
+		db_reg_offset = mmNIC2_QM0_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_4_2:
+		db_reg_offset = mmNIC2_QM0_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_4_3:
+		db_reg_offset = mmNIC2_QM0_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_5_0:
+		db_reg_offset = mmNIC2_QM1_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_5_1:
+		db_reg_offset = mmNIC2_QM1_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_5_2:
+		db_reg_offset = mmNIC2_QM1_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_5_3:
+		db_reg_offset = mmNIC2_QM1_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_6_0:
+		db_reg_offset = mmNIC3_QM0_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_6_1:
+		db_reg_offset = mmNIC3_QM0_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_6_2:
+		db_reg_offset = mmNIC3_QM0_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_6_3:
+		db_reg_offset = mmNIC3_QM0_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_7_0:
+		db_reg_offset = mmNIC3_QM1_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_7_1:
+		db_reg_offset = mmNIC3_QM1_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_7_2:
+		db_reg_offset = mmNIC3_QM1_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_7_3:
+		db_reg_offset = mmNIC3_QM1_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_8_0:
+		db_reg_offset = mmNIC4_QM0_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_8_1:
+		db_reg_offset = mmNIC4_QM0_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_8_2:
+		db_reg_offset = mmNIC4_QM0_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_8_3:
+		db_reg_offset = mmNIC4_QM0_PQ_PI_3;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_9_0:
+		db_reg_offset = mmNIC4_QM1_PQ_PI_0;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_9_1:
+		db_reg_offset = mmNIC4_QM1_PQ_PI_1;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_9_2:
+		db_reg_offset = mmNIC4_QM1_PQ_PI_2;
+		break;
+
+	case GAUDI_QUEUE_ID_NIC_9_3:
+		db_reg_offset = mmNIC4_QM1_PQ_PI_3;
+		break;
+
 	default:
 		invalid_queue = true;
 	}
@@ -4248,6 +4654,17 @@ static int gaudi_parse_cb_no_ext_queue(struct hl_device *hdev,
 					struct hl_cs_parser *parser)
 {
 	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	u32 nic_mask_q_id = 1 << (HW_CAP_NIC_SHIFT +
+		((parser->hw_queue_id - GAUDI_QUEUE_ID_NIC_0_0) >> 2));
+
+	if ((parser->hw_queue_id >= GAUDI_QUEUE_ID_NIC_0_0) &&
+			(parser->hw_queue_id <= GAUDI_QUEUE_ID_NIC_9_3) &&
+			(!(gaudi->hw_cap_initialized & nic_mask_q_id))) {
+		dev_err(hdev->dev, "h/w queue %d is disabled\n",
+				parser->hw_queue_id);
+		return -EINVAL;
+	}
 
 	/* For internal queue jobs just check if CB address is valid */
 	if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
@@ -4481,6 +4898,12 @@ static void gaudi_restore_qm_registers(struct hl_device *hdev)
 		qman_offset = i * TPC_QMAN_OFFSET;
 		WREG32(mmTPC0_QM_ARB_CFG_0 + qman_offset, 0);
 	}
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++) {
+		qman_offset = (i >> 1) * NIC_MACRO_QMAN_OFFSET +
+				(i & 0x1) * NIC_ENGINE_QMAN_OFFSET;
+		WREG32(mmNIC0_QM0_ARB_CFG_0 + qman_offset, 0);
+	}
 }
 
 static void gaudi_restore_user_registers(struct hl_device *hdev)
@@ -4913,6 +5336,136 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 	gaudi_mmu_prepare_reg(hdev, mmMME2_ACC_WBC, asid);
 	gaudi_mmu_prepare_reg(hdev, mmMME3_ACC_WBC, asid);
 
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC0) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC1) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC2) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC3) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC4) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC5) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC6) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC7) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC8) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
+	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC9) {
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_0,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_1,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_2,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_3,
+				asid);
+		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_4,
+				asid);
+	}
+
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER, asid);
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER, asid);
 
@@ -5442,6 +5995,8 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.num_memories = 33;
 		params.derr = true;
 		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
+		break;
 	default:
 		return;
 	}
@@ -5493,6 +6048,56 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
 			mmDMA0_QM_ARB_ERR_CAUSE + index * DMA_QMAN_OFFSET;
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "DMA_QM", index);
 		break;
+	case GAUDI_EVENT_NIC0_QM0:
+		glbl_sts_addr = mmNIC0_QM0_GLBL_STS1_0;
+		arb_err_addr = mmNIC0_QM0_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM0");
+		break;
+	case GAUDI_EVENT_NIC0_QM1:
+		glbl_sts_addr = mmNIC0_QM1_GLBL_STS1_0;
+		arb_err_addr = mmNIC0_QM1_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM1");
+		break;
+	case GAUDI_EVENT_NIC1_QM0:
+		glbl_sts_addr = mmNIC1_QM0_GLBL_STS1_0;
+		arb_err_addr = mmNIC1_QM0_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM0");
+		break;
+	case GAUDI_EVENT_NIC1_QM1:
+		glbl_sts_addr = mmNIC1_QM1_GLBL_STS1_0;
+		arb_err_addr = mmNIC1_QM1_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM1");
+		break;
+	case GAUDI_EVENT_NIC2_QM0:
+		glbl_sts_addr = mmNIC2_QM0_GLBL_STS1_0;
+		arb_err_addr = mmNIC2_QM0_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM0");
+		break;
+	case GAUDI_EVENT_NIC2_QM1:
+		glbl_sts_addr = mmNIC2_QM1_GLBL_STS1_0;
+		arb_err_addr = mmNIC2_QM1_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM1");
+		break;
+	case GAUDI_EVENT_NIC3_QM0:
+		glbl_sts_addr = mmNIC3_QM0_GLBL_STS1_0;
+		arb_err_addr = mmNIC3_QM0_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM0");
+		break;
+	case GAUDI_EVENT_NIC3_QM1:
+		glbl_sts_addr = mmNIC3_QM1_GLBL_STS1_0;
+		arb_err_addr = mmNIC3_QM1_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM1");
+		break;
+	case GAUDI_EVENT_NIC4_QM0:
+		glbl_sts_addr = mmNIC4_QM0_GLBL_STS1_0;
+		arb_err_addr = mmNIC4_QM0_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM0");
+		break;
+	case GAUDI_EVENT_NIC4_QM1:
+		glbl_sts_addr = mmNIC4_QM1_GLBL_STS1_0;
+		arb_err_addr = mmNIC4_QM1_ARB_ERR_CAUSE;
+		snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM1");
+		break;
 	default:
 		return;
 	}
@@ -5870,6 +6475,16 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
 	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
 		fallthrough;
+	case GAUDI_EVENT_NIC0_QM0:
+	case GAUDI_EVENT_NIC0_QM1:
+	case GAUDI_EVENT_NIC1_QM0:
+	case GAUDI_EVENT_NIC1_QM1:
+	case GAUDI_EVENT_NIC2_QM0:
+	case GAUDI_EVENT_NIC2_QM1:
+	case GAUDI_EVENT_NIC3_QM0:
+	case GAUDI_EVENT_NIC3_QM1:
+	case GAUDI_EVENT_NIC4_QM0:
+	case GAUDI_EVENT_NIC4_QM1:
 	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_qman_err(hdev, event_type);
@@ -6103,10 +6718,11 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	const char *fmt = "%-5d%-9s%#-14x%#-12x%#x\n";
 	const char *mme_slave_fmt = "%-5d%-9s%-14s%-12s%#x\n";
+	const char *nic_fmt = "%-5d%-9s%#-14x%#x\n";
 	u32 qm_glbl_sts0, qm_cgm_sts, dma_core_sts0, tpc_cfg_sts, mme_arch_sts;
 	bool is_idle = true, is_eng_idle, is_slave;
 	u64 offset;
-	int i, dma_id;
+	int i, dma_id, port;
 
 	mutex_lock(&gaudi->clk_gate_mutex);
 
@@ -6195,6 +6811,45 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 		}
 	}
 
+	if (s)
+		seq_puts(s, "\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
+				"---  -------  ------------  ----------\n");
+
+	for (i = 0 ; i < (NIC_NUMBER_OF_ENGINES / 2) ; i++) {
+		offset = i * NIC_MACRO_QMAN_OFFSET;
+		port = 2 * i;
+		if (hdev->nic_ports_mask & BIT(port)) {
+			qm_glbl_sts0 = RREG32(mmNIC0_QM0_GLBL_STS0 + offset);
+			qm_cgm_sts = RREG32(mmNIC0_QM0_CGM_STS + offset);
+			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
+			is_idle &= is_eng_idle;
+
+			if (mask)
+				*mask |= ((u64) !is_eng_idle) <<
+						(GAUDI_ENGINE_ID_NIC_0 + port);
+			if (s)
+				seq_printf(s, nic_fmt, port,
+						is_eng_idle ? "Y" : "N",
+						qm_glbl_sts0, qm_cgm_sts);
+		}
+
+		port = 2 * i + 1;
+		if (hdev->nic_ports_mask & BIT(port)) {
+			qm_glbl_sts0 = RREG32(mmNIC0_QM1_GLBL_STS0 + offset);
+			qm_cgm_sts = RREG32(mmNIC0_QM1_CGM_STS + offset);
+			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
+			is_idle &= is_eng_idle;
+
+			if (mask)
+				*mask |= ((u64) !is_eng_idle) <<
+						(GAUDI_ENGINE_ID_NIC_0 + port);
+			if (s)
+				seq_printf(s, nic_fmt, port,
+						is_eng_idle ? "Y" : "N",
+						qm_glbl_sts0, qm_cgm_sts);
+		}
+	}
+
 	if (s)
 		seq_puts(s, "\n");
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 83ad2b0a3a61..5b99c94ebe36 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -79,6 +79,7 @@
 #define TPC_QMAN_OFFSET		(mmTPC1_QM_BASE - mmTPC0_QM_BASE)
 #define MME_QMAN_OFFSET		(mmMME1_QM_BASE - mmMME0_QM_BASE)
 #define NIC_MACRO_QMAN_OFFSET	(mmNIC1_QM0_BASE - mmNIC0_QM0_BASE)
+#define NIC_ENGINE_QMAN_OFFSET	(mmNIC0_QM1_BASE - mmNIC0_QM0_BASE)
 
 #define TPC_CFG_OFFSET		(mmTPC1_CFG_BASE - mmTPC0_CFG_BASE)
 
@@ -140,6 +141,10 @@
 #define TPC_QMAN_LENGTH			1024
 #define TPC_QMAN_SIZE_IN_BYTES		(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
+#define NIC_QMAN_LENGTH			1024
+#define NIC_QMAN_SIZE_IN_BYTES		(NIC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
+
+
 #define SRAM_USER_BASE_OFFSET  GAUDI_DRIVER_SRAM_RESERVED_SIZE_FROM_START
 
 /* Virtual address space */
@@ -161,6 +166,19 @@
 #define HW_CAP_SRAM_SCRAMBLER	BIT(10)
 #define HW_CAP_HBM_SCRAMBLER	BIT(11)
 
+#define HW_CAP_NIC0		BIT(14)
+#define HW_CAP_NIC1		BIT(15)
+#define HW_CAP_NIC2		BIT(16)
+#define HW_CAP_NIC3		BIT(17)
+#define HW_CAP_NIC4		BIT(18)
+#define HW_CAP_NIC5		BIT(19)
+#define HW_CAP_NIC6		BIT(20)
+#define HW_CAP_NIC7		BIT(21)
+#define HW_CAP_NIC8		BIT(22)
+#define HW_CAP_NIC9		BIT(23)
+#define HW_CAP_NIC_MASK		GENMASK(23, 14)
+#define HW_CAP_NIC_SHIFT	14
+
 #define HW_CAP_TPC0		BIT(24)
 #define HW_CAP_TPC1		BIT(25)
 #define HW_CAP_TPC2		BIT(26)
@@ -208,6 +226,20 @@ enum gaudi_tpc_mask {
 	GAUDI_TPC_MASK_ALL = 0xFF
 };
 
+enum gaudi_nic_mask {
+	GAUDI_NIC_MASK_NIC0 = 0x01,
+	GAUDI_NIC_MASK_NIC1 = 0x02,
+	GAUDI_NIC_MASK_NIC2 = 0x04,
+	GAUDI_NIC_MASK_NIC3 = 0x08,
+	GAUDI_NIC_MASK_NIC4 = 0x10,
+	GAUDI_NIC_MASK_NIC5 = 0x20,
+	GAUDI_NIC_MASK_NIC6 = 0x40,
+	GAUDI_NIC_MASK_NIC7 = 0x80,
+	GAUDI_NIC_MASK_NIC8 = 0x100,
+	GAUDI_NIC_MASK_NIC9 = 0x200,
+	GAUDI_NIC_MASK_ALL = 0x3FF
+};
+
 /**
  * struct gaudi_internal_qman_info - Internal QMAN information.
  * @pq_kernel_addr: Kernel address of the PQ memory area in the host.
-- 
2.17.1

