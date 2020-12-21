Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBA2DFA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgLUIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgLUIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:52:48 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:52:07 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p12so4088206qvj.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qKCILQuPxtNGC0KokeuabRQiz8j0EzP8ss9vMtRJ/s=;
        b=ljMnF4kXTh+rlfgGGfOtBXETNoDO/OUEZZmp5uyi8291WY0rW5X2Oen/kUUr4FonP7
         ntvV2pPq1HzUSUbnefJsOk2xnzK+yBNgXyau02As3Tk+bBbhxgXHgL9L13ZMSJxQe26+
         u4fVxXjCyfDTO9isZhlZf9xDNsR4afKI+LqoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qKCILQuPxtNGC0KokeuabRQiz8j0EzP8ss9vMtRJ/s=;
        b=f4BRl/7yUIsHmbeJe/9g+WEabE53Pg5zLfrYWSiks7Gbs5GLm670E+Po3qHLE3VbJR
         uLLfl0824atnjOC6cRwDkYxIplN73fXgLuJbSftdue7wBYTKr/PIe39tIT9oVztMfsU7
         b0iTZjuWnefnnFsFrwXHuo3cQlsXufUcWVYACEKYFUFhzOsrtTnNII7SXdR2q0klOpur
         mvpe6yv5VV144qUo97KTYRQRnIuz+kcwOKUXi8fpxI3XO2KnYYtcqdas+Lg/WJChNxFs
         KBIpY6s0xNNTvsBxOtViCVvQIvwvpWrLJ2hHpAOuygE2ZvWajsCMRigMfrU4rkv4e48v
         11nQ==
X-Gm-Message-State: AOAM5336ZHy4zmvgm9a5JUFTqcXpom1ElgrhxFv54soQ4iveCiUD/Tec
        3B05PiAvT/IgZTqUSW1CSWA+OVPZYvrIhqM1K+o+JA==
X-Google-Smtp-Source: ABdhPJwFYHrXu3pafECFOZGz6Ntg1TFkEIWytSpgCb6xGX2GhMePLZ019Ky+9cAPobzPPe22v51njYl9woYl9NI97KU=
X-Received: by 2002:a05:6214:140d:: with SMTP id n13mr16093482qvx.45.1608540727170;
 Mon, 21 Dec 2020 00:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com>
 <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com>
 <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com> <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com>
In-Reply-To: <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 21 Dec 2020 17:51:56 +0900
Message-ID: <CAFr9PX=oLqQqvykiwOGAGg1H2CG0BTEqn0TuSrijodjxY52LxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, 21 Dec 2020 at 03:44, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Daniel Palmer (2020-12-19 22:35:41)
> > Hi Stephen,
> >
> > On Sun, 20 Dec 2020 at 12:39, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > +  clock-output-names:
> > > > +    minItems: 8
> > > > +    maxItems: 8
> > > > +    description: |
> > > > +      This should provide a name for the internal PLL clock and then
> > > > +      a name for each of the divided outputs.
> > >
> > > Is this necessary?
> >
> > I found without the names specified in the dt probing of muxes that
> > depend on the outputs but appear earlier didn't work.
> > Also this same PLL layout seems to be used in some other places so
> > eventually I was thinking this driver would get used for those PLLs
> > with different output names.
>
> Still seems like it could be auto-generated based on dev_name() +
> number.

At one point I had something similar to that where the output names
were generated at probe.
Without the clock outputs listed in the device tree clock muxes that
source clocks from the mpll couldn't probe properly as they couldn't
look up all of their parents if they probed before the mpll.
Maybe I'm doing something wrong there? I couldn't find a way to always
resolve all of the parents or defer the probe of the muxes until the
mpll clocks are registered.

Cheers,

Daniel
