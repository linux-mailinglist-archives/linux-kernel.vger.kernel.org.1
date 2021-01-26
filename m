Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9D304FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhA0DTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390609AbhAZUlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:41:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E30B222B2C;
        Tue, 26 Jan 2021 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611693666;
        bh=gfrQIBDPTm8G/njefwh43yidBaij5XuPfTlaU3DSfy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESPcwSDtYP6WP8YUmNTJxc1DbGpuKHQ3HqnJMNP8a1SZ9oywtGyteiX0azcrnPlRx
         JevXHseOSXhRCw1G2OVQjELuqs3LcgAIzJ6lJBKUytTrnqCO3EdcpkAMchJw1aMh4+
         SAPE1TdxPbYMOTNxvCydGLMOL+4H5DmkYfUl2WfHK//dVXSQ4VSVXVkyENGlW4KRLg
         nOsvOxv+oizFbKz7yqaUNZEXI9xNE4fjEvcUKHwreQJI30Id8zJky4Ss7OzzUvavxP
         f5i4fw4q6b3ndOtBxmkJMur/LloP887+5H/jHwWbU9A4S6S14mfolVX4U9Gt4PbxgU
         JRqmRugpe29yg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/3] habanalabs: fix ETR security issue
Date:   Tue, 26 Jan 2021 22:40:57 +0200
Message-Id: <20210126204057.329-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126204057.329-1-ogabbay@kernel.org>
References: <20210126204057.329-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

ETR should always be non-secured as it is used by the users to record
profiling/trace data.
This patch fixes the configuration to match those requirements.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/gaudi/gaudi_coresight.c    | 18 +++++++++++++++---
 drivers/misc/habanalabs/goya/goya_coresight.c  | 11 +++++++++--
 .../habanalabs/include/gaudi/gaudi_masks.h     |  5 ++++-
 .../include/goya/asic_reg/goya_masks.h         |  5 ++++-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 88a09d42e111..6e56fa1c6c69 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -634,9 +634,21 @@ static int gaudi_config_etr(struct hl_device *hdev,
 		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
 		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
 		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
-		/* Workaround for H3 #HW-2075 bug: use small data chunks */
-		WREG32(mmPSOC_ETR_AXICTL, (is_host ? 0 : 0x700) |
-					PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT);
+		if (hdev->asic_prop.fw_security_disabled) {
+			/* make ETR not privileged */
+			val = FIELD_PREP(
+					PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK, 0);
+			/* make ETR non-secured (inverted logic) */
+			val |= FIELD_PREP(
+					PSOC_ETR_AXICTL_PROTCTRLBIT1_MASK, 1);
+			/*
+			 * Workaround for H3 #HW-2075 bug: use small data
+			 * chunks
+			 */
+			val |= FIELD_PREP(PSOC_ETR_AXICTL_WRBURSTLEN_MASK,
+							is_host ? 0 : 7);
+			WREG32(mmPSOC_ETR_AXICTL, val);
+		}
 		WREG32(mmPSOC_ETR_DBALO,
 				lower_32_bits(input->buffer_address));
 		WREG32(mmPSOC_ETR_DBAHI,
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 6fa03933b438..6b7445cca580 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -434,8 +434,15 @@ static int goya_config_etr(struct hl_device *hdev,
 		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
 		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
 		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
-		WREG32(mmPSOC_ETR_AXICTL,
-				0x700 | PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT);
+		if (hdev->asic_prop.fw_security_disabled) {
+			/* make ETR not privileged */
+			val = FIELD_PREP(PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK, 0);
+			/* make ETR non-secured (inverted logic) */
+			val |= FIELD_PREP(PSOC_ETR_AXICTL_PROTCTRLBIT1_MASK, 1);
+			/* burst size 8 */
+			val |= FIELD_PREP(PSOC_ETR_AXICTL_WRBURSTLEN_MASK, 7);
+			WREG32(mmPSOC_ETR_AXICTL, val);
+		}
 		WREG32(mmPSOC_ETR_DBALO,
 				lower_32_bits(input->buffer_address));
 		WREG32(mmPSOC_ETR_DBAHI,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index b9b90d079e23..b53aeda9a982 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -388,7 +388,10 @@ enum axi_id {
 #define RAZWI_INITIATOR_ID_X_Y_TPC6		RAZWI_INITIATOR_ID_X_Y(7, 6)
 #define RAZWI_INITIATOR_ID_X_Y_TPC7_NIC4_NIC5	RAZWI_INITIATOR_ID_X_Y(8, 6)
 
-#define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT                           1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT	1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK	0x1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT1_MASK	0x2
+#define PSOC_ETR_AXICTL_WRBURSTLEN_MASK		0xF00
 
 /* STLB_CACHE_INV */
 #define STLB_CACHE_INV_PRODUCER_INDEX_SHIFT                          0
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
index 067489bd048e..9ff3cb245580 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
@@ -259,6 +259,9 @@
 #define DMA_QM_3_GLBL_CFG1_DMA_STOP_SHIFT DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT
 #define DMA_QM_4_GLBL_CFG1_DMA_STOP_SHIFT DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT
 
-#define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT                           1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT	1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK	0x1
+#define PSOC_ETR_AXICTL_PROTCTRLBIT1_MASK	0x2
+#define PSOC_ETR_AXICTL_WRBURSTLEN_MASK		0xF00
 
 #endif /* ASIC_REG_GOYA_MASKS_H_ */
-- 
2.25.1

