Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3D19C036
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbgDBLcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 07:32:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8814 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgDBLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:32:38 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e85cd40f51-5deb7; Thu, 02 Apr 2020 19:32:18 +0800 (CST)
X-RM-TRANSID: 2ee65e85cd40f51-5deb7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e85cd3fb73-bb11b;
        Thu, 02 Apr 2020 19:32:17 +0800 (CST)
X-RM-TRANSID: 2ee85e85cd3fb73-bb11b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     clabbe@baylibre.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] crypto:amlogic - use platform_get_irq_optional()
Date:   Thu,  2 Apr 2020 19:33:44 +0800
Message-Id: <20200402113344.16772-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simply code,because platform_get_irq() already has
dev_err() message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 9d4ead2f7..37901bd81 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -252,7 +252,7 @@ static int meson_crypto_probe(struct platform_device *pdev)
 
 	mc->irqs = devm_kcalloc(mc->dev, MAXFLOW, sizeof(int), GFP_KERNEL);
 	for (i = 0; i < MAXFLOW; i++) {
-		mc->irqs[i] = platform_get_irq(pdev, i);
+		mc->irqs[i] = platform_get_irq_optional(pdev, i);
 		if (mc->irqs[i] < 0) {
 			dev_err(mc->dev, "Cannot get IRQ for flow %d\n", i);
 			return mc->irqs[i];
-- 
2.20.1.windows.1



