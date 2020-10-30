Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4912A0A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgJ3Psh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgJ3Psg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:48:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:48:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so5567807pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vQT2iQtNVbEevXMap0BKv0WHD5DBzsJ42aVxPlssZQ=;
        b=n8YbetdbXrwHaFu5Z+ES9pzJl1mjzn/6kfBcwgNdwidkZBJwlppvMVpGe9VtJvMk46
         1sOqVNyttpqEaAiXFolVaj5fEJ5p7um2oGsUYn51dvU/cyACDZ0mMi0l20Z+3H0sHBOH
         UNu8grmQW3F4oYhlTVkOWxxv39avcn3JklliTTHlpntMAQtB/o4WGRYW2UvUHrHVjRqD
         pdsYa7WBTe8yk5flxUPxRJi2Uf35lnMtJDdL0+dTAHrgp8l9v9kngGzEuU2QEYGd+2q8
         94q/DQn52sbC+LNJ4+vqb9myTThKNhYfjHkxbxgUokhw7kvDQTBr6Rm/6AYGfRQaU/M7
         eCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vQT2iQtNVbEevXMap0BKv0WHD5DBzsJ42aVxPlssZQ=;
        b=kkA5Qt9q7FA2QlFpRR/QQKeTDW3ysDDuqZh4mzuU7qPbqA5MtzvfyYXB4TZlGVlNzY
         K20GufVTb2axjpmXXRLC79WwCb22NI8LHrG4XL0z1D4vYfzbVkUuMS5NZmM1JBrmsI4f
         PDVJdaC+zS2J2oXHScArzLExhrTOR+m3QzBYV9/JYa9PjhbW1WHPlW9kUKv/Gs2FNmj+
         fbLlXsVPDTnbaelCBrRu7sQXC1td1LnSnO+G1SxZBtG1TSTRoVhfnnEgPuZPqGDD90xE
         B4kXtoXvXsIULlbdVtvu4llk5RlD5bE6Nv18I3dETplTyIvR05rF8LpDTFl7N+KlMtxF
         4lsg==
X-Gm-Message-State: AOAM5310jWfV/FhN6Fewy8URTnTGKyGUEI36aSb/VGjtPTISNYLgCngA
        kYc/WfpRnb+yy0MDPPVYyK8CGlOGE6xOO9G6DYH9xQ==
X-Google-Smtp-Source: ABdhPJyWs6P4V1KrvnpjlVCkOTtmQP4vylcUtLxXlvFLNPOslyhmAyxboGbGiIxOM/p6VQU24ObF7p093ISZQFWSMqU=
X-Received: by 2002:a63:1906:: with SMTP id z6mr2767197pgl.286.1604072915294;
 Fri, 30 Oct 2020 08:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <56b19be34ee958103481bdfc501978556a168b42.1603372719.git.andreyknvl@google.com>
 <CACT4Y+ZVjEQaQExenOPg-tXQKRE5wUEm_iDn5DUQH_4QC-DBzg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZVjEQaQExenOPg-tXQKRE5wUEm_iDn5DUQH_4QC-DBzg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 30 Oct 2020 16:48:23 +0100
Message-ID: <CAAeHK+x+5EcgiS8wZ9mbh-a32w4_CVOdrzw8yrtpPuquaJrPQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/21] kasan: inline random_tag for HW_TAGS
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

On Wed, Oct 28, 2020 at 12:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Using random_tag() currently results in a function call. Move its
> > definition to mm/kasan/kasan.h and turn it into a static inline function
> > for hardware tag-based mode to avoid uneeded function call.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> > ---
> >  mm/kasan/hw_tags.c |  5 -----
> >  mm/kasan/kasan.h   | 37 ++++++++++++++++++++-----------------
> >  2 files changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index c3a0e83b5e7a..4c24bfcfeff9 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -36,11 +36,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
> >                           round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> >  }
> >
> > -u8 random_tag(void)
> > -{
> > -       return get_random_tag();
> > -}
> > -
> >  bool check_invalid_free(void *addr)
> >  {
> >         u8 ptr_tag = get_tag(addr);
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 0ccbb3c4c519..94ba15c2f860 100644
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
> > -       return 0;
> > -}
> > -
> > -#endif
> > -
> >  #ifndef arch_kasan_set_tag
> >  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >  {
> > @@ -273,6 +262,20 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >  #define get_mem_tag(addr)                      arch_get_mem_tag(addr)
> >  #define set_mem_tag_range(addr, size, tag)     arch_set_mem_tag_range((addr), (size), (tag))
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +u8 random_tag(void);
> > +#elif defined(CONFIG_KASAN_HW_TAGS)
> > +static inline u8 random_tag(void)
> > +{
> > +       return get_random_tag();
>
> What's the difference between random_tag() and get_random_tag()? Do we
> need both?

Not really. Will simplify this in the next version and give cleaner names.
