Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920127C532
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgI2LcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:32:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbgI2L3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84D83840CDE957B3B0ED;
        Tue, 29 Sep 2020 19:29:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:33 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] ASoC: fsl: mx27vis-aic32x4: use devm_snd_soc_register_card()
Date:   Tue, 29 Sep 2020 19:29:32 +0800
Message-ID: <20200929112932.46926-1-miaoqinglang@huawei.com>
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
 sound/soc/fsl/mx27vis-aic32x4.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 4ead537e0..8d3b18973 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -176,7 +176,7 @@ static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 	mx27vis_amp_muter_gpio = pdata->amp_muter_gpio;
 
 	mx27vis_aic32x4.dev = &pdev->dev;
-	ret = snd_soc_register_card(&mx27vis_aic32x4);
+	ret = devm_snd_soc_register_card(&pdev->dev, &mx27vis_aic32x4);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -199,19 +199,11 @@ static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mx27vis_aic32x4_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&mx27vis_aic32x4);
-
-	return 0;
-}
-
 static struct platform_driver mx27vis_aic32x4_audio_driver = {
 	.driver = {
 		.name = "mx27vis",
 	},
 	.probe = mx27vis_aic32x4_probe,
-	.remove = mx27vis_aic32x4_remove,
 };
 
 module_platform_driver(mx27vis_aic32x4_audio_driver);
-- 
2.23.0

