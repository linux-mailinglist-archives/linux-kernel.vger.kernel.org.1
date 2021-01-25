Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2063031FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbhAYP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:58:15 -0500
Received: from foss.arm.com ([217.140.110.172]:49884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbhAYPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:53:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B211758;
        Mon, 25 Jan 2021 07:19:08 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF74A3F68F;
        Mon, 25 Jan 2021 07:19:06 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 06/21] mfd: axp20x: Allow AXP chips without interrupt lines
Date:   Mon, 25 Jan 2021 15:17:56 +0000
Message-Id: <20210125151811.11871-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210125151811.11871-1-andre.przywara@arm.com>
References: <20210125151811.11871-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the AXP chip requires to have its IRQ line connected to some
interrupt controller, and will fail probing when this is not the case.

On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
least one board does not connect the AXP's IRQ pin to anything else,
so the interrupt functionality of the AXP chip is simply not available.

Check whether the interrupt line number returned by the platform code is
valid, before trying to register the irqchip. If not, we skip this
registration, to avoid the driver to bail out completely.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3eae04e24ac8..00c163a1e20d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -959,12 +959,17 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 				     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
 	}
 
-	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
-			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
-			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
-	if (ret) {
-		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
-		return ret;
+	/* Only if there is an interrupt line connected towards the CPU. */
+	if (axp20x->irq > 0) {
+		ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
+				IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
+				-1, axp20x->regmap_irq_chip,
+				&axp20x->regmap_irqc);
+		if (ret) {
+			dev_err(axp20x->dev, "failed to add irq chip: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
-- 
2.17.5

