Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54FC23C376
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHEC2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 22:28:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57712 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHEC2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:28:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D53E11A1465;
        Wed,  5 Aug 2020 04:28:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3252D1A04CF;
        Wed,  5 Aug 2020 04:28:31 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 472EA402CF;
        Wed,  5 Aug 2020 04:28:25 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: fsl_sai: Clean code for synchronous mode
Date:   Wed,  5 Aug 2020 10:23:52 +0800
Message-Id: <1596594233-13489-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tx synchronous with Rx: The RMR is the word mask register, it is used
to mask any word in the frame, it is not relating to clock generation,
So it is no need to be changed when Tx is going to be enabled.

Rx synchronous with Tx: The TMR is the word mask register, it is used
to mask any word in the frame, it is not relating to clock generation,
So it is no need to be changed when Rx is going to be enabled.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index cdff739924e2..84714fe7144c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -470,8 +470,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
 	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
-	 * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
-	 * error.
+	 * RCR5(TCR5) for playback(capture), or there will be sync error.
 	 */
 
 	if (!sai->is_slave_mode) {
@@ -482,8 +481,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 			regmap_update_bits(sai->regmap, FSL_SAI_TCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 				FSL_SAI_CR5_FBT_MASK, val_cr5);
-			regmap_write(sai->regmap, FSL_SAI_TMR,
-				~0UL - ((1 << channels) - 1));
 		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR4(ofs),
 				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
@@ -491,8 +488,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 				FSL_SAI_CR5_FBT_MASK, val_cr5);
-			regmap_write(sai->regmap, FSL_SAI_RMR,
-				~0UL - ((1 << channels) - 1));
 		}
 	}
 
-- 
2.27.0

