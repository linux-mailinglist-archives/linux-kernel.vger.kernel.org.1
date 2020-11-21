Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE02BBBC9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKUCBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgKUCBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:01:06 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:01:06 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id l14so10369735ybq.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1DTYgzh1PTbt5Dy4OfYWtoZOqwKhfMyLvJRd1nKZqU=;
        b=OWTrmrFhgMKOD4nQ/pwBJ9g35AYS3uNk81qFnTGjAdORh6DQtZwbJDpzryS7hYSdfG
         ZfclUmgvHq2KAyNE3vPPPnAdFiTPZD++Ay29kDZZVVcFXH3HFKUq3hpP96QhSC4f3WUP
         tN7QyhbFxnOXMxQVXZJsWKrtjCr8QpsIfK4XUitTpDVkCCpLX8CmeKtE8uHLPzMzLzH8
         nlcSAqn29YDGud9qmji88sgxJhdVQZIIHrFp5kaayrn+yLZmvJt0psTbeCzogFX50wth
         +zljqvHjn1XdsaDxtg2fm1zMp+iGxB8cqhRS9nWTigDeSpF3bM8AZ/UyNIcXTNV4GIZF
         cSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1DTYgzh1PTbt5Dy4OfYWtoZOqwKhfMyLvJRd1nKZqU=;
        b=rvMK8MT8TaSrB8Y5HfDPSzxAQNXbe1dyTp9CLEU8ouYDxHu9Bi+CNzfFhUP8tQdBtE
         BQkgEVt/ZMMh6V4LbpdmW0T0Cxw0j4ct71K1V7tHzvMm38KU02MXmu69bUVc3NS4RpQ7
         lHSUsA4bkGYBvDk/7fSgfILEvvIToQGbi/KXjleXSDJWrVNRPiMFIGN5cB9MgwQ5nZeT
         qp6nrkQPQ0KCWeRXZZdzcsTVAFRZn7n0yIWLykY0BDJ+PRB2ifNEH1mr5qY9z36VCzi3
         VZp8ZisHc04WHqEGGTmCHK9BQ3o51Z4hVxsqYWIpeq0HgtRZpGgFa8GWBNG5BDjrIOhd
         3pbg==
X-Gm-Message-State: AOAM532xuYh+MpUdeLkBvj6RXm8YrvSe98JHQPti9OtSZfW//3GvUtDg
        TAavU0cR3Yb37rz9a/5eh1Uyk93YZHwtL+mj9JdJ6w==
X-Google-Smtp-Source: ABdhPJyaUd7orwxD63L9YPrdxfBc6vqRk8ovK/YWzUfH+pt8qh68rGG+nqHyaKxR4F41T+ZWt5vk0rTg+/kfNtg6Qxc=
X-Received: by 2002:a25:b090:: with SMTP id f16mr25884519ybj.466.1605924065704;
 Fri, 20 Nov 2020 18:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-15-saravanak@google.com> <CAJZ5v0hQFRo8DzA=RFV8_L7_feiZF=7XMT8vVXgG5VtbLPEJ5Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQFRo8DzA=RFV8_L7_feiZF=7XMT8vVXgG5VtbLPEJ5Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 18:00:30 -0800
Message-ID: <CAGETcx8BZVfZo7Yd-gNCcRgYErsTPdUSSRwBPQN39vVCMFQCnA@mail.gmail.com>
Subject: Re: [PATCH v1 14/18] driver core: Use device's fwnode to check if it
 is waiting for suppliers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > To check if a device is still waiting for its supplier devices to be
> > added, we used to check if the devices is in a global
> > waiting_for_suppliers list. Since the global list will be deleted in
> > subsequent patches, this patch stops using this check.
>
> My kind of educated guess is that you want to drop
> waiting_for_suppliers and that's why you want to use supplier links
> here.

Yes, and a device would never be added waiting_for_suppliers list.

> >
> > Instead, this patch uses a more device specific check. It checks if the
> > device's fwnode has any fwnode links that haven't been converted to
> > device links yet.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4ae5f2885ac5..d51dd564add1 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
> >  static LIST_HEAD(deferred_sync);
> >  static unsigned int defer_sync_state_count = 1;
> >  static DEFINE_MUTEX(fwnode_link_lock);
> > +static bool fw_devlink_is_permissive(void);
> >
> >  /**
> >   * fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -994,13 +995,13 @@ int device_links_check_suppliers(struct device *dev)
> >          * Device waiting for supplier to become available is not allowed to
> >          * probe.
> >          */
> > -       mutex_lock(&wfs_lock);
> > -       if (!list_empty(&dev->links.needs_suppliers) &&
> > -           dev->links.need_for_probe) {
> > -               mutex_unlock(&wfs_lock);
> > +       mutex_lock(&fwnode_link_lock);
> > +       if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > +           !fw_devlink_is_permissive()) {
> > +               mutex_unlock(&fwnode_link_lock);
> >                 return -EPROBE_DEFER;
> >         }
> > -       mutex_unlock(&wfs_lock);
> > +       mutex_unlock(&fwnode_link_lock);
> >
> >         device_links_write_lock();
> >
> > @@ -1166,10 +1167,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
> >         bool val;
> >
> >         device_lock(dev);
> > -       mutex_lock(&wfs_lock);
> > -       val = !list_empty(&dev->links.needs_suppliers)
> > -             && dev->links.need_for_probe;
> > -       mutex_unlock(&wfs_lock);
>
> Why isn't the lock needed any more?
>
> Or maybe it wasn't needed previously too?

Yeah, I sent a separate patch for dropping this lock [1]. But I didn't
want to wait for that to land to write this series. The lock wasn't
needed in the first place and it was causing a lockdep warning.

>
> > +       val = !list_empty(&dev->fwnode->suppliers);
> >         device_unlock(dev);
> >         return sysfs_emit(buf, "%u\n", val);
> >  }
> > @@ -2226,7 +2224,7 @@ static int device_add_attrs(struct device *dev)
> >                         goto err_remove_dev_groups;
> >         }
> >
> > -       if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> > +       if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
>
> And why is this change needed?

Because if a device doesn't have a fwnode, it can't ever be waiting on
a supplier. Also, the "show" function dereferences
dev->fwnode->suppliers.

-Saravana

[1] - https://lore.kernel.org/lkml/20201104205431.3795207-1-saravanak@google.com/
Ignore the 1/2 thing. There's only 1 relevant patch.
