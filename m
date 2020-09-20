Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200E52714E4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgITOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgITOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:16:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B6920809;
        Sun, 20 Sep 2020 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600611415;
        bh=8R8ir9kKSSFLtR/AQl80J/fe8EBZIELfAhgSCQltkW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jefSFVbdsQ3QKA6wAKIgSNVaE6/gIwHbpVmABagPKiRZZ/Gtnc9AJvn0ozi9F5b7l
         PKceKE8CToRd5mWz2PiOuHkvEsmAjwMiSXYT0PCBEhtYXlWNMqIgt4jzFxACo7EmVH
         8+YAfmIcchUCIHtfexmT7lcwRQwACT4osneYLK9A=
Date:   Sun, 20 Sep 2020 16:17:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200920141720.GD2915460@kroah.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:46:22AM -0700, Matthias Kaehlcke wrote:
> The main issue this driver addresses is that a USB hub needs to be
> powered before it can be discovered. For onboard hubs this is often
> solved by supplying the hub with an 'always-on' regulator, which is
> kind of a hack. Some onboard hubs may require further initialization
> steps, like changing the state of a GPIO or enabling a clock, which
> requires further hacks. This driver creates a platform device
> representing the hub which performs the necessary initialization.
> Currently it only supports switching on a single regulator, support
> for multiple regulators or other actions can be added as needed.
> Different initialization sequences can be supported based on the
> compatible string.
> 
> Besides performing the initialization the driver can be configured
> to power the hub off during system suspend. This can help to extend
> battery life on battery powered devices which have no requirements
> to keep the hub powered during suspend. The driver can also be
> configured to leave the hub powered when a wakeup capable USB device
> is connected when suspending, and power it off otherwise.
> 
> Technically the driver consists of two drivers, the platform driver
> described above and a very thin USB driver that subclasses the
> generic driver. The purpose of this driver is to provide the platform
> driver with the USB devices corresponding to the hub(s) (a hub
> controller may provide multiple 'logical' hubs, e.g. one to support
> USB 2.0 and another for USB 3.x).
> 
> Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - check wakeup enabled state of the USB controller instead of
>   using 'wakeup-source' property
> - use sysfs attribute instead of DT property to determine if
>   the hub should be powered off at all during system suspend
> - added missing brace in onboard_hub_suspend()
> - updated commit message
> - use pm_ptr for pm_ops as suggested by Alan
> 
> Changes in v1:
> - renamed the driver to 'onboard_usb_hub'
> - single file for platform and USB driver
> - USB hub devices register with the platform device
>   - the DT includes a phandle of the platform device
> - the platform device now controls when power is turned off
> - the USB driver became a very thin subclass of the generic USB
>   driver
> - enabled autosuspend support
> 
>  drivers/usb/misc/Kconfig           |  15 ++
>  drivers/usb/misc/Makefile          |   1 +
>  drivers/usb/misc/onboard_usb_hub.c | 329 +++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/usb/misc/onboard_usb_hub.c
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6818ea689cd9..e941244e24e5 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -275,3 +275,18 @@ config USB_CHAOSKEY
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called chaoskey.
> +
> +config USB_ONBOARD_HUB
> +	tristate "Onboard USB hub support"
> +	depends on OF

What about COMPILE_TEST as well?

> +	help
> +	  Say Y here if you want to support onboard USB hubs. The driver
> +	  powers supported hubs on and may perform other initialization
> +	  steps.
> +
> +	  The driver can also switch off the power of the hub during
> +	  system suspend if it is configured accordingly. This may
> +	  reduce power consumption while the system is suspended.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called onboard_usb_hub.
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index da39bddb0604..6f10a1c6f7e9 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
>  
>  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
>  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> +obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> new file mode 100644
> index 000000000000..206798029041
> --- /dev/null
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Driver for onboard USB hubs
> + *
> + * Copyright (c) 2020, Google LLC
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/suspend.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include "../core/usb.h"

Why do you need private usb core functions?

> +
> +/************************** Platform driver **************************/
> +
> +struct udev_node {
> +	struct usb_device *udev;
> +	struct list_head list;
> +};
> +
> +struct onboard_hub {
> +	struct regulator *vdd;
> +	struct device *dev;
> +	bool power_off_in_suspend;
> +	struct list_head udev_list;
> +	struct mutex lock;
> +	bool has_wakeup_capable_descendants;
> +};
> +
> +static int onboard_hub_power_on(struct onboard_hub *hub)
> +{
> +	int err;
> +
> +	err = regulator_enable(hub->vdd);
> +	if (err) {
> +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}

Nit, no need for { } or return err here, just return err one line below.

> +
> +	return 0;
> +}
> +
> +static int onboard_hub_power_off(struct onboard_hub *hub)
> +{
> +	int err;
> +
> +	err = regulator_disable(hub->vdd);
> +	if (err) {
> +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;

Same here.

> +}
> +
> +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +	struct udev_node *node;
> +	int rc = 0;
> +
> +	hub->has_wakeup_capable_descendants = false;
> +
> +	if (!hub->power_off_in_suspend)
> +		return 0;
> +
> +	mutex_lock(&hub->lock);
> +
> +	list_for_each_entry(node, &hub->udev_list, list) {
> +		if (!device_may_wakeup(node->udev->bus->controller))
> +			break;
> +
> +		if (usb_wakeup_enabled_descendants(node->udev)) {
> +			hub->has_wakeup_capable_descendants = true;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&hub->lock);
> +
> +	if (!hub->has_wakeup_capable_descendants)
> +		rc = onboard_hub_power_off(hub);
> +
> +	return rc;
> +}
> +
> +static int __maybe_unused onboard_hub_resume(struct device *dev)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +	int rc = 0;
> +
> +	if (hub->power_off_in_suspend && !hub->has_wakeup_capable_descendants)
> +		rc = onboard_hub_power_on(hub);
> +
> +	return rc;
> +}
> +
> +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +	struct udev_node *node;
> +
> +	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->udev = udev;

No reference counting?  Are you sure about this?

> +
> +	mutex_lock(&hub->lock);
> +	list_add(&node->list, &hub->udev_list);
> +	mutex_unlock(&hub->lock);
> +
> +	return 0;
> +}
> +
> +static int onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +	struct udev_node *node;
> +
> +	mutex_lock(&hub->lock);
> +
> +	list_for_each_entry(node, &hub->udev_list, list) {

list_for_each_entry_safe()?

> +		if (node->udev == udev) {
> +			list_del(&node->list);
> +			devm_kfree(hub->dev, node);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&hub->lock);
> +
> +	if (node == NULL)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static ssize_t power_off_in_suspend_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", hub->power_off_in_suspend);
> +}
> +
> +static ssize_t power_off_in_suspend_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +	bool val;
> +	int ret;
> +
> +	ret = strtobool(buf, &val);

You should use kstrtobool() instead, right?

> +	if (ret < 0)
> +		return ret;
> +
> +	hub->power_off_in_suspend = val;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(power_off_in_suspend);
> +
> +static int onboard_hub_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct onboard_hub *hub;
> +	int rc;
> +
> +	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> +	if (!hub)
> +		return -ENOMEM;
> +
> +	hub->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(hub->vdd))
> +		return PTR_ERR(hub->vdd);
> +
> +	hub->dev = dev;
> +	mutex_init(&hub->lock);
> +	INIT_LIST_HEAD(&hub->udev_list);
> +
> +	dev_set_drvdata(dev, hub);
> +
> +	rc = sysfs_create_file(&dev->kobj, &dev_attr_power_off_in_suspend.attr);

Use the default platform device files group, never create/add your own
sysfs files "by hand", otherwise it could go easily wrong.


> +	if (rc)
> +		return rc;
> +
> +	return onboard_hub_power_on(hub);
> +}
> +
> +static int onboard_hub_remove(struct platform_device *pdev)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> +
> +	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_power_off_in_suspend.attr);

If you do the above, no need to remove this here.

> +
> +	return onboard_hub_power_off(hub);
> +}
> +
> +static const struct of_device_id onboard_hub_match[] = {
> +	{ .compatible = "onboard-usb-hub" },
> +	{ .compatible = "realtek,rts5411" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, onboard_hub_match);
> +
> +static SIMPLE_DEV_PM_OPS(onboard_hub_pm_ops, onboard_hub_suspend, onboard_hub_resume);
> +
> +static struct platform_driver onboard_hub_driver = {
> +	.probe = onboard_hub_probe,
> +	.remove = onboard_hub_remove,
> +
> +	.driver = {
> +		.name = "onboard-usb-hub",
> +		.of_match_table = onboard_hub_match,
> +		.pm = pm_ptr(&onboard_hub_pm_ops),
> +	},
> +};
> +
> +/************************** USB driver **************************/
> +
> +#define VENDOR_ID_REALTEK	0x0bda
> +
> +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> +{
> +	const phandle *ph;
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +
> +	ph = of_get_property(dev->of_node, "hub", NULL);
> +	if (!ph) {
> +		dev_err(dev, "failed to read 'hub' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	np = of_find_node_by_phandle(be32_to_cpu(*ph));
> +	if (!np) {
> +		dev_err(dev, "failed find device node for onboard hub\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);

Why can you defer here?

> +
> +	return dev_get_drvdata(&pdev->dev);
> +}
> +
> +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> +{
> +	struct device *dev = &udev->dev;
> +	struct onboard_hub *hub;
> +
> +	/* ignore supported hubs without device tree node */
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	hub = _find_onboard_hub(dev);
> +	if (IS_ERR(hub))
> +		return PTR_ERR(dev);
> +
> +	dev_set_drvdata(dev, hub);
> +
> +	onboard_hub_add_usbdev(hub, udev);
> +
> +	return 0;
> +}
> +
> +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
> +
> +	onboard_hub_remove_usbdev(hub, udev);
> +
> +	put_device(hub->dev);
> +}
> +
> +static const struct usb_device_id onboard_hub_id_table[] = {
> +	{ .idVendor = VENDOR_ID_REALTEK,
> +	  .idProduct = 0x0411, /* RTS5411 USB 3.0 */
> +	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
> +	{ .idVendor = VENDOR_ID_REALTEK,
> +	  .idProduct = 0x5411, /* RTS5411 USB 2.0 */
> +	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },

USB_DEVICE() should be used here instead for both of these, right?

> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> +
> +static struct usb_device_driver onboard_hub_usbdev_driver = {
> +
> +	.name = "onboard-usb-hub",
> +	.probe = onboard_hub_usbdev_probe,
> +	.disconnect = onboard_hub_usbdev_disconnect,
> +	.generic_subclass = 1,
> +	.supports_autosuspend =	1,
> +	.id_table = onboard_hub_id_table,
> +};
> +
> +/************************** Driver (de)registration **************************/
> +
> +static int __init onboard_hub_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_driver_register(&onboard_hub_driver);
> +	if (rc)
> +		return rc;
> +
> +	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);

No unwinding of the platform driver register if this fails?

And THIS_MODULE should not be needed, did we get the api wrong here?

> +}
> +device_initcall(onboard_hub_init);

Why device_initcall() if this could be a module?  Why not a normal
module_init()?

thanks,

greg k-h
