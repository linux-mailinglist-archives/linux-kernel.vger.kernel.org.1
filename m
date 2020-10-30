Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F832A0AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJ3QUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJ3QUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:20:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78295C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:19:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so5602436pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpV5+JCLvAj2Fu+RD4QwotunWLsVQxGyCVUUhxPbUwA=;
        b=FSWYLdrsonhTJtcOLvC+jZU5Gj1TiA4iVM4P+e7yP8fAWGTh8vu2UxOIjyuwkiIOPt
         a1hTR+idNBMdtcwt9Oj+iztkSkcLlLF8E8p/8YDZpHg7lUTYpb00t4iX9e/noadWmM85
         mwRpvEQM6ry77L8lRbp36lbmguKJZoWwPPAzpC2R1QOXjJ1NHx4tcTvC/KAZZUjjYSGc
         3dxlAbMdhxw9eFPv/nRYT4EarwQdQXcuTifYWjaeYtMck8M2FlMfI1sIehL+oLRWOqGA
         4dteKZ6l+l+OtrqdHCLmSkbSO6HudQ0urxyg3yEScFf4qZdq0tIgnAb4Wwjo1Hng8+Fr
         rwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpV5+JCLvAj2Fu+RD4QwotunWLsVQxGyCVUUhxPbUwA=;
        b=fbjZCFfp7PdGzaKfSxsbSMhR3ZYE17G/IseInOW22xk4aTxB4L0Fx7pmSCwOU2Lx/Z
         2vekdnpb+8ogp05A6KwGOYVw9LYp4dbl4xQUVGq8VCIhJ4Qrnaif04xLGRkCiWO3PLFj
         jvm0w1CQhX7e1kHSMRt2CJLaCnqUxI4AqnTs3du6OnzZjR/zYQXcYS/Djklzv7+fFeB0
         DdLxcb8Qj2dJVxG+UN+/kBkkgn2AC31tEISkTnS7iuUfoLK320UUr9b0eXXONefQQGwI
         /AeEftA1oQAFIBdLR0HZdw70+/w5RGVEgUdXu9+NG8c74FdMRe/FeNSdAuq9Uv7eT+wX
         yAEQ==
X-Gm-Message-State: AOAM531UutYFgOQdgxZNVj928aPqAzOCs/T2buDDPbjsz4GEvSIGD0/I
        5CWT2qDzDGzl/Qoxr4MH+hwYxUnM0GygNKUg0MmBUw==
X-Google-Smtp-Source: ABdhPJz/tsifaJhuXgriAGLYjzjyVMccUTostGEnlnHrU3UURZ5aFDAMgOdFOEkCTdURXzV9DDUOO3ioWvzoL92ld40=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr3737334pjb.166.1604074771799;
 Fri, 30 Oct 2020 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <b75b7fe2842e916f5e39ac5355c29ae38a2c5e0a.1603372719.git.andreyknvl@google.com>
 <CACT4Y+YcQH2mKv3y15XkWa-tKvyhRQHAw5dLVoAkFRWgFMLq1w@mail.gmail.com>
In-Reply-To: <CACT4Y+YcQH2mKv3y15XkWa-tKvyhRQHAw5dLVoAkFRWgFMLq1w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 30 Oct 2020 17:19:20 +0100
Message-ID: <CAAeHK+xN4x4ggcBxTZj53OWCzKMe5LVLK1JMhKd3u87=E_Aw1A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 09/21] kasan: inline kasan_reset_tag for tag-based modes
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:05 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Using kasan_reset_tag() currently results in a function call. As it's
> > called quite often from the allocator code this leads to a noticeable
> > slowdown. Move it to include/linux/kasan.h and turn it into a static
> > inline function.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
> > ---
> >  include/linux/kasan.h | 5 ++++-
> >  mm/kasan/hw_tags.c    | 5 -----
> >  mm/kasan/kasan.h      | 6 ++----
> >  mm/kasan/sw_tags.c    | 5 -----
> >  4 files changed, 6 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 93d9834b7122..6377d7d3a951 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -187,7 +187,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
> >
> >  void __init kasan_init_tags(void);
> >
> > -void *kasan_reset_tag(const void *addr);
> > +static inline void *kasan_reset_tag(const void *addr)
> > +{
> > +       return (void *)arch_kasan_reset_tag(addr);
>
> It seems that all implementations already return (void *), so the cast
> is not needed.

arch_kasan_reset_tag() (->__tag_reset() -> __untagged_addr())
preserves the type of the argument, so the cast is needed.

>
> > +}
> >
> >  bool kasan_report(unsigned long addr, size_t size,
> >                 bool is_write, unsigned long ip);
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index b372421258c8..c3a0e83b5e7a 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -24,11 +24,6 @@ void __init kasan_init_tags(void)
> >         pr_info("KernelAddressSanitizer initialized\n");
> >  }
> >
> > -void *kasan_reset_tag(const void *addr)
> > -{
> > -       return reset_tag(addr);
> > -}
> > -
> >  void kasan_poison_memory(const void *address, size_t size, u8 value)
> >  {
> >         set_mem_tag_range(reset_tag(address),
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 456b264e5124..0ccbb3c4c519 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -246,15 +246,13 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >         return addr;
> >  }
> >  #endif
> > -#ifndef arch_kasan_reset_tag
> > -#define arch_kasan_reset_tag(addr)     ((void *)(addr))
> > -#endif
> >  #ifndef arch_kasan_get_tag
> >  #define arch_kasan_get_tag(addr)       0
> >  #endif
> >
> > +/* kasan_reset_tag() defined in include/linux/kasan.h. */
> > +#define reset_tag(addr)                ((void *)kasan_reset_tag(addr))
>
> The cast is not needed.
>
> I would also now remove reset_tag entirely by replacing it with
> kasan_reset_tag. Having 2 names for the same thing does not add
> clarity.

Will remove it.
