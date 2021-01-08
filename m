Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC092EF93D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbhAHUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbhAHUbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:31:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7117023AC2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610137870;
        bh=dN/vCuTfi01My7gqxrmbsoNneHB7mr8tZmJby3DM2Ts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CK8hMSmJlda2+nQd/elAbLb6PsPulkmBsfLI7uMcP/u5n2IrnaEt6BIOaRTYJxiwY
         LBj5ATT03OE7SXXkvjFHc+eADEWghwWQKrpuKdFN3I/CzOpVcQan+Atg0NaHa47OtK
         LmzxK/798PUNYHO/fGwACW0KH8Hi+652iL6SuDv9yndLXV2iiLwzJVi2Oz69n1Y4Sj
         N4pQqvohaveCDIzjwey5Z4V1PB75s0hXmo0GQO22OxC/+55xIxTHx9KeACIS2j/3r9
         ye3R2dyzshr3vWK4ht96ESK7jnEbEUFyFgrCrJjEFGnE/hffyiVcsF/VVMJslTZ68Y
         379cIu9sAq4Gw==
Received: by mail-oi1-f182.google.com with SMTP id x13so12768468oic.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:31:10 -0800 (PST)
X-Gm-Message-State: AOAM5300g+PV0JmCDniIDvJgVaZOWUeFGJTXVahHEbiqL60fk8GQskVM
        XkJoLDbBmlncBC44zJ08jvRUxF795rt/8iX7GPk=
X-Google-Smtp-Source: ABdhPJwYZTJvr7kFzDF/qWiLnN5DYHOF+FSG0HkLBoXAW+tr4GMnTQfrliSZqYEPhR50hYyWxogqt+5hi3LKcOotPiU=
X-Received: by 2002:aca:44d:: with SMTP id 74mr3515461oie.4.1610137869802;
 Fri, 08 Jan 2021 12:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20210108040940.1138-1-walter-zh.wu@mediatek.com> <CAAeHK+wW3bTCvk=6v_vDQFYLC6=3kunmprXA-P=tWyXCTMZjhQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wW3bTCvk=6v_vDQFYLC6=3kunmprXA-P=tWyXCTMZjhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Jan 2021 21:30:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3FakV-Y9xkoy_fpYKBNkMvcO7DPOQC8R7ku7yPcgDw3g@mail.gmail.com>
Message-ID: <CAK8P3a3FakV-Y9xkoy_fpYKBNkMvcO7DPOQC8R7ku7yPcgDw3g@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: remove redundant config option
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 7:56 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> On Fri, Jan 8, 2021 at 5:09 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:

> > @@ -2,6 +2,12 @@
> >  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> >  KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
> >
> > +ifdef CONFIG_KASAN_STACK
> > +       stack_enable := 1
> > +else
> > +       stack_enable := 0
> > +endif
> > +
>
> AFAIR, Arnd wanted to avoid having KASAN_STACK to be enabled by
> default when compiling with Clang, since Clang instrumentation leads
> to very large kernel stacks, which, in turn, lead to compile-time
> warnings. What I don't remember is why there are two configs.
>
> Arnd, is that correct? What was the reason behind having two configs?

I think I just considered it cleaner than defining the extra variable in the
Makefile at the time, as this was the only place that referenced
CONFIG_KASAN_STACK.

The '#if CONFIG_KASAN_STACK' (rather than #ifdef) that got added
later do make my version more confusing though, so I agree that
Walter's second patch improves it.

Acked-by: Arnd Bergmann <arnd@arndb.de>

On a related note: do you have any hope that clang will ever fix
https://bugs.llvm.org/show_bug.cgi?id=38809 and KASAN_STACK
can be enabled by default on clang without risking stack
overflows?

       Arnd
