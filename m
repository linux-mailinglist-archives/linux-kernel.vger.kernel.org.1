Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC327CBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgI2Mad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:30:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729135AbgI2L3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA783C771E4471C79FAD;
        Tue, 29 Sep 2020 19:29:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] ASoC: soc-core: use devm_snd_soc_register_card()
Date:   Tue, 29 Sep 2020 19:29:33 +0800
Message-ID: <20200929112933.46977-1-miaoqinglang@huawei.com>
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
 sound/soc/soc-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 74df22486..ea3986a46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1994,16 +1994,7 @@ static int soc_probe(struct platform_device *pdev)
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
 
-	return snd_soc_register_card(card);
-}
-
-/* removes a socdev */
-static int soc_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 int snd_soc_poweroff(struct device *dev)
@@ -2047,7 +2038,6 @@ static struct platform_driver soc_driver = {
 		.pm		= &snd_soc_pm_ops,
 	},
 	.probe		= soc_probe,
-	.remove		= soc_remove,
 };
 
 /**
-- 
2.23.0

