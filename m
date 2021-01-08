Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE402EEC8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 05:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAHEgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbhAHEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:36:11 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80182C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 20:35:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k78so8219126ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 20:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1SVE6yoN4HPrAiKG4HycbN2VbZ3WYTsf5zLfwe+sy4=;
        b=g1w6Le+l124UY7y6qxUP4M9LoiaYaqnN6tlZEbZs0Y34sSFxxSepoQIooN234dWk1Q
         pIXAhdhmZIRCyfgfZyfND8EQmBZ14SQEheYb92p5gdRSl9xrqCofsx1h3tfB5XHNwe/J
         vqxQVz+8QelNVjAdZiOAQbF56J900Mge6fkY2VJJa9FTL189YfKMu9spQ8K5BP2EkHj3
         n8VoSpz1y12kzLEdT12Hz+jEGlQdreRgkdYGxwGpZb94VThewIFjtfckd0P8U+neqpzY
         Hd9GEHSYDJ0BKjh3TV50Jxio7xrQGXqn1zIHY2/09PcepxCoslr/jcxlFiiuGPQxN0sA
         FnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1SVE6yoN4HPrAiKG4HycbN2VbZ3WYTsf5zLfwe+sy4=;
        b=f6vqUFFwCDFiJLxFTOJKKWAqAJ2nGmLyoShwjrC0DQYh0xzhmmWMcupD3jpmI20o2+
         QLhRKgDh5N5AjUP5WrKZnEljbmi3dih/cu/DAr4eBtpY1R8jcqGpcdOsweooujQQGIyT
         sjF5qdO9V7leP7OfluUX00GQla6o2/PHAT6svz1dK93xhy5tkF02eEKtouwpqXkswHjx
         q+zP3+Q4mrPdJFC4CUv2EXi8UNns4jxDl+O4FWRyuekVwYeG0Zv5E/Gx3YRF9s3WvNeN
         qDTb0UFnMZ0cGyaWHmQNENbqehPfytvV22kW+T19xULIjG7bRVmijZMJfJGdwjBhqSMW
         UPKw==
X-Gm-Message-State: AOAM531rPRKK/dto22Qvjj1P3aE0ggo5kVv5quU5NZKc8RiJYn8JEYz+
        Z0HbVidzZvNfCDNctx1YpjGSuzaJZ9HtY5qO3GULKg==
X-Google-Smtp-Source: ABdhPJwk0SgDSw8iXgF7b+s7xZ+XMb1t95rL6CaG5YcATnqHLyA5MuPYfG84/ZyY1wK2F/mw51Iy/hLfqi0elInvNNw=
X-Received: by 2002:a25:4f55:: with SMTP id d82mr3172943ybb.466.1610080529217;
 Thu, 07 Jan 2021 20:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
 <CAGETcx_4n951Fx-Gn14ikDDxgWtv6QqQtNno9pcPJyiiGynWHQ@mail.gmail.com>
 <CAL_Jsq+mavViUqWDVTAYB5p1j5h7FUNCzM9hg-ttJzLuJazZFQ@mail.gmail.com>
 <CAGETcx-PwEt58S24N-2dhnXavtyzdCd_F332npQXA6Czuf1hWQ@mail.gmail.com> <CAL_JsqKL4EXin7ZjUW65THE=nTeCtV1bGpFn93A04xpCJ27KoA@mail.gmail.com>
In-Reply-To: <CAL_JsqKL4EXin7ZjUW65THE=nTeCtV1bGpFn93A04xpCJ27KoA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 20:34:51 -0800
Message-ID: <CAGETcx-rOTbiE3tS266cV4Baaf1D=AMdU3zhHot+W1f6D9LOaw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Rob Herring <robh@kernel.org>
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

On Thu, Jan 7, 2021 at 7:36 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 7, 2021 at 4:13 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jan 7, 2021 at 11:33 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Jan 7, 2021 at 12:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Jan 7, 2021 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jan 6, 2021 at 11:53 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 31 Dec 2020 21:12:40 +0000,
> > > > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > > > > > > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > > > > > > > Add support for creating device links out of interrupts property.
> > > > > > > > > >
> > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > > > > ---
> > > > > > > > > > Rob/Greg,
> > > > > > > > > >
> > > > > > > > > > This might need to go into driver-core to avoid conflict
> > > > > > > > > > due to fw_devlink refactor series that merged there.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Saravana
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > > > > > > > >  1 file changed, 17 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > > > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > > > > > > > --- a/drivers/of/property.c
> > > > > > > > > > +++ b/drivers/of/property.c
> > > > > > > > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > > > > > > > *parse_iommu_maps(struct device_node *np,
> > > > > > > > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > > > > > > > +                                     const char *prop_name, int index)
> > > > > > > > > > +{
> > > > > > > > > > + struct device_node *sup;
> > > > > > > > > > +
> > > > > > > > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > > > > > > > +         return NULL;
> > > > > > > > > > +
> > > > > > > > > > + of_node_get(np);
> > > > > > > > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > > > > > > > +         np = of_get_next_parent(np);
> > > > > > > > > > + of_node_put(np);
> > > > > > > > > > +
> > > > > > > > > > + return sup;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > > > > > > > >   { .parse_prop = parse_clocks, },
> > > > > > > > > >   { .parse_prop = parse_interconnects, },
> > > > > > > > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > > > > > > > of_supplier_bindings[] = {
> > > > > > > > > >   { .parse_prop = parse_pinctrl6, },
> > > > > > > > > >   { .parse_prop = parse_pinctrl7, },
> > > > > > > > > >   { .parse_prop = parse_pinctrl8, },
> > > > > > > > > > + { .parse_prop = parse_interrupts, },
> > > > > > > > > >   { .parse_prop = parse_regulators, },
> > > > > > > > > >   { .parse_prop = parse_gpio, },
> > > > > > > > > >   { .parse_prop = parse_gpios, },
> > > > > > > > >
> > > > > > > > > You don't really describe what this is for so I'm only guessing
> > > > > > > > > from the context. If you want to follow the interrupt hierarchy,
> > > > > > > > > "interrupt-parent" isn't enough. You also need to track
> > > > > > > > > things like interrupt-map, or anything that carries a phandle
> > > > > > > > > to an interrupt controller.
> > > > > > > >
> > > > > > > > We don't need to follow the hierarchy, we just need the immediate
> > > > > > > > dependencies.
> > > > > > >
> > > > > > > Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.
> > > > > >
> > > > > > Thanks Rob for explaining it.
> > > > > >
> > > > > > Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
> > > > > > Also, I'm trying to keep of/property.c independent of the framework
> > > > > > code for now. The long term goal is to see if I can move out most of
> > > > > > this into the frameworks. But I want to do that after I sort of some
> > > > > > of the larger problems (like getting fw_devlink=on to work on all
> > > > > > devices  first). Let me know if you have a strong preference for right
> > > > > > now, if not, I'd rather keep property.c independent for now.
> > > > > >
> > > > > > I wasn't aware of interrupt-map until a few weeks ago and didn't know
> > > > > > it carried phandles. I can add support for that too. There's no reason
> > > > > > for all of them to go in one patch though.
> > > > > >
> > > > > > >
> > > > > > > > But you are right that 'interrupt-map' also needs to be tracked.
> > > > > > >
> > > > > > > And 'interrupts-extended', while we're at it.
> > > > > >
> > > > > > This is already handled.
> > > > > >
> > > > > > > >
> > > > > > > > I also noticed that we define 'interrupt-parent' as a dependency to
> > > > > > > > parse, but that's wrong. The dependency is where 'interrupts' appears
> > > > > > > > and where 'interrupt-parent' appears is irrelevant.
> > > > > >
> > > > > > No, the interrupt-parent parsing is correct and it's needed for
> > > > > > interrupt controllers to probe in the right order. But
> > > > > > interrupt-parent is also needs to be looked at for parsing
> > > > > > "interrupts".
> > > > >
> > > > > If you parse 'interrupts' for interrupt controllers (which in turn
> > > > > will use 'interrupt-parent'), then you aren't going to need to track
> > > > > 'interrupt-parent' by itself.
> > > >
> > > > Do all interrupt controllers (that are not the root interrupt
> > > > controller) need to have "interrupts" property? If yes, then yeah,
> > > > that makes sense. But I vaguely remember that this wasn't the case for
> > > > some DT I saw.
> > >
> > > There are some cases of stacked controllers where it's implicit.
> >
> > In that case, I think it's good to track interrupt-parent explicitly.
> > Doesn't really hurt anything. We already protect for stuff like making
> > sure a parent doesn't depend on its child, etc.
>
> Given the interrupt controller is probably always going to be there,
> it probably doesn't really matter. But the dependency is wrong.
>
> Does this work:
>
> bus {
>   interrupt-parent = <&root_int>;
>
>   root_int: interrupt-controller {
>   };
>
>   device {
>     interrupts = <1>;
>   };
> };
>
> The only dependency here should be /bus/device -> root_int.

Right, and that's the only one that'll get created because a parent
(bus) can't depend on a child (root_int). There are other similar
things that'll effectively make the interrupt-parent handling harmless
and also cover the few odd cases like the one I pointed out.

> > > >
> > > > Ah, here's one I found.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/mt2701.dtsi#n209
> > >
> > > Right, so this is one of several cases of custom interrupt mapping
> > > properties (mediatek,ext-irq-range). Really, 'interrupts' or
> > > 'interrupt-map' should have been used here, but 'interrupt-map'
> > > doesn't really scale well if you have large ranges of interrupts.
> > >
> > > To handle the dependency with just 'interrupt-parent', you need to
> > > find nodes that are themselves an 'interrupt-parent' and then find
> > > their 'interrupt-parent'.
> >
> > Not sure I understand this.
> >
> > On a side note, if I'm adding device links between a device and the
> > "interrupt-parent" it's pointing to, at worst, I'm having it depend on
> > an interrupt controller its child devices would depend on. This
> > combined with the fact that "weird" links like "parent depending on
> > child",
>
> The above would be this case if you treat root_int as a dependency of
> bus. It's not, but I guess that plus the child dependency on parent
> makes interrupt dependencies mostly work.
>
> > "non-device node having interrupt-parent",
>
> Yes, that's probably 95% of interrupt-parent cases. It's either at the
> root or bus node.
>
> > etc are already
> > ignored, seems safe to leave in "interrupt-parent" to catch these
> > cases where interrupt controllers don't specify "interrupts" or
> > "interrupt-map"? I don't mind removing it, but maybe we can wait till
> > we get fw_devlink=on and then remove it to see if anything breaks? If
> > nothing breaks, we can remove explicit interrupt-parent parsing?
>
> Okay, as long as we're breaking platforms once potentially.

I'm not sure if the sentence needs a negative somewhere in there, but
I believe we are in agreement.

> > Going back to interrupt-map, I understand the syntax now. I'm trying
> > to see if I can break up of_irq_parse_raw() into smaller pieces and
> > reuse (call into) some of that code. While doing that I see that when
> > "address-cells" isn't present, the "addrsize" is initialized to 2 [1]
> > but when "address-cells" isn't present, the "newaddrsize" is
> > initialized to 0 [1]. Why is the default value of #address-cells two
> > different numbers?
>
> It's some ancient code that needs to handle quirks of ancient systems.
>
> The first one is the #address-cells for the device's bus. The second
> is #address-cells in the interrupt-controller/map. It's complicated
> because interrupt hierarchies used to follow the bus hierarchies.
> Generally in modern systems #address-cells used for interrupt-map
> purposes (the 2nd case) will always be 0.
>
> Note that there's generic nexus code to support gpio-map. It works
> similarly though without the address-cells part. Any refactoring
> should take that into account.

Ok, thanks for the info. I'll refactor out the common code and try to
use that to implement interrupt-map support.

-Saravana
