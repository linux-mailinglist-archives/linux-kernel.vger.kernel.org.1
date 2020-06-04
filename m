Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8014E1EE123
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFDJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgFDJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:21:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC716C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:21:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a9so2806483ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyJR1MYehwBUt0YyExV80dxcZRy0+suSSvHSpdzdsAU=;
        b=ge1P9U3b40ro4By+8hHm6GTS1SMbrieAZjWbp/5K+pDJajjes5lTSjJ0+SRUz9S12P
         rkAqjRGvx7YXRNu45zhu7OIDDMdBCsWvg7iBRWAZbmash6YcMA1wfZrO50oXoinhLry3
         8ourmKYOqO+UGXphdqushaKcDEi8j0I/JRah1H0JkiS0eK7QLNqPOOqMFpgdeB1pS0GF
         QfJzZYUkBdAWqxC6ZiKTeUTvfhezJ+593WeVyQ46v9gSnQ0cE82Mjj11GUKPgK+UNnxc
         /S9MM0EXpd+sEQhjOrAXcLL45Hk8kzDMrvgM58FdQvEhshHnfQd0Knh7UUbe8OYmWNan
         MgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyJR1MYehwBUt0YyExV80dxcZRy0+suSSvHSpdzdsAU=;
        b=AMD3LkRny72i09ubu+Sp3ZH2MY3IBFUTIxuh4pJzSykm2LYfXg/Aqzxq0rgjaHSoPT
         /JugBR8gA2uEMvtocsf0qZ/JXwhqthss+6IXDy/XCz+lKkUcpdPnomFLkQdnx3hInWrh
         rdnqqxO4A9p30plPTd+MLRHI7AYTH2caQcmpKFbPFfWFNULIraETtKhcfmqjYqOk6r/U
         KVA0BMRycHL3Xm2MrjsLCV2v3+kUHwA+fAqGSWeFgEI9fwN1gCJV1v6tUMCY2H7m7oyJ
         M+xp3qaUQVFnDVl7t48n8OwzStP3nKNZBSQ7ahxuOf2lXnNDi3A0/7b2sVilaBSU8shn
         dLrw==
X-Gm-Message-State: AOAM530PxySBrRJiao/xOPIv94l48YCPeH8AtjNyyns9TOxziek7j8Qh
        YNJsGqoghnHNFEa2/Qf94iTILoluaRYfnmGu1chcXJfoD+Q=
X-Google-Smtp-Source: ABdhPJyj/mcnooeJF5BciINSiXrorGxe0C3sLWapnPp74fQH2EvEPMjaYihJoGTqLF6YnVBy/ESZi9x4IAQnHCyXVkM=
X-Received: by 2002:a2e:81c5:: with SMTP id s5mr1609658ljg.372.1591262475238;
 Thu, 04 Jun 2020 02:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
 <20200601150645.13412-2-maxim.uvarov@linaro.org> <20200604083655.GA4026@linux.intel.com>
In-Reply-To: <20200604083655.GA4026@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 4 Jun 2020 14:51:03 +0530
Message-ID: <CAFA6WYMZx9goq4+yNH5UtrO-nO+R9ohE1dH6jTvKwvME+kKwoQ@mail.gmail.com>
Subject: Re: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 14:07, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 06:06:43PM +0300, Maxim Uvarov wrote:
> > With the evolving use-cases for TEE bus, now it's required to support
> > multi-stage enumeration process. But using a simple index doesn't
> > suffice this requirement and instead leads to duplicate sysfs entries.
> > So instead switch to use more informative device UUID for sysfs entry
> > like:
> > /sys/bus/tee/devices/optee-ta-<uuid>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> Why do you mean by duplicate sysfs entries?
>

It's just about the device being added with the same name as of the
device which is already present on the TEE bus. So this leads to
duplicate sysfs entry error for device node which is created during
device_register() execution flow.

> > ---
> >  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >  MAINTAINERS                                       | 1 +
> >  drivers/tee/optee/device.c                        | 6 +++---
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > new file mode 100644
> > index 000000000000..0ae04ae5374a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > @@ -0,0 +1,8 @@
> > +What:                /sys/bus/tee/devices/optee-ta-<uuid>/
> > +Date:           May 2020
> > +KernelVersion   5.7
> > +Contact:        tee-dev@lists.linaro.org
> > +Description:
> > +             OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> > +             matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> > +             are free to create needed API under optee-ta-<uuid> directory.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ecc0749810b0..6717afef2de3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >  M:   Jens Wiklander <jens.wiklander@linaro.org>
> >  L:   tee-dev@lists.linaro.org
> >  S:   Maintained
> > +F:   Documentation/ABI/testing/sysfs-bus-optee-devices
> >  F:   drivers/tee/optee/
> >
> >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index e3a148521ec1..ed3d1ddfa52b 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >       return 0;
> >  }
> >
> > -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > +static int optee_register_device(const uuid_t *device_uuid)
> >  {
> >       struct tee_client_device *optee_device = NULL;
> >       int rc;
> > @@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >               return -ENOMEM;
> >
> >       optee_device->dev.bus = &tee_bus_type;
> > -     dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > +     dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
>
> This code is and already was broken. If dev_set_name() returns -ENOMEM,
> the name will be a null pointer.

Is this an expected error scenario? dev_set_name() is invoked at
numerous places in the kernel without any error check.

>
> Also, I don't get how you can just swap the name without potentially
> breaking the backwards compatiblity towards the user space.

As of now, there isn't any compatibility concerns with user space as
these TEE devices are meant to be used by kernel drivers only. TEE
user-space interface is quite separate (see: Documentation/tee.txt).

-Sumit

>
> /Jarkko
