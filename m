Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F62A84F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgKERdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKERdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:33:42 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C85C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:33:41 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m17so425867pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQWq0sb98R2Ibe1tm3jlGBdH5UxkZHIm/WcOlmsUUNY=;
        b=QdBdy/rUUec72wypmwGh2fVnMePLjyBEUxXZQRLf5lKwpGJ3Q4QjIjAqS97YRHOSGk
         kC1icVoR5aILRx6O4gB1f6QjFm9swPJJY4venZ6JBUIsAY51MPCg4EZU42DQC7hAl3qB
         qkgPx90rEXnslxN3X9kAmBVz0TEyiiiru6lffaNACv/XpVjGBgK9H8KwWl4l8+wlx8qY
         3Uiw2RWRalBRpAt7DUdvSx1fhNIqzoyZJ2vITaFnsJw59zcTgkFSePIyW23WXzA7Khej
         puQakcDx5vFlCFlmyFZnMK/WXRA7zIxjPm+81l9yuIJpuqgk+yI/QlvaJbsFBHQZddWk
         XHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQWq0sb98R2Ibe1tm3jlGBdH5UxkZHIm/WcOlmsUUNY=;
        b=EYs1RPh29Y350FrgCQNKH/nSGWv/g+wzkp3RxGPUv9SB3B+OqQeAHetNwXdsAX3UFw
         Yk5qStqoVeYCwfb7Fueasi6mod8ZbFmVCDTdCpV4x0bQmKshauu78saH6MYuiBY9ZS/0
         pGCaMsSVFyTSEMne/MFToZeAUSJmllCPfRiNarrD2xLIy4VU6+rP2czlgHiBkNvwPoTi
         1BFsgdFEhr04FBkuH9qMrWviMwuiA9P00XEUp7hwYFOkaHYclDp4kc2GI6f7HkZWK2/N
         xWKJR3Tw9TvDhmQxMOdRxlWAadMh3o9fxKUUtN7YJ2uOejlahCS4DNFys8oHrSf33Bga
         dpyw==
X-Gm-Message-State: AOAM5335/inufo1ZslX5HyE2Aq3No9mEmQ+QduUSYfdOVmqFM8Yu2wZJ
        bX7IM9/EZI5Su19XBWk7NLfRGVvRTnsEAHkeT6wEnw==
X-Google-Smtp-Source: ABdhPJzUp9GNh9HLS9q1zaYsjjcAfxiPBpu3+B7m+rY5zkpHOwR836b65yiPgM+K3phLKH9O03x9bCKt7zvh54NXzkY=
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr3446803pja.41.1604597620750;
 Thu, 05 Nov 2020 09:33:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5d9ece04df8e9d60e347a2f6f96b8c52316bfe66.1604531793.git.andreyknvl@google.com>
 <20201105173033.GF30030@gaia>
In-Reply-To: <20201105173033.GF30030@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 18:33:28 +0100
Message-ID: <CAAeHK+ywMBwWQmNbcJFhQDggHdi1fzOsoUGrM=6_-7m6n47oTg@mail.gmail.com>
Subject: Re: [PATCH v8 32/43] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Thu, Nov 5, 2020 at 6:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 05, 2020 at 12:18:47AM +0100, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 14b0c19a33e3..cc7e0f8707f7 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -23,6 +23,8 @@
> >  #include <asm/ptrace.h>
> >  #include <asm/sysreg.h>
> >
> > +u64 gcr_kernel_excl __ro_after_init;
> > +
> >  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
> >  {
> >       pte_t old_pte = READ_ONCE(*ptep);
> > @@ -123,6 +125,23 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >
> >  void __init mte_init_tags(u64 max_tag)
> >  {
> > +     static bool gcr_kernel_excl_initialized = false;
> > +
> > +     if (!gcr_kernel_excl_initialized) {
> > +             /*
> > +              * The format of the tags in KASAN is 0xFF and in MTE is 0xF.
> > +              * This conversion extracts an MTE tag from a KASAN tag.
> > +              */
> > +             u64 incl = GENMASK(FIELD_GET(MTE_TAG_MASK >> MTE_TAG_SHIFT,
> > +                                          max_tag), 0);
> > +
> > +             gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> > +             gcr_kernel_excl_initialized = true;
> > +     }
> > +
> > +     /* Enable the kernel exclude mask for random tags generation. */
> > +     write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>
> Same question as on a previous patch. Is SYS_GCR_EL1 written on the
> other registers via cpu_enable_mte()?

You mean for other CPUs? mte_init_tags() is called for each CPU if
that's what you mean. Otherwise, please clarify the question.
