Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB831F3619
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgFIIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 04:30:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40416 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgFIIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:30:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 596BB1A12E4;
        Tue,  9 Jun 2020 10:30:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 305FC1A274D;
        Tue,  9 Jun 2020 10:30:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8AACC4033E;
        Tue,  9 Jun 2020 16:30:04 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Date:   Tue,  9 Jun 2020 16:19:28 +0800
Message-Id: <1591690768-1691-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For mono channel, ssi will switch to normal mode. In normal
mode, the Word Length Control bits control the word length
divider in clock generator, which is different with I2S master
mode, the word length is fixed to 32bit.

So we refine the famula for mono channel, otherwise there
will be sound issue for S24_LE.

Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bad89b0d129e..e347776590f7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -695,6 +695,11 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	/* Generate bit clock based on the slot number and slot width */
 	freq = slots * slot_width * params_rate(hw_params);
 
+	/* The slot_width is not fixed to 32 for normal mode */
+	if (params_channels(hw_params) == 1)
+		freq = (slots <= 1 ? 2 : slots) * params_width(hw_params) *
+		       params_rate(hw_params);
+
 	/* Don't apply it to any non-baudclk circumstance */
 	if (IS_ERR(ssi->baudclk))
 		return -EINVAL;
-- 
2.21.0

