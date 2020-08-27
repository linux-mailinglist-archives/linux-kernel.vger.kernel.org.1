Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8202253F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH0HdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgH0HdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:33:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6940120791;
        Thu, 27 Aug 2020 07:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513600;
        bh=X+y40DLVhGd5Us4fEJgD20QH8kLj69X1y7yxBz33ot4=;
        h=From:To:Subject:Date:From;
        b=M79NegLV/hp09KS6jnHsLXJDpGzwTAbFBEnqL8wuOIyb88R6UiTv8pFuMfUP0+BWi
         4oJaTZqB2gYDbiwU+NEltHJozveSvViGgD53BdKMQJPN6Yy9Moo5nqxoZRjo4bK4Vt
         OLb9LB6o7n16st6Ag4WqrjPs/G8L0jeuluLliYdQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Scott Wood <scottwood@freescale.com>,
        Bharat Bhushan <bharat.bhushan@freescale.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: fsl-corenet-cf: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:33:15 +0200
Message-Id: <20200827073315.29351-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 54afbec0d57f ("memory: Freescale CoreNet Coherency Fabric error reporting driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/fsl-corenet-cf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index 0b0ed72016da..0309bd5a1800 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -211,10 +211,8 @@ static int ccf_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ccf);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "%s: no irq\n", __func__);
-		return -ENXIO;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, ccf_irq, 0, pdev->name, ccf);
 	if (ret) {
-- 
2.17.1

