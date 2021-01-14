Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420812F61BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbhANNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:17:17 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:20489 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbhANNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:17:16 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10EDB1Sa082209;
        Thu, 14 Jan 2021 21:11:01 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 21:16:03 +0800
From:   "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linus.walleij@linaro.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     <BMC-SW@aspeedtech.com>, <haiyue.wang@linux.intel.com>,
        <cyrilbur@gmail.com>, <rlippert@google.com>
Subject: [PATCH v5 4/5] pinctrl: aspeed-g5: Adapt to new LPC device tree layout
Date:   Thu, 14 Jan 2021 21:16:21 +0800
Message-ID: <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10EDB1Sa082209
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check against LPC device v2 compatible string to
ensure that the fixed device tree layout is adopted.
The LPC register offsets are also fixed accordingly.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 0cab4c2576e2..996ebcba4d38 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -60,7 +60,7 @@
 #define COND2		{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 0, 0 }
 
 /* LHCR0 is offset from the end of the H8S/2168-compatible registers */
-#define LHCR0		0x20
+#define LHCR0		0xa0
 #define GFX064		0x64
 
 #define B14 0
@@ -2648,14 +2648,19 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
 	}
 
 	if (ip == ASPEED_IP_LPC) {
-		struct device_node *node;
+		struct device_node *np;
 		struct regmap *map;
 
-		node = of_parse_phandle(ctx->dev->of_node,
+		np = of_parse_phandle(ctx->dev->of_node,
 					"aspeed,external-nodes", 1);
-		if (node) {
-			map = syscon_node_to_regmap(node->parent);
-			of_node_put(node);
+		if (np) {
+			if (!of_device_is_compatible(np->parent, "aspeed,ast2400-lpc-v2") &&
+			    !of_device_is_compatible(np->parent, "aspeed,ast2500-lpc-v2") &&
+			    !of_device_is_compatible(np->parent, "aspeed,ast2600-lpc-v2"))
+				return ERR_PTR(-ENODEV);
+
+			map = syscon_node_to_regmap(np->parent);
+			of_node_put(np);
 			if (IS_ERR(map))
 				return map;
 		} else
-- 
2.17.1

