Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02182765B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgIXBK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgIXBKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:10:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D3C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:10:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so707420plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rd62Oc3gzgsuejUMQ4/DvKo81vT+v7RQmibTThDe6s=;
        b=PlCuIp3XhcrdDE7p4c1/HsA1cIdVxyK4EMXG/v9gweeq3/ritZ/iqR1fxCdeUOHNyL
         6AKU/m1UXR5pe7dzSon+ghGukqr5Wk0hPSt6nnfIa809CutlWA/lT9+d38PihVeIGE4X
         717/6qyiua72ptNUwtCNpWWEeMWfEkhN1p+So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rd62Oc3gzgsuejUMQ4/DvKo81vT+v7RQmibTThDe6s=;
        b=hBwNRiaFcX8zJU67BGFFSxK9Yw5r/UX/2Hw9w/NY+nRvziiPG/f/dZ1Bm2u+VkIIcs
         2abFn5I3JklnaQ4YQPUUla/N9BbIMJ2pDMkN72fdsRmnI36f2u8GicWrapmiLYs+dS2N
         RGyD8CxaoLIY6Iq+OOCgt6e9q3xfILdRgA3yE6BxZeIbbMR/pRkZBxMkYswfp/i4IPqK
         RlskmVaSxAWOKqEe7PsuqmUuHwE8iYTwiL3BI7Ac33MGSKXVL4Hg37KUf4q8WqpaCzns
         e0Lgeb5vkofx9sxytuYZB4m6hs1/z4kzPiVEXlgkepcOjZ6Zi67aR+NFqShAe8hBTFjW
         X/UA==
X-Gm-Message-State: AOAM531WGV56qZ+Pf9/votZt24MOOBcOcqvEbA+7fIRWmdD8djvCotDc
        o8zolEJLkJPiukw0zrFelgxewmxZT9rJ8w==
X-Google-Smtp-Source: ABdhPJzYLlFDG3DPAanmIle2JDPt/kPaSDsPFChs9W3RIaEF73NmgEM3ur/dwwvO1eSz3Q1EqB8qLg==
X-Received: by 2002:a17:90b:d86:: with SMTP id bg6mr1721096pjb.155.1600909821207;
        Wed, 23 Sep 2020 18:10:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id j4sm791039pfd.101.2020.09.23.18.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 18:10:20 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 2/2] USB: misc: Add onboard_usb_hub driver
Date:   Wed, 23 Sep 2020 18:10:12 -0700
Message-Id: <20200923180952.v3.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200923180952.v3.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20200923180952.v3.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main issue this driver addresses is that a USB hub needs to be
powered before it can be discovered. For discrete onboard hubs (an
example for such a hub is the Realtek RTS5411) this is often solved
by supplying the hub with an 'always-on' regulator, which is kind
of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires even more hacks. This driver creates a platform device
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

Changes in v3:
- updated the commit message
- updated description in Kconfig
- remove include of 'core/usb.h'
- use 'is_powered_on' flag instead of 'has_wakeup_capable_descendants'
- added 'going_away' flag to struct onboard_hub
  - don't allow adding new USB devices when the platform device is going away
  - don't bother with deleting the list item in onboard_hub_remove_usbdev()
    when the platform device is going away
- don't assume in onboard_hub_suspend() that all USB hub devices are
  connected to the same controller
- removed unnecessary devm_kfree() from onboard_hub_remove_usbdev()
- fixed error handling in onboard_hub_remove_usbdev()
- use kstrtobool() instead of strtobool() in power_off_in_suspend_store()
- unbind USB devices in onboard_hub_remove() to avoid dangling references
  to the platform device
- moved put_device() for platform device to _find_onboard_hub()
- changed return value of onboard_hub_remove_usbdev() to void
- evaluate return value of onboard_hub_add_usbdev()
- register 'power_off_in_suspend' as managed device attribute
- use USB_DEVICE macro instead manual initialization
- add unwinding to onboard_hub_init()
- updated MODULE_DESCRIPTION
- use module_init() instead of device_initcall()

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

 drivers/usb/misc/Kconfig           |  16 ++
 drivers/usb/misc/Makefile          |   1 +
 drivers/usb/misc/onboard_usb_hub.c | 370 +++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6818ea689cd9..df470903848c 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,19 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config USB_ONBOARD_HUB
+	tristate "Onboard USB hub support"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here if you want to support discrete onboard USB hubs that
+	  don't require an additional control bus for initialization (an
+	  example for such a hub is the Realtek RTS5411). The driver powers
+	  supported hubs on and may perform other initialization steps.
+
+	  The driver can be configured to turn off the power of the hub
+	  during system suspend. This may reduce power consumption while
+	  the system is suspended.
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
index 000000000000..390ae9fe13d0
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Driver for onboard USB hubs
+ *
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/device.h>
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
+	bool is_powered_on;
+	bool going_away;
+	struct list_head udev_list;
+	struct mutex lock;
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
+	hub->is_powered_on = true;
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
+	hub->is_powered_on = false;
+
+	return 0;
+}
+
+static int __maybe_unused onboard_hub_suspend(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	struct udev_node *node;
+	bool power_off;
+	int rc = 0;
+
+	if (!hub->power_off_in_suspend)
+		return 0;
+
+	power_off = true;
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (!device_may_wakeup(node->udev->bus->controller))
+			continue;
+
+		if (usb_wakeup_enabled_descendants(node->udev)) {
+			power_off = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+
+	if (power_off)
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
+	if (!hub->is_powered_on)
+		rc = onboard_hub_power_on(hub);
+
+	return rc;
+}
+
+static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+	int ret = 0;
+
+	mutex_lock(&hub->lock);
+
+	if (hub->going_away) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	node->udev = udev;
+
+	list_add(&node->list, &hub->udev_list);
+
+unlock:
+	mutex_unlock(&hub->lock);
+
+	return ret;
+}
+
+static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+
+	smp_rmb();
+	if (hub->going_away) {
+		/*
+		 * We are most likely being called as a result of unbinding a USB device from
+		 * onboard_hub_remove(). This function also holds the lock and iterates over
+		 * 'udev_list'. Skip deleting the node in this case to avoid a self deadlock,
+		 * keeping the node in the list isn't a problem, since the device is about to go
+		 * away.
+		 */
+		return;
+	}
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (node->udev == udev) {
+			list_del(&node->list);
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
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
+	ret = kstrtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	hub->power_off_in_suspend = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(power_off_in_suspend);
+
+static struct attribute *onboard_hub_sysfs_entries[] = {
+	&dev_attr_power_off_in_suspend.attr,
+	NULL,
+};
+
+static const struct attribute_group onboard_hub_sysfs_group = {
+	.attrs = onboard_hub_sysfs_entries,
+};
+
+static int onboard_hub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_hub *hub;
+	int err;
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
+	err = devm_device_add_group(dev, &onboard_hub_sysfs_group);
+	if (err) {
+		dev_err(dev, "failed to create sysfs entries: %d\n", err);
+		return err;
+	}
+
+	return onboard_hub_power_on(hub);
+}
+
+static int onboard_hub_remove(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+	struct udev_node *node;
+
+	hub->going_away = true;
+
+	mutex_lock(&hub->lock);
+
+	/* unbind the USB devices to avoid dangling references to this device */
+	list_for_each_entry(node, &hub->udev_list, list)
+		device_release_driver(&node->udev->dev);
+
+	mutex_unlock(&hub->lock);
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
+	put_device(&pdev->dev);
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
+	return onboard_hub_add_usbdev(hub, udev);
+}
+
+static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
+
+	onboard_hub_remove_usbdev(hub, udev);
+}
+
+static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.0 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
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
+	int ret;
+
+	ret = platform_driver_register(&onboard_hub_driver);
+	if (ret)
+		return ret;
+
+	ret = usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
+	if (ret)
+		platform_driver_unregister(&onboard_hub_driver);
+
+	return ret;
+}
+module_init(onboard_hub_init);
+
+static void __exit onboard_hub_exit(void)
+{
+	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
+	platform_driver_unregister(&onboard_hub_driver);
+}
+module_exit(onboard_hub_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Driver for discrete onboard USB hubs");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0.709.gb0816b6eb0-goog

