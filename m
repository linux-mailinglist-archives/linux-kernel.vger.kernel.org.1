Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01012737A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgIVAmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgIVAmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:42:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55150C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:42:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so10488315pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaGeSvPYLRYBm98UO6Jry86VMBCqcS8gmrX0rLLRuOo=;
        b=UVWVU0fbt3UEKUYJ92XpmWL02+0ZZG+3A1SSfXv4mzj9EmM+5wPT0JugLs1A1pTkgs
         GvwFgkaLyI7j3I22oeHMuDDE7hUnqOrHHOkP8Msf3V+Ax6fnak1f0BqDfabxgg9kmDXb
         fEd7tC05asleoEk921rx4kEVfKq3LyTKxAUdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaGeSvPYLRYBm98UO6Jry86VMBCqcS8gmrX0rLLRuOo=;
        b=bHEIA1TgSyIE81muC9TdjgBXEsWBD/Ou/GsdHCz1qnphml2EK1A4TGPi6KosJe2zYH
         4XBATZhkcncZ5ABVENs5ZRS5PxWIi2CmeYgoEBPccveJsCHuFt/oE5EktNlSvVmaQBFs
         rLKFrbRJwAXOL3SGvzL9ZRErlYDOWXa9uWG+mZ5MzkJTr2xZrkMF2/H6tbCqMM0zxAoW
         rs+sJBkJUTr59Ud+cnCcVzex62KSnd9XrdQdZy9r24BNaXv4dAMpbFdzchkDrZy1TO37
         qNKYA2OBdyYjK6BQRK5FToi1qTGF8TtTm1hpISkfuqzzje3rqzIyBtqgIGW7tHBk60Zl
         /wYA==
X-Gm-Message-State: AOAM530DO1rFulqkziFwp9p1m3VZT6SHrQirCE5HiiVj14WG6mDMfyCs
        LOilKwx2kj83BXJogcqpbgGWhQ==
X-Google-Smtp-Source: ABdhPJzrP7IAhyFSlSdePZhYT6llTUXfmudyC5btRBnQE8UwmQ3o815KAwRkrvJlha1c1bQQjUFnZw==
X-Received: by 2002:a63:3645:: with SMTP id d66mr1639938pga.167.1600735320822;
        Mon, 21 Sep 2020 17:42:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id e123sm13488203pfh.167.2020.09.21.17.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 17:42:00 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:41:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200922004158.GC21107@google.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200917195416.GA1099735@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917195416.GA1099735@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

thanks for taking time to review!

On Thu, Sep 17, 2020 at 03:54:16PM -0400, Alan Stern wrote:
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
> 
> > +config USB_ONBOARD_HUB
> > +	tristate "Onboard USB hub support"
> > +	depends on OF
> > +	help
> > +	  Say Y here if you want to support onboard USB hubs. The driver
> > +	  powers supported hubs on and may perform other initialization
> > +	  steps.
> 
> I have a nagging feeling that this description may be too vague for a
> lot of people to understand.  Does everybody know what an "onboard"
> USB hub is?
> 
> Consider for example that Intel's current EHCI host controllers all
> come with a USB hub built into the chipset.  That built-in hub
> certainly could be considered "onboard", but it doesn't need this
> driver.
> 
> Maybe also give some examples of devices that require this driver, to
> help make the idea clear to readers.

Ok, I'll try to come up with a better description.

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
> 
> You're assuming that node->udev->bus->controller is going to be the
> same for the nodes on the list, right?

Yes, that is the assumption, although you have a point that this isn't
necessarily the case. It's probably true in the vast majority of cases,
but a hub could be wired up to multiple controllers. I'll change the
loop to set the flag without breaking, it's a micro-optimization
anyway.

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
> 
> Instead of this cumbersome two-condition test, how about simply
> having a hub->is_powered_on flag?  Then
> hub->has_wakeup_capable_descendants wouldn't be needed.

Ok, less cumbersome code is always good :)

> > +		rc = onboard_hub_power_on(hub);
> > +
> > +	return rc;
> > +}
> 
> > +static int onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> > +		if (node->udev == udev) {
> > +			list_del(&node->list);
> > +			devm_kfree(hub->dev, node);
> 
> Why have an explicit kfree here but not anywhere else?  And if you do
> have an explicit kfree, why use devm_kzalloc rather than plain kzalloc?

The motivation of the explicit kfree was to avoid hogging memory if the
USB device disappears and reappears repeatedly. However this doesn't seem
to be a very common scenario so maybe we can ignore it.

> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	if (node == NULL)
> > +		return -EINVAL;
> 
> This test is wrong.  Look at the definition of list_for_each_entry;
> node will never be NULL.  Probably the best approach is to use a local
> "ret" variable.

Ack, thanks for catching!

> > +
> > +	return 0;
> > +}
> 
> > +static int onboard_hub_remove(struct platform_device *pdev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> > +
> > +	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_power_off_in_suspend.attr);
> > +
> > +	return onboard_hub_power_off(hub);
> > +}
> 
> Shouldn't this routine unbind the onboard_hub_usbdev driver from all
> the associated devices?  Otherwise you end up with more-or-less
> dangling references to hub (I say more-or-less because with the devm
> allocations, the structures will hang around as zombies for a while).

True, the dangling references aren't a good idea. Initially I thought
that the USB devices holding a reference of the hub device would prevent
this, but apparently that was wishful thinking. IIUC unbinding would be
done through device_driver_detach().

> Relying on the onboard_hub_power_off call to do this for you isn't a
> great idea, because the effect won't happen immediately.
> 
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
> 
> Ignoring the return code?  Then why does that routine return int rather
> than void?

Ok, will abort if the function returns an error.

> > +
> > +	return 0;
> > +}
> > +
> > +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
> > +
> > +	onboard_hub_remove_usbdev(hub, udev);
> 
> Ditto.

In this case it's probably better to change the return type to void, since
there is not really an alternative course of action.

> > +
> > +	put_device(hub->dev);
> 
> Is there a matching get_device somewhere (like in _find_onboard_hub)?
> If so, I didn't see it.  And I don't see any reason for it.

Yes, implicitly, of_find_device_by_node() "takes a reference to the
embedded struct device which needs to be dropped after use."
