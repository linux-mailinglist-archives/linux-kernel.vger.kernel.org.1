Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E332B2DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKNOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 09:18:02 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43255 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 09:18:01 -0500
Received: by mail-vs1-f65.google.com with SMTP id f7so6726486vsh.10;
        Sat, 14 Nov 2020 06:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2nyHy33MI2x03SLbTYwXPNRWCCKocisnvXz3U5fHmgg=;
        b=R6kvCY9oi1e2FkCNAtfw3ThCWuI0USI2QMbsgUG9Wo/Mt6lQyekrJOLp7RtXN7yAlB
         MUsKoW5KFL06XtkAJp6fCo/f/5UVDCPCGxGURKWVFrpYfv0QiztpiT3Y4Vn0X1HByEkI
         1eukcUuY+XHA6PdAsnb8YjvWS48CiBW+q7QYibQgi9Bqy8J1J0pZHAokpaUItEhPlEYI
         glXbvEUvT+EmdhgPIzZ8/DUaIlQ17yV1fwPVwG+VxjxTo1466yQXAHsvOmlDCKJ5hG5P
         xh3eM8xkCs5sdgFC/R+Io3QPhRcol7ODW8ToA5EFaTrJAGYUuxayuJY2oSrPDn4AW33e
         mhgw==
X-Gm-Message-State: AOAM532eePrdIjARz1WjRUXbdKyE+bGraEd1Yj0LATBo1Qos0DITxG7S
        xJSWcLM3RwC/U/UXPOWzN+irvgJaVTEUGQ==
X-Google-Smtp-Source: ABdhPJxpdBgZHUqD4BJITp8tmhGVt2p4KUfpz2Tjg+rqoLibpduSWzaoDsJKOP05cOk+c4nOwCdSEw==
X-Received: by 2002:a67:6ac6:: with SMTP id f189mr4431356vsc.4.1605363480359;
        Sat, 14 Nov 2020 06:18:00 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id w1sm1207109vsk.34.2020.11.14.06.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 06:18:00 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id t15so3925918ual.6;
        Sat, 14 Nov 2020 06:17:59 -0800 (PST)
X-Received: by 2002:ab0:6d91:: with SMTP id m17mr3490956uah.97.1605363479780;
 Sat, 14 Nov 2020 06:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201114124249.634234-1-tanure@linux.com> <X6/UDpZRDAGDZydT@kroah.com>
In-Reply-To: <X6/UDpZRDAGDZydT@kroah.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sat, 14 Nov 2020 14:17:48 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+2iLzf8M-vzvrEh6TEhn2bDyg-P5CiHiSOwcmoYxzQgdQ@mail.gmail.com>
Message-ID: <CAJX_Q+2iLzf8M-vzvrEh6TEhn2bDyg-P5CiHiSOwcmoYxzQgdQ@mail.gmail.com>
Subject: Re: [PATCH] USB: apple-mfi-fastcharge: Use devm_kzalloc and simplify
 the code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 12:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 14, 2020 at 12:42:49PM +0000, Lucas Tanure wrote:
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
>
> I can't take patches without any changelog text, sorry.
>
> > ---
> >  drivers/usb/misc/apple-mfi-fastcharge.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
> > index 9de0171b5177..de86e389a008 100644
> > --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> > +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> > @@ -178,16 +178,13 @@ static int mfi_fc_probe(struct usb_device *udev)
> >  {
> >       struct power_supply_config battery_cfg = {};
> >       struct mfi_device *mfi = NULL;
> > -     int err;
> >
> >       if (!mfi_fc_match(udev))
> >               return -ENODEV;
> >
> > -     mfi = kzalloc(sizeof(struct mfi_device), GFP_KERNEL);
> > -     if (!mfi) {
> > -             err = -ENOMEM;
> > -             goto error;
> > -     }
> > +     mfi = devm_kzalloc(&udev->dev, sizeof(*mfi), GFP_KERNEL);
> > +     if (!mfi)
> > +             return -ENOMEM;
> >
> >       battery_cfg.drv_data = mfi;
> >
> > @@ -197,8 +194,7 @@ static int mfi_fc_probe(struct usb_device *udev)
> >                                               &battery_cfg);
> >       if (IS_ERR(mfi->battery)) {
> >               dev_err(&udev->dev, "Can't register battery\n");
> > -             err = PTR_ERR(mfi->battery);
> > -             goto error;
> > +             return PTR_ERR(mfi->battery);
> >       }
> >
> >       mfi->udev = usb_get_dev(udev);
> > @@ -206,9 +202,6 @@ static int mfi_fc_probe(struct usb_device *udev)
> >
> >       return 0;
> >
> > -error:
> > -     kfree(mfi);
> > -     return err;
> >  }
> >
> >  static void mfi_fc_disconnect(struct usb_device *udev)
> > @@ -220,7 +213,7 @@ static void mfi_fc_disconnect(struct usb_device *udev)
> >               power_supply_unregister(mfi->battery);
> >       dev_set_drvdata(&udev->dev, NULL);
> >       usb_put_dev(mfi->udev);
> > -     kfree(mfi);
> > +     devm_kfree(&udev->dev, mfi);
>
> Are you sure about this?
I think so, as the probe will allocate again that struct, the
disconnect should free the previous one.

>
> And what's wrong with the existing code?  Using the devm_*() variants
> seems like a "cleanup", but it's not always the case.
I don't know what's wrong, but I will figure out.
>
> thanks,
>
> greg k-h

Thanks
Lucas
