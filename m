Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CC26FA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:32:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40790 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:32:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EEFE7201194;
        Fri, 18 Sep 2020 12:32:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B6DE2014E3;
        Fri, 18 Sep 2020 12:32:50 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A982F402AE;
        Fri, 18 Sep 2020 12:32:44 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Instantiate snd_soc_dai_driver
Date:   Fri, 18 Sep 2020 18:26:00 +0800
Message-Id: <1600424760-32071-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate snd_soc_dai_driver for independent symmetric control.
Otherwise the symmetric setting may be overwritten by other
instance.

Fixes: 08fdf65e37d5 ("ASoC: fsl_sai: Add asynchronous mode support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 19 +++++++++++--------
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5117c1cd5682..3e5c1eaccd5e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -725,7 +725,7 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
-static struct snd_soc_dai_driver fsl_sai_dai = {
+static struct snd_soc_dai_driver fsl_sai_dai_template = {
 	.probe = fsl_sai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
@@ -1062,12 +1062,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	memcpy(&sai->cpu_dai_drv, &fsl_sai_dai_template,
+	       sizeof(fsl_sai_dai_template));
+
 	/* Sync Tx with Rx as default by following old DT binding */
 	sai->synchronous[RX] = true;
 	sai->synchronous[TX] = false;
-	fsl_sai_dai.symmetric_rates = 1;
-	fsl_sai_dai.symmetric_channels = 1;
-	fsl_sai_dai.symmetric_samplebits = 1;
+	sai->cpu_dai_drv.symmetric_rates = 1;
+	sai->cpu_dai_drv.symmetric_channels = 1;
+	sai->cpu_dai_drv.symmetric_samplebits = 1;
 
 	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
 	    of_find_property(np, "fsl,sai-asynchronous", NULL)) {
@@ -1084,9 +1087,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		/* Discard all settings for asynchronous mode */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = false;
-		fsl_sai_dai.symmetric_rates = 0;
-		fsl_sai_dai.symmetric_channels = 0;
-		fsl_sai_dai.symmetric_samplebits = 0;
+		sai->cpu_dai_drv.symmetric_rates = 0;
+		sai->cpu_dai_drv.symmetric_channels = 0;
+		sai->cpu_dai_drv.symmetric_samplebits = 0;
 	}
 
 	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
@@ -1128,7 +1131,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	regcache_cache_only(sai->regmap, true);
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
-			&fsl_sai_dai, 1);
+					      &sai->cpu_dai_drv, 1);
 	if (ret)
 		goto err_pm_disable;
 
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index ba7425a9e217..4bbcd0dbe8f1 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -267,6 +267,7 @@ struct fsl_sai {
 	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct fsl_sai_verid verid;
-- 
2.27.0

