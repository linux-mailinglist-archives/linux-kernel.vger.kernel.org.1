Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4C27C536
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgI2Lce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:32:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729468AbgI2L3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D37D95A0F9160BD62D2;
        Tue, 29 Sep 2020 19:29:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:39 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] ASoC: tegra: tegra_wm8753: use devm_snd_soc_register_card()
Date:   Tue, 29 Sep 2020 19:29:38 +0800
Message-ID: <20200929112938.47599-1-miaoqinglang@huawei.com>
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
 sound/soc/tegra/tegra_wm8753.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index ec3ee0580..fa41fa366 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -155,7 +155,7 @@ static int tegra_wm8753_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -165,15 +165,6 @@ static int tegra_wm8753_driver_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_wm8753_driver_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static const struct of_device_id tegra_wm8753_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-wm8753", },
 	{},
@@ -186,7 +177,6 @@ static struct platform_driver tegra_wm8753_driver = {
 		.of_match_table = tegra_wm8753_of_match,
 	},
 	.probe = tegra_wm8753_driver_probe,
-	.remove = tegra_wm8753_driver_remove,
 };
 module_platform_driver(tegra_wm8753_driver);
 
-- 
2.23.0

