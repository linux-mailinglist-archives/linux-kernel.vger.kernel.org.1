Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988601FA92F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 08:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgFPGxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 02:53:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36360 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPGxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:53:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A90C0200460;
        Tue, 16 Jun 2020 08:53:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37E1A200470;
        Tue, 16 Jun 2020 08:53:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7BC6840310;
        Tue, 16 Jun 2020 14:53:39 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
Date:   Tue, 16 Jun 2020 14:42:41 +0800
Message-Id: <1592289761-29118-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
References: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one difference on imx6sx platform is that the root clock
is shared with ASRC module, so we add a new flags "ind_root_clk"
which means the root clock is independent, then we will not
do the clk_set_rate and clk_round_rate to avoid impact ASRC
module usage.

As add a new flags, we include the soc specific data struct.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 43 +++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1b2e516f9162..00e06803d32f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -42,6 +42,17 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
 
 #define DEFAULT_RXCLK_SRC	1
 
+/**
+ * struct fsl_spdif_soc_data: soc specific data
+ *
+ * @imx: for imx platform
+ * @ind_root_clk: flag for round clk rate
+ */
+struct fsl_spdif_soc_data {
+	bool imx;
+	bool ind_root_clk;
+};
+
 /*
  * SPDIF control structure
  * Defines channel status, subcode and Q sub
@@ -93,6 +104,7 @@ struct fsl_spdif_priv {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct platform_device *pdev;
 	struct regmap *regmap;
+	const struct fsl_spdif_soc_data *soc;
 	bool dpll_locked;
 	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
@@ -110,6 +122,21 @@ struct fsl_spdif_priv {
 	u32 regcache_srpc;
 };
 
+static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
+	.imx = false,
+	.ind_root_clk = true,
+};
+
+static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
+	.imx = true,
+	.ind_root_clk = true,
+};
+
+static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
+	.imx = true,
+	.ind_root_clk = false,
+};
+
 /* DPLL locked and lock loss interrupt handler */
 static void spdif_irq_dpll_lock(struct fsl_spdif_priv *spdif_priv)
 {
@@ -421,7 +448,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	sysclk_df = spdif_priv->sysclk_df[rate];
 
 	/* Don't mess up the clocks from other modules */
-	if (clk != STC_TXCLK_SPDIF_ROOT)
+	if (clk != STC_TXCLK_SPDIF_ROOT || !spdif_priv->soc->ind_root_clk)
 		goto clk_set_bypass;
 
 	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
@@ -1186,7 +1213,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			continue;
 
 		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
-					     i == STC_TXCLK_SPDIF_ROOT);
+					     i == STC_TXCLK_SPDIF_ROOT &&
+					     spdif_priv->soc->ind_root_clk);
 		if (savesub == ret)
 			continue;
 
@@ -1230,6 +1258,12 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	spdif_priv->pdev = pdev;
 
+	spdif_priv->soc = of_device_get_match_data(&pdev->dev);
+	if (!spdif_priv->soc) {
+		dev_err(&pdev->dev, "failed to get soc data\n");
+		return -ENODEV;
+	}
+
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
 	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
@@ -1359,8 +1393,9 @@ static const struct dev_pm_ops fsl_spdif_pm = {
 };
 
 static const struct of_device_id fsl_spdif_dt_ids[] = {
-	{ .compatible = "fsl,imx35-spdif", },
-	{ .compatible = "fsl,vf610-spdif", },
+	{ .compatible = "fsl,imx35-spdif", .data = &fsl_spdif_imx35, },
+	{ .compatible = "fsl,vf610-spdif", .data = &fsl_spdif_vf610, },
+	{ .compatible = "fsl,imx6sx-spdif", .data = &fsl_spdif_imx6sx, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
-- 
2.21.0

