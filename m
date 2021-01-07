Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0E2ED530
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbhAGRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbhAGRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:09:33 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D2C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:08:52 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k4so6750820ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SS3DM2iEdyFUgDhuSMZ8Sz2/zsciyLMLy6hexAt6XHw=;
        b=XTHrAcEoXL6NXFTI6YYLlkcFJ4JYiZA4lZ2r4NlQbR4yvEwd0rHwLuvjtc8A9FzMoo
         jcXJ8ooo9EFzkUpdS0YKUiFO8/nzr1PuZ2ww4DlVtU8gdatYwpdyGTaXpN4UJj40TIxM
         fHfvmH89gtb50EutYmZlN4ElLGQ/7S/z8HJUUuPmjnbr7QjuPrcfeilv+oAL3+7dhfZ9
         g6lIGNSVHK0qg2XOIRtmCIgdkKIIcRZBXzKoA7y0bHNTIBEjxKBRXQO6K0yx8hW30nwQ
         Eygxda6iS+fW1hIMbCXnBhfHKME/Jz/GzGSiKjnTcYUkJuQiMk108d1I2wnyHPuabIrC
         cFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS3DM2iEdyFUgDhuSMZ8Sz2/zsciyLMLy6hexAt6XHw=;
        b=fhtFzBRjQmBp1mdDLasmsylJ4hfc0kzU8Zgg2hB9YhL/Dsdi0TApoBUCoJLYWeD/8m
         woHZ3bwDD1QTqvRbu/ihJaZsi0/JYCPve6CrmwLMqjHOvbRuD+95qYdzi7OcouqbEc7L
         OXKqO04RL6ZAWKqmZL5vvxzU0KhkQNuiQ7ssUlqfaCOp44H1Dp697TnnmIDDZ1Ttm/91
         q1Mxl8jPioNJ/oqCnvAafiBy8b+DjhZIlEUvkAhvt3SD1NWvWMtRJkD9iatrF76cLrz/
         ciYNeOnsif0XqEtv04jPsa3OCgeFZauzlG3ddvztY1/BGDlTN6syoXrmnF7bLt1tF9uL
         yvJw==
X-Gm-Message-State: AOAM532Qyw9PSEmhaARyEC2rYKBTPBT9FQbykTAGvm0aVgZVPxBkWatB
        5/DQrSCi7XA8MteJRiu/AhjNMUF5kuz4/pIpQFeUqg==
X-Google-Smtp-Source: ABdhPJzdHxcYJZiIF6rorYMgkdsqh3rdIFCGsiyDWZpYkaXLuNAk04h6SjasWV00BvCK9RRiHoYYc1NDa7zYUoraEns=
X-Received: by 2002:a25:d7d7:: with SMTP id o206mr14472508ybg.228.1610039331469;
 Thu, 07 Jan 2021 09:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAGETcx_y6pj-8xEUfMi164iFTiDLVcdATofkOTjvFBCSAQY3sw@mail.gmail.com> <CAL_JsqJX_eWEU=0STW0rjxO=0NVgpuV5rD-5utD7Yzd6otPFvw@mail.gmail.com>
In-Reply-To: <CAL_JsqJX_eWEU=0STW0rjxO=0NVgpuV5rD-5utD7Yzd6otPFvw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 09:08:15 -0800
Message-ID: <CAGETcx8D6Q7XojOnRCPNAZWcxhNt5ebFCp6gyh-cuKeaKfS2Bw@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 8:48 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 6:26 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Jan 6, 2021 at 10:52 AM Saravana Kannan <saravanak@google.com> wrote:
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
> >
> > Hmm... I looked at
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > and it has no documentation for interrupt-map. There's a bunch of
> > references to it in device specific DT binding documentation but I
> > don't want to rely on those for correctness.
>
> See the DT spec and there's also details on elinux.org. It's only
> existed since the 1990s.

Thanks :) Will try to find it there.

-Saravana
