Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95071289196
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbgJITJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgJITIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:08:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F3C0613D2;
        Fri,  9 Oct 2020 12:08:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so7060145pga.6;
        Fri, 09 Oct 2020 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIh4NtJMpceQPCyI8B0iBo+e8xdzyggN1ixRaYdfX1Y=;
        b=SELMvgZZJnlTrinixfTe32AcZJQePxb2uSVllEYw0EctXLRgO9PWh9eqrGf0xLwsjy
         tMbWOv+AOqjIny//YeoWDYwSanB2ZlPe236ZnMJkqhDZU06BhGoBE7Yt/eSt+v8sRD4t
         cYTpsH/SUbmPAL5s5Yt1AZBmkw8m1q7KlAtaqcfUw/wPArbdv0rfskK01XbwkgpHUbpF
         I+7FFwwYSz0SJYyJJLNMS0nOQvu9uCon1eBg4wzlQI0ihsTjtQW8onmmCttrIWGC2up8
         VzCmWTLOBtzydfMfXjshtJPFGFbuaqYUEv5pIuc9hjPlSXYUlPvTJbnxh6pChOl3+QoG
         74KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mIh4NtJMpceQPCyI8B0iBo+e8xdzyggN1ixRaYdfX1Y=;
        b=rsj2qOlEE2GCCnu1cY5deHG4dUUijBKHilf1l0VkAde8euCDt70dwyKAT0466KWE/S
         e3mtWAefrzAiPYp7TiRuXobXrw5Sbp09y/q5rchXSRlS7kLeMaDVtJcHblmXX8OVuxHG
         f4JMPlEy2gMaF9cuFeOuiGgX9QwDsTX9YArYtZ14Yu9XE6p3H4AG+xtAvSwNrldJEOkt
         IOzRl5rcJJkIsGqqEjlcIR8pNiUtOoKtpsMtwCgtZ2t20VYKzZe2in1tnTmO1LsRZi4N
         p9LZVZnloD2oyTNhLcIZJNTdX4Ff2HuZ8h08u1z9y1HyFSsMSwdX0aGU/EhHJ6chbdkA
         27HQ==
X-Gm-Message-State: AOAM530XOdP6ezSf7EEA2nigd1P9yKnU7P172XkVt29a4+hVGzA6RLmY
        QEnTSGgBBakorciGpECSGN/eQYcv5/8=
X-Google-Smtp-Source: ABdhPJzlcc4zzu5DjEQVWB59Nss8OswWYE/n0rZgCeNv5VISIv5krDGUDVll0PkqQPDdsJJARdk2KA==
X-Received: by 2002:a63:1047:: with SMTP id 7mr4680997pgq.349.1602270532701;
        Fri, 09 Oct 2020 12:08:52 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o20sm12281043pgh.63.2020.10.09.12.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:08:52 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] usb: Add driver to allow any GPIO to be used for 7211 USB signals
Date:   Fri,  9 Oct 2020 15:08:39 -0400
Message-Id: <20201009190839.12612-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009190839.12612-1-alcooperx@gmail.com>
References: <20201009190839.12612-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom 7211 has new functionality that allows some USB low
speed side band signals, that go from the XHCI host controller to
pins on the chip, to be remapped to use any GPIO pin instead of the
limited set selectable by hardware. This can be done without changing
the standard driver for the host controller. There is currently
support for three USB signals, PWRON, VBUS_PRESENT and PWRFLT. This
driver will allow the remapping of any of these three signals based
on settings in the Device Tree node for the driver. The driver was
written so that it could handle additional signals added in the
future by just adding the correct properties to the DT node.

Below is an example of a DT node that would remap all three
signals:

usb_pinmap: usb-pinmap@22000d0 {
	compatible = "brcm,usb-pinmap";
	reg = <0x22000d0 0x4>;
	in-gpios = <&gpio 18 0>, <&gpio 19 0>;
	brcm,in-functions = "VBUS", "PWRFLT";
	brcm,in-masks = <0x8000 0x40000 0x10000 0x80000>;
	out-gpios = <&gpio 20 0>;
	brcm,out-functions = "PWRON";
	brcm,out-masks = <0x20000 0x800000 0x400000 0x200000>;
	interrupts = <0x0 0xb2 0x4>;
};

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS                           |   8 +
 drivers/usb/misc/Kconfig              |   9 +
 drivers/usb/misc/Makefile             |   1 +
 drivers/usb/misc/brcmstb-usb-pinmap.c | 348 ++++++++++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 drivers/usb/misc/brcmstb-usb-pinmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd2aea603e03..1198acd71534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3567,6 +3567,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 F:	drivers/usb/host/ehci-brcm.*
 
+BROADCOM BRCMSTB USB PIN MAP DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
+F:	drivers/usb/misc/brcmstb-usb-pinmap.c
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6818ea689cd9..22e8a44fd2b2 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,12 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config BRCM_USB_PINMAP
+	tristate "Broadcom pinmap driver support"
+	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
+	default y if (ARCH_BRCMSTB && PHY_BRCM_USB)
+	help
+	  This option enables support for remapping some USB external
+	  signals, which are typically on dedicated pins on the chip,
+	  to any gpio.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index da39bddb0604..5f4e598573ab 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
+obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
diff --git a/drivers/usb/misc/brcmstb-usb-pinmap.c b/drivers/usb/misc/brcmstb-usb-pinmap.c
new file mode 100644
index 000000000000..007e2a4b4a85
--- /dev/null
+++ b/drivers/usb/misc/brcmstb-usb-pinmap.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Broadcom */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/gpio/consumer.h>
+
+struct out_pin {
+	u32 enable_mask;
+	u32 value_mask;
+	u32 changed_mask;
+	u32 clr_changed_mask;
+	struct gpio_desc *gpiod;
+	const char *name;
+};
+
+struct in_pin {
+	u32 enable_mask;
+	u32 value_mask;
+	struct gpio_desc *gpiod;
+	const char *name;
+	struct brcmstb_usb_pinmap_data *pdata;
+};
+
+struct brcmstb_usb_pinmap_data {
+	void __iomem *regs;
+	int in_count;
+	struct in_pin *in_pins;
+	int out_count;
+	struct out_pin *out_pins;
+};
+
+
+static void pinmap_set(void __iomem *reg, u32 mask)
+{
+	u32 val;
+
+	val = readl(reg);
+	val |= mask;
+	writel(val, reg);
+}
+
+static void pinmap_unset(void __iomem *reg, u32 mask)
+{
+	u32 val;
+
+	val = readl(reg);
+	val &= ~mask;
+	writel(val, reg);
+}
+
+static void sync_in_pin(struct in_pin *pin)
+{
+	u32 val;
+
+	val = gpiod_get_value(pin->gpiod);
+	if (val)
+		pinmap_set(pin->pdata->regs, pin->value_mask);
+	else
+		pinmap_unset(pin->pdata->regs, pin->value_mask);
+}
+
+/*
+ * Interrupt from override register, propagate from override bit
+ * to GPIO.
+ */
+static irqreturn_t brcmstb_usb_pinmap_ovr_isr(int irq, void *dev_id)
+{
+	struct brcmstb_usb_pinmap_data *pdata = dev_id;
+	struct out_pin *pout;
+	u32 val;
+	u32 bit;
+	int x;
+
+	pr_debug("%s: reg: 0x%x\n", __func__, readl(pdata->regs));
+	pout = pdata->out_pins;
+	for (x = 0; x < pdata->out_count; x++) {
+		val = readl(pdata->regs);
+		if (val & pout->changed_mask) {
+			pinmap_set(pdata->regs, pout->clr_changed_mask);
+			pinmap_unset(pdata->regs, pout->clr_changed_mask);
+			bit = val & pout->value_mask;
+			gpiod_set_value(pout->gpiod, bit ? 1 : 0);
+			pr_debug("%s: %s bit changed state to %d\n",
+				 __func__, pout->name, bit ? 1 : 0);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Interrupt from GPIO, propagate from GPIO to override bit.
+ */
+static irqreturn_t brcmstb_usb_pinmap_gpio_isr(int irq, void *dev_id)
+{
+	struct in_pin *pin = dev_id;
+
+	pr_debug("%s: %s pin changed state\n", __func__, pin->name);
+	sync_in_pin(pin);
+	return IRQ_HANDLED;
+}
+
+
+static void get_pin_counts(struct device_node *dn, int *in_count,
+			   int *out_count)
+{
+	int in;
+	int out;
+
+	*in_count = 0;
+	*out_count = 0;
+	in = of_property_count_strings(dn, "brcm,in-functions");
+	if (in < 0)
+		return;
+	out = of_property_count_strings(dn, "brcm,out-functions");
+	if (out < 0)
+		return;
+	*in_count = in;
+	*out_count = out;
+}
+
+static int parse_pins(struct device *dev, struct device_node *dn,
+		      struct brcmstb_usb_pinmap_data *pdata)
+{
+	struct out_pin *pout;
+	struct in_pin *pin;
+	int index;
+	int res;
+	int x;
+
+	pin = pdata->in_pins;
+	for (x = 0, index = 0; x < pdata->in_count; x++) {
+		pin->gpiod = devm_gpiod_get_index(dev, "in", x, GPIOD_IN);
+		if (IS_ERR(pin->gpiod)) {
+			dev_err(dev, "Error getting gpio %s\n", pin->name);
+			return PTR_ERR(pin->gpiod);
+
+		}
+		res = of_property_read_string_index(dn, "brcm,in-functions", x,
+						    &pin->name);
+		if (res < 0) {
+			dev_err(dev, "Error getting brcm,in-functions for %s\n",
+				pin->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,in-masks", index++,
+						 &pin->enable_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 1st brcm,in-masks for %s\n",
+				pin->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,in-masks", index++,
+						 &pin->value_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 2nd brcm,in-masks for %s\n",
+				pin->name);
+			return res;
+		}
+		pin->pdata = pdata;
+		pin++;
+	}
+	pout = pdata->out_pins;
+	for (x = 0, index = 0; x < pdata->out_count; x++) {
+		pout->gpiod = devm_gpiod_get_index(dev, "out", x,
+						   GPIOD_OUT_HIGH);
+		if (IS_ERR(pout->gpiod)) {
+			dev_err(dev, "Error getting gpio %s\n", pin->name);
+			return PTR_ERR(pout->gpiod);
+		}
+		res = of_property_read_string_index(dn, "brcm,out-functions", x,
+						    &pout->name);
+		if (res < 0) {
+			dev_err(dev, "Error getting brcm,out-functions for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,out-masks", index++,
+						 &pout->enable_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 1st brcm,out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,out-masks", index++,
+						 &pout->value_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 2nd brcm,out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,out-masks", index++,
+						 &pout->changed_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 3rd brcm,out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "brcm,out-masks", index++,
+						 &pout->clr_changed_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting 4th out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		pout++;
+	}
+	return 0;
+}
+
+void sync_all_pins(struct brcmstb_usb_pinmap_data *pdata)
+{
+	struct out_pin *pout;
+	struct in_pin *pin;
+	int val;
+	int x;
+
+	/*
+	 * Enable the override, clear any changed condition and
+	 * propagate the state to the GPIO for all out pins.
+	 */
+	pout = pdata->out_pins;
+	for (x = 0; x < pdata->out_count; x++) {
+		pinmap_set(pdata->regs, pout->enable_mask);
+		pinmap_set(pdata->regs, pout->clr_changed_mask);
+		pinmap_unset(pdata->regs, pout->clr_changed_mask);
+		val = readl(pdata->regs) & pout->value_mask;
+		gpiod_set_value(pout->gpiod, val ? 1 : 0);
+		pout++;
+	}
+
+	/* sync and enable all in pins. */
+	pin = pdata->in_pins;
+	for (x = 0; x < pdata->in_count; x++) {
+		sync_in_pin(pin);
+		pinmap_set(pdata->regs, pin->enable_mask);
+		pin++;
+	}
+}
+
+static int __init brcmstb_usb_pinmap_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct brcmstb_usb_pinmap_data *pdata;
+	struct in_pin *pin;
+	struct resource *r;
+	int out_count;
+	int in_count;
+	int err;
+	int irq;
+	int x;
+
+	get_pin_counts(dn, &in_count, &out_count);
+	if ((in_count + out_count) == 0)
+		return -EINVAL;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	pdata = devm_kzalloc(&pdev->dev,
+			     sizeof(*pdata) +
+			     (sizeof(struct in_pin) * in_count) +
+			     (sizeof(struct out_pin) * out_count), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->in_count = in_count;
+	pdata->out_count = out_count;
+	pdata->in_pins = (struct in_pin *)(pdata + 1);
+	pdata->out_pins = (struct out_pin *)(pdata->in_pins + in_count);
+
+	pdata->regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (IS_ERR(pdata->regs))
+		return PTR_ERR(pdata->regs);
+	platform_set_drvdata(pdev, pdata);
+
+	err = parse_pins(&pdev->dev, dn, pdata);
+	if (err)
+		return err;
+
+	sync_all_pins(pdata);
+
+	if (out_count) {
+
+		/* Enable interrupt for out pins */
+		irq = platform_get_irq(pdev, 0);
+		err = devm_request_irq(&pdev->dev, irq,
+				       brcmstb_usb_pinmap_ovr_isr,
+				       IRQF_TRIGGER_RISING,
+				       pdev->name, pdata);
+		if (err < 0) {
+			dev_err(&pdev->dev, "Error requesting IRQ\n");
+			return err;
+		}
+	}
+
+	for (x = 0, pin = pdata->in_pins; x < pdata->in_count; x++, pin++) {
+		irq = gpiod_to_irq(pin->gpiod);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "Error getting IRQ for %s pin\n",
+				pin->name);
+			return irq;
+		}
+		err = devm_request_irq(&pdev->dev, irq,
+				       brcmstb_usb_pinmap_gpio_isr,
+				       IRQF_SHARED | IRQF_TRIGGER_RISING |
+				       IRQF_TRIGGER_FALLING,
+				       pdev->name, pin);
+		if (err < 0) {
+			dev_err(&pdev->dev, "Error requesting IRQ for %s pin\n",
+				pin->name);
+			return err;
+		}
+	}
+
+	dev_dbg(&pdev->dev, "Driver probe succeeded\n");
+	dev_dbg(&pdev->dev, "In pin count: %d, out pin count: %d\n",
+		pdata->in_count, pdata->out_count);
+	return 0;
+}
+
+
+static const struct of_device_id brcmstb_usb_pinmap_of_match[] = {
+	{ .compatible = "brcm,usb-pinmap" },
+	{ },
+};
+
+static struct platform_driver brcmstb_usb_pinmap_driver = {
+	.driver = {
+		.name	= "brcm-usb-pinmap",
+		.of_match_table = brcmstb_usb_pinmap_of_match,
+	},
+};
+
+static int __init brcmstb_usb_pinmap_init(void)
+{
+	return platform_driver_probe(&brcmstb_usb_pinmap_driver,
+				     brcmstb_usb_pinmap_probe);
+}
+
+module_init(brcmstb_usb_pinmap_init);
-- 
2.17.1

