Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC42ED744
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbhAGTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:10:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F7C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:09:50 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id w127so7095712ybw.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKGkFmm6dM/AAYIANDqWrJzHUmWC0POy+3cbbrpsiKY=;
        b=SgPLVDN6cTkiMRRQPbLMl6hNHvL4IFv26gvrZSA4Sr5VrOJDVHtdovZEnIo9jT8ieK
         3ZZqYJmuATrdEUJDhxkQ3ys5Nhlw4LirtwPrhTGB7IPZJFR+DYOMm3oRDP2k1bS27vsF
         YQzqjKpfwsLHVdRbT2AZnLMliAtQtshpgN8whBFzGgGPaxufLV9t0dIHDJ8glD6evnzt
         E6haf9UzYTjmqG6ymcZrJloD6zrurTO4ZkkmsBTE/gPCHISt9fP6frpOECgjzN7odUVL
         6jOF7KHHZSG0tPMrxqVLdDq49EZQS61QE7Qc5UgG+U46Jnv+OR5wnTVjYjMI9//ty2uU
         P73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKGkFmm6dM/AAYIANDqWrJzHUmWC0POy+3cbbrpsiKY=;
        b=V6yyg9Qg8/rXT6k++k1YmyuZ3lxT+m53B18umhJhRwr+7F8YBJk8kHI1mPJ74vHBul
         X+W6r3ZDm7SJbSi3xVHdrNd1gy78pOCPNTCML9nveukTGDuatd9VUjB1PnvXvLV5C+rI
         FH9P2T+kLEkLxdal2g9NXi9UgWbFyH9aIYA5m5l6C0TdeoGB/2EFT/ghlo/4xROnLnfC
         zZoY/2/0U+u04d5C4y76Bn6BdjLptm/jIved+Womusfqbp9UE9l93FBCO41xIxw+FU9j
         fEjCQ/Xslk9GZYxKOEEdnCpaHGFzcbF48IYr/ADoBbReYshBI/TIsHQRTTe3j4odV+Dj
         WW1w==
X-Gm-Message-State: AOAM530+bnm2PlzQRlCeffrPd3FjuDXlcoxCdRNc6lKH/4n86wn+ieY/
        4MwuJW9TFbnbfH9KbXu6sHWBzpoQbvic+lQC+fqGBQ==
X-Google-Smtp-Source: ABdhPJw65HlNw5Ta5xSHJ/boxx023/D1yb8PW6AMfxFFa5G+tFXQNBhdk57pg9FzZhYcsRHrZfdjnfPHqsaDPXWzTEM=
X-Received: by 2002:a25:6604:: with SMTP id a4mr414212ybc.412.1610046588981;
 Thu, 07 Jan 2021 11:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+0DdS+F_NZEyP2ajG5g6a_Q543Yp5ReWXGp8qA+25F=g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 11:09:12 -0800
Message-ID: <CAGETcx_4n951Fx-Gn14ikDDxgWtv6QqQtNno9pcPJyiiGynWHQ@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 11:53 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Sat, Jan 2, 2021 at 3:37 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 31 Dec 2020 21:12:40 +0000,
> > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> > > > > On 2020-12-18 21:07, Saravana Kannan wrote:
> > > > > > Add support for creating device links out of interrupts property.
> > > > > >
> > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > ---
> > > > > > Rob/Greg,
> > > > > >
> > > > > > This might need to go into driver-core to avoid conflict
> > > > > > due to fw_devlink refactor series that merged there.
> > > > > >
> > > > > > Thanks,
> > > > > > Saravana
> > > > > >
> > > > > >
> > > > > >  drivers/of/property.c | 17 +++++++++++++++++
> > > > > >  1 file changed, 17 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1271,6 +1271,22 @@ static struct device_node
> > > > > > *parse_iommu_maps(struct device_node *np,
> > > > > >   return of_parse_phandle(np, prop_name, (index * 4) + 1);
> > > > > >  }
> > > > > >
> > > > > > +static struct device_node *parse_interrupts(struct device_node *np,
> > > > > > +                                     const char *prop_name, int index)
> > > > > > +{
> > > > > > + struct device_node *sup;
> > > > > > +
> > > > > > + if (strcmp(prop_name, "interrupts") || index)
> > > > > > +         return NULL;
> > > > > > +
> > > > > > + of_node_get(np);
> > > > > > + while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > > > > > +         np = of_get_next_parent(np);
> > > > > > + of_node_put(np);
> > > > > > +
> > > > > > + return sup;
> > > > > > +}
> > > > > > +
> > > > > >  static const struct supplier_bindings of_supplier_bindings[] = {
> > > > > >   { .parse_prop = parse_clocks, },
> > > > > >   { .parse_prop = parse_interconnects, },
> > > > > > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > > > > > of_supplier_bindings[] = {
> > > > > >   { .parse_prop = parse_pinctrl6, },
> > > > > >   { .parse_prop = parse_pinctrl7, },
> > > > > >   { .parse_prop = parse_pinctrl8, },
> > > > > > + { .parse_prop = parse_interrupts, },
> > > > > >   { .parse_prop = parse_regulators, },
> > > > > >   { .parse_prop = parse_gpio, },
> > > > > >   { .parse_prop = parse_gpios, },
> > > > >
> > > > > You don't really describe what this is for so I'm only guessing
> > > > > from the context. If you want to follow the interrupt hierarchy,
> > > > > "interrupt-parent" isn't enough. You also need to track
> > > > > things like interrupt-map, or anything that carries a phandle
> > > > > to an interrupt controller.
> > > >
> > > > We don't need to follow the hierarchy, we just need the immediate
> > > > dependencies.
> > >
> > > Indeed. I also wonder why this isn't just a irq_find_parent() call, TBH.
> >
> > Thanks Rob for explaining it.
> >
> > Marc, I wasn't sure if Rob would be okay with including of_irq.h here.
> > Also, I'm trying to keep of/property.c independent of the framework
> > code for now. The long term goal is to see if I can move out most of
> > this into the frameworks. But I want to do that after I sort of some
> > of the larger problems (like getting fw_devlink=on to work on all
> > devices  first). Let me know if you have a strong preference for right
> > now, if not, I'd rather keep property.c independent for now.
> >
> > I wasn't aware of interrupt-map until a few weeks ago and didn't know
> > it carried phandles. I can add support for that too. There's no reason
> > for all of them to go in one patch though.
> >
> > >
> > > > But you are right that 'interrupt-map' also needs to be tracked.
> > >
> > > And 'interrupts-extended', while we're at it.
> >
> > This is already handled.
> >
> > > >
> > > > I also noticed that we define 'interrupt-parent' as a dependency to
> > > > parse, but that's wrong. The dependency is where 'interrupts' appears
> > > > and where 'interrupt-parent' appears is irrelevant.
> >
> > No, the interrupt-parent parsing is correct and it's needed for
> > interrupt controllers to probe in the right order. But
> > interrupt-parent is also needs to be looked at for parsing
> > "interrupts".
>
> If you parse 'interrupts' for interrupt controllers (which in turn
> will use 'interrupt-parent'), then you aren't going to need to track
> 'interrupt-parent' by itself.

Do all interrupt controllers (that are not the root interrupt
controller) need to have "interrupts" property? If yes, then yeah,
that makes sense. But I vaguely remember that this wasn't the case for
some DT I saw.

Ah, here's one I found.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/mt2701.dtsi#n209

-Saravana
