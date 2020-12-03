Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6E2CDCA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgLCRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLCRqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:46:53 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 2/3] habanalabs: fetch PSOC PLL frequency from F/W in goya
Date:   Thu,  3 Dec 2020 19:46:04 +0200
Message-Id: <20201203174605.31530-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203174605.31530-1-ogabbay@kernel.org>
References: <20201203174605.31530-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

When the F/W security is enabled, goya needs to fetch the PSOC pll
frequency through a dedicated interface

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 61 ++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3e5eb9e3d7bd..b66fd55accb5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -694,32 +694,47 @@ static void goya_qman0_set_security(struct hl_device *hdev, bool secure)
 static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 trace_freq = 0;
-	u32 pll_clk = 0;
-	u32 div_fctr = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
-	u32 div_sel = RREG32(mmPSOC_PCI_PLL_DIV_SEL_1);
-	u32 nr = RREG32(mmPSOC_PCI_PLL_NR);
-	u32 nf = RREG32(mmPSOC_PCI_PLL_NF);
-	u32 od = RREG32(mmPSOC_PCI_PLL_OD);
-
-	if (div_sel == DIV_SEL_REF_CLK || div_sel == DIV_SEL_DIVIDED_REF) {
-		if (div_sel == DIV_SEL_REF_CLK)
-			trace_freq = PLL_REF_CLK;
-		else
-			trace_freq = PLL_REF_CLK / (div_fctr + 1);
-	} else if (div_sel == DIV_SEL_PLL_CLK ||
-					div_sel == DIV_SEL_DIVIDED_PLL) {
-		pll_clk = PLL_REF_CLK * (nf + 1) / ((nr + 1) * (od + 1));
-		if (div_sel == DIV_SEL_PLL_CLK)
-			trace_freq = pll_clk;
-		else
-			trace_freq = pll_clk / (div_fctr + 1);
+	u32 nr = 0, nf = 0, od = 0, div_fctr = 0, pll_clk, div_sel;
+	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS], freq;
+	int rc;
+
+	if (hdev->asic_prop.fw_security_disabled) {
+		div_fctr = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
+		div_sel = RREG32(mmPSOC_PCI_PLL_DIV_SEL_1);
+		nr = RREG32(mmPSOC_PCI_PLL_NR);
+		nf = RREG32(mmPSOC_PCI_PLL_NF);
+		od = RREG32(mmPSOC_PCI_PLL_OD);
+
+		if (div_sel == DIV_SEL_REF_CLK ||
+				div_sel == DIV_SEL_DIVIDED_REF) {
+			if (div_sel == DIV_SEL_REF_CLK)
+				freq = PLL_REF_CLK;
+			else
+				freq = PLL_REF_CLK / (div_fctr + 1);
+		} else if (div_sel == DIV_SEL_PLL_CLK ||
+				div_sel == DIV_SEL_DIVIDED_PLL) {
+			pll_clk = PLL_REF_CLK * (nf + 1) /
+					((nr + 1) * (od + 1));
+			if (div_sel == DIV_SEL_PLL_CLK)
+				freq = pll_clk;
+			else
+				freq = pll_clk / (div_fctr + 1);
+		} else {
+			dev_warn(hdev->dev,
+				"Received invalid div select value: %d",
+				div_sel);
+			freq = 0;
+		}
 	} else {
-		dev_warn(hdev->dev,
-			"Received invalid div select value: %d", div_sel);
+		rc = hl_fw_cpucp_pll_info_get(hdev, PCI_PLL, pll_freq_arr);
+
+		if (rc)
+			return;
+
+		freq = pll_freq_arr[1];
 	}
 
-	prop->psoc_timestamp_frequency = trace_freq;
+	prop->psoc_timestamp_frequency = freq;
 	prop->psoc_pci_pll_nr = nr;
 	prop->psoc_pci_pll_nf = nf;
 	prop->psoc_pci_pll_od = od;
-- 
2.17.1

