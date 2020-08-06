Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5109C23D7A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHFHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 03:44:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36600 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgHFHob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:44:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FCC41A08EB;
        Thu,  6 Aug 2020 09:44:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB7F81A0901;
        Thu,  6 Aug 2020 09:44:24 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D574D402D0;
        Thu,  6 Aug 2020 09:44:18 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: Get "extal" clock rate by clk_get_rate
Date:   Thu,  6 Aug 2020 15:39:45 +0800
Message-Id: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
with the mclk of codec, then the clock rate is also different.
So it is better to get clock rate of "extal" rate by clk_get_rate,
don't reuse the clock rate of mclk.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 52adedc03245..2c92a5efad61 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -696,6 +696,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 			goto asrc_fail;
 		}
 	} else if (of_node_name_eq(cpu_np, "esai")) {
+		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
+
+		if (!IS_ERR(esai_clk)) {
+			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
+			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
+			clk_put(esai_clk);
+		}
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
 		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
 	} else if (of_node_name_eq(cpu_np, "sai")) {
-- 
2.27.0

