Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6D2F870E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbhAOVB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbhAOVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:01:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42371C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:01:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so8149058ybz.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=19u5OiX4KBPBwY3Y98L9C8EI52RTKEJcpug2/sxV07E=;
        b=NRd4zE6hHYhy8MQG2tBqbhyKMolpMBaToG/3TeC2H71bdGpFtxHlEcibYPFqHFnuQ8
         35w0D5ujJ9EM76nrYYrRNYt1plla+o+Z5/SJe994kzPjdqjpnHE2cyErw2RpuRt/uzOp
         YxcWTxykXF+evZE7CeAgt9f7RaOWl+AxQEUgk4Rr08zdjUHi6g9Yh2i9A1XtfBebkdEg
         TED53iZt7QY+0L3py+vRxf00Lg4VWs/Uex4CnyBsVtxKPiY11xO+6SXp8vTLoxrL0ZcA
         LZzRtQ/rKItZehyTmUO/2BdFA4bSEDxQL5urIXEHNBuVeP24j/+ZN/k3Okoa6R1nfxNj
         bm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=19u5OiX4KBPBwY3Y98L9C8EI52RTKEJcpug2/sxV07E=;
        b=Eo303XKDTQw0GC5hqGRqkpFAPJmdM2ZsRHnmDKJ34E6UQt57DCoDU8+yvN6pKDBm2G
         t85isCa+id6X4LJtZ6sgqCqsi7+AlQab2HsWSlIPYDrCzsJKucVRgeDfaTF/iUr4cGyq
         xDrw5E3owsyL5B+sF3dJQ0NpQ1T932k0ptkkgJMUSSm03JyH3vF6IaHokdmpfF9YbrN8
         35BzQTf5uOZoscC5VyswGPaU2RaWl5rUQQlImnr1zKQMr+o8Q+4BuUas0mIO+Vuwhvqm
         teDD18DO0JcOX8VBzfikVNfD+Ncck4WAQs5uFFp3NpAsrQrMkMe+1jUkK+QAf/mYpPCT
         0vTw==
X-Gm-Message-State: AOAM531+T6H6qREBPnUukJ5L/rPJZZNdH2d8+9XUExRiaBi0NYuGOf9C
        GOBALshkj+IzUP0asMqYX8UiKfTbzR3iBhI=
X-Google-Smtp-Source: ABdhPJy9JEJYku0CW7gLgs1pDRQsm+DFskGChpIP1Qy/G83tI9nezCpBRsDOYFKqX5htz4CyURoDbjxHNNar+04=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:23ca:: with SMTP id
 j193mr7219826ybj.16.1610744472390; Fri, 15 Jan 2021 13:01:12 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:01:07 -0800
Message-Id: <20210115210107.3087548-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v1] gpiolib: Bind gpio_device to a driver to enable
 fw_devlink=on by default
From:   Saravana Kannan <saravanak@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel-team@android.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of GPIO devictree nodes of the form:

foo {
	compatible = "acme,foo";
	...

	gpio0: gpio0@xxxxxxxx {
		compatible = "acme,bar";
		...
		gpio-controller;
	};

	gpio1: gpio1@xxxxxxxx {
		compatible = "acme,bar";
		...
		gpio-controller;
	};

	...
}

bazz {
	my-gpios = <&gpio0 ...>;
}

Case 1: The driver for "foo" populates struct device for these gpio*
nodes and then probes them using a driver that binds with "acme,bar".
This lines up with how DT nodes with the "compatible" property are
generally converted to struct devices and then registered with driver
core to probe them. This also allows the gpio* devices to hook into all
the driver core capabilities like runtime PM, probe deferral,
suspend/resume ordering, device links, etc.

Case 2: The driver for "foo" doesn't populate its child device nodes
with "compatible" property and instead just loops through its child
nodes and directly registers the GPIOs with gpiolib without ever
populating a struct device or binding a driver to it.

Drivers that follow the case 2 cause problems with fw_devlink=on.  This
is because fw_devlink will prevent bazz from probing until there's a
struct device that has gpio0 as its fwnode (because bazz lists gpio0 as
a GPIO supplier). Once the struct device is available, fw_devlink will
create a device link between with gpio0 as the supplier and bazz as the
consumer. After this point, the device link will prevent bazz from
probing until its supplier (the gpio0 device) has bound to a driver.
Once the supplier is bound to a driver, the probe of bazz is triggered
automatically.

Finding and refactoring all the instances of drivers that follow case 2
will cause a lot of code churn and it not something that can be done in
one shot. Examples of such instances are [1] [2].

This patch works around this problem and avoids all the code churn by
simply creating a stub driver to bind to the gpio_device. Since the
gpio_device already points to the GPIO device tree node, this allows all
the consumers to continue probing when the driver follows case 2.

If/when all the old drivers are refactored, we can revert this patch.

[1] - https://lore.kernel.org/lkml/20201014191235.7f71fcb4@xhacker.debian/
[2] - https://lore.kernel.org/lkml/e28e1f38d87c12a3c714a6573beba6e1@kernel.org/
Cc: Marc Zyngier <maz@kernel.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/gpio/gpiolib.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b02cc2abd3b6..36f0af42e203 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -574,6 +574,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	unsigned	i;
 	int		base = gc->base;
 	struct gpio_device *gdev;
+	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
+	struct device *fwnode_dev;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
@@ -596,6 +599,22 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		gdev->dev.of_node = gc->of_node;
 	else
 		gc->of_node = gdev->dev.of_node;
+
+	of_node = gdev->dev.of_node;
+	fwnode = of_fwnode_handle(of_node);
+	fwnode_dev = get_dev_from_fwnode(fwnode);
+
+	/*
+	 * If your driver hits this warning, it's because you are directly
+	 * parsing a device tree node with "compatible" property and
+	 * initializing it instead of using the standard DT + device driver
+	 * model of creating a struct device and then initializing it in the
+	 * probe function. Please refactor your driver.
+	 */
+	if (!fwnode_dev && of_find_property(gdev->dev.of_node, "compatible")) {
+		chip_warn(gc, "Create a real device for %pOF\n" of_node);
+		gdev->dev.fwnode = fwnode;
+	}
 #endif
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
@@ -4202,6 +4221,17 @@ void gpiod_put_array(struct gpio_descs *descs)
 }
 EXPORT_SYMBOL_GPL(gpiod_put_array);
 
+static int gpio_drv_probe(struct device *dev)
+{
+	return 0;
+}
+
+static struct device_driver gpio_drv = {
+	.name = "gpio_drv",
+	.bus = &gpio_bus_type,
+	.probe = gpio_drv_probe,
+};
+
 static int __init gpiolib_dev_init(void)
 {
 	int ret;
@@ -4213,9 +4243,16 @@ static int __init gpiolib_dev_init(void)
 		return ret;
 	}
 
+	if (driver_register(&gpio_drv) < 0) {
+		pr_err("gpiolib: could not register GPIO stub driver\n");
+		bus_unregister(&gpio_bus_type);
+		return ret;
+	}
+
 	ret = alloc_chrdev_region(&gpio_devt, 0, GPIO_DEV_MAX, GPIOCHIP_NAME);
 	if (ret < 0) {
 		pr_err("gpiolib: failed to allocate char dev region\n");
+		driver_unregister(&gpio_drv);
 		bus_unregister(&gpio_bus_type);
 		return ret;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

