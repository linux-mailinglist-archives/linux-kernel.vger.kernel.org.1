Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA672F97AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbhARCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:11:22 -0500
Received: from foss.arm.com ([217.140.110.172]:48688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbhARCLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:11:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7252F1424;
        Sun, 17 Jan 2021 18:09:48 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73AD63F719;
        Sun, 17 Jan 2021 18:09:46 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 09/21] mfd: axp20x: Allow AXP chips without interrupt lines
Date:   Mon, 18 Jan 2021 02:08:36 +0000
Message-Id: <20210118020848.11721-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210118020848.11721-1-andre.przywara@arm.com>
References: <20210118020848.11721-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the AXP chip requires to have its IRQ line connected to some
interrupt controller, and will fail probing when this is not the case.

On a new Allwinner SoC (H616) there is no NMI pin anymore, so the
interrupt functionality of the AXP chip is simply not available.

Check whether the DT describes the AXP chip as an interrupt controller
before trying to register the irqchip, to avoid probe failures on
setups without an interrupt.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index aa59496e4376..a52595c49d40 100644
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
+	if (!axp20x->dev->of_node ||
+	    of_property_read_bool(axp20x->dev->of_node, "interrupt-controller")) {
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

