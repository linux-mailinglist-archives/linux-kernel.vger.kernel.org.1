Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBB2AFC75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKLBhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgKLAVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:21:34 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:21:32 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so2615006pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MZFMCDMJdh8yBoOAogISYylpvG5r3umSSn0ihSNDmU=;
        b=rPQm3cbRkOkVqr4CsvzcXfuE3WxGu8YXwcmoJUX+iiTibOnMx7k8gICJ7o/D9ehxAj
         gwEMHbU+MLUdW+oXFtv4aaHIlBw5qom9YKVHMPRFPLYassKcEQqJtF6yZv7/uBs1sGTl
         Z/RwvtC5uAODROFcARAZW5HLkshPe0mpc7kGuBGHUxV+Mw9iJUIXmEhD2NTPehGOhr7X
         ZpWsvvOcc88JMWF+taOAkIbDEUMa7NgG0DC7j7qNUf4fQKKnsluilbeAL8unalVPtF7G
         SuWl7RQpy91qh6+iXoledaTEyp9FNZXn82Sb6NvkelNqGwXE1+GLwNCTAu+Qc4k1cKOD
         5rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MZFMCDMJdh8yBoOAogISYylpvG5r3umSSn0ihSNDmU=;
        b=oGoLkW7hmO3A09yx7lBYnjo4+1J9FnSfSJtXruBpLik2KaQ2mbrdOs8CO6YXpgBlvb
         74lm727kDHYLY7+KodluRMl9ev4NBeSEuuJuZRI8OsylCAh6Qkcc+DqXHTPdO5wYFSHy
         /GZRXW6dEz1zZJrHAtJg58FroMpz/zAJW51UCxp15V+Y7zD658lMscX6tFqdJaKLbeao
         ztDV7DRTTL/5+Pls6n9zTi5+zko15jknfJt5uJsQjzs4VW8j+zuaSnAGiw3if/JPvQOk
         yV+WxxoKcZCpoyA7io6yPpDtewVN6wD8rq3DTPiZ6p4SYv/v6DFf4Owf0TeeWfckhvNw
         t7Ww==
X-Gm-Message-State: AOAM532Gvnz4cWbcCDuUGLtML9+8WPQ2a3ScFgbQRUwlOb5PvJqTZZnS
        tIyBgu4m1+luP8vffI9qsxXZXiWN8FRUzDbNY0yxuQ==
X-Google-Smtp-Source: ABdhPJwbHHV44p630ib4iQLxnv+aiWIvzAFB8wIk0g6M+xyqLZRKhxKaaM2yKdMCXymGu/1h8y9ILzuHX8p+apLNAeo=
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id
 y189-20020a62cec60000b029018ad6206b86mr24239448pfg.2.1605140492153; Wed, 11
 Nov 2020 16:21:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <73399d4c0644266d61ad81eb391f5ee10c09e098.1605046662.git.andreyknvl@google.com>
 <20201111170213.GJ517454@elver.google.com>
In-Reply-To: <20201111170213.GJ517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 01:21:21 +0100
Message-ID: <CAAeHK+w4mXJxrerZc0YLXPV0sx6-uadocRHhkrq-4UYRkuXs8g@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] kasan: inline random_tag for HW_TAGS
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

On Wed, Nov 11, 2020 at 6:02 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > Using random_tag() currently results in a function call. Move its
> > definition to mm/kasan/kasan.h and turn it into a static inline function
> > for hardware tag-based mode to avoid uneeded function calls.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> > ---
> >  mm/kasan/hw_tags.c |  5 -----
> >  mm/kasan/kasan.h   | 34 +++++++++++++++++-----------------
> >  2 files changed, 17 insertions(+), 22 deletions(-)
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> But see style comments below.
>
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 49ea5f5c5643..1476ac07666e 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -42,11 +42,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
> >                       round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> >  }
> >
> > -u8 random_tag(void)
> > -{
> > -     return hw_get_random_tag();
> > -}
> > -
> >  bool check_invalid_free(void *addr)
> >  {
> >       u8 ptr_tag = get_tag(addr);
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 8a5501ef2339..7498839a15d3 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -188,6 +188,12 @@ static inline bool addr_has_metadata(const void *addr)
> >
> >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> >
> > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > +void print_tags(u8 addr_tag, const void *addr);
> > +#else
> > +static inline void print_tags(u8 addr_tag, const void *addr) { }
> > +#endif
> > +
> >  bool check_invalid_free(void *addr);
> >
> >  void *find_first_bad_addr(void *addr, size_t size);
> > @@ -223,23 +229,6 @@ static inline void quarantine_reduce(void) { }
> >  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
> >  #endif
> >
> > -#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > -
> > -void print_tags(u8 addr_tag, const void *addr);
> > -
> > -u8 random_tag(void);
> > -
> > -#else
> > -
> > -static inline void print_tags(u8 addr_tag, const void *addr) { }
> > -
> > -static inline u8 random_tag(void)
> > -{
> > -     return 0;
> > -}
> > -
> > -#endif
> > -
> >  #ifndef arch_kasan_set_tag
> >  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >  {
> > @@ -279,6 +268,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >
> >  #endif /* CONFIG_KASAN_HW_TAGS */
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +u8 random_tag(void);
> > +#elif defined(CONFIG_KASAN_HW_TAGS)
> > +#define random_tag() hw_get_random_tag()
>
> Shouldn't this also be a function?
>
> +static inline u8 random_tag(void) { return hw_get_random_tag(); }
>
> Or is there a reason why this was made a macro?

No reason, will turn into a function in v10.

>
> > +#else
> > +static inline u8 random_tag(void)
> > +{
> > +     return 0;
> > +}
>
> Could just be on 1 line:
>
> +static inline u8 random_tag(void) { return 0; }

Will do in v10.

Thanks!

>
> > +#endif
> > +
> >  /*
> >   * Exported functions for interfaces called from assembly or from generated
> >   * code. Declarations here to avoid warning about missing declarations.
> > --
> > 2.29.2.222.g5d2a92d10f8-goog
> >
