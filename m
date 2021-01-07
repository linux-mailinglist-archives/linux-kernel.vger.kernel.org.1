Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A982ED4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbhAGQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbhAGQsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:48:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 504A123435;
        Thu,  7 Jan 2021 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610038081;
        bh=YaCZZZbSinB9rPbQ56pUOlP/NfRFcdIMlqgkjgEsynM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K9C7xix/0JOAhv+G7GIk+62ppLJjfTK2kDNNTFgt5fjUCmftj1aYG1AIPSklQ9fX1
         tb47S7u856CnWBcbtMj/nEOtqaP7i950Zw+WBr/K9UoD0YyTe68urQmO2FzJBKrWYA
         iIKCGDYZZOnn+pEPzeN4rJScTs/sH3XwWftM1z86GSBJ7LTLTPS4Hj8pCCaB7ei6wj
         AvARaA0lkD3phO2y2hvWepJLA28/d9pUW96E2aqIADPq9/1jLVWQhKxzcRJ5U/HtcH
         zuV1wnRtaoKFbxjIt9orMPUPoIn54VQoZEWymUpnQSvkQExRT2vbkdaX/1olOpLukp
         jOOiuxHMTfVYA==
Received: by mail-ed1-f48.google.com with SMTP id u19so8430545edx.2;
        Thu, 07 Jan 2021 08:48:01 -0800 (PST)
X-Gm-Message-State: AOAM532cmyDfoitI8nVZ1wIjU5PQZ4IG0V55suxGbYjNeOG3vb0ZQ08o
        e5x5SVNsJYAkNxBwdT5eQq0bNBx+xXpPBoINKQ==
X-Google-Smtp-Source: ABdhPJzLXCPsl/f5C2HbB8efROfp6zlM7GI/1U5HgudGrdQwWsv4q5ypidjCTB+tU86iuwz+hYjCFiR4ts+4msnntlQ=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr2366343edy.194.1610038079756;
 Thu, 07 Jan 2021 08:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org> <20201231211240.GA2333246@robh.at.kernel.org>
 <877dovlgdl.wl-maz@kernel.org> <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAGETcx_y6pj-8xEUfMi164iFTiDLVcdATofkOTjvFBCSAQY3sw@mail.gmail.com>
In-Reply-To: <CAGETcx_y6pj-8xEUfMi164iFTiDLVcdATofkOTjvFBCSAQY3sw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 09:47:46 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJX_eWEU=0STW0rjxO=0NVgpuV5rD-5utD7Yzd6otPFvw@mail.gmail.com>
Message-ID: <CAL_JsqJX_eWEU=0STW0rjxO=0NVgpuV5rD-5utD7Yzd6otPFvw@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 6:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:52 AM Saravana Kannan <saravanak@google.com> wrote:
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
>
> Hmm... I looked at
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> and it has no documentation for interrupt-map. There's a bunch of
> references to it in device specific DT binding documentation but I
> don't want to rely on those for correctness.

See the DT spec and there's also details on elinux.org. It's only
existed since the 1990s.

Rob
