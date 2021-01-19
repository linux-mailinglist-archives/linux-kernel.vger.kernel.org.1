Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363792FBF66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbhASSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:46:59 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33883 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbhASSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:34:08 -0500
Received: by mail-oi1-f180.google.com with SMTP id h192so4545135oib.1;
        Tue, 19 Jan 2021 10:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbVLgD/AmPRXVgD1Qm+R+JESdeabtq3CZjpUzVZvhfY=;
        b=fKjB7s9CLJ3Li62DVNtOZ3U82i9wGaZi7I8+t45Sx/SkD54dNrIOC7mHoQBJsSWGZr
         VzzgUn1UWXR2VroeHwNyK+xwZioGJVESSvRZ/nRKAOlUOibLgeed1saBUn6MtsLZtPdZ
         ohEbHe08uhCXItHtir72KV8BeqUm/SqUe1AOacYga9hsqwPBpBj42hnwtX3yG1VgwUUb
         ZWJ6aGn57bdP9dEDvpe9is6VNfGBYi41tvHpIqAwX7RNBg4wL6nYxpjjbDwSM96hOvGB
         nQ2UNRVpoY5XYyhPE/kVwrB4aF+eEqV/UvyRFoyMgFwds5pxP7P5yR8lZ/AsTwUtrW8P
         rJkg==
X-Gm-Message-State: AOAM532PBuv+pFxjGY6EcN2SyW+r8eH4Sy+x58xDkLKXSNlgAnPWwsjs
        E9UPZQ0QL2d6rCjUZtoQTUycjZhFsoNbnhaW9GY=
X-Google-Smtp-Source: ABdhPJyi7FSrKeCQGWXG4jTZDvgDfi17y3rNnYi8HgSf5QEd5RWqUyZo+Kuj7HSsOsGqSMfOSvkqjzhDueOJnpCJgQ4=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr696462oia.54.1611081198709;
 Tue, 19 Jan 2021 10:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20210115210159.3090203-1-saravanak@google.com>
 <CACRpkdYrzaFuWkbTe7Fmos4Bk4Ojt6wbqayDjyrS7sf98P-Rbg@mail.gmail.com>
 <CAGETcx9t3R-k0ttiaBUqcveqnXMX75xuTcKPSo9J6WJOfgSP8w@mail.gmail.com>
 <CAMuHMdUN7+O28Xz5rkPwR2RuSA+o_E2VcWsz_9+kzy4=0Jnb1g@mail.gmail.com>
 <CACRpkdZqSm-xfo8a8aFUe-Mbaw9tM+OmCAF3KWjOVDfC=oWj+Q@mail.gmail.com>
 <CAGETcx-Vp0BpYbpPjwsmOv0q5ba1mJvfsPEZ9Oi2Rmx67udu7A@mail.gmail.com>
 <CAMuHMdUc+RCK=t02QhtWRekoYCx2pHnMyaTYiC0=SxKQVrqDHQ@mail.gmail.com> <CAGETcx_Ud+UJcdWkCH-WzEGjH4voRBoO++np7ARSi5Gnh51jYg@mail.gmail.com>
In-Reply-To: <CAGETcx_Ud+UJcdWkCH-WzEGjH4voRBoO++np7ARSi5Gnh51jYg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jan 2021 19:32:57 +0100
Message-ID: <CAMuHMdUe6W5ABO-WntCRFXnusacY=2HNiahXN-9ts-Nsf847uQ@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add fw_devlink support for "gpio" and
 "gpios" binding
To:     Saravana Kannan <saravanak@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Tue, Jan 19, 2021 at 7:19 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Jan 19, 2021 at 10:10 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Jan 19, 2021 at 6:54 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Jan 19, 2021 at 2:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > On Tue, Jan 19, 2021 at 9:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > Can we pull this into driver-core-next please? It fixes issues on some
> > > > > > boards with fw_devlink=on.
> > > > >
> > > > > On r8a77951-salvator-xs.dts, it introduces one more failure:
> > > > >
> > > > >     OF: /soc/i2c@e66d8000/gpio@20/pcie-sata-switch-hog: could not get
> > > > > #gpio-cells for /cpus/cpu@102
> > >
> > > Geert,
> > >
> > > One good thing is that it's noticing this being weird and ignoring it
> > > in your particular board. I *think* it interprets the "7" as a phandle
> > > and that's cpu@102 and realizes it's not a gpio-controller. For at
> > > least in your case, it's a safe failure.
> >
> > While 7 is the GPIO index, relative to the current GPIO controller,
> > represented by the parent device node.
> >
> > > > > Seems like it doesn't parse gpios properties in GPIO hogs correctly.
> > > >
> > > > Could it be that the code assumes no self-referencing phandles?
> > > > (Just guessing...)
> > >
> > > Ok I tried to understand what gpio-hogs means. It's not fully clear to
> > > me. But it looks like if a gpio-controller has a gpio-hog, then it
> > > doesn't have/need gpio-cells? Is that right?
> >
> > A GPIO hog is a way to fix (strap) a GPIO line to a specific value.
> > Usually this is done to enable a piece of hardware on a board, or
> > control a mux.
> >
> > The controller still needs gpio-cells.
> >
> > > So if a gpio-controller has a gpio-hog, can it ever be referred to by
> > > another consumer in DT using blah-gpios = ...? If so, I don't see any
> > > obvious code that's handling the missing gpio-cells in this case.
> >
> > Yes it can.
> >
> > > Long story short, please help me understand gpio-hog in the context of
> > > finding dependencies in DT.
> >
> > The hog references a GPIO on the current controller.  As this is always
> > the parent device node, the hog's gpios properties lack the phandle.
> >
> > E.g. a normal reference to the first GPIO of gpio5 looks like:
> >
> >     gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> >
> > A hog on the first GPIO of gpio5 would be a subnode of gpio5,
> > and would just use:
> >
> >     gpios = <0 GPIO_ACTIVE_LOW>;
> >
> > instead.
> >
> > Hope this helps.
>
> I'm still not sure if I've understood this fully, but does this just
> boil down to:
> Don't parse [name-]gpio[s] to find dependencies if the node has
> gpio-hog property?

Indeed. You can just ignore all nodes with a gpio-hog property, as they're
always handled by their parent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
