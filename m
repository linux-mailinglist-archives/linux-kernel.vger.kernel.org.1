Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FC25678B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgH2MoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 08:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgH2MoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:44:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C061720CC7;
        Sat, 29 Aug 2020 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705047;
        bh=gAK75cVH++fnacgNSJoBEvQ1QmxjOebkEJ7pvmm4vyw=;
        h=From:To:Subject:Date:From;
        b=QwAMROvBnor/5MCjASxb+QJKliHvgMRMziQJA7O8yDvUxu4kak3ziB1fxwTu022+u
         jZ0qY0f+1/jBHwo/9lxEKlBZsoTlHn+t6REH7uNoq/fas17BXM/yBhlrWfgKYaFX1c
         UFrySahsfczfoPix0RqFgDzDNKjbu55YTzuF+axY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] extcon: max14577: Return error code of extcon_dev_allocate()
Date:   Sat, 29 Aug 2020 14:43:53 +0200
Message-Id: <20200829124356.18148-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_extcon_dev_allocate() can fail of multiple reasons.  The call
returns proper error code on failure so pass it instead of fixed ENOMEM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-max14577.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index cc47d626095c..ace523924e58 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -713,7 +713,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
 					      max14577_extcon_cable);
 	if (IS_ERR(info->edev)) {
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		return -ENOMEM;
+		return PTR_ERR(info->edev);
 	}
 
 	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
-- 
2.17.1

