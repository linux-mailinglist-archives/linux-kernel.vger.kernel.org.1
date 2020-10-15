Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BE28ECB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgJOFdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:33:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48898 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgJOFds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:33:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EF5E6200557;
        Thu, 15 Oct 2020 07:33:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAE992006C9;
        Thu, 15 Oct 2020 07:33:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8B10440327;
        Thu, 15 Oct 2020 07:33:34 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_spdif: Add support for i.MX8QM platform
Date:   Thu, 15 Oct 2020 13:28:48 +0800
Message-Id: <1602739728-4433-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
References: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QM, there are separate interrupts for TX and RX.

As the EDMA can't be configured to swing back to first FIFO
after writing the second FIFO, so we need to force the burst
size to be 2 on i.MX8QM. And EDMA don't support to shift
the data from S24_LE to S16_LE, so the supported TX format
is also different on i.MX8QM.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 57 ++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index f41496cf5b63..5fa178f3f497 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -49,10 +49,18 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
  * @imx: for imx platform
  * @shared_root_clock: flag of sharing a clock source with others;
  *                     so the driver shouldn't set root clock rate
+ * @interrupts: interrupt number
+ * @tx_burst: tx maxburst size
+ * @rx_burst: rx maxburst size
+ * @tx_formats: tx supported data format
  */
 struct fsl_spdif_soc_data {
 	bool imx;
 	bool shared_root_clock;
+	u32 interrupts;
+	u32 tx_burst;
+	u32 rx_burst;
+	u64 tx_formats;
 };
 
 /*
@@ -128,16 +136,38 @@ struct fsl_spdif_priv {
 static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
 	.imx = false,
 	.shared_root_clock = false,
+	.interrupts = 1,
+	.tx_burst = FSL_SPDIF_TXFIFO_WML,
+	.rx_burst = FSL_SPDIF_RXFIFO_WML,
+	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
 static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
 	.imx = true,
 	.shared_root_clock = false,
+	.interrupts = 1,
+	.tx_burst = FSL_SPDIF_TXFIFO_WML,
+	.rx_burst = FSL_SPDIF_RXFIFO_WML,
+	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
 static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
 	.imx = true,
 	.shared_root_clock = true,
+	.interrupts = 1,
+	.tx_burst = FSL_SPDIF_TXFIFO_WML,
+	.rx_burst = FSL_SPDIF_RXFIFO_WML,
+	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
+
+};
+
+static struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
+	.imx = true,
+	.shared_root_clock = true,
+	.interrupts = 2,
+	.tx_burst = 2,		/* Applied for EDMA */
+	.rx_burst = 2,		/* Applied for EDMA */
+	.tx_formats = SNDRV_PCM_FMTBIT_S24_LE,  /* Applied for EDMA */
 };
 
 /* Check if clk is a root clock that does not share clock source with others */
@@ -1283,6 +1313,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
 	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
+	spdif_priv->cpu_dai_drv.playback.formats =
+				spdif_priv->soc->tx_formats;
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1297,15 +1329,19 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif_priv->regmap);
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	for (i = 0; i < spdif_priv->soc->interrupts; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+			return irq;
+		}
 
-	ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
-			       dev_name(&pdev->dev), spdif_priv);
-	if (ret) {
-		dev_err(&pdev->dev, "could not claim irq %u\n", irq);
-		return ret;
+		ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
+				       dev_name(&pdev->dev), spdif_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "could not claim irq %u\n", irq);
+			return ret;
+		}
 	}
 
 	/* Get system clock for rx clock rate calculation */
@@ -1354,8 +1390,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	spdif_priv->dpll_locked = false;
 
-	spdif_priv->dma_params_tx.maxburst = FSL_SPDIF_TXFIFO_WML;
-	spdif_priv->dma_params_rx.maxburst = FSL_SPDIF_RXFIFO_WML;
+	spdif_priv->dma_params_tx.maxburst = spdif_priv->soc->tx_burst;
+	spdif_priv->dma_params_rx.maxburst = spdif_priv->soc->rx_burst;
 	spdif_priv->dma_params_tx.addr = res->start + REG_SPDIF_STL;
 	spdif_priv->dma_params_rx.addr = res->start + REG_SPDIF_SRL;
 
@@ -1468,6 +1504,7 @@ static const struct of_device_id fsl_spdif_dt_ids[] = {
 	{ .compatible = "fsl,imx35-spdif", .data = &fsl_spdif_imx35, },
 	{ .compatible = "fsl,vf610-spdif", .data = &fsl_spdif_vf610, },
 	{ .compatible = "fsl,imx6sx-spdif", .data = &fsl_spdif_imx6sx, },
+	{ .compatible = "fsl,imx8qm-spdif", .data = &fsl_spdif_imx8qm, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
-- 
2.27.0

