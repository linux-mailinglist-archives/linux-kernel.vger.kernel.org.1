Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE26E2F6BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbhANUAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhANUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:00:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C87C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:59:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b11so669244ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVX4hjQG171pq3hAFqWgHQZmY5orHRtD4DKUrqpfc8k=;
        b=smdNBJbVI/K24tKPUpEEJ2KKez/vtOQlocB8RmXEuj7OvOzYrhF12dkBtAWF+xMQhK
         e8pa2c5sWrM9IwbzTV1nr3II83gc+a6s20FNkI2kYKOGh6M/VYhc55fQUBs74xiDJFS/
         Jd6PEVmJ28njwCMTKGYU6QNd6MVoiu5fz2pwEz0qwCZQ54a0Gz0D0kuuAVV9MWBpapPi
         Na25bqt/8oxUMmH3nlJ624hqwIZFohdmSpfvQZjHYjb6adF5xzUO5nigG0deMxGq0EWN
         KsHOBCavD8zVRVQ1Hx6NELTSbrpZM16Ym6GuVtptnhf+ssZR1yDKal7H6ztJay/rdY6A
         sJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVX4hjQG171pq3hAFqWgHQZmY5orHRtD4DKUrqpfc8k=;
        b=HjpFIQAc792QtOe4lOe2ggNoMomcTVGvPPoF5RfIiKO2W+Qs7kKFR/JXYWElN15bwU
         td2QWgydUM0uIHgIom4HmvqYol6peKoPjHF/lcYAlN7L3Hm33s9UtjrOi+kADcE70g7P
         eN3ByUhGBAceBJTQgolEDyYEKUTYmRX5vEw8XzJg6aZq1EmJZlFpUo5VhPmhPdDMY4tk
         DMWc67N2kF+YstwLFhFxC6ctl9trenKT2U98kKeGiN2hkocMKZrp7Ve4ZKiYhIgGUmLy
         +m3UWytohCvKBGOS7RvrrZquJ+XuTCi3kirwywI0VLcIdoFHAd3ELM6uQOhRnhoZW2kT
         c/Pw==
X-Gm-Message-State: AOAM533uJ07O9Snnu/JiL/kzT5Js8aRFec/MIiDm7e1Ge3bf8BSyoADC
        qLENPJc2e0QyK05pEKBYi6VtpjO0PldBV98dptSCdw==
X-Google-Smtp-Source: ABdhPJx1B3sj27mURuownmtoOFqhC1LwKzftYmZIeO0dIpGxGGCpkME1ubEfiKxvCm77/qdfiHQ5faBPcTn0qRi45LU=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr9780726ybl.310.1610654369442;
 Thu, 14 Jan 2021 11:59:29 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <CAJZ5v0jREeXtYa8LAiLoRBG1ok66BR86MCQxrQ1WPR5qbhTKbw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jREeXtYa8LAiLoRBG1ok66BR86MCQxrQ1WPR5qbhTKbw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 11:58:53 -0800
Message-ID: <CAGETcx-G4YQ2Og0CrpVXK3n9Re=VNQbdSt=d7MA7gzRf8D5SxA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 14, 2021 at 8:32 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > When adding a new device link, device_is_dependent() is used to
> > > check whether or not the prospective supplier device does not
> > > depend on the prospective consumer one to avoid adding loops
> > > to the graph of device dependencies.
> > >
> > > However, device_is_dependent() does not take the ancestors of
> > > the target device into account, so it may not detect an existing
> > > reverse dependency if, for example, the parent of the target
> > > device depends on the device passed as its first argument.
> > >
> > > For this reason, extend device_is_dependent() to also check if
> > > the device passed as its first argument is an ancestor of the
> > > target one and return 1 if that is the case.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >  drivers/base/core.c |   12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-pm/drivers/base/core.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/core.c
> > > +++ linux-pm/drivers/base/core.c
> > > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> > >  #endif
> > >  #endif /* !CONFIG_SRCU */
> > >
> > > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > > +{
> > > +       while (target->parent) {
> > > +               target = target->parent;
> > > +               if (dev == target)
> > > +                       return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > >  /**
> > >   * device_is_dependent - Check if one device depends on another one
> > >   * @dev: Device to check dependencies for.
> > > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> > >         struct device_link *link;
> > >         int ret;
> > >
> > > -       if (dev == target)
> > > +       if (dev == target || device_is_ancestor(dev, target))
> > >                 return 1;
> > >
> > >         ret = device_for_each_child(dev, target, device_is_dependent);
> > >
> >
> > The code works, but it's not at all obvious what it's doing. Because,
> > at first glance, it's easy to mistakenly think that it's trying to
> > catch this case:
> > dev <- child1 <- child2 <- target
> >
> > Maybe it's clearer if we do this check inside the loop?
>
> Which of the loops do you mean?

Sorry, the list of consumers loop.

> There are two of them and both need
> to do the check in each step AFAICS.

I don't think we need it in the "loop through children" one. Here's why.

We already make sure:
1. The prospective supplier (target) is not a child of the prospective
consumer (dev).
2. The prospective supplier (target) is not a consumer of the
prospective consumer (dev) or any of its children.

To address the problem in the commit, we need to make changes to make sure:
3. The ancestor of prospective supplier (ancestor of target) is not a
child of prospective consumer (dev)
4. The ancestor of prospective supplier (ancestor of target) is not a
consumer of the prospective consumer (dev) or any of its children.

But (3) would be caught automatically when we do (1). Because if (3)
is true, (1) would also be true.
So, what's left is (4), for which my suggestion should be sufficient?

Does it make sense? Or am I missing anything else that needs to be checked?

-Saravana

>
> > Something like:
> >
> >                 if (link->consumer == target ||
> > device_is_ancestor(link->consumer, target))
> >                         return 1;
>
> So would this be sufficient?
