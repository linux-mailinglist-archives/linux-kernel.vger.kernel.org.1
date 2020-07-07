Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230112174FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGGRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGGRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:18:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55926C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:18:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p25so15141808vsg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74Xd65ujs50AwKytINLgt7qtTa7IevS/aqZRV1i9Rd8=;
        b=UWYVic96pOSZRZsRmw2D0xW579eTy1JPNBw9lI+/tOGAhV3ymR2VcORJIdFnYMXlx/
         Pyh7l5oLPF9TOnZJYezcZKg0Et63e+3Ah4oPnZkC/aFt8IXpEP/Dw63qRvAoiZeMGyTl
         BkYS5dtdJ+VAfBgPrKdTozMDQ4weGwZxX/96E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74Xd65ujs50AwKytINLgt7qtTa7IevS/aqZRV1i9Rd8=;
        b=Er+/WR9erMtf3E+LHrBTbAzdv0HVedIz+aT0/+va/31EpesQ1NJ1AHv7L/eXv1GtxE
         OLXXVsgu4qCCQ+wZjSsbheNKf9mKegZk9cG08STIu9vSKb/9dQLePLXIvq1husv7kCLZ
         M5Zqvrlah6WpbNXeYtDuCvXppAfBWthOQkgioGfkE94vvya/TItqql8St+l9augszzys
         TBiXAx2Tv9dKr4rLpamFK1qb4AStFLQl7ifJvS32lMes3xPDRK1ogvSrKxf7suwK6fJr
         rsc6AffkHUsHFt0BgKGGi/+aK7W/yT04iSRSTb+dJ5oqQRihyNmfwS5YHEYJb1pYrm/b
         BRdw==
X-Gm-Message-State: AOAM530JIr2A5L6G4YsvgVK7CqIkwwg0FWZg5yDS3HByTXVp4jliIs6T
        fl/nLaGSVHBBpQdJh0WNvpRtFgcLHtC4kqnvW24Wmw==
X-Google-Smtp-Source: ABdhPJwk+V71z2wv/WQnTefFWymSCRO53UNKZiBT8TehImzf1AUUKNg93mkz/cBBz2gO3h2NY5EkhH6PKev8387kkUo=
X-Received: by 2002:a67:6e05:: with SMTP id j5mr32408546vsc.196.1594142306552;
 Tue, 07 Jul 2020 10:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707162417.3514284-1-abhishekpandit@chromium.org>
 <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
 <CAJZ5v0iyvge_Hqgm46_vfjh45YFdnsJ7ksvY7DqD6gx+f+1dvg@mail.gmail.com>
 <CANFp7mUas8Qnzqeivri25S7SWbKe6T+6riN419dR6xZXXOcaKA@mail.gmail.com> <CAJZ5v0iVXbxHzV0Y_y5idkoS4DdF+cXQ6kmA0bWWHWZ-TVv8wg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iVXbxHzV0Y_y5idkoS4DdF+cXQ6kmA0bWWHWZ-TVv8wg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 10:18:15 -0700
Message-ID: <CANFp7mXEB4ckWKRDDqUdmBBrbk00CW_pOX+1zmo_AgywtHZ+Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good to me. Patch v5 incoming after compile-test.

Thanks
Abhishek

On Tue, Jul 7, 2020 at 10:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 7, 2020 at 6:48 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Rafael,
> >
> > (resent in plain text)
> >
> > On Tue, Jul 7, 2020 at 9:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jul 7, 2020 at 6:24 PM Abhishek Pandit-Subedi
> > > <abhishekpandit@chromium.org> wrote:
> > > >
> > > > Udev rules that depend on the power/wakeup attribute don't get triggered
> > > > correctly if device_set_wakeup_capable is called after the device is
> > > > created. This can happen for several reasons (driver sets wakeup after
> > > > device is created, wakeup is changed on parent device, etc) and it seems
> > > > reasonable to emit a changed event when adding or removing attributes on
> > > > the device.
> > > >
> > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Fix warning where returning from void and tested on device
> > > >
> > > > Changes in v3:
> > > > - Simplified error handling
> > > >
> > > > Changes in v2:
> > > > - Add newline at end of bt_dev_err
> > > >
> > > >  drivers/base/power/sysfs.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > > index 24d25cf8ab1487..aeb58d40aac8de 100644
> > > > --- a/drivers/base/power/sysfs.c
> > > > +++ b/drivers/base/power/sysfs.c
> > > > @@ -1,6 +1,7 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >  /* sysfs entries for device PM */
> > > >  #include <linux/device.h>
> > > > +#include <linux/kobject.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/pm_qos.h>
> > > > @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
> > > >
> > > >  int wakeup_sysfs_add(struct device *dev)
> > > >  {
> > > > -       return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > > +       int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > > +
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> > >
> > > So let me repeat the previous comment:
> > >
> > > If you return an error here, it may confuse the caller to think that
> > > the operation has failed completely, whereas the merging of the
> > > attribute group has been successful already.
> > >
> > > I don't think that an error can be returned at this point.
> > >
> >
> > The caller looks at the return code and just logs that an error
> > occurred (no other action). It's also unlikely for kobject_uevent to
> > fail (I saw mostly -ENOMEM and an -ENOENT when the kobj wasn't in the
> > correct set).
> >
> > Call site:
> >     int ret = wakeup_sysfs_add(dev);
> >
> >     if (ret)
> >         dev_info(dev, "Wakeup sysfs attributes not added\n");
>
> Yes, which is confusing, because the wakeup attributes may in fact
> have been added.  Which is my point.
>
> >
> > So I'm ok with either keeping this as-is (caller isn't getting
> > confused, just logging) or swallowing the return of kobject_uevent.
>
> I would just ignore the return value of kobject_uevent() along the
> lines of wakeup_sysfs_remove() below.
>
> Thanks!
>
> > > >  }
> > > >
> > > >  void wakeup_sysfs_remove(struct device *dev)
> > > >  {
> > > >         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > > +       kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> > > >  }
> > > >
> > > >  int pm_qos_sysfs_add_resume_latency(struct device *dev)
> > > > --
> > > > 2.27.0.212.ge8ba1cc988-goog
> > > >
