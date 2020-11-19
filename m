Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3582B8BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKSGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:47:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47468 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgKSGrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:47:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D3481A197F;
        Thu, 19 Nov 2020 07:47:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1531E1A1962;
        Thu, 19 Nov 2020 07:47:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BBEB34024F;
        Thu, 19 Nov 2020 07:47:20 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_sai: Correct the clock source for mclk0
Date:   Thu, 19 Nov 2020 14:40:38 +0800
Message-Id: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On VF610, mclk0 = bus_clk;
On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
On i.MX7ULP, mclk0 = bus_clk;
On i.MX8QM/8QXP, mclk0 = bus_clk;
On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;

So add variable mclk0_is_mclk1 in fsl_sai_soc_data to
distinguish these platforms.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- rename mclk0_mclk1_match to mclk0_is_mclk1
- skip MCLK0 when it is same as MCLK1 on master clock scanning

 sound/soc/fsl/fsl_sai.c | 20 ++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 3e5c1eaccd5e..f3d3d20d35d7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -359,7 +359,14 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	if (sai->is_slave_mode)
 		return 0;
 
-	for (id = 0; id < FSL_SAI_MCLK_MAX; id++) {
+	/*
+	 * There is no point in polling MCLK0 if it is identical to MCLK1.
+	 * And given that MQS use case has to use MCLK1 though two clocks
+	 * are the same, we simply skip MCLK0 and start to find from MCLK1.
+	 */
+	id = sai->soc_data->mclk0_is_mclk1 ? 1 : 0;
+
+	for (; id < FSL_SAI_MCLK_MAX; id++) {
 		clk_rate = clk_get_rate(sai->mclk_clk[id]);
 		if (!clk_rate)
 			continue;
@@ -1040,7 +1047,6 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->bus_clk = NULL;
 	}
 
-	sai->mclk_clk[0] = sai->bus_clk;
 	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
 		sprintf(tmp, "mclk%d", i);
 		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
@@ -1051,6 +1057,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (sai->soc_data->mclk0_is_mclk1)
+		sai->mclk_clk[0] = sai->mclk_clk[1];
+	else
+		sai->mclk_clk[0] = sai->bus_clk;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1165,6 +1176,7 @@ static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.mclk0_is_mclk1 = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
@@ -1172,6 +1184,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.mclk0_is_mclk1 = true,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
@@ -1179,6 +1192,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.use_edma = false,
 	.fifo_depth = 16,
 	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
@@ -1186,6 +1200,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.use_edma = false,
 	.fifo_depth = 128,
 	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
@@ -1193,6 +1208,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.use_edma = true,
 	.fifo_depth = 64,
 	.reg_offset = 0,
+	.mclk0_is_mclk1 = false,
 };
 
 static const struct of_device_id fsl_sai_ids[] = {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 4bbcd0dbe8f1..ff2619f1b214 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -219,6 +219,7 @@
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
 	bool use_edma;
+	bool mclk0_is_mclk1;
 	unsigned int fifo_depth;
 	unsigned int reg_offset;
 };
-- 
2.27.0

