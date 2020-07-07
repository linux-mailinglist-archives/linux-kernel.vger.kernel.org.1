Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06494217362
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGGQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgGGQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:11:18 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29091C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:11:18 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id d198so1509866vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PdkRv62nUyer3utyHGyA4zyawQ7UJwHUu+IzIsdxXbk=;
        b=ZIRm1sCwWG3uRuWaf7gqVsqLFlt4i5nQz7D3SKhQhXqifxYIfsrwV7RYthE1frvidf
         BirGcXuaaJKJ4hYD7MHm32VHftEpvf0G5tFcM7LQkFDNl8cT0WJ0NQdDwx10Ci9aIObS
         OCMwze0DIhf2sgT7WI1QToBUwX4SISOB1G0+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PdkRv62nUyer3utyHGyA4zyawQ7UJwHUu+IzIsdxXbk=;
        b=gqP5iuknDrSp8UTTCKY/H/MpwDXl7dtkD/BLARD0MYrxtRPWpnlCfH/Se2QRUjOukf
         kLWonozzwmyU9cSylctzZZPcDjgf/JfGl2GkWUtzDNOjDl2+LWKud8eVUvF/JacLJxbW
         jEzoqamFbALNlE9KhLuqJGyfWsLE++ZLGZ8KAYJPBsLqTwKABt3SNuGYvZK+ITgroT9r
         eVbUhhW7YwBopQMPM+tAqdavOLNsovqnNUtwv4I1YhVXnX1WpzExZ52DloC+IzJSKQ3h
         Ga6VtdL3qRI+9nrDuUww0XjsAntDGeMo8G2S8skFHz7WYc4ldRiH7RUTDGmSHJZ4tIVM
         q60A==
X-Gm-Message-State: AOAM531RyEgeB13xWQ8X5HhKSXibiD4kwX6UHtQg72HUmI0AntzHlMeU
        buKOEvfGqNkmn6Xtz1O8ocMUZynRte1olIVoChjbcQ==
X-Google-Smtp-Source: ABdhPJxMj1B4DMC0cpSoOzvOLQGp4qu9v2iXoupdVrCYhGX2pRj4jjKQXOUpCAK37GZcNDrEen+wpsqytTGK7L52DQc=
X-Received: by 2002:a67:6e05:: with SMTP id j5mr32157567vsc.196.1594138277134;
 Tue, 07 Jul 2020 09:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707154905.2763616-1-abhishekpandit@chromium.org>
 <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid> <20200707160045.GA118278@kroah.com>
In-Reply-To: <20200707160045.GA118278@kroah.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 09:11:06 -0700
Message-ID: <CANFp7mV_5HtaKo0Q5BRanVhbu618gQS-Xiut7uz+CuGbVmf5EQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        rafael.j.wysocki@intel.com, Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I admit I didn't test this but I built it with allmodconfig.

Sadly, this only raised a warning instead of an error so I didn't go
look through the build logs (ignore the 5.4, the remote here is the
linux-pm git repo):

/usr/local/google/home/abhishekpandit/chromiumos/src/third_party/kernel/v5.=
4/drivers/base/power/sysfs.c:
In function =E2=80=98wakeup_sysfs_remove=E2=80=99:
/usr/local/google/home/abhishekpandit/chromiumos/src/third_party/kernel/v5.=
4/drivers/base/power/sysfs.c:754:9:
warning: =E2=80=98return=E2=80=99 with a value, in function returning void
[-Wreturn-type]
  754 |  return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/local/google/home/abhishekpandit/chromiumos/src/third_party/kernel/v5.=
4/drivers/base/power/sysfs.c:751:6:
note: declared here
  751 | void wakeup_sysfs_remove(struct device *dev)


Will send up another fix.

Thanks
Abhishek

On Tue, Jul 7, 2020 at 9:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 07, 2020 at 08:49:05AM -0700, Abhishek Pandit-Subedi wrote:
> > Udev rules that depend on the power/wakeup attribute don't get triggere=
d
> > correctly if device_set_wakeup_capable is called after the device is
> > created. This can happen for several reasons (driver sets wakeup after
> > device is created, wakeup is changed on parent device, etc) and it seem=
s
> > reasonable to emit a changed event when adding or removing attributes o=
n
> > the device.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Simplified error handling
> >
> > Changes in v2:
> > - Add newline at end of bt_dev_err
> >
> >  drivers/base/power/sysfs.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index 24d25cf8ab1487..04c82373c8f240 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* sysfs entries for device PM */
> >  #include <linux/device.h>
> > +#include <linux/kobject.h>
> >  #include <linux/string.h>
> >  #include <linux/export.h>
> >  #include <linux/pm_qos.h>
> > @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, ku=
id_t kuid, kgid_t kgid)
> >
> >  int wakeup_sysfs_add(struct device *dev)
> >  {
> > -     return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +     int ret =3D sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> >  }
> >
> >  void wakeup_sysfs_remove(struct device *dev)
> >  {
> >       sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +     return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
>
> Always test build and hopefully actually test, your patches before
> sending them out :(
>
