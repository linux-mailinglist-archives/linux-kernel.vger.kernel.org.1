Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE22EC38B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhAFSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbhAFSxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:53:47 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6FC061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:53:07 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x2so3710495ybt.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2l9qh9pEx3tDqkeXpfiJtf+59pHlf0HYS1sRLL/nNY=;
        b=cGVzfXZ1PY8zcKXJcAYsHz5SGGkLtmpRi78cWZaof73NU70oKKzx6tgiLL8mI5B6+b
         Gp+w5qK+zGzD8NLQi15UaFqG9srsNH6mXDsiCgUC53eG3g9CNKJMr8bM8ju/Ig+twNJC
         eK8BJ1uibWiYXmn87YZbZ4tTQoajIPEVX5ND6oISKjeN4yuh74GhdISJtJDJI3ado3fz
         wKqf5q79ovC8Ns8p9NDEFipC0ePC6zaPvwBvebay8hs2jxqvpgS3BUcxvJuClf+zpm7W
         17SRMZU2uKl4zIYcvpJt+K3gq6hcu3kxQC9EMKViOUAK6v9xkwflt0vXNdD+HKCmlNVH
         0vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2l9qh9pEx3tDqkeXpfiJtf+59pHlf0HYS1sRLL/nNY=;
        b=eIYb8KosSwbEE3sl1lOFnEqMFifhFzyCVFMEt1IvydBogQwYCQXiKJyAT5crb07SOX
         jB+u91oWjEH0pbxqSwu9uQJife2BVevrBvK4epw1asBpQp7Yp7Am6toIhCfgLPYGq7p2
         bIgHtfg8T2LkT2AxvJPwH+3/b9YCLTIhSoQCUnY2XmhDDmqceRJOzaZci6vm4oS9ISH6
         S8HbaE5midgLM5dpeGyy/zVoxPF2EnZPbLVEB+wq8Mp85MvmtF45D2CqF0PsZPl9gOXb
         qgyVyjtBvP52n6EAFv5nBmrbZKDXYXVyYeur2YHGfPaHEpCk0NMzd9X0KGU3dJmOdQVL
         RL1A==
X-Gm-Message-State: AOAM531RPHdedjJwKDlZ/xac76WnAkMSQ1wsI3RSt3an8+3j/lLwgGUt
        rNJr1+JrWU1yKrdtvo5l7yZhYRGesg+VJJLjmd1s6w==
X-Google-Smtp-Source: ABdhPJy5U09WopUYakbG/SJlhE6YbEf9niULhY+a5LhlxayWH71C1E4faS1u4Hb1efL1+/iqPNXcViwntubk3djHIl8=
X-Received: by 2002:a25:d7d7:: with SMTP id o206mr8081358ybg.228.1609959186065;
 Wed, 06 Jan 2021 10:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org>
In-Reply-To: <877dovlgdl.wl-maz@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Jan 2021 10:52:30 -0800
Message-ID: <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 31 Dec 2020 21:12:40 +0000,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > Add support for creating device links out of interrupts property.
> > > >
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > > Rob/Greg,
> > > >
> > > > This might need to go into driver-core to avoid conflict
> > > > due to fw_devlink refactor series that merged there.
> > > >
> > > > Thanks,
> > > > Saravana
> > > >
> > > >
> > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > *parse_iommu_maps(struct device_node *np,
> > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > >  }
> > > >
> > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > +                                     const char *prop_name, int index)
> > > > +{
> > > > + struct device_node *sup;
> > > > +
> > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > +         return NULL;
> > > > +
> > > > + of_node_get(np);
> > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > +         np = of_get_next_parent(np);
> > > > + of_node_put(np);
> > > > +
> > > > + return sup;
> > > > +}
> > > > +
> > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > >   { .parse_prop = parse_clocks, },
> > > >   { .parse_prop = parse_interconnects, },
> > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > of_supplier_bindings[] = {
> > > >   { .parse_prop = parse_pinctrl6, },
> > > >   { .parse_prop = parse_pinctrl7, },
> > > >   { .parse_prop = parse_pinctrl8, },
> > > > + { .parse_prop = parse_interrupts, },
> > > >   { .parse_prop = parse_regulators, },
> > > >   { .parse_prop = parse_gpio, },
> > > >   { .parse_prop = parse_gpios, },
> > >
> > > You don't really describe what this is for so I'm only guessing
> > > from the context. If you want to follow the interrupt hierarchy,
> > > "interrupt-parent" isn't enough. You also need to track
> > > things like interrupt-map, or anything that carries a phandle
> > > to an interrupt controller.
> >
> > We don't need to follow the hierarchy, we just need the immediate
> > dependencies.
>
> Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.

Thanks Rob for explaining it.

Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
Also, I'm trying to keep of/property.c independent of the framework
code for now. The long term goal is to see if I can move out most of
this into the frameworks. But I want to do that after I sort of some
of the larger problems (like getting fw_devlink=on to work on all
devices  first). Let me know if you have a strong preference for right
now, if not, I'd rather keep property.c independent for now.

I wasn't aware of interrupt-map until a few weeks ago and didn't know
it carried phandles. I can add support for that too. There's no reason
for all of them to go in one patch though.

>
> > But you are right that 'interrupt-map' also needs to be tracked.
>
> And 'interrupts-extended', while we're at it.

This is already handled.

> >
> > I also noticed that we define 'interrupt-parent' as a dependency to
> > parse, but that's wrong. The dependency is where 'interrupts' appears
> > and where 'interrupt-parent' appears is irrelevant.

No, the interrupt-parent parsing is correct and it's needed for
interrupt controllers to probe in the right order. But
interrupt-parent is also needs to be looked at for parsing
"interrupts".

-Saravana

> Agreed. Though you need the object the dependency is on, I guess, if
> you want to be able to have the dependency edge between the device and
> the interrupt controller. But since the commit message doesn't say
> much about what this is trying to achieve, I'm only guessing the
> purpose of this patch.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
