Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4C2737B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgIVA5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgIVA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:57:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:57:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so10539488pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/2UIHSD+hbD9/XCm2LFBXpV4w2R7LaAj/BBBieDXtOU=;
        b=B6sUsa1QUvAeo3BZNfcv6jwsZiebVcbLS2CGUEVHBYxrAWie0xw/k80T0ceGurIKt+
         2Hr2FAnUJV+8ehvQIPkTA1jpT+RY0P/GQtn3i7/c7Plewzs56cZVgRjsCCkHWsnSmR9y
         lafoqQvNM2JDw4KFfjsi0/vvLfipK0Wb6yM54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2UIHSD+hbD9/XCm2LFBXpV4w2R7LaAj/BBBieDXtOU=;
        b=fOtOLe0Eg83gtRiji1g13W7UREmbwfTv9joaH7Nx42eWPpa7wPkbD+hDIVGlqAKtqk
         tgTeeu7sMn2dqEeG1dXGSBPITXtg9yUraMYq1ujtYmdrDmJb1oJitpkzasM4lo0KgR2S
         jQORLJm8cfd8dOCoPCnc5+my/MecibTnQHxgxrwULN3yrTrXZKQ2PrIY7dqhDdOnFZ3G
         mynAs4prQInIVKVTlRzt2kZ+cfVHlyxD5K6IU8Mjvdh2SwM62Nf8gkqRmpZ2pBC2yOmH
         JFrDIqx2gCOWexUGUu9DlsGX3LocnFaEVZNX/q3iGUKUZq3Km/jLhgXS7KCp9YYpbFGr
         r6Pw==
X-Gm-Message-State: AOAM5329Pw2ZQgjRog8BdDhTOHPM9FEr3DU1RDozKI8OF3+imjdlGlDX
        CKsrRbtbbH6uVWgeGmZ820fcKg==
X-Google-Smtp-Source: ABdhPJz7FrBzPRdx17yONMe68ekQBkxq/errYQZ9czK2iIPqzoMw46wfdmjYq+CCGcFRfSKwYFfz3g==
X-Received: by 2002:a05:6a00:1513:b029:142:2501:34de with SMTP id q19-20020a056a001513b0290142250134demr2040339pfu.55.1600736228551;
        Mon, 21 Sep 2020 17:57:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id ie13sm546943pjb.5.2020.09.21.17.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 17:57:08 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:57:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200922005706.GD21107@google.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200918012935.GA3938@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918012935.GA3938@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Sep 18, 2020 at 01:30:20AM +0000, Peter Chen wrote:
> On 20-09-17 11:46:22, Matthias Kaehlcke wrote:
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
> 
> On board HUB belongs to HUB, this driver is just for possible power and
> initialization requirements for HUB which is hard-wired on board. The
> configuration name USB_HUB_POWER_SUPPLY may more suitable, and at the
> menu and help, you could indicate it is special for HUBs which are
> hard-wired on board.

I'm not convinced about the 'power supply' naming, since as you say there
can be more initialization besides switching on a regulator and the driver
'extends' the hub driver to support switching the hub power off during
system suspend.

So far neither Alan nor Greg have raised concerns about the naming (though
that's still an option ;-). I'm open to change it if we can come up with a
name that clearly describes the driver better than the current name.

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
> > +	if (rc)
> > +		return rc;
> 
> You could use dev_groups for sysfs entry management.

Thanks, will do, Greg also pointed that out.

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
> > +}
> > +device_initcall(onboard_hub_init);
> > +
> > +static void __exit onboard_hub_exit(void)
> > +{
> > +	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
> > +	platform_driver_unregister(&onboard_hub_driver);
> > +}
> > +module_exit(onboard_hub_exit);
> > +
> > +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> > +MODULE_DESCRIPTION("Onboard USB Hub driver");
> 
> Improve the description like mentioned above.

Will have to see if I can come up with something that provides more
information but is at the same time short. I might leave it as is
in the next version if my inspiration fails and be open to specific
suggestions.
