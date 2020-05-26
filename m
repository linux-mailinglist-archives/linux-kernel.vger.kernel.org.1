Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3F19E0A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgDCWGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 18:06:48 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3381 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:06:48 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e87b3617b4-7d944; Sat, 04 Apr 2020 06:06:25 +0800 (CST)
X-RM-TRANSID: 2ee25e87b3617b4-7d944
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.73])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e87b35f24a-49938;
        Sat, 04 Apr 2020 06:06:25 +0800 (CST)
X-RM-TRANSID: 2ee45e87b35f24a-49938
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     narmstrong@baylibre.com, clabbe@baylibre.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v6]crypto: amlogic - Delete duplicate dev_err in meson_crypto_probe()
Date:   Sat,  4 Apr 2020 06:07:54 +0800
Message-Id: <20200403220754.7856-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When something goes wrong, platform_get_irq() will print an error message,
so in order to avoid the situation of repeat output，we should remove
dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v5
 - modify the commit message.

Changes from v4:
 - rewrite the code, because the code in v4 is wrong, sorry.

Changes form v3:
 - fix the theme writing error.

Changes from v2:
 - modify the theme format and content description.
 - reformat the patch, it's the wrong way to resubmit a new patch that
   should be modified on top of the original. The original piece is:
   https://lore.kernel.org/patchwork/patch/1219611/

Changes from v1:
 - the title has changed, because the description is not very detailed.
 - the code has been modified, because it needs to match the theme.

 drivers/crypto/amlogic/amlogic-gxl-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 9d4ead2f7..411857fad 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -253,10 +253,8 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	mc->irqs = devm_kcalloc(mc->dev, MAXFLOW, sizeof(int), GFP_KERNEL);
 	for (i = 0; i < MAXFLOW; i++) {
 		mc->irqs[i] = platform_get_irq(pdev, i);
-		if (mc->irqs[i] < 0) {
-			dev_err(mc->dev, "Cannot get IRQ for flow %d\n", i);
+		if (mc->irqs[i] < 0)
 			return mc->irqs[i];
-		}
 
 		err = devm_request_irq(&pdev->dev, mc->irqs[i], meson_irq_handler, 0,
 				       "gxl-crypto", mc);
-- 
2.20.1.windows.1



