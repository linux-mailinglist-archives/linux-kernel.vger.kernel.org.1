Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6A2AE757
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 05:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKKEPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 23:15:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58516 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgKKEPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:15:07 -0500
X-UUID: da4327da52524f578b33f17bd0f1bb1d-20201111
X-UUID: da4327da52524f578b33f17bd0f1bb1d-20201111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 649482759; Wed, 11 Nov 2020 12:15:00 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 12:14:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 12:14:58 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH] ASoC: Remove mt6359_platform_driver_remove
Date:   Wed, 11 Nov 2020 12:14:56 +0800
Message-ID: <1605068096-12587-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

remove mt6359_platform_driver_remove due to it is
useless.

Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
---
 sound/soc/codecs/mt6359.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index ecdfd57..d37dbd2 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2817,23 +2817,11 @@ static int mt6359_platform_driver_probe(struct platform_device *pdev)
 					       ARRAY_SIZE(mt6359_dai_driver));
 }
 
-static int mt6359_platform_driver_remove(struct platform_device *pdev)
-{
-	struct mt6359_priv *priv = dev_get_drvdata(&pdev->dev);
-	int ret;
-
-	dev_dbg(&pdev->dev, "%s(), dev name %s\n",
-		__func__, dev_name(&pdev->dev));
-
-	return 0;
-}
-
 static struct platform_driver mt6359_platform_driver = {
 	.driver = {
 		.name = "mt6359-sound",
 	},
 	.probe = mt6359_platform_driver_probe,
-	.remove = mt6359_platform_driver_remove,
 };
 
 module_platform_driver(mt6359_platform_driver)
-- 
1.7.9.5

