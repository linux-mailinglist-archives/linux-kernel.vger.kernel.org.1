Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EBE2F6823
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbhANRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhANRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:48:40 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6566C061794
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:47:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BD23B1F5CE;
        Thu, 14 Jan 2021 18:47:25 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 2/3] phy: qcom-qusb2: Add configuration for SDM660
Date:   Thu, 14 Jan 2021 18:47:17 +0100
Message-Id: <20210114174718.398638-2-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114174718.398638-1-angelogioacchino.delregno@somainline.org>
References: <20210114174718.398638-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM660 SoC uses the same configuration as MSM8996, but the
clock scheme uses a differential reference clock and none of
the SoCs in this series (630, 636 and others) have got a usable
PHY_CLK_SCHEME register in the TCSR for clk scheme detection.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 8fcfea2a8f1f..3629f60460a1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -289,6 +289,19 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
+static const struct qusb2_phy_cfg sdm660_phy_cfg = {
+	.tbl		= msm8996_init_tbl,
+	.tbl_num	= ARRAY_SIZE(msm8996_init_tbl),
+	.regs		= msm8996_regs_layout,
+
+	.has_pll_test	= true,
+	.se_clk_scheme_default = false,
+	.disable_ctrl	= (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en	 = BIT(3),
+};
+
+
 static const char * const qusb2_phy_vreg_names[] = {
 	"vdda-pll", "vdda-phy-dpdm",
 };
@@ -829,6 +842,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 	}, {
 		.compatible	= "qcom,msm8998-qusb2-phy",
 		.data		= &msm8998_phy_cfg,
+	}, {
+		.compatible	= "qcom,sdm660-qusb2-phy",
+		.data		= &sdm660_phy_cfg,
 	}, {
 		/*
 		 * Deprecated. Only here to support legacy device
-- 
2.29.2

