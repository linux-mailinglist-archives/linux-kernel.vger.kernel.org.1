Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E202D8E49
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436726AbgLMPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:37:28 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:18170 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405890AbgLMPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:37:27 -0500
Received: from localhost.localdomain ([93.23.12.208])
        by mwinf5d78 with ME
        id 3rbg2401A4VKWNM03rbhAU; Sun, 13 Dec 2020 16:35:43 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Dec 2020 16:35:43 +0100
X-ME-IP: 93.23.12.208
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        gokcekuler@gmail.com, romain.perier@gmail.com,
        siddhantgupta416@gmail.com, apais@linux.microsoft.com,
        blogic@openwrt.org, neil@brown.name
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: mt7621-dma: Fix a resource leak in an error handling path
Date:   Sun, 13 Dec 2020 16:35:13 +0100
Message-Id: <20201213153513.138723-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling 'mtk_hsdma_init()', it must be undone by
a corresponding call to 'mtk_hsdma_uninit()' as already done in the
remove function.

Fixes: 0853c7a53eb3 ("staging: mt7621-dma: ralink: add rt2880 dma engine")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index d241349214e7..bc4bb4374313 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -712,7 +712,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(dd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register dma device\n");
-		return ret;
+		goto err_uninit_hsdma;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -728,6 +728,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_uninit_hsdma:
+	mtk_hsdma_uninit(hsdma);
 	return ret;
 }
 
-- 
2.27.0

