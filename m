Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580DE1A742B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406387AbgDNHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 03:05:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57340 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406330AbgDNHEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:04:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A45721A0315;
        Tue, 14 Apr 2020 09:04:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0858C1A031C;
        Tue, 14 Apr 2020 09:04:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1690D402FC;
        Tue, 14 Apr 2020 15:04:17 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/7] ASoC: fsl-asoc-card: Support new property fsl,asrc-format
Date:   Tue, 14 Apr 2020 14:56:03 +0800
Message-Id: <d345821ea8016283e1b1d80bed5fc373272f79de.1586845138.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1586845137.git.shengjiu.wang@nxp.com>
References: <cover.1586845137.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1586845137.git.shengjiu.wang@nxp.com>
References: <cover.1586845137.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to align with new ESARC, we add new property fsl,asrc-format.
The fsl,asrc-format can replace the fsl,asrc-width, driver
can accept format from devicetree, don't need to convert it to
format through width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index bb33601fab84..cf4feb835743 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -680,17 +680,23 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 			goto asrc_fail;
 		}
 
-		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
+		ret = of_property_read_u32(asrc_np, "fsl,asrc-format",
+					   &priv->asrc_format);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to get output rate\n");
-			ret = -EINVAL;
-			goto asrc_fail;
-		}
+			/* Fallback to old binding; translate to asrc_format */
+			ret = of_property_read_u32(asrc_np, "fsl,asrc-width",
+						   &width);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"failed to decide output format\n");
+				goto asrc_fail;
+			}
 
-		if (width == 24)
-			priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
-		else
-			priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
+			if (width == 24)
+				priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
+			else
+				priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
+		}
 	}
 
 	/* Finish card registering */
-- 
2.21.0

