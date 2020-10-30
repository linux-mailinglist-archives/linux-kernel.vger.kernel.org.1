Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8302A0AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ3QH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJ3QH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:07:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:07:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so3167691pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65NdEmArmPn2nuNEZO88L62AlLpra/5W/MBvA6ISo6c=;
        b=GrPpfjH1Ts0r2xcMdjmbjed7OUayfMuc4WOdlv0ZhFob64TnL4hD5hOk7Now2nQ8yu
         fOXSQ648lTFpOXPIhsi1WZHKxnFPnXinXXCZXTH9mlJFC/e3MWaWyDWTLMXWaLIPRfCM
         8dZ8KLfY/EtY0e0A/QpFpHNMkm3Z/+tbzTpyR+fz5y9RXVAxlbHux2PVwMeEkvlPFVgf
         DPlIpeWxYE1F6Pna/9vDxLRMxT51ye0bSNL2+L5DVGolhL7HMNqKn8Qxn+HUgo4+b+pa
         D6Oc5V8RLnBBL3KPx8XbpMS89rdSwKVDtSU7eCr3enXvqiq5Ljtc2TQd6xSvSRbiJDch
         4TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65NdEmArmPn2nuNEZO88L62AlLpra/5W/MBvA6ISo6c=;
        b=sX57swH2j0QZGdMVc7K8We9Z0qnCIVIVzKY4dBAC3PnjyGN9P/G97G6iNXFF4E2MY+
         96CjwVLYq5Cj5Y25xSzaf+1wV6yWtkppbwj3DbIdkj7urckJgbKG+vyU84lmqnH+uQCq
         uZh2qDOISE3g6U4qQZy6Yhvgla+1ulczWPNvHtEFSLH5H6OQP2mgOu76tJeTXoDrRL1t
         2OSpBH21thk9lW2GSlCSE/BSmSPMk9SeOfTlQnOHW94xh4CleX36FpLsoQFSjxDklXMy
         8vZTROCtLibWkW38bo3V2miw23Wh5pNRwkBGs1Z0riIpMb5ncxyUA6cyl9n1fUACp9yH
         6m7Q==
X-Gm-Message-State: AOAM533Hnf/iZmCXhAc2OymeTvfFOOZQXt/rLHcMBF115cA/FQkCkpC+
        oUOOn3BAfxfjuWc+YypwLrPaaZNzOgiT29Bt736ukg==
X-Google-Smtp-Source: ABdhPJwlIp8b6tHuhS2gJe93mWv2avcRLDWoNoXAS1I+eryy8zoqP3XyCYL4BSaptouForfDCOtkN5t50ZACn32fcPo=
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id
 b8-20020a170902d888b02900d0cb2df274mr9313310plz.13.1604074045822; Fri, 30 Oct
 2020 09:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <56b19be34ee958103481bdfc501978556a168b42.1603372719.git.andreyknvl@google.com>
 <CACT4Y+ZVjEQaQExenOPg-tXQKRE5wUEm_iDn5DUQH_4QC-DBzg@mail.gmail.com> <CAAeHK+x+5EcgiS8wZ9mbh-a32w4_CVOdrzw8yrtpPuquaJrPQA@mail.gmail.com>
In-Reply-To: <CAAeHK+x+5EcgiS8wZ9mbh-a32w4_CVOdrzw8yrtpPuquaJrPQA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 30 Oct 2020 17:07:14 +0100
Message-ID: <CAAeHK+wKp_foQz9vnMbKA5hMqTgMK4Uczy8ZEb33S3j1rHX=Sw@mail.gmail.com>
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

On Fri, Oct 30, 2020 at 4:48 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Oct 28, 2020 at 12:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > Using random_tag() currently results in a function call. Move its
> > > definition to mm/kasan/kasan.h and turn it into a static inline function
> > > for hardware tag-based mode to avoid uneeded function call.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> > > ---
> > >  mm/kasan/hw_tags.c |  5 -----
> > >  mm/kasan/kasan.h   | 37 ++++++++++++++++++++-----------------
> > >  2 files changed, 20 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > > index c3a0e83b5e7a..4c24bfcfeff9 100644
> > > --- a/mm/kasan/hw_tags.c
> > > +++ b/mm/kasan/hw_tags.c
> > > @@ -36,11 +36,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
> > >                           round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> > >  }
> > >
> > > -u8 random_tag(void)
> > > -{
> > > -       return get_random_tag();
> > > -}
> > > -
> > >  bool check_invalid_free(void *addr)
> > >  {
> > >         u8 ptr_tag = get_tag(addr);
> > > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > > index 0ccbb3c4c519..94ba15c2f860 100644
> > > --- a/mm/kasan/kasan.h
> > > +++ b/mm/kasan/kasan.h
> > > @@ -188,6 +188,12 @@ static inline bool addr_has_metadata(const void *addr)
> > >
> > >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > >
> > > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > > +void print_tags(u8 addr_tag, const void *addr);
> > > +#else
> > > +static inline void print_tags(u8 addr_tag, const void *addr) { }
> > > +#endif
> > > +
> > >  bool check_invalid_free(void *addr);
> > >
> > >  void *find_first_bad_addr(void *addr, size_t size);
> > > @@ -223,23 +229,6 @@ static inline void quarantine_reduce(void) { }
> > >  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
> > >  #endif
> > >
> > > -#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > > -
> > > -void print_tags(u8 addr_tag, const void *addr);
> > > -
> > > -u8 random_tag(void);
> > > -
> > > -#else
> > > -
> > > -static inline void print_tags(u8 addr_tag, const void *addr) { }
> > > -
> > > -static inline u8 random_tag(void)
> > > -{
> > > -       return 0;
> > > -}
> > > -
> > > -#endif
> > > -
> > >  #ifndef arch_kasan_set_tag
> > >  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> > >  {
> > > @@ -273,6 +262,20 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> > >  #define get_mem_tag(addr)                      arch_get_mem_tag(addr)
> > >  #define set_mem_tag_range(addr, size, tag)     arch_set_mem_tag_range((addr), (size), (tag))
> > >
> > > +#ifdef CONFIG_KASAN_SW_TAGS
> > > +u8 random_tag(void);
> > > +#elif defined(CONFIG_KASAN_HW_TAGS)
> > > +static inline u8 random_tag(void)
> > > +{
> > > +       return get_random_tag();
> >
> > What's the difference between random_tag() and get_random_tag()? Do we
> > need both?
>
> Not really. Will simplify this in the next version and give cleaner names.

Actually I think I'll keep both for the next version, but rename
get_random_tag() into hw_get_random_tag() along with other hw-specific
calls. The idea is to have hw_*() calls for things that are
implemented by the hardware for HW_TAGS, and then define random_tag()
based on that for HW_TAGS and based on a software implementation for
SW_TAGS.
