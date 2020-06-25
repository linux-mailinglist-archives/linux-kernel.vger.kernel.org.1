Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2620A448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406935AbgFYRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405562AbgFYRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:52:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:52:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so6096294otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrZ2fY9WrTaypJt+sZgGoNyHFbZy3M4E4I5hfw0mTfw=;
        b=sFfFzlBZwWpraJ6jRuapOCOKSygjVulQ/rqhqEcZWWtn8I9wPs5SeR64GQBF5ho1TL
         /7VIWlxCUfCyoMTKA0z7oTM+Qo97sHURB2JuAj5c2xtrTvr0KTKTWqV8R+5pdLVeIcR9
         rPBfFJHp5ycenXoTB+AmnnzwTCFaKzu4EPpdmU1nDDgkMZGQzHTV3bUg/CtarN1XsfFr
         pJKnRJKAsbum00k7hz42NJRszPC6yCrmwrUJ32uplle/FL5svBQJ8lfs2R07SCriNOA4
         fq2Cc1rQxqrDchZSfuQ2qwVdNhy6xikQ9d6ArI4byI93mtxMlHep+rFDNNSzU0ltQMRG
         pYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrZ2fY9WrTaypJt+sZgGoNyHFbZy3M4E4I5hfw0mTfw=;
        b=WOXQmT6TXmJkmlz7edYuq0BB1VqmMJ33MPuYWKjnfwRextti6kKz97Xxg91fVCpjOr
         8pqFkibd0oB3MBp1UJOI9SlO8flqfhalZBb8wG8s8bW20R6oaQUKec7l8X1V2ZuyrCO6
         GqD5DxDFoBxvQThls9ZwVdz0oolXewKUPKLZFTMvFC5Wz+/fTiPPJZ1wS71SWXGiQ6ci
         G7p4AFMEINkZ2R8NTDi166ujKVDxbG9ucZgUeV9+NIH6JwvqmwPgptLQp5RQAnu7nANl
         9tBk9hLTZMrViOY04pN1waDLryqerX/V7LFmtPxJdTigkISNuy1ZBniDX/XguDRJkzhd
         kIow==
X-Gm-Message-State: AOAM531POpzDhNV7PSEF2zL/tM3XoL1IA6F1CJZbshdltutcrJo5PTDo
        dxe81OOybH6ZwsmYfTu+SDfaza+JlKK5VdZpfcFv/w==
X-Google-Smtp-Source: ABdhPJxD72QqOollRgpUr8DNVPYWzzgpfhSVTIHf/kl7SIgKh1cVaA6bqg+8CA5wFpdwWKImIOspyn4RC6QblaLauLQ=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr29889627otj.231.1593107545163;
 Thu, 25 Jun 2020 10:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
 <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com> <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
In-Reply-To: <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jun 2020 10:51:49 -0700
Message-ID: <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 7:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jun 25, 2020 at 10:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 7:01 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Jun 25, 2020 at 9:58 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jun 25, 2020 at 6:49 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > Dropping Feng Kan <fkan@apm.com> and Toan Le <toanle@apm.com> because
> > > > > > their mails are bouncing.
> > > > > >
> > > > > > On Thu, Jun 25, 2020 at 8:19 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > >
> > > > > > > > Under the following conditions:
> > > > > > > > - driver A is built in and can probe device-A
> > > > > > > > - driver B is a module and can probe device-B
> > > > > > > > - device-A is supplier of device-B
> > > > > > > >
> > > > > > > > Without this patch:
> > > > > > > > 1. device-A is added.
> > > > > > > > 2. device-B is added.
> > > > > > > > 3. dpm_list is now [device-A, device-B].
> > > > > > > > 4. driver-A defers probe of device-A.
> > > > > > > > 5. deferred probe of device-A is reattempted
> > > > > > > > 6. device-A is moved to end of dpm_list.
> > > > > > > > 6. dpm_list is now [device-B, device-A].
> > > > > > > > 7. driver-B is loaded and probes device-B.
> > > > > > > > 8. dpm_list stays as [device-B, device-A].
> > > > > > > >
> > > > > > > > Suspend (which goes in the reverse order of dpm_list) fails because
> > > > > > > > device-A (supplier) is suspended before device-B (consumer).
> > > > > > > >
> > > > > > > > With this patch:
> > > > > > > > 1. device-A is added.
> > > > > > > > 2. device-B is added.
> > > > > > > > 3. dpm_list is now [device-A, device-B].
> > > > > > > > 4. driver-A defers probe of device-A.
> > > > > > > > 5. deferred probe of device-A is reattempted later.
> > > > > > > > 6. dpm_list is now [device-B, device-A].
> > > > > > > > 7. driver-B is loaded and probes device-B.
> > > > > > > > 8. dpm_list is now [device-A, device-B].
> > > > > > > >
> > > > > > > > Suspend works because device-B (consumer) is suspended before device-A
> > > > > > > > (supplier).
> > > > > > > >
> > > > > > > > Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> > > > > > > > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > > ---
> > > > > > > >  drivers/base/dd.c | 16 ++++++++++++++++
> > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > > > > index 9a1d940342ac..52b2148c7983 100644
> > > > > > > > --- a/drivers/base/dd.c
> > > > > > > > +++ b/drivers/base/dd.c
> > > > > > > > @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
> > > > > > > >                  * probe makes that very unsafe.
> > > > > > > >                  */
> > > > > > > >                 device_pm_move_to_tail(dev);
> > > > > > > > +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> > > > > > > > +                * I'm worried if it'll have some unintended consequeneces. */
> > > > > > >
> > > > > > > Yes, this needs to go away if you make the other change.
> > > > > > >
> > > > > > > >
> > > > > > > >                 dev_dbg(dev, "Retrying from deferred list\n");
> > > > > > > >                 bus_probe_device(dev);
> > > > > > > > @@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > > > > > > >                 goto re_probe;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       /*
> > > > > > > > +        * The devices are added to the dpm_list (resume/suspend (reverse
> > > > > > > > +        * order) list) as they are registered with the driver core. But the
> > > > > > > > +        * order the devices are added doesn't necessarily match the real
> > > > > > > > +        * dependency order.
> > > > > > > > +        *
> > > > > > > > +        * The successful probe order is a much better signal. If a device just
> > > > > > > > +        * probed successfully, then we know for sure that all the devices that
> > > > > > > > +        * probed before it don't depend on the device. So, we can safely move
> > > > > > > > +        * the device to the end of the dpm_list. As more devices probe,
> > > > > > > > +        * they'll automatically get ordered correctly.
> > > > > > > > +        */
> > > > > > > > +       device_pm_move_to_tail(dev);
> > > > > > >
> > > > > > > But it would be good to somehow limit this to the devices affected by
> > > > > > > deferred probing or we'll end up reordering dpm_list unnecessarily for
> > > > > > > many times in the actual majority of cases.
> > > > > >
> > > > > > Yes, lots of unnecessary reordering, but doing it only for deferred
> > > > > > probes IS the problem. In the example I gave, the consumer is never
> > > > > > deferred probe because the supplier happens to finish probing before
> > > > > > the consumer probe is even attempted.
> > > > >
> > > > > But why would the supplier be moved to the end of dpm_list without
> > > > > moving the consumer along with it?
> > > >
> > > > There is no device link between the supplier/consumer in this case.
> > >
> > > So this is the real problem, isn't it?
> > >
> > > > Sadly there are plenty of cases where device links aren't present to
> > > > capture supplier/consumer dependencies.
> > >
> > > And so that's why you want to add a ton of overhead to driver probing
> > > in all of the cases in which that is not an issue?
> >
> > Well, until all/most of the frameworks add device links or
> > fw_devlink=on by default, it doesn't hurt to have suspend/resume work
> > in more platforms.
>
> In the presence of deferred probing, that is.
>
> Note that deferred probing gets in the way here and so the problem is
> related to it.

I mean, we officially support deferred probing. Shouldn't we fix it so
that it doesn't break suspend/resume? Also, it's pretty easy to have
cases where one module probes multiple device instances and loading it
in one order would break dpm_list order for one device and loading it
in another order would break it for another device. And there would be
no "proper" order to load modules (because module order != device
order).

> > What about the option of not adding to dpm_list until a device is
> > probed? Is it DOA?
>
> Yes, it is, I'm afraid.  There are devices without drivers. :-)

Devices that still suspend/resume without drivers?! I didn't know that
was possible.

-Saravana
