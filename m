Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581CA2FBEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392430AbhASSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392403AbhASST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:19:56 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5AAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:19:15 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y128so16856297ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHK63mNEb6W4AaDercWEjXkLeIiYVU3MkZRoAzxz/mw=;
        b=TIKhKTRiWi86JaBOFJSF4irAc52V20kHLuNqvziTTpBjGp3nKdshbwFVlPqC5MQiSd
         iuJl1Kioq0DuEj4Ij/cpA3HZALUgN1HS/TA5uG2KrYah/3L9lpuktzLLoiA365+IWEHf
         d8iCmmDNoFSWNDuq/1zYACTbZNPeSSiMa/H28opAMGaxfB1dutjMLQ/Z32aF+wP+rWBC
         zBTi/wLEuNcg/kVVduAO045TnKU1GD6+fDtWxuNWScZBSc+d2jwNrQV4B+00nOS0cBhU
         02Oki33NxIM339vFFJbj/pkY4t6smCaD+O37PWEw5vD8+tAi1Edp9oQOctWwi3Xr6Ylf
         Hxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHK63mNEb6W4AaDercWEjXkLeIiYVU3MkZRoAzxz/mw=;
        b=ZOfrJ3L4bBkv/fMUCBHmmqfU9NEBAbgenDApHN2zXhg+AxAt2rf/t+lw3bXiUYw4tr
         VQiDOYQqB1XuOKexp9y+9SD8JLt1YwHJiBt7kVk4eJnFh/q6WPoJRpkn6zprB6MsflhM
         3kii3ykPagtV2QXGvXj7az6hYDUW+7bncp/rl11p5RtVzVtxWkkVh1VeOjuS/UIi0Hue
         A0c8s8Juh0wsJOP2fUKYX8sgRAcXf6mZT+0pedOlJo1R9Z4dpx+lsQ1ByOgVpw+Z69x0
         l7iZBhEiDuWvuoVvkn6wedLq5DVm69v9lLlyVvYd0FfZGC1dZgMjLzkscUbc89BvRM1x
         rAgw==
X-Gm-Message-State: AOAM530unwA7VV4SfRUEsfA4PHZQTqqpkAmjgfNP74gqF9rXKL1bEq3r
        il1gXoqLL9K469EsAF6sd56CWOY2SEbt0CLVZoQzvg==
X-Google-Smtp-Source: ABdhPJyLm5a7tvFOQ9GLnScwek6wKmCIHJ18QWGEYTshZYKHDn18Z57uCs9I6lcgQx2VH3iG7/oNB3pahuCum8iP7M8=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr8612886ybc.32.1611080355041;
 Tue, 19 Jan 2021 10:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20210115210159.3090203-1-saravanak@google.com>
 <CACRpkdYrzaFuWkbTe7Fmos4Bk4Ojt6wbqayDjyrS7sf98P-Rbg@mail.gmail.com>
 <CAGETcx9t3R-k0ttiaBUqcveqnXMX75xuTcKPSo9J6WJOfgSP8w@mail.gmail.com>
 <CAMuHMdUN7+O28Xz5rkPwR2RuSA+o_E2VcWsz_9+kzy4=0Jnb1g@mail.gmail.com>
 <CACRpkdZqSm-xfo8a8aFUe-Mbaw9tM+OmCAF3KWjOVDfC=oWj+Q@mail.gmail.com>
 <CAGETcx-Vp0BpYbpPjwsmOv0q5ba1mJvfsPEZ9Oi2Rmx67udu7A@mail.gmail.com> <CAMuHMdUc+RCK=t02QhtWRekoYCx2pHnMyaTYiC0=SxKQVrqDHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUc+RCK=t02QhtWRekoYCx2pHnMyaTYiC0=SxKQVrqDHQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 Jan 2021 10:18:38 -0800
Message-ID: <CAGETcx_Ud+UJcdWkCH-WzEGjH4voRBoO++np7ARSi5Gnh51jYg@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add fw_devlink support for "gpio" and
 "gpios" binding
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Jan 19, 2021 at 10:10 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Jan 19, 2021 at 6:54 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Jan 19, 2021 at 2:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Tue, Jan 19, 2021 at 9:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > Can we pull this into driver-core-next please? It fixes issues on some
> > > > > boards with fw_devlink=on.
> > > >
> > > > On r8a77951-salvator-xs.dts, it introduces one more failure:
> > > >
> > > >     OF: /soc/i2c@e66d8000/gpio@20/pcie-sata-switch-hog: could not get
> > > > #gpio-cells for /cpus/cpu@102
> >
> > Geert,
> >
> > One good thing is that it's noticing this being weird and ignoring it
> > in your particular board. I *think* it interprets the "7" as a phandle
> > and that's cpu@102 and realizes it's not a gpio-controller. For at
> > least in your case, it's a safe failure.
>
> While 7 is the GPIO index, relative to the current GPIO controller,
> represented by the parent device node.
>
> > > > Seems like it doesn't parse gpios properties in GPIO hogs correctly.
> > >
> > > Could it be that the code assumes no self-referencing phandles?
> > > (Just guessing...)
> >
> > Ok I tried to understand what gpio-hogs means. It's not fully clear to
> > me. But it looks like if a gpio-controller has a gpio-hog, then it
> > doesn't have/need gpio-cells? Is that right?
>
> A GPIO hog is a way to fix (strap) a GPIO line to a specific value.
> Usually this is done to enable a piece of hardware on a board, or
> control a mux.
>
> The controller still needs gpio-cells.
>
> > So if a gpio-controller has a gpio-hog, can it ever be referred to by
> > another consumer in DT using blah-gpios = ...? If so, I don't see any
> > obvious code that's handling the missing gpio-cells in this case.
>
> Yes it can.
>
> > Long story short, please help me understand gpio-hog in the context of
> > finding dependencies in DT.
>
> The hog references a GPIO on the current controller.  As this is always
> the parent device node, the hog's gpios properties lack the phandle.
>
> E.g. a normal reference to the first GPIO of gpio5 looks like:
>
>     gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>
> A hog on the first GPIO of gpio5 would be a subnode of gpio5,
> and would just use:
>
>     gpios = <0 GPIO_ACTIVE_LOW>;
>
> instead.
>
> Hope this helps.

I'm still not sure if I've understood this fully, but does this just
boil down to:
Don't parse [name-]gpio[s] to find dependencies if the node has
gpio-hog property?

-Saravana
