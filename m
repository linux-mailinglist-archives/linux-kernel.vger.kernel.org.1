Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15172EEBE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAHDgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbhAHDgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:36:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0507A235DD;
        Fri,  8 Jan 2021 03:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610076962;
        bh=1bLSWJSdg4Q9c9x/9FtnXiRcfy2TSdP0/0CcM65VPv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=II6F9O5ffDWFmYvhlXJhW0OhF+a+/qUxozmyUQllZyFudUc66j1z7ZjojuCYqm+P7
         2CxmnbTb4IrBqKYAH3tXqSSddlId4zCcht+/3YvwEOhr1TdvjnM72l9Jsm5Rd//xav
         MPDV6rJ4Y8eRwzoc6ueWRgjqbF5se57QhB3Y1TSWrxoZ1z0HSJL6X7qoQrNBCURJIf
         YpMn4JXVWdknKPd8SmXaeBmNnazb9dTuQVlWdcq/cBJmiY0C5TQ8zmxAgVguud0ETV
         erJDgnpv1uG77wTVPZ8HMAg0xo8awZU/87cxA6xjR3lLgbK/p5CVM7hb7WFIUwttjt
         QGg1BN5EupN+Q==
Received: by mail-ed1-f53.google.com with SMTP id u19so9887600edx.2;
        Thu, 07 Jan 2021 19:36:01 -0800 (PST)
X-Gm-Message-State: AOAM53201hgv6gwvDHNRubdifZnJlyVb+VTuVJHC/du/a1hAzHzTb7oo
        4mKtuzlZb3AlHdDlbco9jUa3BacrVi8XKgQfSg==
X-Google-Smtp-Source: ABdhPJw+gbq0Aa6wTV5RlFQUoRUYHQbK9g9Sg9RwcIjLRL0y1nV5vvjgt6BL6OKr1i6+n1Iy15wDQmxdND2pi90QIoY=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr3769360edw.373.1610076960416;
 Thu, 07 Jan 2021 19:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
 <CAGETcx_4n951Fx-Gn14ikDDxgWtv6QqQtNno9pcPJyiiGynWHQ@mail.gmail.com>
 <CAL_Jsq+mavViUqWDVTAYB5p1j5h7FUNCzM9hg-ttJzLuJazZFQ@mail.gmail.com> <CAGETcx-PwEt58S24N-2dhnXavtyzdCd_F332npQXA6Czuf1hWQ@mail.gmail.com>
In-Reply-To: <CAGETcx-PwEt58S24N-2dhnXavtyzdCd_F332npQXA6Czuf1hWQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 20:35:48 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKL4EXin7ZjUW65THE=nTeCtV1bGpFn93A04xpCJ27KoA@mail.gmail.com>
Message-ID: <CAL_JsqKL4EXin7ZjUW65THE=nTeCtV1bGpFn93A04xpCJ27KoA@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 4:13 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 7, 2021 at 11:33 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jan 7, 2021 at 12:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Jan 7, 2021 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 6, 2021 at 11:53 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 31 Dec 2020 21:12:40 +0000,
> > > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > > > > > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > > > > > > Add support for creating device links out of interrupts property.
> > > > > > > > >
> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > > > ---
> > > > > > > > > Rob/Greg,
> > > > > > > > >
> > > > > > > > > This might need to go into driver-core to avoid conflict
> > > > > > > > > due to fw_devlink refactor series that merged there.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Saravana
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > > > > > > >  1 file changed, 17 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > > > > > > --- a/drivers/of/property.c
> > > > > > > > > +++ b/drivers/of/property.c
> > > > > > > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > > > > > > *parse_iommu_maps(struct device_node *np,
> > > > > > > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > > > > > > +                                     const char *prop_name, int index)
> > > > > > > > > +{
> > > > > > > > > + struct device_node *sup;
> > > > > > > > > +
> > > > > > > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > > > > > > +         return NULL;
> > > > > > > > > +
> > > > > > > > > + of_node_get(np);
> > > > > > > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > > > > > > +         np = of_get_next_parent(np);
> > > > > > > > > + of_node_put(np);
> > > > > > > > > +
> > > > > > > > > + return sup;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > > > > > > >   { .parse_prop = parse_clocks, },
> > > > > > > > >   { .parse_prop = parse_interconnects, },
> > > > > > > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > > > > > > of_supplier_bindings[] = {
> > > > > > > > >   { .parse_prop = parse_pinctrl6, },
> > > > > > > > >   { .parse_prop = parse_pinctrl7, },
> > > > > > > > >   { .parse_prop = parse_pinctrl8, },
> > > > > > > > > + { .parse_prop = parse_interrupts, },
> > > > > > > > >   { .parse_prop = parse_regulators, },
> > > > > > > > >   { .parse_prop = parse_gpio, },
> > > > > > > > >   { .parse_prop = parse_gpios, },
> > > > > > > >
> > > > > > > > You don't really describe what this is for so I'm only guessing
> > > > > > > > from the context. If you want to follow the interrupt hierarchy,
> > > > > > > > "interrupt-parent" isn't enough. You also need to track
> > > > > > > > things like interrupt-map, or anything that carries a phandle
> > > > > > > > to an interrupt controller.
> > > > > > >
> > > > > > > We don't need to follow the hierarchy, we just need the immediate
> > > > > > > dependencies.
> > > > > >
> > > > > > Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.
> > > > >
> > > > > Thanks Rob for explaining it.
> > > > >
> > > > > Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
> > > > > Also, I'm trying to keep of/property.c independent of the framework
> > > > > code for now. The long term goal is to see if I can move out most of
> > > > > this into the frameworks. But I want to do that after I sort of some
> > > > > of the larger problems (like getting fw_devlink=on to work on all
> > > > > devices  first). Let me know if you have a strong preference for right
> > > > > now, if not, I'd rather keep property.c independent for now.
> > > > >
> > > > > I wasn't aware of interrupt-map until a few weeks ago and didn't know
> > > > > it carried phandles. I can add support for that too. There's no reason
> > > > > for all of them to go in one patch though.
> > > > >
> > > > > >
> > > > > > > But you are right that 'interrupt-map' also needs to be tracked.
> > > > > >
> > > > > > And 'interrupts-extended', while we're at it.
> > > > >
> > > > > This is already handled.
> > > > >
> > > > > > >
> > > > > > > I also noticed that we define 'interrupt-parent' as a dependency to
> > > > > > > parse, but that's wrong. The dependency is where 'interrupts' appears
> > > > > > > and where 'interrupt-parent' appears is irrelevant.
> > > > >
> > > > > No, the interrupt-parent parsing is correct and it's needed for
> > > > > interrupt controllers to probe in the right order. But
> > > > > interrupt-parent is also needs to be looked at for parsing
> > > > > "interrupts".
> > > >
> > > > If you parse 'interrupts' for interrupt controllers (which in turn
> > > > will use 'interrupt-parent'), then you aren't going to need to track
> > > > 'interrupt-parent' by itself.
> > >
> > > Do all interrupt controllers (that are not the root interrupt
> > > controller) need to have "interrupts" property? If yes, then yeah,
> > > that makes sense. But I vaguely remember that this wasn't the case for
> > > some DT I saw.
> >
> > There are some cases of stacked controllers where it's implicit.
>
> In that case, I think it's good to track interrupt-parent explicitly.
> Doesn't really hurt anything. We already protect for stuff like making
> sure a parent doesn't depend on its child, etc.

Given the interrupt controller is probably always going to be there,
it probably doesn't really matter. But the dependency is wrong.

Does this work:

bus {
  interrupt-parent = <&root_int>;

  root_int: interrupt-controller {
  };

  device {
    interrupts = <1>;
  };
};

The only dependency here should be /bus/device -> root_int.

> > >
> > > Ah, here's one I found.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/mt2701.dtsi#n209
> >
> > Right, so this is one of several cases of custom interrupt mapping
> > properties (mediatek,ext-irq-range). Really, 'interrupts' or
> > 'interrupt-map' should have been used here, but 'interrupt-map'
> > doesn't really scale well if you have large ranges of interrupts.
> >
> > To handle the dependency with just 'interrupt-parent', you need to
> > find nodes that are themselves an 'interrupt-parent' and then find
> > their 'interrupt-parent'.
>
> Not sure I understand this.
>
> On a side note, if I'm adding device links between a device and the
> "interrupt-parent" it's pointing to, at worst, I'm having it depend on
> an interrupt controller its child devices would depend on. This
> combined with the fact that "weird" links like "parent depending on
> child",

The above would be this case if you treat root_int as a dependency of
bus. It's not, but I guess that plus the child dependency on parent
makes interrupt dependencies mostly work.

> "non-device node having interrupt-parent",

Yes, that's probably 95% of interrupt-parent cases. It's either at the
root or bus node.

> etc are already
> ignored, seems safe to leave in "interrupt-parent" to catch these
> cases where interrupt controllers don't specify "interrupts" or
> "interrupt-map"? I don't mind removing it, but maybe we can wait till
> we get fw_devlink=on and then remove it to see if anything breaks? If
> nothing breaks, we can remove explicit interrupt-parent parsing?

Okay, as long as we're breaking platforms once potentially.

> Going back to interrupt-map, I understand the syntax now. I'm trying
> to see if I can break up of_irq_parse_raw() into smaller pieces and
> reuse (call into) some of that code. While doing that I see that when
> "address-cells" isn't present, the "addrsize" is initialized to 2 [1]
> but when "address-cells" isn't present, the "newaddrsize" is
> initialized to 0 [1]. Why is the default value of #address-cells two
> different numbers?

It's some ancient code that needs to handle quirks of ancient systems.

The first one is the #address-cells for the device's bus. The second
is #address-cells in the interrupt-controller/map. It's complicated
because interrupt hierarchies used to follow the bus hierarchies.
Generally in modern systems #address-cells used for interrupt-map
purposes (the 2nd case) will always be 0.

Note that there's generic nexus code to support gpio-map. It works
similarly though without the address-cells part. Any refactoring
should take that into account.

Rob
