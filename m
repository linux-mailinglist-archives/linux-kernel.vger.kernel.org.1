Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8C1A88DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 20:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503619AbgDNSOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503603AbgDNSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:13:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D77C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:13:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h26so4184005wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FePb4TXsoKh/PIB9k7N8o/xhP/C75qZkUNccU++YPbg=;
        b=qFpi1PI9DkoXaOJihAA4XzdRNxDO4fhL10MkWqPNEgUoQgWFM8UiMaufAsYNRf9bCk
         YLViRHdF5gZM8R3iwJWOwxxiDQd5nm55ndZ+62eeADCJ3zivQkkTA81XfQYsfcNFtIcj
         2ka14gJv83Mul2RRk8r1LUJUKSJ2EZ8fwNwl5HUnqU76Z0f8u7YHDwMMMXU6b1lGF161
         SunyY5ZDSnJtjCGAi3XaOpu1ic2DVNeghiLJAtTeC5HggvLX/vR1J7uiOuyQUC7Gp9Jg
         HsHv+mLgVuOokgvEF2FJ2kyD+dPs7BKwr1kDjsywdA6rasMeYLNsDdHoGa+fg3v4h5XB
         BMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FePb4TXsoKh/PIB9k7N8o/xhP/C75qZkUNccU++YPbg=;
        b=hIU1MtH425bCEWJsFYkRCJlVZAUDpZNdqIn0eqn9opEJ++ryCSL+MSFUrnUjAF0xQ8
         XXISXW1c5DPHbvY7kJWcPEQw4pRHKiYad2o+QQz02R4qsA4kOakhiFMdS7QZigkNlakH
         kmHTz7MR584A6nOAjb7YaVRbj05McP2BkDdKH9uWQZ77MhS6VEbE0pxJB3l45oc4RIul
         /un5c4Qg0dRGNeQmyFi6W2pLBbXIFnmKJG/8UO90dQ5rRCXKns96Hu902s4efyJFIJIM
         CKXfJf5r8dyPzavrkcizHHCTk54mXP2gXG1hk9dKaIrALiA8bUZz3PRrh5jRJbqDeS5I
         dKkA==
X-Gm-Message-State: AGi0PubTlLPgO2UPu/G0WCOV8eY62OwPQK07mqaAzz9xATqe1HpvKakz
        /qoa6YG6uo/VzthYWDfm/MiiQA==
X-Google-Smtp-Source: APiQypKSol0GqR/vM24wZJGNbv0ZPm4oa4MmLj13h8k2ijdNDY8ftK+2s+mE+VB9LZtC/ixJ2Ujh3g==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr24604736wrw.405.1586888036650;
        Tue, 14 Apr 2020 11:13:56 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-22.xnet.hr. [88.207.97.22])
        by smtp.googlemail.com with ESMTPSA id w12sm5387763wrk.56.2020.04.14.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:13:55 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Christian Lamparter <chunkeey@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 1/3] net: phy: mdio: add IPQ40xx MDIO driver
Date:   Tue, 14 Apr 2020 20:10:11 +0200
Message-Id: <20200414181012.114905-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver for the MDIO interface
inside of Qualcomm IPQ40xx series SoC-s.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes from v1 to v2:
* Remove magic default value
* Remove lockdep_assert_held
* Add C45 check
* Simplify the driver
* Drop device and mii_bus structs from private struct
* Use devm_mdiobus_alloc_size()

 drivers/net/phy/Kconfig        |   7 ++
 drivers/net/phy/Makefile       |   1 +
 drivers/net/phy/mdio-ipq40xx.c | 176 +++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 drivers/net/phy/mdio-ipq40xx.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3fa33d27eeba..815d52fa6080 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -157,6 +157,13 @@ config MDIO_I2C
 
 	  This is library mode.
 
+config MDIO_IPQ40XX
+	tristate "Qualcomm IPQ40xx MDIO interface"
+	depends on HAS_IOMEM && OF
+	help
+	  This driver supports the MDIO interface found in Qualcomm
+	  IPQ40xx series Soc-s.
+
 config MDIO_IPQ8064
 	tristate "Qualcomm IPQ8064 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2f5c7093a65b..36aafc6128c4 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MDIO_CAVIUM)	+= mdio-cavium.o
 obj-$(CONFIG_MDIO_GPIO)		+= mdio-gpio.o
 obj-$(CONFIG_MDIO_HISI_FEMAC)	+= mdio-hisi-femac.o
 obj-$(CONFIG_MDIO_I2C)		+= mdio-i2c.o
+obj-$(CONFIG_MDIO_IPQ40XX)	+= mdio-ipq40xx.o
 obj-$(CONFIG_MDIO_IPQ8064)	+= mdio-ipq8064.o
 obj-$(CONFIG_MDIO_MOXART)	+= mdio-moxart.o
 obj-$(CONFIG_MDIO_MSCC_MIIM)	+= mdio-mscc-miim.o
diff --git a/drivers/net/phy/mdio-ipq40xx.c b/drivers/net/phy/mdio-ipq40xx.c
new file mode 100644
index 000000000000..d8c11c621f20
--- /dev/null
+++ b/drivers/net/phy/mdio-ipq40xx.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright (c) 2015, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2020 Sartura Ltd. */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+
+#define MDIO_CTRL_0_REG		0x40
+#define MDIO_CTRL_1_REG		0x44
+#define MDIO_CTRL_2_REG		0x48
+#define MDIO_CTRL_3_REG		0x4c
+#define MDIO_CTRL_4_REG		0x50
+#define MDIO_CTRL_4_ACCESS_BUSY		BIT(16)
+#define MDIO_CTRL_4_ACCESS_START		BIT(8)
+#define MDIO_CTRL_4_ACCESS_CODE_READ		0
+#define MDIO_CTRL_4_ACCESS_CODE_WRITE	1
+
+#define IPQ40XX_MDIO_RETRY	1000
+#define IPQ40XX_MDIO_DELAY	10
+
+struct ipq40xx_mdio_data {
+	void __iomem	*membase;
+};
+
+static int ipq40xx_mdio_wait_busy(struct mii_bus *bus)
+{
+	struct ipq40xx_mdio_data *priv = bus->priv;
+	int i;
+
+	for (i = 0; i < IPQ40XX_MDIO_RETRY; i++) {
+		unsigned int busy;
+
+		busy = readl(priv->membase + MDIO_CTRL_4_REG) &
+			MDIO_CTRL_4_ACCESS_BUSY;
+		if (!busy)
+			return 0;
+
+		/* BUSY might take to be cleard by 15~20 times of loop */
+		udelay(IPQ40XX_MDIO_DELAY);
+	}
+
+	dev_err(bus->parent, "MDIO operation timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static int ipq40xx_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct ipq40xx_mdio_data *priv = bus->priv;
+	int value = 0;
+	unsigned int cmd = 0;
+
+	/* Reject clause 45 */
+	if (regnum & MII_ADDR_C45)
+		return -EOPNOTSUPP;
+
+	if (ipq40xx_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
+
+	/* issue the phy address and reg */
+	writel((mii_id << 8) | regnum, priv->membase + MDIO_CTRL_1_REG);
+
+	cmd = MDIO_CTRL_4_ACCESS_START | MDIO_CTRL_4_ACCESS_CODE_READ;
+
+	/* issue read command */
+	writel(cmd, priv->membase + MDIO_CTRL_4_REG);
+
+	/* Wait read complete */
+	if (ipq40xx_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
+
+	/* Read data */
+	value = readl(priv->membase + MDIO_CTRL_3_REG);
+
+	return value;
+}
+
+static int ipq40xx_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
+							 u16 value)
+{
+	struct ipq40xx_mdio_data *priv = bus->priv;
+	unsigned int cmd = 0;
+
+	/* Reject clause 45 */
+	if (regnum & MII_ADDR_C45)
+		return -EOPNOTSUPP;
+
+	if (ipq40xx_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
+
+	/* issue the phy address and reg */
+	writel((mii_id << 8) | regnum, priv->membase + MDIO_CTRL_1_REG);
+
+	/* issue write data */
+	writel(value, priv->membase + MDIO_CTRL_2_REG);
+
+	cmd = MDIO_CTRL_4_ACCESS_START | MDIO_CTRL_4_ACCESS_CODE_WRITE;
+	/* issue write command */
+	writel(cmd, priv->membase + MDIO_CTRL_4_REG);
+
+	/* Wait write complete */
+	if (ipq40xx_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ipq40xx_mdio_probe(struct platform_device *pdev)
+{
+	struct ipq40xx_mdio_data *priv;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+
+	priv->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->membase))
+		return PTR_ERR(priv->membase);
+
+	bus->name = "ipq40xx_mdio";
+	bus->read = ipq40xx_mdio_read;
+	bus->write = ipq40xx_mdio_write;
+	bus->parent = &pdev->dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s%d", pdev->name, pdev->id);
+
+	ret = of_mdiobus_register(bus, pdev->dev.of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot register MDIO bus!\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, bus);
+
+	return 0;
+}
+
+static int ipq40xx_mdio_remove(struct platform_device *pdev)
+{
+	struct mii_bus *bus = platform_get_drvdata(pdev);
+
+	mdiobus_unregister(bus);
+
+	return 0;
+}
+
+static const struct of_device_id ipq40xx_mdio_dt_ids[] = {
+	{ .compatible = "qcom,ipq40xx-mdio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ipq40xx_mdio_dt_ids);
+
+static struct platform_driver ipq40xx_mdio_driver = {
+	.probe = ipq40xx_mdio_probe,
+	.remove = ipq40xx_mdio_remove,
+	.driver = {
+		.name = "ipq40xx-mdio",
+		.of_match_table = ipq40xx_mdio_dt_ids,
+	},
+};
+
+module_platform_driver(ipq40xx_mdio_driver);
+
+MODULE_DESCRIPTION("IPQ40XX MDIO interface driver");
+MODULE_AUTHOR("Qualcomm Atheros");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.26.0

