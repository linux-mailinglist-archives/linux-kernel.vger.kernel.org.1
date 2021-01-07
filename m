Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A92ED6CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbhAGSj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbhAGSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:39:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE2A923403;
        Thu,  7 Jan 2021 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610044758;
        bh=6+kQE334J9SbW0yM3NlWxvaes7U9CBgIgTENrhIeApQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WecSKvLqEpXuq1LKLnwc0qdwdS5RlfZwGoW594uX0owQE+g7C9vXHhXFs4y1p/NX1
         C+NaaQCnKioFWCwoQVdYzzGT9m6K4KsmmLLAPGEK6KmU9I+8Cgw40IKAkAR30hOkPO
         Kg9h/CngluYr8fUkR050c8cjEVhX1Cu/ZPQ1HAi277Pf7f79lQBCw7cjCX+Qb9pL5d
         vdpqoJaz6ykdW7pHTQ9AgWTx6hY4TTl1rl8zbVJFl0EZVgzCXNf4Xriws+FCc41qbb
         i9fXRtbfjUiacCvnH5MZfpTtBVF0OIP/kb4oryys3LqLmLcM5W7J+Y/L197JLWVuWA
         NcLBrLictgEgQ==
Received: by mail-ej1-f49.google.com with SMTP id d17so11042992ejy.9;
        Thu, 07 Jan 2021 10:39:17 -0800 (PST)
X-Gm-Message-State: AOAM530szlXwcUcxjc2zoT870G667EGRoaz6PSvP3pSk0B5j/Q+kAXBi
        QVoKsRHNNUhfW8Ofr+E1OYY5SF98bddxgyXuEA==
X-Google-Smtp-Source: ABdhPJw2T/nYP8wCSKP9LM1NhNkUO/a7gkRrME4qq0kUTYpXK6H/AVboPr3+a/BiQcPdXbZu9rLcKNTraNnwIHLWrz8=
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr128297eji.108.1610044756363;
 Thu, 07 Jan 2021 10:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
In-Reply-To: <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 11:39:04 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
Message-ID: <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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

On Wed, Jan 6, 2021 at 11:53 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 31 Dec 2020 21:12:40 +0000,
> > Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > > Add support for creating device links out of interrupts property.
> > > > >
> > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > ---
> > > > > Rob/Greg,
> > > > >
> > > > > This might need to go into driver-core to avoid conflict
> > > > > due to fw_devlink refactor series that merged there.
> > > > >
> > > > > Thanks,
> > > > > Saravana
> > > > >
> > > > >
> > > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > > >  1 file changed, 17 insertions(+)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > > *parse_iommu_maps(struct device_node *np,
> > > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > > >  }
> > > > >
> > > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > > +                                     const char *prop_name, int index)
> > > > > +{
> > > > > + struct device_node *sup;
> > > > > +
> > > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > > +         return NULL;
> > > > > +
> > > > > + of_node_get(np);
> > > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > > +         np = of_get_next_parent(np);
> > > > > + of_node_put(np);
> > > > > +
> > > > > + return sup;
> > > > > +}
> > > > > +
> > > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > > >   { .parse_prop = parse_clocks, },
> > > > >   { .parse_prop = parse_interconnects, },
> > > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > > of_supplier_bindings[] = {
> > > > >   { .parse_prop = parse_pinctrl6, },
> > > > >   { .parse_prop = parse_pinctrl7, },
> > > > >   { .parse_prop = parse_pinctrl8, },
> > > > > + { .parse_prop = parse_interrupts, },
> > > > >   { .parse_prop = parse_regulators, },
> > > > >   { .parse_prop = parse_gpio, },
> > > > >   { .parse_prop = parse_gpios, },
> > > >
> > > > You don't really describe what this is for so I'm only guessing
> > > > from the context. If you want to follow the interrupt hierarchy,
> > > > "interrupt-parent" isn't enough. You also need to track
> > > > things like interrupt-map, or anything that carries a phandle
> > > > to an interrupt controller.
> > >
> > > We don't need to follow the hierarchy, we just need the immediate
> > > dependencies.
> >
> > Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.
>
> Thanks Rob for explaining it.
>
> Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
> Also, I'm trying to keep of/property.c independent of the framework
> code for now. The long term goal is to see if I can move out most of
> this into the frameworks. But I want to do that after I sort of some
> of the larger problems (like getting fw_devlink=on to work on all
> devices  first). Let me know if you have a strong preference for right
> now, if not, I'd rather keep property.c independent for now.
>
> I wasn't aware of interrupt-map until a few weeks ago and didn't know
> it carried phandles. I can add support for that too. There's no reason
> for all of them to go in one patch though.
>
> >
> > > But you are right that 'interrupt-map' also needs to be tracked.
> >
> > And 'interrupts-extended', while we're at it.
>
> This is already handled.
>
> > >
> > > I also noticed that we define 'interrupt-parent' as a dependency to
> > > parse, but that's wrong. The dependency is where 'interrupts' appears
> > > and where 'interrupt-parent' appears is irrelevant.
>
> No, the interrupt-parent parsing is correct and it's needed for
> interrupt controllers to probe in the right order. But
> interrupt-parent is also needs to be looked at for parsing
> "interrupts".

If you parse 'interrupts' for interrupt controllers (which in turn
will use 'interrupt-parent'), then you aren't going to need to track
'interrupt-parent' by itself.

To look at it another way, 'interrupt-parent' can appear in any
ancestor node. Which node the dts author arbitrarily decided to put it
in does not matter at all. It could be at the DT root or duplicated in
every single node with 'interrupts'. Those are logically the same. The
node(s) with the dependency are the ones with 'interrupts'.

Rob
