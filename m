Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41D2CC844
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgLBUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbgLBUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:49:18 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F06C0617A7;
        Wed,  2 Dec 2020 12:48:38 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d8so6931245lfa.1;
        Wed, 02 Dec 2020 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fME1OhigrePu/d9svQdeo1hhqzpZnre8vwvVcbb0o94=;
        b=MSEzlaHM+955Yh7zHDktUoIkJNGUF1w9l2tUvXBZiwfQ8yHpVdNoWKA09UrKHiq/b2
         UhdLqP3Vxc7b+ls10QRHN6/cBa8JPYv1/+ViwXUdkcAR33ZHkTsE9VP0LTVwShR0SjED
         HTbOVe3O1oeqykbh7/W+a2sdw5+6JJlSXQU6dDeCgVOALejt7oJJB9nwRyvAaI43Ob03
         FR0w6shkc7xfpomXL3ZG8VmuDmdchuXMnvZvLuOX0kjr8wgmDQtXzO+5c3dnyz0yOV48
         woOw1HnLqy8f4xejDmMLIKgLePYdbyZt42ZU1EUB/LC009TTdI3k/4ITQl4l+8XEHTzj
         JBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fME1OhigrePu/d9svQdeo1hhqzpZnre8vwvVcbb0o94=;
        b=cFPOsSVPL/e8RtjDAIOzGBRIvSyTPCaIgZkeNbkzodQYlGRVOV4xLXsR0WvYtAv1ta
         PwlwTj/ldIcfSzISUorwVSvfp6aoQY4YtTM8pcaI/yaFgzmY+/j3AbhPnPI0ZGzjfN9m
         IJxZJcmhNg0klEUimTT+flfCpRH7gAefEm9s1kDoMicM+1975GxU2sqKHhQItnLi4pju
         6eEHes+VvYseHHsAi83WboPqgnWXyQmsNMZtHFspDvwMCkZ5ypgjy4AwRIoaIf6HCpJL
         DuZ6+AxgvMzEpTusJLgVJQMzvksUYA6f3ITkCl+jQ1gVWPcz5uAzGuz/GDIPXtwGdJUa
         IOng==
X-Gm-Message-State: AOAM5326JTPdaGUQ5HBd4UDW8qFwHEHfA4Wocxe9W1EuzUTZ7zOhUN7d
        qIh9tC6WVQWIXjcGe3HkZAY=
X-Google-Smtp-Source: ABdhPJyehgWZsnA2xNcYT5Rck9dkNw4Jc13vo7D/PGKYJXg2/sZyH4S2Vla2dYQ4a5pYIJjQIg9zqA==
X-Received: by 2002:a19:7e16:: with SMTP id z22mr1877296lfc.73.1606942116888;
        Wed, 02 Dec 2020 12:48:36 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r66sm801503lff.265.2020.12.02.12.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:48:36 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Simon Arlott <simon@octiron.net>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] phy: phy-bcm4908-usb: Add drivers for USB PHYs
Date:   Wed,  2 Dec 2020 21:46:49 +0100
Message-Id: <20201202204649.25314-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202204649.25314-1-zajec5@gmail.com>
References: <20201202204649.25314-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This driver initializes BCM4908 USB PHYs so USB can be utilized.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/Kconfig           |   9 ++
 drivers/phy/broadcom/Makefile          |   1 +
 drivers/phy/broadcom/phy-bcm4908-usb.c | 204 +++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/phy/broadcom/phy-bcm4908-usb.c

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index a1f1a9c90d0d..ff2ca2b77f38 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -78,6 +78,15 @@ config PHY_NS2_USB_DRD
 
 	  If unsure, say N.
 
+config PHY_BCM4908_USB
+	tristate "Broadcom BCM4908 USB PHYs support"
+	depends on OF && (ARCH_BCM4908 || COMPILE_TEST)
+	select GENERIC_PHY
+	default ARCH_BCM4908
+	help
+	  Enable this to support the Broadcom BCM4908 USB 2.0 PHY and USB 3.0
+	  PHY. This driver initializes PHYs so USB can be utilized.
+
 config PHY_BRCM_SATA
 	tristate "Broadcom SATA PHY driver"
 	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || \
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index 7024127f86ad..8e6a9b748421 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_BCM_NS_USB2)		+= phy-bcm-ns-usb2.o
 obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
 obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
 obj-$(CONFIG_PHY_NS2_USB_DRD)		+= phy-bcm-ns2-usbdrd.o
+obj-$(CONFIG_PHY_BCM4908_USB)		+= phy-bcm4908-usb.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
 
diff --git a/drivers/phy/broadcom/phy-bcm4908-usb.c b/drivers/phy/broadcom/phy-bcm4908-usb.c
new file mode 100644
index 000000000000..bf3803a11710
--- /dev/null
+++ b/drivers/phy/broadcom/phy-bcm4908-usb.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013 Broadcom
+ * Copyright (C) 2020 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+
+enum bcm4908_usb_ver {
+	BCM4908_UNKNOWN,
+	BCM4908_USB_2,
+	BCM4908_USB_3,
+};
+
+struct bcm4908_usb {
+	struct mdio_device *mdiodev;
+	struct device *dev;
+	struct phy *phy;
+	enum bcm4908_usb_ver ver;
+};
+
+static int bcm4908_usb_mdio_phy_read(struct bcm4908_usb *usb, u16 reg)
+{
+	struct mdio_device *mdiodev = usb->mdiodev;
+
+	return mdiobus_read(mdiodev->bus, mdiodev->addr, reg);
+}
+
+static int bcm4908_usb_mdio_phy_write(struct bcm4908_usb *usb, u16 reg,
+				      u16 value)
+{
+	struct mdio_device *mdiodev = usb->mdiodev;
+
+	return mdiobus_write(mdiodev->bus, mdiodev->addr, reg, value);
+}
+
+static int bcm4908_usb_2_init(struct bcm4908_usb *usb)
+{
+	int err;
+
+	/* Eye fix */
+
+	err = bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x80a0);
+	if (err < 0)
+		return err;
+
+	err = bcm4908_usb_mdio_phy_write(usb, 0x0a, 0xc6a0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static void bcm4908_usb_3_ssc_enable(struct bcm4908_usb *usb)
+{
+	u32 val;
+
+	/* Enable USB 3.0 TX spread spectrum */
+	bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x8040);
+
+	val = bcm4908_usb_mdio_phy_read(usb, 0x01);
+	val |= 0x0f;
+	bcm4908_usb_mdio_phy_write(usb, 0x01, val);
+
+	bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x9040);
+
+	val = bcm4908_usb_mdio_phy_read(usb, 0x01);
+	val |= 0x0f;
+	bcm4908_usb_mdio_phy_write(usb, 0x01, val);
+}
+
+static void bcm4908_usb_3_enable_pipe_reset(struct bcm4908_usb *usb)
+{
+	u32 val;
+
+	/* Re-enable USB 3.0 pipe reset */
+	bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x8000);
+
+	val = bcm4908_usb_mdio_phy_read(usb, 0x0f);
+	val |= 0x200;
+	bcm4908_usb_mdio_phy_write(usb, 0x0f, val);
+}
+
+
+static void bcm4908_usb_3_enable_sigdet(struct bcm4908_usb *usb)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		u32 offset = i * 0x1000;
+
+		/* Set correct default for sigdet */
+		bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x8080 + offset);
+
+		val = bcm4908_usb_mdio_phy_read(usb, 0x05);
+		val = (val & ~0x800f) | 0x800d;
+		bcm4908_usb_mdio_phy_write(usb, 0x05, val);
+	}
+}
+
+
+static void bcm4908_usb_3_enable_skip_align(struct bcm4908_usb *usb)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		u32 offset = i * 0x1000;
+
+		/* Set correct default for SKIP align */
+		bcm4908_usb_mdio_phy_write(usb, 0x1f, 0x8060 + offset);
+
+		val = bcm4908_usb_mdio_phy_read(usb, 0x01);
+		val |= 0x200;
+		bcm4908_usb_mdio_phy_write(usb, 0x01, val);
+	}
+}
+
+static int bcm4908_usb_3_init(struct bcm4908_usb *usb)
+{
+	struct device *dev = usb->dev;
+
+	bcm4908_usb_3_ssc_enable(usb);
+	bcm4908_usb_3_enable_pipe_reset(usb);
+	bcm4908_usb_3_enable_sigdet(usb);
+	bcm4908_usb_3_enable_skip_align(usb);
+
+	mdelay(300);
+
+	return 0;
+}
+
+static int bcm4908_usb_init(struct phy *phy)
+{
+	struct bcm4908_usb *usb = phy_get_drvdata(phy);
+
+	switch (usb->ver) {
+	case BCM4908_USB_2:
+		return bcm4908_usb_2_init(usb);
+	case BCM4908_USB_3:
+		return bcm4908_usb_3_init(usb);
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
+static const struct phy_ops bcm4908_usb_phy_ops = {
+	.init		= bcm4908_usb_init,
+	.owner		= THIS_MODULE,
+};
+
+static int bcm4908_usb_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct phy_provider *phy_provider;
+	struct bcm4908_usb *usb;
+
+	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
+	if (!usb)
+		return -ENOMEM;
+
+	usb->dev = dev;
+	usb->mdiodev = mdiodev;
+	usb->ver = (uintptr_t)of_device_get_match_data(dev);
+
+	usb->phy = devm_phy_create(dev, NULL, &bcm4908_usb_phy_ops);
+	if (IS_ERR(usb->phy)) {
+		dev_err(dev, "Failed to create PHY\n");
+		return PTR_ERR(usb->phy);
+	}
+
+	phy_set_drvdata(usb->phy, usb);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id bcm4908_usb_id_table[] = {
+	{ .compatible = "brcm,bcm4908-usb2-phy", .data = (void *)BCM4908_USB_2 },
+	{ .compatible = "brcm,bcm4908-usb3-phy", .data = (void *)BCM4908_USB_3 },
+	{},
+};
+
+static struct mdio_driver bcm4908_usb_mdio_driver = {
+	.mdiodrv = {
+		.driver = {
+			.name = "bcm4908_usb",
+			.of_match_table = bcm4908_usb_id_table,
+		},
+	},
+	.probe = bcm4908_usb_probe,
+};
+
+mdio_module_driver(bcm4908_usb_mdio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, bcm4908_usb_id_table);
-- 
2.26.2

