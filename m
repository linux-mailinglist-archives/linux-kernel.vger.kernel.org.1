Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904D26951A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgINSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:42:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F1C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:42:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so287443pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZtzJKOmcRqr1EVmUilZSEprXwugBU/kWXmN9ZUg4oo=;
        b=iGIJiRKLdm5vl7BMNOta7ZDTbPTjhNyjUSTYbYiuwasLWEjYOEnp4PMScoDZ+tShp0
         uaipp7qn0TCNOklC2HkozkFCCfh9C0Bxg2q5hibjF8wfzVJvXOf5+OUhgExkdwj3YZH0
         Shvji0H/0PLTJ66reak04gLH2Hti7dXSdM4tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZtzJKOmcRqr1EVmUilZSEprXwugBU/kWXmN9ZUg4oo=;
        b=Mun3pnPX2kOnrhtufd7jq2nNR+4snfkXcq1IGMmQ7vA2t3GR1szQ6vsgXVWC6xVG0u
         NS0/+FUCeYmx/TqebJyfgHO/orQXskq+PgdcbLzBIXdYovMCkwO+0pYqd22E03m8r8PD
         nx4PrPZLOImdcvUWpV1Nr+uHF3i3xEkD/XLNC8uK1T32ZadsfCoC8P0DmsZWQC3itWFm
         Uu2HvstlUa/oOXhnQr9D4ug5UiAkr/hilBx7/w4EVnHIR3jvRt18Y44SyzOZ4Gr0SQD6
         74/T0d+Cu7dMGCigtVtdLPmJ47mpXOiPQV7/ykTqGFrHi7JK1nBJ9hd4rQEqKFCl9gT9
         5wYQ==
X-Gm-Message-State: AOAM533VH5yu7MV9nuSjVxmZCpH7FyqdL5gLjQzq8FN0m2KfZanTVgjb
        m4eMJdUfsDvl+FTkBYUULKKwVg==
X-Google-Smtp-Source: ABdhPJxP8Hb5Z2o+CWXU5aVMtBhFPKN5lM/+6HzL7QtVZl4LiAOba5xI5L9oe5qjoJnHKdZv/pd/jA==
X-Received: by 2002:a62:7ecb:0:b029:13e:d13d:a04c with SMTP id z194-20020a627ecb0000b029013ed13da04cmr13963994pfc.18.1600108919992;
        Mon, 14 Sep 2020 11:41:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k3sm11285930pfp.41.2020.09.14.11.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 11:41:59 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Date:   Mon, 14 Sep 2020 11:27:49 -0700
Message-Id: <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main issue this driver addresses is that a USB hub needs to be
powered before it can be discovered. For onboard hubs this is often
solved by supplying the hub with an 'always-on' regulator, which is
kind of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires further hacks. This driver creates a platform device
representing the hub which performs the necessary initialization.
Currently it only supports switching on a single regulator, support
for multiple regulators or other actions can be added as needed.
Different initialization sequences can be supported based on the
compatible string.

Besides performing the initialization the driver can be configured
to power the hub off during system suspend. This can help to extend
battery life on battery powered devices, which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and keeping it powered otherwise.

Technically the driver consists of two drivers, the platform driver
described above and a very thin USB driver that subclasses the
generic hub driver. The purpose of this driver is to provide the
platform driver with the USB devices corresponding to the hub(s)
(a hub controller may provide multiple 'logical' hubs, e.g. one
to support USB 2.0 and another for USB 3.x).

Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
This is an evolution of '[RFC] USB: misc: Add usb_hub_pwr driver'
(https://lore.kernel.org/patchwork/patch/1299239/).

Changes in v1:
- renamed the driver to 'onboard_usb_hub'
- single file for platform and USB driver
- USB hub devices register with the platform device
  - the DT includes a phandle of the platform device
- the platform device now controls when power is turned off
- the USB driver became a very thin subclass of the generic hub
  driver
- enabled autosuspend support

 drivers/usb/misc/Kconfig           |  15 ++
 drivers/usb/misc/Makefile          |   1 +
 drivers/usb/misc/onboard_usb_hub.c | 306 +++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6818ea689cd9..e941244e24e5 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,18 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config USB_ONBOARD_HUB
+	tristate "Onboard USB hub support"
+	depends on OF
+	help
+	  Say Y here if you want to support onboard USB hubs. The driver
+	  powers supported hubs on and may perform other initialization
+	  steps.
+
+	  The driver can also switch off the power of the hub during
+	  system suspend if it is configured accordingly. This may
+	  reduce power consumption while the system is suspended.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called onboard_usb_hub.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index da39bddb0604..6f10a1c6f7e9 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
+obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
new file mode 100644
index 000000000000..e5a816d0b124
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Driver for onboard USB hubs
+ *
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include "../core/usb.h"
+
+/************************** Platform driver **************************/
+
+struct udev_node {
+	struct usb_device *udev;
+	struct list_head list;
+};
+
+struct onboard_hub {
+	struct regulator *vdd;
+	struct device *dev;
+	struct {
+		bool power_off_in_suspend;
+		bool wakeup_source;
+	} cfg;
+	struct list_head udev_list;
+	struct mutex lock;
+	bool has_wakeup_capable_descendants;
+};
+
+static int onboard_hub_power_on(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_enable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int onboard_hub_power_off(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_disable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int onboard_hub_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	if (!hub->cfg.power_off_in_suspend)
+		return 0;
+
+	hub->has_wakeup_capable_descendants = false;
+
+	if (hub->cfg.wakeup_source) {
+		struct udev_node *node;
+
+		mutex_lock(&hub->lock);
+
+		list_for_each_entry(node, &hub->udev_list, list) {
+			if (usb_wakeup_enabled_descendants(node->udev)) {
+				hub->has_wakeup_capable_descendants = true;
+				break;
+		}
+
+		mutex_unlock(&hub->lock);
+	}
+
+	if (!hub->has_wakeup_capable_descendants)
+		rc = onboard_hub_power_off(hub);
+
+	return rc;
+}
+
+static int onboard_hub_resume(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	if (hub->cfg.power_off_in_suspend && !hub->has_wakeup_capable_descendants)
+		rc = onboard_hub_power_on(hub);
+
+	return rc;
+}
+
+#endif
+
+static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+
+	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->udev = udev;
+
+	mutex_lock(&hub->lock);
+	list_add(&node->list, &hub->udev_list);
+	mutex_unlock(&hub->lock);
+
+	return 0;
+}
+
+static int onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (node->udev == udev) {
+			list_del(&node->list);
+			devm_kfree(hub->dev, node);
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+
+	if (node == NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int onboard_hub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_hub *hub;
+
+	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(hub->vdd))
+		return PTR_ERR(hub->vdd);
+
+	hub->dev = dev;
+	mutex_init(&hub->lock);
+	INIT_LIST_HEAD(&hub->udev_list);
+
+	hub->cfg.power_off_in_suspend = of_property_read_bool(dev->of_node, "power-off-in-suspend");
+	hub->cfg.wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
+
+	dev_set_drvdata(dev, hub);
+
+	return onboard_hub_power_on(hub);
+}
+
+static int onboard_hub_remove(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+
+	return onboard_hub_power_off(hub);
+}
+
+static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "onboard-usb-hub" },
+	{ .compatible = "realtek,rts5411" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, onboard_hub_match);
+
+static struct platform_driver onboard_hub_driver = {
+	.probe = onboard_hub_probe,
+	.remove = onboard_hub_remove,
+#ifdef CONFIG_PM
+	.suspend = onboard_hub_suspend,
+	.resume = onboard_hub_resume,
+#endif
+	.driver = {
+		.name = "onboard-usb-hub",
+		.of_match_table = onboard_hub_match,
+	},
+};
+
+/************************** USB driver **************************/
+
+#define VENDOR_ID_REALTEK	0x0bda
+
+static struct onboard_hub *_find_onboard_hub(struct device *dev)
+{
+	const phandle *ph;
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	ph = of_get_property(dev->of_node, "hub", NULL);
+	if (!ph) {
+		dev_err(dev, "failed to read 'hub' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	np = of_find_node_by_phandle(be32_to_cpu(*ph));
+	if (!np) {
+		dev_err(dev, "failed find device node for onboard hub\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return dev_get_drvdata(&pdev->dev);
+}
+
+static int onboard_hub_usbdev_probe(struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+	struct onboard_hub *hub;
+
+	/* ignore supported hubs without device tree node */
+	if (!dev->of_node)
+		return -ENODEV;
+
+	hub = _find_onboard_hub(dev);
+	if (IS_ERR(hub))
+		return PTR_ERR(dev);
+
+	dev_set_drvdata(dev, hub);
+
+	onboard_hub_add_usbdev(hub, udev);
+
+	return 0;
+}
+
+static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
+
+	onboard_hub_remove_usbdev(hub, udev);
+
+	put_device(hub->dev);
+}
+
+static const struct usb_device_id onboard_hub_id_table[] = {
+	{ .idVendor = VENDOR_ID_REALTEK,
+	  .idProduct = 0x0411, /* RTS5411 USB 3.0 */
+	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
+	{ .idVendor = VENDOR_ID_REALTEK,
+	  .idProduct = 0x5411, /* RTS5411 USB 2.0 */
+	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
+	{},
+};
+
+MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
+
+static struct usb_device_driver onboard_hub_usbdev_driver = {
+
+	.name = "onboard-usb-hub",
+	.probe = onboard_hub_usbdev_probe,
+	.disconnect = onboard_hub_usbdev_disconnect,
+	.generic_subclass = 1,
+	.supports_autosuspend =	1,
+	.id_table = onboard_hub_id_table,
+};
+
+/************************** Driver (de)registration **************************/
+
+static int __init onboard_hub_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&onboard_hub_driver);
+	if (rc)
+		return rc;
+
+	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
+}
+device_initcall(onboard_hub_init);
+
+static void __exit onboard_hub_exit(void)
+{
+	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
+	platform_driver_unregister(&onboard_hub_driver);
+}
+module_exit(onboard_hub_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Onboard USB Hub driver");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0.618.gf4bc123cb7-goog

