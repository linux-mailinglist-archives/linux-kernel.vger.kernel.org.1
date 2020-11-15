Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0A2B32E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKOIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 03:14:05 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40940 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgKOIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 03:14:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id r5so166482vsp.7;
        Sun, 15 Nov 2020 00:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EIcVWSbGU169K8Uh8qeoR37cku7k7gkjKkBQK5FaYso=;
        b=J2SdI3WeawzTilthTZfg2aXApW4KqM6O9ZNQVjI5LhbNCirAOdwePk1swnUHsJHCOG
         0ciAOeQcXTvifCQvFs7enaorQ5V8SW0e4LdHGUj5zExKNqa+P7Nr6cvgKhgNbWXrboVN
         nbPkH25NfeLb69ieZbzvpeeMWNNyFMywX2crWfV1kaXm2XZ6GrNP+lihW2mM7aP3mVAv
         gL1i46WFkHu47ISL30K8vruttGsPXisYsccEqqdYCoATM+LlnHrLy6vUwc6+DNAFWiMc
         aneZHDzmgnD/QBEDZO5r1ubYMYJNDfe0lFBXTZ0xVZYPReE1eWZ+pb+tRVHspg2JuxIk
         ppCg==
X-Gm-Message-State: AOAM530Frc+Kp9QoWs+UFf4DY9vHzYJl4wOxipmbY5F0YkFpUcN36ECi
        8TkVfQhts+zktufrSFsehbkbNsFR/e3AzA==
X-Google-Smtp-Source: ABdhPJy+aHYX7QcUhihUB3G5w5ep3fCfIF9ChPQ7aiyaCQCG544t2HUYQ9q9hLmIunV2fxlY83X/0w==
X-Received: by 2002:a67:2647:: with SMTP id m68mr5574679vsm.39.1605428043336;
        Sun, 15 Nov 2020 00:14:03 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id v2sm1582642uao.19.2020.11.15.00.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 00:14:03 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id z123so7504037vsb.0;
        Sun, 15 Nov 2020 00:14:02 -0800 (PST)
X-Received: by 2002:a67:2b47:: with SMTP id r68mr5653539vsr.7.1605428042544;
 Sun, 15 Nov 2020 00:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20201114124249.634234-1-tanure@linux.com> <X6/UDpZRDAGDZydT@kroah.com>
 <CAJX_Q+2iLzf8M-vzvrEh6TEhn2bDyg-P5CiHiSOwcmoYxzQgdQ@mail.gmail.com> <X6/xhYwdw/RPBXf9@kroah.com>
In-Reply-To: <X6/xhYwdw/RPBXf9@kroah.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 15 Nov 2020 08:13:51 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+0-9=7q=VcM6uP+8mCX2mVAjS4sT52mvpj-hS6rm63DGg@mail.gmail.com>
Message-ID: <CAJX_Q+0-9=7q=VcM6uP+8mCX2mVAjS4sT52mvpj-hS6rm63DGg@mail.gmail.com>
Subject: Re: [PATCH] USB: apple-mfi-fastcharge: Use devm_kzalloc and simplify
 the code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 3:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 14, 2020 at 02:17:48PM +0000, Lucas Tanure wrote:
> > On Sat, Nov 14, 2020 at 12:56 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Nov 14, 2020 at 12:42:49PM +0000, Lucas Tanure wrote:
> > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > >
> > > I can't take patches without any changelog text, sorry.
> > >
> > > > ---
> > > >  drivers/usb/misc/apple-mfi-fastcharge.c | 17 +++++------------
> > > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > index 9de0171b5177..de86e389a008 100644
> > > > --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> > > > @@ -178,16 +178,13 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > >  {
> > > >       struct power_supply_config battery_cfg = {};
> > > >       struct mfi_device *mfi = NULL;
> > > > -     int err;
> > > >
> > > >       if (!mfi_fc_match(udev))
> > > >               return -ENODEV;
> > > >
> > > > -     mfi = kzalloc(sizeof(struct mfi_device), GFP_KERNEL);
> > > > -     if (!mfi) {
> > > > -             err = -ENOMEM;
> > > > -             goto error;
> > > > -     }
> > > > +     mfi = devm_kzalloc(&udev->dev, sizeof(*mfi), GFP_KERNEL);
> > > > +     if (!mfi)
> > > > +             return -ENOMEM;
> > > >
> > > >       battery_cfg.drv_data = mfi;
> > > >
> > > > @@ -197,8 +194,7 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > >                                               &battery_cfg);
> > > >       if (IS_ERR(mfi->battery)) {
> > > >               dev_err(&udev->dev, "Can't register battery\n");
> > > > -             err = PTR_ERR(mfi->battery);
> > > > -             goto error;
> > > > +             return PTR_ERR(mfi->battery);
> > > >       }
> > > >
> > > >       mfi->udev = usb_get_dev(udev);
> > > > @@ -206,9 +202,6 @@ static int mfi_fc_probe(struct usb_device *udev)
> > > >
> > > >       return 0;
> > > >
> > > > -error:
> > > > -     kfree(mfi);
> > > > -     return err;
> > > >  }
> > > >
> > > >  static void mfi_fc_disconnect(struct usb_device *udev)
> > > > @@ -220,7 +213,7 @@ static void mfi_fc_disconnect(struct usb_device *udev)
> > > >               power_supply_unregister(mfi->battery);
> > > >       dev_set_drvdata(&udev->dev, NULL);
> > > >       usb_put_dev(mfi->udev);
> > > > -     kfree(mfi);
> > > > +     devm_kfree(&udev->dev, mfi);
> > >
> > > Are you sure about this?
> > I think so, as the probe will allocate again that struct, the
> > disconnect should free the previous one.
>
> Why do you need to manually free it here like this?
My understanding is that memory will only be freed when the driver
gets unloaded and the next connection of the device will allocate a
new one.
So every new disconnection and re-connection there will be a small
memory leak until the driver gets unloaded.

>
> Why are you trying to convert this file to this api anyway?
I was just trying to improve the code as the original source calls
kfree even when kzalloc fails.
And using devm_* would remove the need for kfree and the end of probe.

>
> thanks,
>
> greg k-h

Thanks
Lucas
