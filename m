Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A925678E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgH2Mof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 08:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgH2MoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:44:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B052100A;
        Sat, 29 Aug 2020 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705050;
        bh=hFhp+uizbEAFtBnNMT6EokoqlaFF1omTuhXavhv/ZsA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RWKq27Xbf2Z6TfXr0KuFgwSkgQ99pY5H2+xrrkemPEfrvTpCs1q48bx+cuQ1ilASt
         b+8SlP5vMCqtq9FCpRj9l6ykpwwd1XHi1D4NhfXPaONx6ez7HvWUv7FSr/z4UToau2
         yrDxBiXDjLtTV9VlJbHsRA4Fly39v2M2XAmtdiD0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] extcon: max77843: Return error code of extcon_dev_allocate()
Date:   Sat, 29 Aug 2020 14:43:55 +0200
Message-Id: <20200829124356.18148-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829124356.18148-1-krzk@kernel.org>
References: <20200829124356.18148-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_extcon_dev_allocate() can fail of multiple reasons.  The call
returns proper error code on failure so pass it instead of fixed ENOMEM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-max77843.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index e6b50ca83008..8e6e97ec65a8 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -845,7 +845,7 @@ static int max77843_muic_probe(struct platform_device *pdev)
 			max77843_extcon_cable);
 	if (IS_ERR(info->edev)) {
 		dev_err(&pdev->dev, "Failed to allocate memory for extcon\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(info->edev);
 		goto err_muic_irq;
 	}
 
-- 
2.17.1

