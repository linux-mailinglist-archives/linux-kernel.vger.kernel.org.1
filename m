Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C172737DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgIVBSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgIVBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:18:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 18:18:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l71so10573947pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1aH0rYM25nAL8VLj+CpdiKvx2EP8pVi2wJxx1s/n4ro=;
        b=lLBL/Eqs6/CCaAp6i2GZv8DVklgaxABj2nnsAfYranqi8z5Ww8mZVMQT7B7921Xqsr
         zxmq7CvO6XExhaIpLK47uJPyTx+QypxNJFp1zM8kOo+Cw3z+EBvAXeX1K6XwNnYepNrb
         ApA/u4C5RTqO6qrXa/dVG7dT73Wz7DlaDzo8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1aH0rYM25nAL8VLj+CpdiKvx2EP8pVi2wJxx1s/n4ro=;
        b=H04ulXjOk0Y+sTX8VxYkWV+gfP6lUEHtz/AUdIszfjV1cTQdxXtkA1vwJpSiZR0YOO
         ohaWiY+kvNFK/rjgsZVxL7PCrsKgyu9+31rDBdPo/n3HAXffOzIzlZq8eTUZG4g2/VQD
         BRsKG6ClAmfJsdrBxitv5y3mQ89ICnRRMTfFYF3cRoywfpc6d0WuLiqP19tmRiEG5PBI
         sVHEPBM2WhfEPWPQcqL7JnXO1OSyrcslOGcnSdt7q6XElT3zO2wedLkyT5u7ToV9ZUmj
         dZ1TGSr0UjKzIfOcihE9GKZZuNSxcZwzerFsj9H6HLBM5Hv0oQzaIR0VXfvgrvJ6dJ/4
         Ri0A==
X-Gm-Message-State: AOAM5316+dpXgoGxUbsRugNg/ubKlu5dtBL++OxDXrtfhgBFYoSSmwK8
        eJBLG7M9CvY3WjsdLeYVS3oy+A==
X-Google-Smtp-Source: ABdhPJyzCzf2YyrHewwNzw4wepJ1ugJLyR7tDtqtCNgVfRaJNVxkWQk9bVpbM498QXAotQV8SJVqrA==
X-Received: by 2002:aa7:934e:0:b029:13f:d056:593 with SMTP id 14-20020aa7934e0000b029013fd0560593mr2153404pfn.15.1600737519208;
        Mon, 21 Sep 2020 18:18:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id c1sm13042091pfi.136.2020.09.21.18.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 18:18:38 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:18:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20200922011837.GE21107@google.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200920141720.GD2915460@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920141720.GD2915460@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks for the review!

On Sun, Sep 20, 2020 at 04:17:20PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 17, 2020 at 11:46:22AM -0700, Matthias Kaehlcke wrote:
> > The main issue this driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For onboard hubs this is often
> > solved by supplying the hub with an 'always-on' regulator, which is
> > kind of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires further hacks. This driver creates a platform device
> > representing the hub which performs the necessary initialization.
> > Currently it only supports switching on a single regulator, support
> > for multiple regulators or other actions can be added as needed.
> > Different initialization sequences can be supported based on the
> > compatible string.
> > 
> > Besides performing the initialization the driver can be configured
> > to power the hub off during system suspend. This can help to extend
> > battery life on battery powered devices which have no requirements
> > to keep the hub powered during suspend. The driver can also be
> > configured to leave the hub powered when a wakeup capable USB device
> > is connected when suspending, and power it off otherwise.
> > 
> > Technically the driver consists of two drivers, the platform driver
> > described above and a very thin USB driver that subclasses the
> > generic driver. The purpose of this driver is to provide the platform
> > driver with the USB devices corresponding to the hub(s) (a hub
> > controller may provide multiple 'logical' hubs, e.g. one to support
> > USB 2.0 and another for USB 3.x).
> > 
> > Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v2:
> > - check wakeup enabled state of the USB controller instead of
> >   using 'wakeup-source' property
> > - use sysfs attribute instead of DT property to determine if
> >   the hub should be powered off at all during system suspend
> > - added missing brace in onboard_hub_suspend()
> > - updated commit message
> > - use pm_ptr for pm_ops as suggested by Alan
> > 
> > Changes in v1:
> > - renamed the driver to 'onboard_usb_hub'
> > - single file for platform and USB driver
> > - USB hub devices register with the platform device
> >   - the DT includes a phandle of the platform device
> > - the platform device now controls when power is turned off
> > - the USB driver became a very thin subclass of the generic USB
> >   driver
> > - enabled autosuspend support
> > 
> >  drivers/usb/misc/Kconfig           |  15 ++
> >  drivers/usb/misc/Makefile          |   1 +
> >  drivers/usb/misc/onboard_usb_hub.c | 329 +++++++++++++++++++++++++++++
> >  3 files changed, 345 insertions(+)
> >  create mode 100644 drivers/usb/misc/onboard_usb_hub.c
> > 
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 6818ea689cd9..e941244e24e5 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -275,3 +275,18 @@ config USB_CHAOSKEY
> >  
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called chaoskey.
> > +
> > +config USB_ONBOARD_HUB
> > +	tristate "Onboard USB hub support"
> > +	depends on OF
> 
> What about COMPILE_TEST as well?

ok

> > +	help
> > +	  Say Y here if you want to support onboard USB hubs. The driver
> > +	  powers supported hubs on and may perform other initialization
> > +	  steps.
> > +
> > +	  The driver can also switch off the power of the hub during
> > +	  system suspend if it is configured accordingly. This may
> > +	  reduce power consumption while the system is suspended.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called onboard_usb_hub.
> > diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> > index da39bddb0604..6f10a1c6f7e9 100644
> > --- a/drivers/usb/misc/Makefile
> > +++ b/drivers/usb/misc/Makefile
> > @@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
> >  
> >  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
> >  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> > +obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > new file mode 100644
> > index 000000000000..206798029041
> > --- /dev/null
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -0,0 +1,329 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  Driver for onboard USB hubs
> > + *
> > + * Copyright (c) 2020, Google LLC
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/suspend.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> > +#include "../core/usb.h"
> 
> Why do you need private usb core functions?

An earlier version of the driver used usb_port_disable(), but that isn't needed
anymore, I'll remove the include.

> > +
> > +/************************** Platform driver **************************/
> > +
> > +struct udev_node {
> > +	struct usb_device *udev;
> > +	struct list_head list;
> > +};
> > +
> > +struct onboard_hub {
> > +	struct regulator *vdd;
> > +	struct device *dev;
> > +	bool power_off_in_suspend;
> > +	struct list_head udev_list;
> > +	struct mutex lock;
> > +	bool has_wakeup_capable_descendants;
> > +};
> > +
> > +static int onboard_hub_power_on(struct onboard_hub *hub)
> > +{
> > +	int err;
> > +
> > +	err = regulator_enable(hub->vdd);
> > +	if (err) {
> > +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> > +		return err;
> > +	}
> 
> Nit, no need for { } or return err here, just return err one line below.

ack

> > +
> > +	return 0;
> > +}
> > +
> > +static int onboard_hub_power_off(struct onboard_hub *hub)
> > +{
> > +	int err;
> > +
> > +	err = regulator_disable(hub->vdd);
> > +	if (err) {
> > +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> 
> Same here.

ack

> > +}
> > +
> > +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	struct udev_node *node;
> > +	int rc = 0;
> > +
> > +	hub->has_wakeup_capable_descendants = false;
> > +
> > +	if (!hub->power_off_in_suspend)
> > +		return 0;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> > +		if (!device_may_wakeup(node->udev->bus->controller))
> > +			break;
> > +
> > +		if (usb_wakeup_enabled_descendants(node->udev)) {
> > +			hub->has_wakeup_capable_descendants = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	if (!hub->has_wakeup_capable_descendants)
> > +		rc = onboard_hub_power_off(hub);
> > +
> > +	return rc;
> > +}
> > +
> > +static int __maybe_unused onboard_hub_resume(struct device *dev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	int rc = 0;
> > +
> > +	if (hub->power_off_in_suspend && !hub->has_wakeup_capable_descendants)
> > +		rc = onboard_hub_power_on(hub);
> > +
> > +	return rc;
> > +}
> > +
> > +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +
> > +	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> > +	if (!node)
> > +		return -ENOMEM;
> > +
> > +	node->udev = udev;
> 
> No reference counting?  Are you sure about this?

I thought it isn't strictly needed, since this function is only called by the
onboard_hub_usbdev driver, which also calls onboard_hub_remove_usbdev() on
disconnect. So my thinking was that the driver trusts itself, like the kernel.
Am I missing a case?

> > +
> > +	mutex_lock(&hub->lock);
> > +	list_add(&node->list, &hub->udev_list);
> > +	mutex_unlock(&hub->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> 
> list_for_each_entry_safe()?

I can change it, but IIUC it shouldn't be really necessary, since the loop
is aborted after removing the node.

> > +		if (node->udev == udev) {
> > +			list_del(&node->list);
> > +			devm_kfree(hub->dev, node);
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	if (node == NULL)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t power_off_in_suspend_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%d\n", hub->power_off_in_suspend);
> > +}
> > +
> > +static ssize_t power_off_in_suspend_store(struct device *dev, struct device_attribute *attr,
> > +			    const char *buf, size_t count)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	bool val;
> > +	int ret;
> > +
> > +	ret = strtobool(buf, &val);
> 
> You should use kstrtobool() instead, right?

Will change

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	hub->power_off_in_suspend = val;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(power_off_in_suspend);
> > +
> > +static int onboard_hub_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct onboard_hub *hub;
> > +	int rc;
> > +
> > +	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> > +	if (!hub)
> > +		return -ENOMEM;
> > +
> > +	hub->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(hub->vdd))
> > +		return PTR_ERR(hub->vdd);
> > +
> > +	hub->dev = dev;
> > +	mutex_init(&hub->lock);
> > +	INIT_LIST_HEAD(&hub->udev_list);
> > +
> > +	dev_set_drvdata(dev, hub);
> > +
> > +	rc = sysfs_create_file(&dev->kobj, &dev_attr_power_off_in_suspend.attr);
> 
> Use the default platform device files group, never create/add your own
> sysfs files "by hand", otherwise it could go easily wrong.

Ok

> > +	if (rc)
> > +		return rc;
> > +
> > +	return onboard_hub_power_on(hub);
> > +}
> > +
> > +static int onboard_hub_remove(struct platform_device *pdev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> > +
> > +	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_power_off_in_suspend.attr);
> 
> If you do the above, no need to remove this here.
> 
> > +
> > +	return onboard_hub_power_off(hub);
> > +}
> > +
> > +static const struct of_device_id onboard_hub_match[] = {
> > +	{ .compatible = "onboard-usb-hub" },
> > +	{ .compatible = "realtek,rts5411" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, onboard_hub_match);
> > +
> > +static SIMPLE_DEV_PM_OPS(onboard_hub_pm_ops, onboard_hub_suspend, onboard_hub_resume);
> > +
> > +static struct platform_driver onboard_hub_driver = {
> > +	.probe = onboard_hub_probe,
> > +	.remove = onboard_hub_remove,
> > +
> > +	.driver = {
> > +		.name = "onboard-usb-hub",
> > +		.of_match_table = onboard_hub_match,
> > +		.pm = pm_ptr(&onboard_hub_pm_ops),
> > +	},
> > +};
> > +
> > +/************************** USB driver **************************/
> > +
> > +#define VENDOR_ID_REALTEK	0x0bda
> > +
> > +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > +{
> > +	const phandle *ph;
> > +	struct device_node *np;
> > +	struct platform_device *pdev;
> > +
> > +	ph = of_get_property(dev->of_node, "hub", NULL);
> > +	if (!ph) {
> > +		dev_err(dev, "failed to read 'hub' property\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	np = of_find_node_by_phandle(be32_to_cpu(*ph));
> > +	if (!np) {
> > +		dev_err(dev, "failed find device node for onboard hub\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	pdev = of_find_device_by_node(np);
> > +	of_node_put(np);
> > +	if (!pdev)
> > +		return ERR_PTR(-EPROBE_DEFER);
> 
> Why can you defer here?

We know there is a node, so if the device can not be found it probably
hasn't been probed yet?

> > +
> > +	return dev_get_drvdata(&pdev->dev);
> > +}
> > +
> > +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> > +{
> > +	struct device *dev = &udev->dev;
> > +	struct onboard_hub *hub;
> > +
> > +	/* ignore supported hubs without device tree node */
> > +	if (!dev->of_node)
> > +		return -ENODEV;
> > +
> > +	hub = _find_onboard_hub(dev);
> > +	if (IS_ERR(hub))
> > +		return PTR_ERR(dev);
> > +
> > +	dev_set_drvdata(dev, hub);
> > +
> > +	onboard_hub_add_usbdev(hub, udev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
> > +
> > +	onboard_hub_remove_usbdev(hub, udev);
> > +
> > +	put_device(hub->dev);
> > +}
> > +
> > +static const struct usb_device_id onboard_hub_id_table[] = {
> > +	{ .idVendor = VENDOR_ID_REALTEK,
> > +	  .idProduct = 0x0411, /* RTS5411 USB 3.0 */
> > +	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
> > +	{ .idVendor = VENDOR_ID_REALTEK,
> > +	  .idProduct = 0x5411, /* RTS5411 USB 2.0 */
> > +	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
> 
> USB_DEVICE() should be used here instead for both of these, right?

ack

> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> > +
> > +static struct usb_device_driver onboard_hub_usbdev_driver = {
> > +
> > +	.name = "onboard-usb-hub",
> > +	.probe = onboard_hub_usbdev_probe,
> > +	.disconnect = onboard_hub_usbdev_disconnect,
> > +	.generic_subclass = 1,
> > +	.supports_autosuspend =	1,
> > +	.id_table = onboard_hub_id_table,
> > +};
> > +
> > +/************************** Driver (de)registration **************************/
> > +
> > +static int __init onboard_hub_init(void)
> > +{
> > +	int rc;
> > +
> > +	rc = platform_driver_register(&onboard_hub_driver);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
> 
> No unwinding of the platform driver register if this fails?

Right, will add unwinding.

> And THIS_MODULE should not be needed, did we get the api wrong here?

It seems you suggest to use usb_register() instead, SGTM

> > +}
> > +device_initcall(onboard_hub_init);
> 
> Why device_initcall() if this could be a module?  Why not a normal
> module_init()?

Ok, will change it to module_init()

Thanks

Matthias
