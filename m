Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3272D8E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436929AbgLMPMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:12:52 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58725 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436603AbgLMPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:12:52 -0500
Received: from localhost.localdomain ([93.23.12.208])
        by mwinf5d78 with ME
        id 3rB5240064VKWNM03rB5ND; Sun, 13 Dec 2020 16:11:07 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Dec 2020 16:11:07 +0100
X-ME-IP: 93.23.12.208
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: spmi: hisi-spmi-controller: Fix some error handling paths
Date:   Sun, 13 Dec 2020 16:11:05 +0100
Message-Id: <20201213151105.137731-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IN the probe function, if an error occurs after calling
'spmi_controller_alloc()', it must be undone by a corresponding
'spmi_controller_put() call.

In the remove function, use 'spmi_controller_put(ctrl)' instead of
'kfree(ctrl)'.

While a it fix an error message
(s/spmi_add_controller/spmi_controller_add/)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 .../staging/hikey9xx/hisi-spmi-controller.c   | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 861aedd5de48..0d42bc65f39b 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -278,21 +278,24 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iores) {
 		dev_err(&pdev->dev, "can not get resource!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_controller;
 	}
 
 	spmi_controller->base = devm_ioremap(&pdev->dev, iores->start,
 					     resource_size(iores));
 	if (!spmi_controller->base) {
 		dev_err(&pdev->dev, "can not remap base addr!\n");
-		return -EADDRNOTAVAIL;
+		ret = -EADDRNOTAVAIL;
+		goto err_put_controller;
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
 				   &spmi_controller->channel);
 	if (ret) {
 		dev_err(&pdev->dev, "can not get channel\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_put_controller;
 	}
 
 	platform_set_drvdata(pdev, spmi_controller);
@@ -309,9 +312,15 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ctrl->write_cmd = spmi_write_cmd;
 
 	ret = spmi_controller_add(ctrl);
-	if (ret)
-		dev_err(&pdev->dev, "spmi_add_controller failed with error %d!\n", ret);
+	if (ret) {
+		dev_err(&pdev->dev, "spmi_controller_add failed with error %d!\n", ret);
+		goto err_put_controller;
+	}
+
+	return 0;
 
+err_put_controller:
+	spmi_controller_put(ctrl);
 	return ret;
 }
 
@@ -320,7 +329,7 @@ static int spmi_del_controller(struct platform_device *pdev)
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 
 	spmi_controller_remove(ctrl);
-	kfree(ctrl);
+	spmi_controller_put(ctrl);
 	return 0;
 }
 
-- 
2.27.0

