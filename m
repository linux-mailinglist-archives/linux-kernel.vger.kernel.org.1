Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5B26E462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIQSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:46:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E518EC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:46:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q12so1589493plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFecVLOlfc/XXkcR5W8PXXIvpm1Ju4XygNA0UWPR5K8=;
        b=g5Yy91H8iIVTZ3C8rzFQskX0maOQ/2bDuIII9BvyXYYxxkG8CvaqxlYc6QB58c5aQm
         EB1Nn7Q5pyuR7FFRb7xHvyDES0PZ6G7/Tukr5Jgl2vJnZxA6kK4CvKcrl0b6j5G7DcwD
         +tMxH4+jsWYp9NUdDE135SqNnYqR93FCAYIAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFecVLOlfc/XXkcR5W8PXXIvpm1Ju4XygNA0UWPR5K8=;
        b=q4JpTYr9PZUpfvV0D9Y2E/al/fjg1lBJTavozfJOirPWKmonfY2aLtMjQhcNWnEROh
         O6cWBbnsiHvxdHt4BbmSlD3gtCLtO5ZBcgvpJjx4si95FL8v1kZRByw2iEXtT/jT7bjx
         Uzz8+SyHv9CmQYzFTZXdm3L0Zd4FGG+KJZUu9dXkB6WNAwcDYRlZPi7tJYJ/LpsUE9Sn
         Dnq3/d3Nb+uqVAhs3iKSrtVEQ/OO9QZCTMydzJPUqLUhzle/qMnUWpAWc9QshFrLX0EX
         Gc+J1Rm+Ffnxaov6m14Rs4Rb0HJ6jlAgtXU8tbilxoGQ1B/IE/KRwS+htiuFE+ZMtZs3
         ceUg==
X-Gm-Message-State: AOAM530PlJpCE3IBw5iysJvapVayEJoPdcMeeezAUOYm/G4lVydCQBQ7
        7K4jZtShh2Y3a4JSRxlixAEkgQ==
X-Google-Smtp-Source: ABdhPJwV9AXcQYYZX9vztZlfORFOLRdyjEQS2jbKj7sirebYfeVIF3PcL7qnPRwGNBFne63UQQj+hA==
X-Received: by 2002:a17:90a:ea85:: with SMTP id h5mr9783674pjz.166.1600368388405;
        Thu, 17 Sep 2020 11:46:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id d6sm405595pjw.0.2020.09.17.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:46:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Date:   Thu, 17 Sep 2020 11:46:22 -0700
Message-Id: <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
battery life on battery powered devices which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and power it off otherwise.

Technically the driver consists of two drivers, the platform driver
described above and a very thin USB driver that subclasses the
generic driver. The purpose of this driver is to provide the platform
driver with the USB devices corresponding to the hub(s) (a hub
controller may provide multiple 'logical' hubs, e.g. one to support
USB 2.0 and another for USB 3.x).

Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- check wakeup enabled state of the USB controller instead of
  using 'wakeup-source' property
- use sysfs attribute instead of DT property to determine if
  the hub should be powered off at all during system suspend
- added missing brace in onboard_hub_suspend()
- updated commit message
- use pm_ptr for pm_ops as suggested by Alan

Changes in v1:
- renamed the driver to 'onboard_usb_hub'
- single file for platform and USB driver
- USB hub devices register with the platform device
  - the DT includes a phandle of the platform device
- the platform device now controls when power is turned off
- the USB driver became a very thin subclass of the generic USB
  driver
- enabled autosuspend support

 drivers/usb/misc/Kconfig           |  15 ++
 drivers/usb/misc/Makefile          |   1 +
 drivers/usb/misc/onboard_usb_hub.c | 329 +++++++++++++++++++++++++++++
 3 files changed, 345 insertions(+)
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
index 000000000000..206798029041
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -0,0 +1,329 @@
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
+	bool power_off_in_suspend;
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
+static int __maybe_unused onboard_hub_suspend(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	struct udev_node *node;
+	int rc = 0;
+
+	hub->has_wakeup_capable_descendants = false;
+
+	if (!hub->power_off_in_suspend)
+		return 0;
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (!device_may_wakeup(node->udev->bus->controller))
+			break;
+
+		if (usb_wakeup_enabled_descendants(node->udev)) {
+			hub->has_wakeup_capable_descendants = true;
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+
+	if (!hub->has_wakeup_capable_descendants)
+		rc = onboard_hub_power_off(hub);
+
+	return rc;
+}
+
+static int __maybe_unused onboard_hub_resume(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	int rc = 0;
+
+	if (hub->power_off_in_suspend && !hub->has_wakeup_capable_descendants)
+		rc = onboard_hub_power_on(hub);
+
+	return rc;
+}
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
+static ssize_t power_off_in_suspend_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", hub->power_off_in_suspend);
+}
+
+static ssize_t power_off_in_suspend_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = strtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	hub->power_off_in_suspend = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(power_off_in_suspend);
+
+static int onboard_hub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_hub *hub;
+	int rc;
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
+	dev_set_drvdata(dev, hub);
+
+	rc = sysfs_create_file(&dev->kobj, &dev_attr_power_off_in_suspend.attr);
+	if (rc)
+		return rc;
+
+	return onboard_hub_power_on(hub);
+}
+
+static int onboard_hub_remove(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+
+	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_power_off_in_suspend.attr);
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
+static SIMPLE_DEV_PM_OPS(onboard_hub_pm_ops, onboard_hub_suspend, onboard_hub_resume);
+
+static struct platform_driver onboard_hub_driver = {
+	.probe = onboard_hub_probe,
+	.remove = onboard_hub_remove,
+
+	.driver = {
+		.name = "onboard-usb-hub",
+		.of_match_table = onboard_hub_match,
+		.pm = pm_ptr(&onboard_hub_pm_ops),
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
2.28.0.681.g6f77f65b4e-goog

