Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CF28F01D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgJOKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgJOKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:23:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD924C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:23:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so2385926otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3eDemKpeFc1gJYyDDp5vYr/DT8MF8qWffPtgx/Rzdw=;
        b=ix5+GbXnCWRlROMmgufHq2oE+1cdrFFLX7lx+SfMs/2CGfUvR5/wmuIA1Bu3IcGmDO
         vV7WX7kYim/lnvHFa5lf9TXLL1MdHCjAmpmBLjfAp7+YNcLG9orO6ueizt/rtVl9xfbC
         ONY8RIoHdi2tEDzXnMY+9Qrjm9zrMRytABFb/XwqUEeNKpK8jVvdl4THZ/m/IJ+XHzHw
         Xauz93MOXn2BmKKkWMicJx9hyWiJRUw1QvIpblpkU05644WY+5iDLukMsPAJB02sA9RG
         cNa6M0pgBfUKYVbkGlzSKxsf9AajcFccVsXzAEBnfM/uGxp+GzxmKI/ErwywKUJfnz/T
         OfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3eDemKpeFc1gJYyDDp5vYr/DT8MF8qWffPtgx/Rzdw=;
        b=Xm3+WLoo6kqFVFWecHGU7Bi0wyrGz4DC9y7TnAbq36XY8JBC/nweBA9Hg9btJ5vU7X
         DkCkvEip2JkoQUx2puHm2Stlfl23aWjgvSTsZPHpd9bE/lXbHPOQkbjKs7V03+JSMuxP
         85vQUHUZRPAAfuRB4dQUguwxVWPJ2WwR3fTYqdDlJ+JU7QCZ87uHHmWHBZRaxk7Y8x6w
         yLpjfw9Mwlhb/A4wUuDPwmAAfFPFOMvID+YpHWtKbRUj6/ODkY9bl5Y6VdA5Px0tJJqx
         n2O9ug7h6ySsdf1SYnrXBT6UcteC5qar+3ZK1uKYasUuTJoz5915kTv3r8V4c+OWWA02
         BOTQ==
X-Gm-Message-State: AOAM5335nU26KapS7NwrRZZCoIz+wSl6xSKG3oKppzMCAtw7c5ZZBnEP
        aO7EHrPFJgpGQ1VMhBB8mKIJBcEt+4H7e4X/5H30pA==
X-Google-Smtp-Source: ABdhPJyfR4Ru70eeRKUorgZxSTNOp3yEJDLk6FVxy/rJsoxtubfJHHEqXkcTpqtatgnONECphGKXSGSxV2OemlKYDXk=
X-Received: by 2002:a9d:649:: with SMTP id 67mr2228403otn.233.1602757404080;
 Thu, 15 Oct 2020 03:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <8fe7b641027ea3151bc84e0d7c81d2d8104d50d7.1602708025.git.andreyknvl@google.com>
In-Reply-To: <8fe7b641027ea3151bc84e0d7c81d2d8104d50d7.1602708025.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 15 Oct 2020 12:23:12 +0200
Message-ID: <CANpmjNOKM8=MWPR2MPPrdu0fhvzwD4dDO-xnfeqcxOY1DQe09g@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] kasan: mark kasan_init_tags as __init
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Similarly to kasan_init() mark kasan_init_tags() as __init.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558
> ---
>  include/linux/kasan.h | 4 ++--
>  mm/kasan/hw_tags.c    | 2 +-
>  mm/kasan/sw_tags.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 7be9fb9146ac..af8317b416a8 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
> -void kasan_init_tags(void);
> +void __init kasan_init_tags(void);
>
>  void *kasan_reset_tag(const void *addr);
>
> @@ -194,7 +194,7 @@ bool kasan_report(unsigned long addr, size_t size,
>
>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
> -static inline void kasan_init_tags(void) { }
> +static inline void __init kasan_init_tags(void) { }

Should we mark empty static inline functions __init? __init comes with
a bunch of other attributes, but hopefully they don't interfere with
inlining?

>  static inline void *kasan_reset_tag(const void *addr)
>  {
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 2a38885014e3..0128062320d5 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -15,7 +15,7 @@
>
>  #include "kasan.h"
>
> -void kasan_init_tags(void)
> +void __init kasan_init_tags(void)
>  {
>         init_tags(KASAN_TAG_MAX);
>  }
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index c10863a45775..bf1422282bb5 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -35,7 +35,7 @@
>
>  static DEFINE_PER_CPU(u32, prng_state);
>
> -void kasan_init_tags(void)
> +void __init kasan_init_tags(void)
>  {
>         int cpu;
>
> --
> 2.28.0.1011.ga647a8990f-goog
>
