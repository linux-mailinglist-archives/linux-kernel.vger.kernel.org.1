Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384F2AFC76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgKLBhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgKLAYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:24:14 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C034C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:24:14 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so1866549pll.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/7uKp3kPU+6BPx3Z+SeH1/mQzwr6aT8nYVy2fS4R+I=;
        b=d5XFm+nAwxDiZJfOuHrbmay0x2G6YIjmHqsJkjPH4Sa9HYCRQv5IyztXPCSZqfh9Yw
         679KGx0hlsmP3y99PKrn+VEIjpbVo4rjueN6Evg7X8w0/kkh85OlXnO8u+g9HpTf8HVi
         ts4I0Z2GIjvy/8z55qexA10hhM9TE60a6Bsgomyh3ORtbZCjzyiKcKQDlZaSgeBFjEAP
         fghegnsaPftDVrAoOxFa6Dtvs7hTxvAVs2yWTy7BiGXbOpOAPs+iE4M8jZBijbSvkxbj
         aHFLazgMiK9w6A+NSS/DPscD6fLpdPUTMZ3mUUd2lpkyGwYtAsqDCBMG018l/uSJ+74y
         jgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/7uKp3kPU+6BPx3Z+SeH1/mQzwr6aT8nYVy2fS4R+I=;
        b=mX+086BSwWTdxEYtEVZD459gNsUX69Cc1/HWc584buIRf7oPxG61wrzYt41RdG/Xk0
         dnbZBUQlNhxdlG5I4Om130A+0r/S70M8f4ZYPdn7jtTDYyWM/g5HIHEl9ysHLUIzPCLk
         NUrcgbVAm6WLkrifPdNnd1PYQ/7/6THfv31/J3Wylmi945lFFRHfeOfkgjeicBFKja63
         y5D+4TWEICi6QgmMRm1iY6j9/AxMD7OYU8BDj3x/htXCqFFgYQTvewqgOsI/2hz+dyMo
         wMznHe3bwYS1HikKMWcvql9I0SvWH4G7T2QJT8YeIrimNF7fjb0R9O5FGogqAkup7ns/
         gyGA==
X-Gm-Message-State: AOAM531E1UxC7L3f3xyUFylgxI9OgSarUiQI0Z6VHLZnFux/IbR2lhtb
        Mq4L3NvECsJ3GHjTjmTN8v3Wj8+6IFoIEcAMiBtj9g==
X-Google-Smtp-Source: ABdhPJy+k0LGlBo1IZsQsrfPTKk9qsGvbmN8WMtLliu0P+kZNZHNe3D7VuRZiIk5rzJNbcPUoVAPBv8KQYaOTj3JCbs=
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id
 c13-20020a170902d90db02900d6ecf9c1ddmr23089538plz.13.1605140653446; Wed, 11
 Nov 2020 16:24:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
 <20201111162051.GG517454@elver.google.com>
In-Reply-To: <20201111162051.GG517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 01:24:02 +0100
Message-ID: <CAAeHK+x=8TF1Rda9mVCRe+-_A72BDSFg-e8w9mG-JKgCkfb8=g@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] kasan: allow VMAP_STACK for HW_TAGS mode
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:20 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > Even though hardware tag-based mode currently doesn't support checking
> > vmalloc allocations, it doesn't use shadow memory and works with
> > VMAP_STACK as is. Change VMAP_STACK definition accordingly.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> > ---
>
> Shouldn't this be in the other series?

I don't think it makes much difference considering the series will go
in together.

>
> FWIW,
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks!

>
> >  arch/Kconfig | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 56b6ccc0e32d..7e7d14fae568 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -914,16 +914,16 @@ config VMAP_STACK
> >       default y
> >       bool "Use a virtually-mapped stack"
> >       depends on HAVE_ARCH_VMAP_STACK
> > -     depends on !KASAN || KASAN_VMALLOC
> > +     depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
> >       help
> >         Enable this if you want the use virtually-mapped kernel stacks
> >         with guard pages.  This causes kernel stack overflows to be
> >         caught immediately rather than causing difficult-to-diagnose
> >         corruption.
> >
> > -       To use this with KASAN, the architecture must support backing
> > -       virtual mappings with real shadow memory, and KASAN_VMALLOC must
> > -       be enabled.
> > +       To use this with software KASAN modes, the architecture must support
> > +       backing virtual mappings with real shadow memory, and KASAN_VMALLOC
> > +       must be enabled.
> >
> >  config ARCH_OPTIONAL_KERNEL_RWX
> >       def_bool n
> > --
> > 2.29.2.222.g5d2a92d10f8-goog
> >
