Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E435D2B32EF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 09:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKOI1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 03:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgKOI1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 03:27:02 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E7D223FB;
        Sun, 15 Nov 2020 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605428822;
        bh=yPPmO10BjV3QuMLTiJSy+eaPoun4VeN4IOYCFMPIW3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+z3QYRbZNqVk9bpVlVwZDNZxE2pqRbWdky82QdwZCnhutQVhKo4uL1VTsDa0ZE0q
         yY21By/rZPhrNb9jExx73wyEb8XgbIbYgQRplks8YHeL/+yd/3eblrBCvdrXDyzLew
         HSIpQTgMObWKqHc51kCyrdzYJUikL82+NZSdbVEg=
Date:   Sun, 15 Nov 2020 09:26:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: apple-mfi-fastcharge: Use devm_kzalloc and simplify
 the code
Message-ID: <X7DmUsasFnylaY8C@kroah.com>
References: <20201114124249.634234-1-tanure@linux.com>
 <X6/UDpZRDAGDZydT@kroah.com>
 <CAJX_Q+2iLzf8M-vzvrEh6TEhn2bDyg-P5CiHiSOwcmoYxzQgdQ@mail.gmail.com>
 <X6/xhYwdw/RPBXf9@kroah.com>
 <CAJX_Q+0-9=7q=VcM6uP+8mCX2mVAjS4sT52mvpj-hS6rm63DGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX_Q+0-9=7q=VcM6uP+8mCX2mVAjS4sT52mvpj-hS6rm63DGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 08:13:51AM +0000, Lucas Tanure wrote:
> On Sat, Nov 14, 2020 at 3:03 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 14, 2020 at 02:17:48PM +0000, Lucas Tanure wrote:
> > > On Sat, Nov 14, 2020 at 12:56 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Nov 14, 2020 at 12:42:49PM +0000, Lucas Tanure wrote:
> > > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > >
> > > > I can't take patches without any changelog text, sorry.
> > > >
> > > > > ---
> > > > >  drivers/usb/misc/apple-mfi-fastcharge.c | 17 +++++------------
> > > > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > > index 9de0171b5177..de86e389a008 100644
> > > > > --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > > +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > > @@ -178,16 +178,13 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > > >  {
> > > > >       struct power_supply_config battery_cfg = {};
> > > > >       struct mfi_device *mfi = NULL;
> > > > > -     int err;
> > > > >
> > > > >       if (!mfi_fc_match(udev))
> > > > >               return -ENODEV;
> > > > >
> > > > > -     mfi = kzalloc(sizeof(struct mfi_device), GFP_KERNEL);
> > > > > -     if (!mfi) {
> > > > > -             err = -ENOMEM;
> > > > > -             goto error;
> > > > > -     }
> > > > > +     mfi = devm_kzalloc(&udev->dev, sizeof(*mfi), GFP_KERNEL);
> > > > > +     if (!mfi)
> > > > > +             return -ENOMEM;
> > > > >
> > > > >       battery_cfg.drv_data = mfi;
> > > > >
> > > > > @@ -197,8 +194,7 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > > >                                               &battery_cfg);
> > > > >       if (IS_ERR(mfi->battery)) {
> > > > >               dev_err(&udev->dev, "Can't register battery\n");
> > > > > -             err = PTR_ERR(mfi->battery);
> > > > > -             goto error;
> > > > > +             return PTR_ERR(mfi->battery);
> > > > >       }
> > > > >
> > > > >       mfi->udev = usb_get_dev(udev);
> > > > > @@ -206,9 +202,6 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > > >
> > > > >       return 0;
> > > > >
> > > > > -error:
> > > > > -     kfree(mfi);
> > > > > -     return err;
> > > > >  }
> > > > >
> > > > >  static void mfi_fc_disconnect(struct usb_device *udev)
> > > > > @@ -220,7 +213,7 @@ static void mfi_fc_disconnect(struct usb_device *udev)
> > > > >               power_supply_unregister(mfi->battery);
> > > > >       dev_set_drvdata(&udev->dev, NULL);
> > > > >       usb_put_dev(mfi->udev);
> > > > > -     kfree(mfi);
> > > > > +     devm_kfree(&udev->dev, mfi);
> > > >
> > > > Are you sure about this?
> > > I think so, as the probe will allocate again that struct, the
> > > disconnect should free the previous one.
> >
> > Why do you need to manually free it here like this?
> My understanding is that memory will only be freed when the driver
> gets unloaded and the next connection of the device will allocate a
> new one.
> So every new disconnection and re-connection there will be a small
> memory leak until the driver gets unloaded.

devm_* functions operate on the lifecycle of the device, not the driver.
Two totally different things :)

> > Why are you trying to convert this file to this api anyway?
> I was just trying to improve the code as the original source calls
> kfree even when kzalloc fails.

Then please fix that bug independant of any conversion to a new api, as
that is a bugfix that should be backported to older kernels.

> And using devm_* would remove the need for kfree and the end of probe.

Yes, but you can't introduce new bugs when trying to fix existing ones.

Also, you didn't say this was a bugfix anywhere, which is one reason
that writing good changelog text is essencial.

thanks,

greg k-h
