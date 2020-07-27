Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA422F4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgG0QUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 12:20:42 -0400
Received: from crapouillou.net ([89.234.176.41]:44576 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgG0QUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595866840; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=5yl/jzX3HDM/iQOBIBIxcIRCGrIeyafmiFYKp0M2Wbw=;
        b=rZSJuSCGqLoVL30ZGP6iKf253gvSoU0P6KoY9WVu0BkwIT0ZrlpeUMespVWWeO8Pq4kUGS
        PV6TmP5tgbL9A6JPV6AlLz1fPgs6IuUi5XMA/xM1oj370zuCuR8Ih+Mq3qjk3wyYMaz+QL
        CqXTPeKBdED4SvC8X12icw9mbhoghIM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] memory: jz4780_nemc: Only request IO memory the driver will use
Date:   Mon, 27 Jul 2020 18:20:34 +0200
Message-Id: <20200727162034.12334-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only uses the registers up to offset 0x54. Since the EFUSE
registers are in the middle of the NEMC registers, we only request
the registers we will use for now - that way the EFUSE driver can
probe too.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/memory/jz4780-nemc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index b232ed279fc3..647267ea8c63 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -288,7 +289,19 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	nemc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nemc->base = devm_ioremap_resource(dev, res);
+
+	/*
+	 * The driver only uses the registers up to offset 0x54. Since the EFUSE
+	 * registers are in the middle of the NEMC registers, we only request
+	 * the registers we will use for now - that way the EFUSE driver can
+	 * probe too.
+	 */
+	if (!devm_request_mem_region(dev, res->start, 0x54, dev_name(dev))) {
+		dev_err(dev, "unable to request I/O memory region\n");
+		return -EBUSY;
+	}
+
+	nemc->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (IS_ERR(nemc->base)) {
 		dev_err(dev, "failed to get I/O memory\n");
 		return PTR_ERR(nemc->base);
-- 
2.27.0

