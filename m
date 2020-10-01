Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AF2809BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbgJAVyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgJAVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:54:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:54:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so74327pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3q47gBSVfL/j+OZHN/FfdXXTWivJeUwTp3edwFJcf2k=;
        b=nqXbUTBcQYRd6tU6SJChhpBw778f3yoV9bUIL7dzDLgBraFkF23uG1KqdFIcnXi1hs
         biLuo+UmwVDWhGZv+jXnbqiJjK4oQvgqcGrFQ3nsmvBlG2I6s3O7dlTCP1RLYV9wtZfi
         OJMAjm1b9sHmdlDEMySw+Nl2+rdgbpXcTD2Xen3sSPZnJEbmOWjXkW0iEw1VK9gGqwKu
         bqkykOKziJLGGlx/EAxJtuog4URgaM5/vkqAZhtWO85y7Y8MTBxoe8SDHv2al9GZgatF
         Jw7j4YWqGW+ZhFQXN2r3sL6dxX6Mny8rLvwj86yshvaSvMYL6OpHH3XMBA0sWk2wqPk4
         kkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3q47gBSVfL/j+OZHN/FfdXXTWivJeUwTp3edwFJcf2k=;
        b=h+n0QZLHPO7BXVsmkZGwf6YPGB23DPLuhcAWoRi8LAIZv8nWogybokTmG+Q/FUskuK
         yXulV6PcbbY8b65RkMqpNFzpR6JjYgz5t+zrrOjyIyojnAUldFSNBgjfOGpA5W8vIzJP
         8MBzTTZR/RHVAXq57GILaicbGnnbDvE0YIdsEoYb4LIG/B2IaE85O93cnxdV0KthoXm6
         BmuIi0/yFFxPWHfEuWaBgYi9YGMPGJoVh4QTQ+pM1ESVz6o/hXiTmkkoIeyY70o/78DO
         3oKbqfIzq5GRYFY9S5ZAxOmltR+P1Nx8CX32t/pWCHRJeTaLKMabzzkjCHmDuC/Jrlb0
         4mug==
X-Gm-Message-State: AOAM531oif88FHsSsF2y2CjrI04Rvg+FPzwhwudzj2hJ6qU/oicRs6k+
        vPfHIBIvsQ2y8PkLNaNHW6eY8JSfJzfYsL8HnDZ+dA==
X-Google-Smtp-Source: ABdhPJwe0nnV0aaMaZSbzhcZHDNLv6ns+vWOJVoH00VYC+JUxWYvdwwgqCoZz9JRt5kZ+WOO8cRFkCCmHD3tnOlCeAg=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr4653258pfi.55.1601589278265; Thu, 01
 Oct 2020 14:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <728981bdedbca9dc1e4cca853699b6a6e8f244e0.1600987622.git.andreyknvl@google.com>
 <20201001173945.GI4162920@elver.google.com>
In-Reply-To: <20201001173945.GI4162920@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Oct 2020 23:54:27 +0200
Message-ID: <CAAeHK+zYRYd=67fqrKn7hyAjMj++Z70pjyxS4gQ2KChZa1A5ag@mail.gmail.com>
Subject: Re: [PATCH v3 11/39] kasan: don't duplicate config dependencies
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:39 PM <elver@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> > Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
> > those to KASAN.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> But see comment below:
>
> > ---
> > Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
> > ---
> >  lib/Kconfig.kasan | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index e1d55331b618..b4cf6c519d71 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -24,6 +24,9 @@ menuconfig KASAN
> >                  (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> >       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> >       depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> > +     select SLUB_DEBUG if SLUB
> > +     select CONSTRUCTORS
> > +     select STACKDEPOT
>
> In the later patch your move 'select SLUB_DEBUG' back to where they were
> here it seems. The end result is the same, so I leave it to you if you
> want to change it.

Will fix in v4, thank you!

>
> >       help
> >         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> >         designed to find out-of-bounds accesses and use-after-free bugs.
> > @@ -46,10 +49,6 @@ choice
> >  config KASAN_GENERIC
> >       bool "Generic mode"
> >       depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
> > -     depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> > -     select SLUB_DEBUG if SLUB
> > -     select CONSTRUCTORS
> > -     select STACKDEPOT
> >       help
> >         Enables generic KASAN mode.
> >
> > @@ -70,10 +69,6 @@ config KASAN_GENERIC
> >  config KASAN_SW_TAGS
> >       bool "Software tag-based mode"
> >       depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> > -     depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> > -     select SLUB_DEBUG if SLUB
> > -     select CONSTRUCTORS
> > -     select STACKDEPOT
> >       help
> >         Enables software tag-based KASAN mode.
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
