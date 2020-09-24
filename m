Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBB2775EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgIXPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgIXPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:55:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF05C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:55:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so1886347pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fLTh9jL1POsAJyAwBG036fCbpHZ7vFNhvxGxsA/maA=;
        b=UN5kA39n7bx+2dZUFFwEidL4mRPP7F5+vhq7Vy0NJsRMWKRMn+nwjEBoGqwfvfe33V
         cH5rcWsLGJgwwupusUODWGxemHGLnzJYUC6WxkVsCfMBKpB11rOcl0kfxad/Rwu87xqn
         xl/nw49zS7HZspAVyE3x1JnL9dGzuvBCMCrmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7fLTh9jL1POsAJyAwBG036fCbpHZ7vFNhvxGxsA/maA=;
        b=WcnKoaNp82iO2pqqUZwAqCSewqF0Two+mzINzPMWR9hlbenxv3FtkTWH13WHYXeJ+3
         xBmg2HrYX0wnEdhO4D8RHYZi0zff9PYfAkgLLuDWRz9a+gRZSVd9s7sgOhLlxbDKxGl/
         E6aSdibY+NuMlznTiINuUrW9Sl29oXiJv47WJ21l7yPZCz1FTEu6Xo33VvfN5RJBKFZQ
         AsxNK/BDft3iOSxsOKF48v7y21o0jmZX3L4wTJ7j0Y4zsNzHQtDIHHmqLTotPeoTX1TY
         rQ+9GEFrcqWxEPmbzits37zQ2oWGnf+NeuQUAwMeQeUZt3+ZmMJviEgF93AA67enm/+m
         EsdA==
X-Gm-Message-State: AOAM533GMUsNo/krHTtI5ZhfvlcGiNzhK8mYLxxpD+Haq+Fs3aEW5yED
        jmgxMs5R9boCHA5qfL5kwr+xoQ==
X-Google-Smtp-Source: ABdhPJwRSAiXyiNg0VJvCtL0dZgy6vfq+3uHTNuSGySrHdwBGL0d9FBnfZeCzUV9uWPYYfZ70FmCFw==
X-Received: by 2002:a17:902:8f8f:b029:d2:439c:3b7d with SMTP id z15-20020a1709028f8fb02900d2439c3b7dmr4963448plo.39.1600962923888;
        Thu, 24 Sep 2020 08:55:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id i9sm3404790pfq.53.2020.09.24.08.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:55:23 -0700 (PDT)
Date:   Thu, 24 Sep 2020 08:55:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20200924155521.GA3165145@google.com>
References: <20200923180952.v3.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200923180952.v3.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200924152758.GA1337044@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924152758.GA1337044@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, Sep 24, 2020 at 11:27:58AM -0400, Alan Stern wrote:
> On Wed, Sep 23, 2020 at 06:10:12PM -0700, Matthias Kaehlcke wrote:
> > The main issue this driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For discrete onboard hubs (an
> > example for such a hub is the Realtek RTS5411) this is often solved
> > by supplying the hub with an 'always-on' regulator, which is kind
> > of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires even more hacks. This driver creates a platform device
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
> 
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -275,3 +275,19 @@ config USB_CHAOSKEY
> >  
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called chaoskey.
> > +
> > +config USB_ONBOARD_HUB
> > +	tristate "Onboard USB hub support"
> > +	depends on OF || COMPILE_TEST
> > +	help
> > +	  Say Y here if you want to support discrete onboard USB hubs that
> > +	  don't require an additional control bus for initialization (an
> 
> ... but does require nontrivial form of initialization, such as
> enabling a power regulator.

ok, I'll add that

> > +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +
> > +	smp_rmb();
> > +	if (hub->going_away) {
> > +		/*
> > +		 * We are most likely being called as a result of unbinding a USB device from
> > +		 * onboard_hub_remove(). This function also holds the lock and iterates over
> > +		 * 'udev_list'. Skip deleting the node in this case to avoid a self deadlock,
> > +		 * keeping the node in the list isn't a problem, since the device is about to go
> > +		 * away.
> > +		 */
> > +		return;
> > +	}
> 
> This part has a suspicious look.  For one thing, there's no comment
> explaining the purpose of the smp_rmb().  For another, that barrier
> doesn't seem to pair with any other memory barrier in the driver.

IIUC the mutex_lock() in onboard_hub_remove() is an implicit barrier, but
it is indeed not obvious from looking at the code.

> I get that you want to avoid self-deadlock here.  But there must be a
> better way.  See below.

I wasn't super happy about this either ...

> > +static int onboard_hub_remove(struct platform_device *pdev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> > +	struct udev_node *node;
> > +
> > +	hub->going_away = true;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	/* unbind the USB devices to avoid dangling references to this device */
> > +	list_for_each_entry(node, &hub->udev_list, list)
> > +		device_release_driver(&node->udev->dev);
> > +
> > +	mutex_unlock(&hub->lock);
> 
> Alternative approach:
> 
> 	/* unbind the USB devices to avoid dangling references to this device */
> 	mutex_lock(&hub->lock);
> 	while (!list_empty(&hub->udev_list)) {
> 		node = list_first_entry(&hub->udev_list, struct udev_node, list);
> 		udev = node->udev;
> 
> 		/*
> 		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
> 		 * which acquires hub->lock.  We must release the lock first.
> 		 */
> 		usb_get_device(udev);
> 		mutex_unlock(&hub->lock);
> 		device_release_driver(&udev->dev);
> 		usb_put_device(udev);
> 		mutex_lock(&hub->lock);
> 	}
> 	mutex_unlock(&hub->lock);
>

Thanks, that should work. I also thought about unlocking the mutex before
calling device_release_driver(), but that wouldn't be the right thing when
using list_for_each_entry(_safe). The alternative loop style allows for it.

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
> 
> hub, not dev.

ugh, yes
