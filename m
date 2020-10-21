Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB472294CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442537AbgJUMlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:41:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54078 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440482AbgJUMk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:40:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B59622012A6;
        Wed, 21 Oct 2020 14:40:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A944E200C0A;
        Wed, 21 Oct 2020 14:40:54 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BA092039E;
        Wed, 21 Oct 2020 14:40:54 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] clk: imx8m: Use dram variant registration for dram clocks
Date:   Wed, 21 Oct 2020 15:40:43 +0300
Message-Id: <1603284043-27059-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603284043-27059-1-git-send-email-abel.vesa@nxp.com>
References: <1603284043-27059-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both dram_apb and dram_alt are controlled by EL3. Using the dram
variant registration of the composite-8m clock, the mux and the
divider will be read only. Do this for all i.MX8M platforms.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 4 ++--
 drivers/clk/imx/clk-imx8mn.c | 4 ++--
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 drivers/clk/imx/clk-imx8mq.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 0de0be0..955cac4 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -468,8 +468,8 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	 * DRAM clocks are manipulated from TF-A outside clock framework.
 	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
 	 */
-	hws[IMX8MM_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
-	hws[IMX8MM_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mm_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+	hws[IMX8MM_CLK_DRAM_ALT] = __imx8m_clk_hw_composite_dram("dram_alt", imx8mm_dram_alt_sels, base + 0xa000, 0);
+	hws[IMX8MM_CLK_DRAM_APB] = __imx8m_clk_hw_composite_dram("dram_apb", imx8mm_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL);
 
 	/* IP */
 	hws[IMX8MM_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g1_sels, base + 0xa100);
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index e984de5..7aea389 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -451,8 +451,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	 * DRAM clocks are manipulated from TF-A outside clock framework.
 	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
 	 */
-	hws[IMX8MN_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
-	hws[IMX8MN_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mn_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+	hws[IMX8MN_CLK_DRAM_ALT] = __imx8m_clk_hw_composite_dram("dram_alt", imx8mn_dram_alt_sels, base + 0xa000, 0);
+	hws[IMX8MN_CLK_DRAM_APB] = __imx8m_clk_hw_composite_dram("dram_apb", imx8mn_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL);
 
 	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
 	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 12ce477..205f9d6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -579,8 +579,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 	hws[IMX8MP_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", ccm_base + 0x9180, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = __imx8m_clk_hw_composite_dram("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000, 0);
+	hws[IMX8MP_CLK_DRAM_APB] = __imx8m_clk_hw_composite_dram("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080, CLK_IS_CRITICAL);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a06cc21..774906e9 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -458,8 +458,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
 	 */
 	hws[IMX8MQ_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
-	hws[IMX8MQ_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
-	hws[IMX8MQ_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+	hws[IMX8MQ_CLK_DRAM_ALT] = __imx8m_clk_hw_composite_dram("dram_alt", imx8mq_dram_alt_sels, base + 0xa000, 0);
+	hws[IMX8MQ_CLK_DRAM_APB] = __imx8m_clk_hw_composite_dram("dram_apb", imx8mq_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL);
 
 	/* IP */
 	hws[IMX8MQ_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
-- 
2.7.4

