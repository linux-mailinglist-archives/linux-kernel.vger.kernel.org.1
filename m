Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70EC255D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgH1PNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 11:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgH1PNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:13:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E07C208C9;
        Fri, 28 Aug 2020 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598627621;
        bh=rPCsaXfaJ8tMmGrgiB0WKcJSn4iPxStyfSWM6ySl1p8=;
        h=From:To:Cc:Subject:Date:From;
        b=DARVhXa3li9phBOgNWUfeg2fCJMjVpOKbCCZHgwV2fOGVIPW8647779WTR2CHgE/Y
         DPvV5Xh8Li+GlNAFkCfFUdRey9SyxEM3YKYo873lsc8zrjRQSxFhOkXd70RT29B9dg
         TsX74lPyiwxdZ5YVPsy5nEdXfibiMOHZkgXxgmUs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] extcon: palmas: Simplify with dev_err_probe()
Date:   Fri, 28 Aug 2020 17:13:37 +0200
Message-Id: <20200828151337.6748-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-palmas.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index e8e9eebe6b1d..a2852bcc5f0d 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -205,21 +205,15 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 	palmas_usb->id_gpiod = devm_gpiod_get_optional(&pdev->dev, "id",
 							GPIOD_IN);
-	if (PTR_ERR(palmas_usb->id_gpiod) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (IS_ERR(palmas_usb->id_gpiod)) {
-		dev_err(&pdev->dev, "failed to get id gpio\n");
-		return PTR_ERR(palmas_usb->id_gpiod);
-	}
+	if (IS_ERR(palmas_usb->id_gpiod))
+		return dev_err_probe(&pdev->dev, PTR_ERR(palmas_usb->id_gpiod),
+				     "failed to get id gpio\n");
 
 	palmas_usb->vbus_gpiod = devm_gpiod_get_optional(&pdev->dev, "vbus",
 							GPIOD_IN);
-	if (PTR_ERR(palmas_usb->vbus_gpiod) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (IS_ERR(palmas_usb->vbus_gpiod)) {
-		dev_err(&pdev->dev, "failed to get vbus gpio\n");
-		return PTR_ERR(palmas_usb->vbus_gpiod);
-	}
+	if (IS_ERR(palmas_usb->vbus_gpiod))
+		return dev_err_probe(&pdev->dev, PTR_ERR(palmas_usb->vbus_gpiod),
+				     "failed to get id gpio\n");
 
 	if (palmas_usb->enable_id_detection && palmas_usb->id_gpiod) {
 		palmas_usb->enable_id_detection = false;
-- 
2.17.1

