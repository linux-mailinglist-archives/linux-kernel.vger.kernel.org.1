Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4527C53A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgI2LdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:33:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbgI2L3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5097DC68BBB112D265BD;
        Tue, 29 Sep 2020 19:29:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:32 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        "Shengjiu Wang" <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] ASoC: fsl: imx-mc13783: use devm_snd_soc_register_card()
Date:   Tue, 29 Sep 2020 19:29:30 +0800
Message-ID: <20200929112930.46848-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_snd_soc_register_card() can make the code
shorter and cleaner.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 sound/soc/fsl/imx-mc13783.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index dd9c1ac81..d9dca7bbc 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -96,7 +96,7 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 
 	imx_mc13783.dev = &pdev->dev;
 
-	ret = snd_soc_register_card(&imx_mc13783);
+	ret = devm_snd_soc_register_card(&pdev->dev, &imx_mc13783);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -140,19 +140,11 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_mc13783_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&imx_mc13783);
-
-	return 0;
-}
-
 static struct platform_driver imx_mc13783_audio_driver = {
 	.driver = {
 		.name = "imx_mc13783",
 	},
 	.probe = imx_mc13783_probe,
-	.remove = imx_mc13783_remove
 };
 
 module_platform_driver(imx_mc13783_audio_driver);
-- 
2.23.0

