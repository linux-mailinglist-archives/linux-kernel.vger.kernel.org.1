Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C32B36EE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKORHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 12:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbgKORHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 12:07:02 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A902B221F9;
        Sun, 15 Nov 2020 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605460021;
        bh=6612iz/wOV7iLmeYWB9xpng9vvdHRnkYCRyJneu/GSM=;
        h=From:To:Cc:Subject:Date:From;
        b=eT14NCvpOE/qRLuA+QYDO6E8JGCwPfh89S4Ub7Pmp2SCP/BUnl/vvs1S2WIBaJZa0
         vMQiYEG5xsvnBAgoxnl8BrDZjSehjKWBeltKoN2TW8NT8yclCA+6IGVfN5no88XtZX
         HzxmUqOoSLH5yKQcFvd1pkKqMXtUYTUCi3t8z2yY=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: align to new FW reset scheme
Date:   Sun, 15 Nov 2020 19:06:56 +0200
Message-Id: <20201115170656.23990-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As part of the security effort in which FW will be handling
sensitive HW registers, hard reset flow will be done by FW
and will be triggered by driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9c9df5f020a6..9f54baeef754 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -65,7 +65,7 @@
 
 #define GAUDI_DMA_POOL_BLK_SIZE		0x100 /* 256 bytes */
 
-#define GAUDI_RESET_TIMEOUT_MSEC	1000		/* 1000ms */
+#define GAUDI_RESET_TIMEOUT_MSEC	2000		/* 2000ms */
 #define GAUDI_RESET_WAIT_MSEC		1		/* 1ms */
 #define GAUDI_CPU_RESET_WAIT_MSEC	200		/* 200ms */
 #define GAUDI_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
@@ -3534,7 +3534,6 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 		wait_timeout_ms = GAUDI_RESET_WAIT_MSEC;
 
 	gaudi_stop_nic_qmans(hdev);
-
 	gaudi_stop_mme_qmans(hdev);
 	gaudi_stop_tpc_qmans(hdev);
 	gaudi_stop_hbm_dma_qmans(hdev);
@@ -3911,26 +3910,31 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	/* Set device to handle FLR by H/W as we will put the device CPU to
 	 * halt mode
 	 */
-	WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
+	if (!hdev->asic_prop.hard_reset_done_by_fw)
+		WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
 					PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
 
 	/* I don't know what is the state of the CPU so make sure it is
 	 * stopped in any means necessary
 	 */
 	WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
+
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_HALT_MACHINE);
 
-	msleep(cpu_timeout_ms);
+	if (!hdev->asic_prop.hard_reset_done_by_fw) {
+		msleep(cpu_timeout_ms);
 
-	/* Tell ASIC not to re-initialize PCIe */
-	WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
+		/* Tell ASIC not to re-initialize PCIe */
+		WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
 
-	/* Restart BTL/BLR upon hard-reset */
-	if (hdev->asic_prop.fw_security_disabled)
-		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
+		/* Restart BTL/BLR upon hard-reset */
+		if (hdev->asic_prop.fw_security_disabled)
+			WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
 
-	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
 			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
+	}
+
 	dev_info(hdev->dev,
 		"Issued HARD reset command, going to wait %dms\n",
 		reset_timeout_ms);
-- 
2.17.1

