Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878092ED784
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbhAGTeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbhAGTeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:34:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A86123441;
        Thu,  7 Jan 2021 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610048010;
        bh=4bn6yrlNvnbi+YyRMhYO2OyDFdanqHEUkfN+HZD+QxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nRtzzkzzacHPgFIcgMNDkAKFt/d///MMlN1lCQQDXYsQk4zXJSY2WFNAK1sKmOEQX
         D90k6NiwzD/oFlquNxY5nU+CcUA6aQOzWcJ1TAyqp1hYLKiM3BiZ6Mztg3eU7U5GE2
         SZDBHJJDOs2X+LdswYEdyCnL5qsNuwb8RDFEzvGmKKMuQQ/qxz6kZ4dUWZlTRb5+pL
         D/dlVkuNFNXWt31jZQGWQEA8nTnuJzh6U1CAS7wSPsS8wEtYaxEW88WGejx+gDxPQ+
         BiN8EwGWZbe5rFe2ETijUuJkMLSZkQkfHJzO3Kquru6t3yL6HECekAn8/OUfknWL0P
         zs0t3fZ+GTIhA==
Received: by mail-ed1-f48.google.com with SMTP id c7so8865646edv.6;
        Thu, 07 Jan 2021 11:33:30 -0800 (PST)
X-Gm-Message-State: AOAM533PrScXQtKlTMtE7LexjtK2FnuAjkW+37+HSIXbvSj5LIK/kOHx
        XcD84HScp/52RxuRx7moV1AhY/soAZdh4lOnqA==
X-Google-Smtp-Source: ABdhPJxquLlQfooOFatSc92RuKQ92hFcMIbT2KZ8GWY/wEGrrhoa+oN4Jp/b/i92uaCCsUVYslh83UkBAbGOq04S4+s=
X-Received: by 2002:a50:f404:: with SMTP id r4mr2800429edm.62.1610048008818;
 Thu, 07 Jan 2021 11:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com> <CAGETcx_4n951Fx-Gn14ikDDxgWtv6QqQtNno9pcPJyiiGynWHQ@mail.gmail.com>
In-Reply-To: <CAGETcx_4n951Fx-Gn14ikDDxgWtv6QqQtNno9pcPJyiiGynWHQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 12:33:16 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+mavViUqWDVTAYB5p1j5h7FUNCzM9hg-ttJzLuJazZFQ@mail.gmail.com>
Message-ID: <CAL_Jsq+mavViUqWDVTAYB5p1j5h7FUNCzM9hg-ttJzLuJazZFQ@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 12:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 7, 2021 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jan 6, 2021 at 11:53 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Thu, 31 Dec 2020 21:12:40 +0000,
> > > > Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > > > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > > > > Add support for creating device links out of interrupts property.
> > > > > > >
> > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > ---
> > > > > > > Rob/Greg,
> > > > > > >
> > > > > > > This might need to go into driver-core to avoid conflict
> > > > > > > due to fw_devlink refactor series that merged there.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Saravana
> > > > > > >
> > > > > > >
> > > > > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > > > > >  1 file changed, 17 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > > > > --- a/drivers/of/property.c
> > > > > > > +++ b/drivers/of/property.c
> > > > > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > > > > *parse_iommu_maps(struct device_node *np,
> > > > > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > > > > >  }
> > > > > > >
> > > > > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > > > > +                                     const char *prop_name, int index)
> > > > > > > +{
> > > > > > > + struct device_node *sup;
> > > > > > > +
> > > > > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > > > > +         return NULL;
> > > > > > > +
> > > > > > > + of_node_get(np);
> > > > > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > > > > +         np = of_get_next_parent(np);
> > > > > > > + of_node_put(np);
> > > > > > > +
> > > > > > > + return sup;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > > > > >   { .parse_prop = parse_clocks, },
> > > > > > >   { .parse_prop = parse_interconnects, },
> > > > > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > > > > of_supplier_bindings[] = {
> > > > > > >   { .parse_prop = parse_pinctrl6, },
> > > > > > >   { .parse_prop = parse_pinctrl7, },
> > > > > > >   { .parse_prop = parse_pinctrl8, },
> > > > > > > + { .parse_prop = parse_interrupts, },
> > > > > > >   { .parse_prop = parse_regulators, },
> > > > > > >   { .parse_prop = parse_gpio, },
> > > > > > >   { .parse_prop = parse_gpios, },
> > > > > >
> > > > > > You don't really describe what this is for so I'm only guessing
> > > > > > from the context. If you want to follow the interrupt hierarchy,
> > > > > > "interrupt-parent" isn't enough. You also need to track
> > > > > > things like interrupt-map, or anything that carries a phandle
> > > > > > to an interrupt controller.
> > > > >
> > > > > We don't need to follow the hierarchy, we just need the immediate
> > > > > dependencies.
> > > >
> > > > Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.
> > >
> > > Thanks Rob for explaining it.
> > >
> > > Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
> > > Also, I'm trying to keep of/property.c independent of the framework
> > > code for now. The long term goal is to see if I can move out most of
> > > this into the frameworks. But I want to do that after I sort of some
> > > of the larger problems (like getting fw_devlink=on to work on all
> > > devices  first). Let me know if you have a strong preference for right
> > > now, if not, I'd rather keep property.c independent for now.
> > >
> > > I wasn't aware of interrupt-map until a few weeks ago and didn't know
> > > it carried phandles. I can add support for that too. There's no reason
> > > for all of them to go in one patch though.
> > >
> > > >
> > > > > But you are right that 'interrupt-map' also needs to be tracked.
> > > >
> > > > And 'interrupts-extended', while we're at it.
> > >
> > > This is already handled.
> > >
> > > > >
> > > > > I also noticed that we define 'interrupt-parent' as a dependency to
> > > > > parse, but that's wrong. The dependency is where 'interrupts' appears
> > > > > and where 'interrupt-parent' appears is irrelevant.
> > >
> > > No, the interrupt-parent parsing is correct and it's needed for
> > > interrupt controllers to probe in the right order. But
> > > interrupt-parent is also needs to be looked at for parsing
> > > "interrupts".
> >
> > If you parse 'interrupts' for interrupt controllers (which in turn
> > will use 'interrupt-parent'), then you aren't going to need to track
> > 'interrupt-parent' by itself.
>
> Do all interrupt controllers (that are not the root interrupt
> controller) need to have "interrupts" property? If yes, then yeah,
> that makes sense. But I vaguely remember that this wasn't the case for
> some DT I saw.

There are some cases of stacked controllers where it's implicit.

>
> Ah, here's one I found.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/mt2701.dtsi#n209

Right, so this is one of several cases of custom interrupt mapping
properties (mediatek,ext-irq-range). Really, 'interrupts' or
'interrupt-map' should have been used here, but 'interrupt-map'
doesn't really scale well if you have large ranges of interrupts.

To handle the dependency with just 'interrupt-parent', you need to
find nodes that are themselves an 'interrupt-parent' and then find
their 'interrupt-parent'.

Rob
