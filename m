Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5B2AF88C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgKKSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:50:20 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:50:20 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id ei22so1227325pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJh1hc9aoLNnAEUPgEfQmYydHZQ7GWODzgkyZKHT9uI=;
        b=Kp0u3B28Re8rUmbgk6Wbi+mcHr4eQNPYwd4jZAOskQYR4o5MaGeDoWqvdO4BVYbcFn
         Hw2Q6K8HVjJlGdDYkeRAutbNUMlg6rv+2l97ht2b62K6cCQ6AVumEqxy+mzLAaNjSAoG
         absNio8m32HzZApXXtAcXDLkXbhcZlenRLtcF9iFlh5gcmcYU1DVXZQqZ+6qsNRlR0OP
         /99JefrK7tG3NNeTd10NqBwV4CIZTUmrJYXsgpmdpn3n4C1Jpngfv0Y/mPX9oKuH5aSA
         RBuTgPHwKl6taj3zlgUL6Ujw1PHPTQ0YStD6g0ZI8zVElJAn5GmfzzsN9DGi6AlvSrJs
         aIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJh1hc9aoLNnAEUPgEfQmYydHZQ7GWODzgkyZKHT9uI=;
        b=T9DCxesoweM8VRL6avAYsR5ShcQEjSpIwNb9dNQHtsxcNfEzuW66xw6anJZaRsyU55
         wY5Tsh4Qsk/PPBSOHA/uODdOICpL+kvwsOpZWySL8JX35PpoiHETRasP/zasJpy9AkT9
         ZT3VTgYEp9HxUKu0ythNeCe7li8syIzb5PS5bM1ubBjFTGyoC00xwuf4WuNv9ICN4WyK
         bSz385wrDovl/8PaBVJfF6xV8Axn1Sid32n2pTEpFV/YsvxLM6BPY8roA6eIOivyaV4l
         3ODWlVwulIZNghP/9Av4A9+B/3s4PHQvnqJyAdunK0jDMkkUPB1ki5x7TweMtXfBZCyc
         v3bg==
X-Gm-Message-State: AOAM5335otV1YSqKLzlwQJ/Z3eNY/vrC3vrKRlU7H7OV50BtpP3N+uBW
        DknKo/KUs61znLeiQY9n7jClwrHzHtu9R1JHUxv7Hg==
X-Google-Smtp-Source: ABdhPJw6s07+zs7B+6RC0cvaGmwVCAUyrlExtzm9EAiQNBIKwlEQmALGDwxaVv43WCL3AuSGWQLFpPDv3U5Mfrn1Yjc=
X-Received: by 2002:a17:90a:4215:: with SMTP id o21mr5064897pjg.166.1605120620141;
 Wed, 11 Nov 2020 10:50:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <619cb0edad35d946c4796976c25bddb5b3eb0c56.1605046192.git.andreyknvl@google.com>
 <CAG_fn=UKSp8shtYujRbM=8ndhLg_Ccdpk9eSfOeb=KpwNi7HBg@mail.gmail.com>
In-Reply-To: <CAG_fn=UKSp8shtYujRbM=8ndhLg_Ccdpk9eSfOeb=KpwNi7HBg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 19:50:09 +0100
Message-ID: <CAAeHK+zh6tOh91Dg4n4NrJwdPWRaDEtz_Btitg8viQQk7Zm_JQ@mail.gmail.com>
Subject: Re: [PATCH v9 17/44] kasan, arm64: move initialization message
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Wed, Nov 11, 2020 at 4:04 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Software tag-based KASAN mode is fully initialized with kasan_init_tags(),
> > while the generic mode only requires kasan_init(). Move the
> > initialization message for tag-based mode into kasan_init_tags().
> >
> > Also fix pr_fmt() usage for KASAN code: generic.c doesn't need it as it
> > doesn't use any printing functions; tag-based mode should use "kasan:"
> > instead of KBUILD_MODNAME (which stands for file name).
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > Change-Id: Iddca9764b30ff0fab1922f26ca9d4f39b6f22673
> > ---
> >  arch/arm64/include/asm/kasan.h |  9 +++------
> >  arch/arm64/mm/kasan_init.c     | 13 +++++--------
> >  mm/kasan/generic.c             |  2 --
> >  mm/kasan/sw_tags.c             |  4 +++-
> >  4 files changed, 11 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> > index f7ea70d02cab..0aaf9044cd6a 100644
> > --- a/arch/arm64/include/asm/kasan.h
> > +++ b/arch/arm64/include/asm/kasan.h
> > @@ -12,14 +12,10 @@
> >  #define arch_kasan_reset_tag(addr)     __tag_reset(addr)
> >  #define arch_kasan_get_tag(addr)       __tag_get(addr)
> >
> > -#ifdef CONFIG_KASAN
> > -void kasan_init(void);
> > -#else
> > -static inline void kasan_init(void) { }
> > -#endif
> > -
> >  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >
> > +void kasan_init(void);
> > +
> >  /*
> >   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> >   * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
> > @@ -43,6 +39,7 @@ void kasan_copy_shadow(pgd_t *pgdir);
> >  asmlinkage void kasan_early_init(void);
> >
> >  #else
> > +static inline void kasan_init(void) { }
> >  static inline void kasan_copy_shadow(pgd_t *pgdir) { }
> >  #endif
> >
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index 5172799f831f..e35ce04beed1 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -278,17 +278,14 @@ static void __init kasan_init_depth(void)
> >         init_task.kasan_depth = 0;
> >  }
> >
> > -#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
> > -
> > -static inline void __init kasan_init_shadow(void) { }
> > -
> > -static inline void __init kasan_init_depth(void) { }
> > -
> > -#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > -
> >  void __init kasan_init(void)
> >  {
> >         kasan_init_shadow();
> >         kasan_init_depth();
> > +#if defined(CONFIG_KASAN_GENERIC)
> > +       /* CONFIG_KASAN_SW_TAGS also requires kasan_init_tags(). */
> >         pr_info("KernelAddressSanitizer initialized\n");
> > +#endif
> >  }
>
> Cannot we have a single kasan_init() function that will call
> tool-specific initialization functions and print the message at the
> end?

Unfortunately no. For different modes we need different functions that
are called in different places in the kernel. E.g. for generic KASAN
we only need kasan_init() to setup shadow pages; for SW tags we also
need kasan_init_sw_tags() which initializes per-cpu state and
finilizes initialization process.
