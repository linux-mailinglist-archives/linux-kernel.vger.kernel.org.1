Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077527753E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgIXP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:28:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39601 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728285AbgIXP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:28:00 -0400
Received: (qmail 1340421 invoked by uid 1000); 24 Sep 2020 11:27:58 -0400
Date:   Thu, 24 Sep 2020 11:27:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v3 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200924152758.GA1337044@rowland.harvard.edu>
References: <20200923180952.v3.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200923180952.v3.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923180952.v3.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 06:10:12PM -0700, Matthias Kaehlcke wrote:
> The main issue this driver addresses is that a USB hub needs to be
> powered before it can be discovered. For discrete onboard hubs (an
> example for such a hub is the Realtek RTS5411) this is often solved
> by supplying the hub with an 'always-on' regulator, which is kind
> of a hack. Some onboard hubs may require further initialization
> steps, like changing the state of a GPIO or enabling a clock, which
> requires even more hacks. This driver creates a platform device
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

> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -275,3 +275,19 @@ config USB_CHAOSKEY
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called chaoskey.
> +
> +config USB_ONBOARD_HUB
> +	tristate "Onboard USB hub support"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say Y here if you want to support discrete onboard USB hubs that
> +	  don't require an additional control bus for initialization (an

... but does require nontrivial form of initialization, such as
enabling a power regulator.


> +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +	struct udev_node *node;
> +
> +	smp_rmb();
> +	if (hub->going_away) {
> +		/*
> +		 * We are most likely being called as a result of unbinding a USB device from
> +		 * onboard_hub_remove(). This function also holds the lock and iterates over
> +		 * 'udev_list'. Skip deleting the node in this case to avoid a self deadlock,
> +		 * keeping the node in the list isn't a problem, since the device is about to go
> +		 * away.
> +		 */
> +		return;
> +	}

This part has a suspicious look.  For one thing, there's no comment
explaining the purpose of the smp_rmb().  For another, that barrier
doesn't seem to pair with any other memory barrier in the driver.

I get that you want to avoid self-deadlock here.  But there must be a
better way.  See below.

> +static int onboard_hub_remove(struct platform_device *pdev)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> +	struct udev_node *node;
> +
> +	hub->going_away = true;
> +
> +	mutex_lock(&hub->lock);
> +
> +	/* unbind the USB devices to avoid dangling references to this device */
> +	list_for_each_entry(node, &hub->udev_list, list)
> +		device_release_driver(&node->udev->dev);
> +
> +	mutex_unlock(&hub->lock);

Alternative approach:

	/* unbind the USB devices to avoid dangling references to this device */
	mutex_lock(&hub->lock);
	while (!list_empty(&hub->udev_list)) {
		node = list_first_entry(&hub->udev_list, struct udev_node, list);
		udev = node->udev;

		/*
		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
		 * which acquires hub->lock.  We must release the lock first.
		 */
		usb_get_device(udev);
		mutex_unlock(&hub->lock);
		device_release_driver(&udev->dev);
		usb_put_device(udev);
		mutex_lock(&hub->lock);
	}
	mutex_unlock(&hub->lock);

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

hub, not dev.

Alan Stern
