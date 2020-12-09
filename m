Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6A2D4E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbgLIXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgLIXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:00:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D4C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:59:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d14so2412538qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGVpH46Y7Ns607Ym8+8VlXliCHyKOwhz1ihyoKRqkgA=;
        b=JAf4R4DdRjm0G9P817PRtU4y28lwz4LVe/ebp1hiuMjKGYGdC3D4dk9e6uaGKIDhfr
         kX5MP3muxV7N6NUoicnNC8n83neusTxe8kW+n+qdE9ZHzVGaKmWo7pJ3bzBZ9tkqznA8
         rFj2Ou7Np6prwsc7wNFUDF0hJ19W9xS8EHg34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGVpH46Y7Ns607Ym8+8VlXliCHyKOwhz1ihyoKRqkgA=;
        b=eksSY9VJBdFuj3n4n0U7qlDR8W4bh+3RweZhOhnFGl4Sv/DzoTHhk0qfIVlqc4zRuE
         bcxh6VxKUcVxnc8a7GAxgo104Frvwp9UNoFKdZL4JayCIDJ83SmZe35CNOCL01AVv9Fx
         7/Vgkw2yTxT3eWWPHMCCzsSdn4ftIzlCjtNtPIk4tEKPoKbL0e0DUB2ZOWuDPHBiaaQS
         TOJVXEWAOuRtlJLZiJBozi7M36KpUzeMwpPU68mVEh0iRNsoM6ZmYE8J83IpBvQQz0l3
         zXYP/oXz6LQFA4xs9jtJxDCghjIAmiDld2RIaSWqseHEXavAN0ON0AVlJ7BNLvBxjIX5
         +ujg==
X-Gm-Message-State: AOAM533VDAkC3C84xjoOyrm30tvCUY4HPqz7BPDeChK0lT9P6eyz1rP8
        1Iw024IjZv44SY1qeZUDffw72pL4gZH2dZsPP3RgdQ==
X-Google-Smtp-Source: ABdhPJyHxwWBajJb9vFDUnfaQR80KHMaN9kN3HFayyO1ax2QQlpRCsQji50AaT2tljlbbtpt6swwpryLzj6puHoyrW8=
X-Received: by 2002:a37:744:: with SMTP id 65mr5224292qkh.71.1607554781012;
 Wed, 09 Dec 2020 14:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203030846.51669-1-pmalani@chromium.org> <20201208093734.GD680328@kuha.fi.intel.com>
 <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
 <20201209161356.GI680328@kuha.fi.intel.com> <CACeCKacdcGi_6VW7F9agN+bgRH7gAXLDxK7DngE=fPkYT-CWNQ@mail.gmail.com>
 <20201209171524.GK680328@kuha.fi.intel.com>
In-Reply-To: <20201209171524.GK680328@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 9 Dec 2020 14:59:29 -0800
Message-ID: <CACeCKafc6A-O09LrTsYgBTbmwVV0y-tEevj_Ci188WmT=hkjxg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: Add bus type for plug alt modes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Dec 9, 2020 at 9:15 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Prashant,
>
> On Wed, Dec 09, 2020 at 08:22:52AM -0800, Prashant Malani wrote:
> > Hi Heikki,
> >
> > On Wed, Dec 9, 2020 at 8:14 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Dec 08, 2020 at 03:45:19PM -0800, Prashant Malani wrote:
> > > > Hi Heikki,
> > > >
> > > > Thanks a lot for looking at the patch.
> > > >
> > > > On Tue, Dec 8, 2020 at 1:37 AM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> > > > > > Add the Type C bus for plug alternate modes which are being
> > > > > > registered via the Type C connector class. This ensures that udev events
> > > > > > get generated when plug alternate modes are registered (and not just for
> > > > > > partner/port alternate modes), even though the Type C bus doesn't link
> > > > > > plug alternate mode devices to alternate mode drivers.
> > > > >
> > > > > I still don't understand how is the uevent related to the bus? If you
> > > > > check the device_add() function, on line 2917, kobject_uevent() is
> > > > > called unconditionally. The device does not need a bus for that event
> > > > > to be generated.
> > > >
> > > > My initial thought process was to see what is the difference in the adev device
> > > > initialization between partner altmode and plug altmode (the only difference I saw in
> > > > typec_register_altmode() was regarding the bus field).
> > > >
> > > > Yes, kobject_uevent() is called unconditionally, but it's return value isn't checked,
> > > > so we don't know if it succeeded or not.
> > > >
> > > > In the case of cable plug altmode, I see it fail with the following error[1]:
> > > >
> > > > [  114.431409] kobject: 'port1-plug0.0' (000000004ad42956): kobject_uevent_env: filter function caused the event to drop!
> > > >
> > > > I think the filter function which is called is this one: drivers/base/core.c: dev_uevent_filter() [2]
> > > >
> > > > static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
> > > > {
> > > >       struct kobj_type *ktype = get_ktype(kobj);
> > > >
> > > >       if (ktype == &device_ktype) {
> > > >               struct device *dev = kobj_to_dev(kobj);
> > > >               if (dev->bus)
> > > >                       return 1;
> > > >               if (dev->class)
> > > >                       return 1;
> > > >       }
> > > >       return 0;
> > > > }
> > > >
> > > > So, both the "if (dev->bus)" and "if (dev->class)" checks are failing here. In the case of partner alt modes, bus is set by the class.c code
> > > > so this check likely returns 1 in that case.
> > >
> > > OK. I understand the issue now. So I would say that the proper
> > > solution to this problem is to link the alt modes with the class
> > > instead of the bus. That is much smaller change IMO.
> >
> > Got it. Just to confirm that I understand correctly, do you mean:
> > 1. Only cable plug alt modes should be linked with the class instead of the bus.
> >
> > <or>
> >
> > 2. All alt modes (cable plug, partner, port) should be linked with the
> > class instead of the bus
> >
> > My initial interpretation is 1.) since the bus linkage would be
> > necessary to match alt mode drivers to partner alt mode devices.
> > But, my understanding of the bus code is limited so I could be wrong;
> > could you kindly clarify?
>
> We don't need to care about the bus here. A device can be part of a
> bus and a class at the same time. I don't think there is any reason to
> limit the class to only plug alt modes, so let's just assign it to all
> of them.

I had actually tried this earlier, but here we run into errors.
If we always set the class, then "partner" altmode device creation
fails ("port" altmode creation will likely also fail, but I haven't
verified that)

The issue is that if we set both "class" and "bus", the device_add()
[1] code tries to create the "subsystem" symlink in the altmode
device's sysfs entry twice.

The first creation is in the call to device_add_class_symlinks()[2]
which creates a "subsystem" file [3]. Note that if "class" is not set,
this code doesn't execute.
Next is the call to bus_add_device() [4] which again tries to create
the "subsystem" symlink [5] and fails since it already exists; this
leads to failure.

There are 2 solutions I can see:
1. Only set class for cable plug alt modes (which won't have a bus
set). This will avoid the double "subsystem" sysfs file creation.
2. Change the bus_add_device() code to:
    a. use the _nowarn() option of the symlink create function which
prevents the warn stack traces on -EEXIST error, and
    b. check for -EEXIST return value and don't fail if so.

2.) Sounds good to me, but I'm not sure if it's alright to continue if
a "subsystem" symlink already exists.

If 2.) is OK with you, I will upload a patch to implement it and make
a series with that patch and this one.

Best regards,

-Prashant

[1]: https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/core.c#L2884
[2]: https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/core.c#L2955
[3]: https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/core.c#L2722
[4]: https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/core.c#L2961
[5]: https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/bus.c#L471
