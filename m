Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC41D439A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEOCkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 22:40:00 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:31861 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgEOCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:39:58 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 May 2020 08:09:52 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 May 2020 08:09:35 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id 48B4A29A7; Fri, 15 May 2020 08:09:34 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v7 4/4] phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
Date:   Fri, 15 May 2020 08:09:18 +0530
Message-Id: <1589510358-3865-5-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
References: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding QMP v3 USB3 PHY support for SC7180.
Adding only usb phy reset in the list to avoid
reset of DP block.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 5942167..3504931 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1578,6 +1578,10 @@ static const char * const msm8996_usb3phy_reset_l[] = {
 	"phy", "common",
 };
 
+static const char * const sc7180_usb3phy_reset_l[] = {
+	"phy",
+};
+
 static const char * const sdm845_pciephy_reset_l[] = {
 	"phy",
 };
@@ -1791,6 +1795,37 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.is_dual_lane_phy	= true,
 };
 
+static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
+	.tx_tbl			= qmp_v3_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_tx_tbl),
+	.rx_tbl			= qmp_v3_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_rx_tbl),
+	.pcs_tbl		= qmp_v3_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_pcs_tbl),
+	.clk_list		= qmp_v3_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
+	.reset_list		= sc7180_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+};
+
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -2680,6 +2715,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
 	}, {
+		.compatible = "qcom,sc7180-qmp-usb3-phy",
+		.data = &sc7180_usb3phy_cfg,
+	}, {
 		.compatible = "qcom,sdm845-qhp-pcie-phy",
 		.data = &sdm845_qhp_pciephy_cfg,
 	}, {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

