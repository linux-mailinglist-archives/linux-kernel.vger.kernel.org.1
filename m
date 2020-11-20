Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CB2BB05F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgKTQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbgKTQWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:08 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942EF223BE;
        Fri, 20 Nov 2020 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889327;
        bh=6qUhf2df6YHu083uuIrpaf14GKeZQqyELwqjl3Hr81k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cViIjeTFMJYkCOMT/xAcPv2RziinrswH6Rhfugqj0huDiZaU3Fz49Xds9xB19xHIK
         fNbEeufSRsMSzs3L2IMCj5Fb6znhuRn0n/xNTSAOnXAKHtTiKg7CBqTLaN1mEcZBvS
         B0gde80tQCWJMmAbtXzOR6RTV7vYNRSZ6F4/S7Zc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/16] mfd: mt6397: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:27 +0100
Message-Id: <20201120162133.472938-10-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  drivers/mfd/mt6397-core.c:214:34: warning: ‘mt6397_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/mt6397-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index f6cd8a660602..7518d74c3b4c 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -237,7 +237,7 @@ static struct platform_driver mt6397_driver = {
 	.probe = mt6397_probe,
 	.driver = {
 		.name = "mt6397",
-		.of_match_table = of_match_ptr(mt6397_of_match),
+		.of_match_table = mt6397_of_match,
 	},
 	.id_table = mt6397_id,
 };
-- 
2.25.1

