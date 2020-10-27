Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E829AC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900139AbgJ0Mk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:40:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44940 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900132AbgJ0Mkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:40:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so916973qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2tDKAOxc+uu+1RBFzTdO3JlDCHYZwi+KFiWnGXj6D4=;
        b=eXyC7a+kdQWf7gyBaBcXcqJdLcqb09UxACwxIuXD0EqU4qICrjIWvKc50xhbwF49gG
         aztmsXfS+5KyaveUa40tBCZapl3tKRPCieATamVtAd42+OOqvwHCElaSq+HcMaswTgzh
         3cylgtPcWDd7tceJOo3+mCf18FE3lIGioobzeNAKqBlO12Q8Be7eiFG2dT1pXvFNJH41
         8eqG1NvlqFnQos9kH8RvCoM00r1+YEu/safsbcbJAhPNlFKejz0kWkfgDegDOuxgNGgW
         QkLDyavsG64K63C7R/T24DWcnfBtOCuvupnP8Vu9Eszd31UwDRDEjsaGCP2aKAKqEM3Z
         fXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2tDKAOxc+uu+1RBFzTdO3JlDCHYZwi+KFiWnGXj6D4=;
        b=ohChs0ajL1kCEDZirrKk0Jrd4pRgmeP/WqVMiqs0fAWA/C0i5WmK8gFhW6dyiGc4NO
         7VEZs5NSb6t+PPqZceet9ZYlT2NkYJtCTnepk40izI6X2uJpI2m2mZKkFRc08SfdvzSh
         Jt7B5bpdUh+k6ZsdYXD1lXBzkqiOwTjGec6yxg0C1sOz6T7Acl1mwi+WcX8EeC9Wb1JE
         JvT4ZfgJkRiqmLDgGM0bCdAYG6uElEoWuJtXplhxWHC0t4k46ShW+OLuU3NNsIJGe4fc
         ny/NWiQGn88gL3WgV+E+SKJPyS9BmHiU7fU1zBTjWU6i0MsH3uauhYjVgxi9J30koQHk
         /1Nw==
X-Gm-Message-State: AOAM532FzvxywEUW4jGn9aX/qgjNg+LmUAQGQo3Rcdr3TPo1uKgqt7xM
        roi8ii1tijqJX36iwjXOVA90qNWBSkg1abgomzWTrA==
X-Google-Smtp-Source: ABdhPJyI6ewWlHIMIUXPm4kj8NFrCdj78fZyHJilKPev5dxGCgG2Jqc987ffxHqOkzWCWcWzba12sZ8h6Ggqcr/9BLo=
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr1912592qkk.265.1603802449178;
 Tue, 27 Oct 2020 05:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <eaeb053a84e82badf1ade6cf7f9caf6737fcd229.1603372719.git.andreyknvl@google.com>
In-Reply-To: <eaeb053a84e82badf1ade6cf7f9caf6737fcd229.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:40:37 +0100
Message-ID: <CACT4Y+Ywj+q8zsED+oqAj__2_gBKVcjr3ngVoCwCe7HQKssS4g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/21] kasan: simplify quarantine_put call site
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Move get_free_info() call into quarantine_put() to simplify the call site.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iab0f04e7ebf8d83247024b7190c67c3c34c7940f

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c     | 2 +-
>  mm/kasan/kasan.h      | 5 ++---
>  mm/kasan/quarantine.c | 3 ++-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2bb0ef6da6bd..5712c66c11c1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -308,7 +308,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>
>         kasan_set_free_info(cache, object, tag);
>
> -       quarantine_put(get_free_info(cache, object), cache);
> +       quarantine_put(cache, object);
>
>         return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 6850308c798a..5c0116c70579 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -214,12 +214,11 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>
>  #if defined(CONFIG_KASAN_GENERIC) && \
>         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> -void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
> +void quarantine_put(struct kmem_cache *cache, void *object);
>  void quarantine_reduce(void);
>  void quarantine_remove_cache(struct kmem_cache *cache);
>  #else
> -static inline void quarantine_put(struct kasan_free_meta *info,
> -                               struct kmem_cache *cache) { }
> +static inline void quarantine_put(struct kmem_cache *cache, void *object) { }
>  static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 580ff5610fc1..a0792f0d6d0f 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -161,11 +161,12 @@ static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
>         qlist_init(q);
>  }
>
> -void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
> +void quarantine_put(struct kmem_cache *cache, void *object)
>  {
>         unsigned long flags;
>         struct qlist_head *q;
>         struct qlist_head temp = QLIST_INIT;
> +       struct kasan_free_meta *info = get_free_info(cache, object);
>
>         /*
>          * Note: irq must be disabled until after we move the batch to the
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
