Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB32DBF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLPKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:53:38 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35676 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgLPKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:53:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 828091A00A5;
        Wed, 16 Dec 2020 11:52:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 705491A0A5F;
        Wed, 16 Dec 2020 11:52:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E577402F3;
        Wed, 16 Dec 2020 11:52:40 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized variable ret
Date:   Wed, 16 Dec 2020 18:44:24 +0800
Message-Id: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shengjiu wang <shengjiu.wang@nxp.com>

When condition ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in))
is true, then goto fail, the uninitialized variable ret will be
returned.

Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/fsl/imx-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 2c2a76a71940..ede4a9ad1054 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -164,6 +164,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 
 	if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
 		dev_err(&pdev->dev, "Invalid HDMI DAI link\n");
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.17.1

