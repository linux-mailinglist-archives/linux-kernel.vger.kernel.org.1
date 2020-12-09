Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098C42D4EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgLIXsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLIXsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:48:10 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 15:47:29 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b9so2412877qtr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEDy9e6MULAxxvc3gfaoOMf7yXixV4MmveX5QoBc0M0=;
        b=TFpdJEn84BFYinB2Dg6QobxTWrhtFD+bYMceAur0R4opoz8o8WgG73WauK9wx1G+6a
         35hVLIt17CA2FOx3rKigWTYiGtllriycdvLS1XDI/dsYNZiKT6tW1pIJEPGZnUcWdJOC
         gIBodtPVt2Ih/WvntEzQ/EwHLlJ0s36catgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEDy9e6MULAxxvc3gfaoOMf7yXixV4MmveX5QoBc0M0=;
        b=GuqOhFyKBn6C4z6+JkuPXG7ameXbZA6AyZGoWhhJoqQv4XivE05fx0dCm0RmcKWkFW
         TpaW1tD0VKSuCLf10WjCRKuUeMPFv7N/+kr+RMYil/3p9SPmiHPnMDukkApXGnLF6CT8
         RgJRy4YnKwix113xgjpQ6oK8wtmN5NqiTUCFJqRKBWkLW5QbbCTTsus4wwoN9E2d/PtE
         TdhQeqwlZpPTo+c4/6rWqNUEhHwru3t3g59uW9OaOyZ6V1FY2coAuyg0/Nv1M/5bxlL5
         ttJvN4ra8+lemRV3gcjv2RWq9Ea2fyjJpwi9RsROwb8UmpfniEna3aFsQuQqDyQqmi4c
         tjLg==
X-Gm-Message-State: AOAM530Vo3L5DKgBqVlVcqhnNQMxOxT5aiLQkOZse3CEGWcxVudsck99
        4PNnEfH5dn52mxFGUxwJWpDJ/bK1C8jQK/ccA8sdVW5wMF4=
X-Google-Smtp-Source: ABdhPJxvdtamgd/uVbuavrschkjTLxHSU+w2IYkR1tiOmF5Uv9v/Nb/UT0aOJkSqCn1q19FiNmI0A7p3JjMlem1ui90=
X-Received: by 2002:ac8:594c:: with SMTP id 12mr6032953qtz.224.1607557648904;
 Wed, 09 Dec 2020 15:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20201203030846.51669-1-pmalani@chromium.org> <20201208093734.GD680328@kuha.fi.intel.com>
 <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
 <20201209161356.GI680328@kuha.fi.intel.com> <CACeCKacdcGi_6VW7F9agN+bgRH7gAXLDxK7DngE=fPkYT-CWNQ@mail.gmail.com>
 <20201209171524.GK680328@kuha.fi.intel.com> <CACeCKafc6A-O09LrTsYgBTbmwVV0y-tEevj_Ci188WmT=hkjxg@mail.gmail.com>
In-Reply-To: <CACeCKafc6A-O09LrTsYgBTbmwVV0y-tEevj_Ci188WmT=hkjxg@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 9 Dec 2020 15:47:17 -0800
Message-ID: <CACeCKafbAOQdthkafd-QQizQ=1vy4e+4KeGHfLs7JnmgSrVv6Q@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 2:59 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Heikki,
>
> On Wed, Dec 9, 2020 at 9:15 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Prashant,
> >
> > On Wed, Dec 09, 2020 at 08:22:52AM -0800, Prashant Malani wrote:
> > > Hi Heikki,
> > >
> > > On Wed, Dec 9, 2020 at 8:14 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Tue, Dec 08, 2020 at 03:45:19PM -0800, Prashant Malani wrote:
> > > > > Hi Heikki,
> > > > >
> > > > > Thanks a lot for looking at the patch.
> > > > >
> > > > > On Tue, Dec 8, 2020 at 1:37 AM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> > > > > > > Add the Type C bus for plug alternate modes which are being
> > > > > > > registered via the Type C connector class. This ensures that udev events
> > > > > > > get generated when plug alternate modes are registered (and not just for
> > > > > > > partner/port alternate modes), even though the Type C bus doesn't link
> > > > > > > plug alternate mode devices to alternate mode drivers.
> > > > > >
> > > > > > I still don't understand how is the uevent related to the bus? If you
> > > > > > check the device_add() function, on line 2917, kobject_uevent() is
> > > > > > called unconditionally. The device does not need a bus for that event
> > > > > > to be generated.
> > > > >
> > > > > My initial thought process was to see what is the difference in the adev device
> > > > > initialization between partner altmode and plug altmode (the only difference I saw in
> > > > > typec_register_altmode() was regarding the bus field).
> > > > >
> > > > > Yes, kobject_uevent() is called unconditionally, but it's return value isn't checked,
> > > > > so we don't know if it succeeded or not.
> > > > >
> > > > > In the case of cable plug altmode, I see it fail with the following error[1]:
> > > > >
> > > > > [  114.431409] kobject: 'port1-plug0.0' (000000004ad42956): kobject_uevent_env: filter function caused the event to drop!
> > > > >
> > > > > I think the filter function which is called is this one: drivers/base/core.c: dev_uevent_filter() [2]
> > > > >
> > > > > static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
> > > > > {
> > > > >       struct kobj_type *ktype = get_ktype(kobj);
> > > > >
> > > > >       if (ktype == &device_ktype) {
> > > > >               struct device *dev = kobj_to_dev(kobj);
> > > > >               if (dev->bus)
> > > > >                       return 1;
> > > > >               if (dev->class)
> > > > >                       return 1;
> > > > >       }
> > > > >       return 0;
> > > > > }
> > > > >
> > > > > So, both the "if (dev->bus)" and "if (dev->class)" checks are failing here. In the case of partner alt modes, bus is set by the class.c code
> > > > > so this check likely returns 1 in that case.
> > > >
> > > > OK. I understand the issue now. So I would say that the proper
> > > > solution to this problem is to link the alt modes with the class
> > > > instead of the bus. That is much smaller change IMO.
> > >
> > > Got it. Just to confirm that I understand correctly, do you mean:
> > > 1. Only cable plug alt modes should be linked with the class instead of the bus.
> > >
> > > <or>
> > >
> > > 2. All alt modes (cable plug, partner, port) should be linked with the
> > > class instead of the bus
> > >
> > > My initial interpretation is 1.) since the bus linkage would be
> > > necessary to match alt mode drivers to partner alt mode devices.
> > > But, my understanding of the bus code is limited so I could be wrong;
> > > could you kindly clarify?
> >
> > We don't need to care about the bus here. A device can be part of a
> > bus and a class at the same time. I don't think there is any reason to
> > limit the class to only plug alt modes, so let's just assign it to all
> > of them.
>
> I had actually tried this earlier, but here we run into errors.
> If we always set the class, then "partner" altmode device creation
> fails ("port" altmode creation will likely also fail, but I haven't
> verified that)
>
> The issue is that if we set both "class" and "bus", the device_add()
> [1] code tries to create the "subsystem" symlink in the altmode
> device's sysfs entry twice.
>
> The first creation is in the call to device_add_class_symlinks()[2]
> which creates a "subsystem" file [3]. Note that if "class" is not set,
> this code doesn't execute.
> Next is the call to bus_add_device() [4] which again tries to create
> the "subsystem" symlink [5] and fails since it already exists; this
> leads to failure.
>
> There are 2 solutions I can see:
> 1. Only set class for cable plug alt modes (which won't have a bus
> set). This will avoid the double "subsystem" sysfs file creation.
> 2. Change the bus_add_device() code to:
>     a. use the _nowarn() option of the symlink create function which
> prevents the warn stack traces on -EEXIST error, and
>     b. check for -EEXIST return value and don't fail if so.
>
> 2.) Sounds good to me, but I'm not sure if it's alright to continue if
> a "subsystem" symlink already exists.

It looks like the "subsystem" name depends on the bus_type.name  and
class.name (for bus and class respectively).
So it is possible the two symlinks will not point to the same location
(For example, the class for typec is "typec_mux"
but the bus is simply "typec").

Given this, it sounds like option 1.) might be better, but I'll defer
to your suggestions.


Best regards,

-Prashant
