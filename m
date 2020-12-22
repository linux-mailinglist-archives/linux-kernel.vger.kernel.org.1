Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD712DEDC3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLSHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 02:54:02 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:54478 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgLSHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:54:02 -0500
Received: from localhost.localdomain ([93.23.13.5])
        by mwinf5d69 with ME
        id 67s52400A06YL0V037s6Eo; Sat, 19 Dec 2020 08:52:17 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Dec 2020 08:52:17 +0100
X-ME-IP: 93.23.13.5
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mpm@selenic.com, herbert@gondor.apana.org.au,
        zhouyanjie@wanyeetech.com, aric.pzqi@ingenic.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] hwrng: ingenic - Fix a resource leak in an error handling path
Date:   Sat, 19 Dec 2020 08:52:07 +0100
Message-Id: <20201219075207.176279-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, we should call 'clk_disable_unprepare()' to undo a
previous 'clk_prepare_enable()' call, as already done in the remove
function.

Fixes: 406346d22278 ("hwrng: ingenic - Add hardware TRNG for Ingenic X1830")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/hw_random/ingenic-trng.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 954a8411d67d..0eb80f786f4d 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -113,13 +113,17 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	ret = hwrng_register(&trng->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register hwrng\n");
-		return ret;
+		goto err_unprepare_clk;
 	}
 
 	platform_set_drvdata(pdev, trng);
 
 	dev_info(&pdev->dev, "Ingenic DTRNG driver registered\n");
 	return 0;
+
+err_unprepare_clk:
+	clk_disable_unprepare(trng->clk);
+	return ret;
 }
 
 static int ingenic_trng_remove(struct platform_device *pdev)
-- 
2.27.0

