Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709C26C217
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgIPLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 07:24:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgIPKec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:34:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CC0B2004DA;
        Wed, 16 Sep 2020 12:23:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 873DA200036;
        Wed, 16 Sep 2020 12:23:25 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EFF6F4030D;
        Wed, 16 Sep 2020 12:23:19 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: fsl_sai: Set MCLK input or output direction
Date:   Wed, 16 Sep 2020 18:16:27 +0800
Message-Id: <1600251387-1863-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI support select MCLK direction with version.major > 3
and version.minor > 1, the default direction is input,
set it to be output according to DT property.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 738b4dda7847..5117c1cd5682 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1117,6 +1117,13 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(&pdev->dev, "Error reading SAI version: %d\n", ret);
 
+	/* Select MCLK direction */
+	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
+	    sai->verid.major >= 3 && sai->verid.minor >= 1) {
+		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
+				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	regcache_cache_only(sai->regmap, true);
 
-- 
2.27.0

