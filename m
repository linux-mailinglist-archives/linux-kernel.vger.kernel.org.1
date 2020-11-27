Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5F2C6134
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgK0Iwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgK0Iwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:52:38 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E358B22249;
        Fri, 27 Nov 2020 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606467156;
        bh=L0hWWJOvh2olKK63JPQ1fnHK0JEnXJ4ZPC/GhCIVAMg=;
        h=From:To:Cc:Subject:Date:From;
        b=OlugDK4wixIoeO1B2OHznxp2y7++AurX3KpvLXTVERDUpO/uuLqo6/JMTCzCftD8N
         ybU3buZMvFLMbS5/TgU0D6w7ENmyiPNk219RdDev+TGdi4cOAmcr1dk08fjUWAHXwu
         EjW9Fxe9kHRG4MNT8n7vRyuDT36IfGPDGYNlpOf0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: handle reset when f/w is in preboot
Date:   Fri, 27 Nov 2020 10:52:32 +0200
Message-Id: <20201127085232.3247-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the f/w is in preboot/u-boot they don't perform the new
reset mechanism. Therefore, the driver needs to reset the device.
To prevent reset of PCI_IF, the driver needs to first configure the
reset units.

If the security is enabled, the driver can't configure the reset units.
In that situation, don't reset the card.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 60 ++++++++++++++-------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index cd18456fa523..568afe1b6849 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3829,33 +3829,6 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	 * cleared by the H/W upon H/W reset
 	 */
 	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
-	if (hdev->asic_prop.fw_security_disabled) {
-		/* Configure the reset registers. Must be done as early as
-		 * possible in case we fail during H/W initialization
-		 */
-		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_H,
-						(CFG_RST_H_DMA_MASK |
-						CFG_RST_H_MME_MASK |
-						CFG_RST_H_SM_MASK |
-						CFG_RST_H_TPC_7_MASK));
-
-		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
-
-		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_H,
-						(CFG_RST_H_HBM_MASK |
-						CFG_RST_H_TPC_7_MASK |
-						CFG_RST_H_NIC_MASK |
-						CFG_RST_H_SM_MASK |
-						CFG_RST_H_DMA_MASK |
-						CFG_RST_H_MME_MASK |
-						CFG_RST_H_CPU_MASK |
-						CFG_RST_H_MMU_MASK));
-
-		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_L,
-						(CFG_RST_L_IF_MASK |
-						CFG_RST_L_PSOC_MASK |
-						CFG_RST_L_TPC_MASK));
-	}
 }
 
 static int gaudi_hw_init(struct hl_device *hdev)
@@ -3946,7 +3919,8 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	/* Set device to handle FLR by H/W as we will put the device CPU to
 	 * halt mode
 	 */
-	if (!hdev->asic_prop.hard_reset_done_by_fw)
+	if (hdev->asic_prop.fw_security_disabled &&
+				!hdev->asic_prop.hard_reset_done_by_fw)
 		WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
 					PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
 
@@ -3957,7 +3931,35 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_HALT_MACHINE);
 
-	if (!hdev->asic_prop.hard_reset_done_by_fw) {
+	if (hdev->asic_prop.fw_security_disabled &&
+				!hdev->asic_prop.hard_reset_done_by_fw) {
+
+		/* Configure the reset registers. Must be done as early as
+		 * possible in case we fail during H/W initialization
+		 */
+		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_H,
+						(CFG_RST_H_DMA_MASK |
+						CFG_RST_H_MME_MASK |
+						CFG_RST_H_SM_MASK |
+						CFG_RST_H_TPC_7_MASK));
+
+		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
+
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_H,
+						(CFG_RST_H_HBM_MASK |
+						CFG_RST_H_TPC_7_MASK |
+						CFG_RST_H_NIC_MASK |
+						CFG_RST_H_SM_MASK |
+						CFG_RST_H_DMA_MASK |
+						CFG_RST_H_MME_MASK |
+						CFG_RST_H_CPU_MASK |
+						CFG_RST_H_MMU_MASK));
+
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_L,
+						(CFG_RST_L_IF_MASK |
+						CFG_RST_L_PSOC_MASK |
+						CFG_RST_L_TPC_MASK));
+
 		msleep(cpu_timeout_ms);
 
 		/* Tell ASIC not to re-initialize PCIe */
-- 
2.17.1

