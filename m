Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94227CABD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgI2MVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbgI2MVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:21:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486ACC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:21:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so3722721pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5kKBQ+Qqkla12YVhGRy7ZogNeaVCuiLnDorQW/L8Lg=;
        b=SX2sc9ksvtIkXUBGDPsan+1J1Enlck2Gs9xWJRjb0TZ4XlzM+PfRs7yD3PfT3WGpj/
         70k/+6UbTWf2E6C+WKu2kRq2+ga2ef7dJWAKX4wS+ZH/zUQmscp7qdbgDy3UsZefs63T
         lbhiJeknylvPB93DNsTQaKRFN/ty7oXkYeCSYiPX3FDzAuOLJ4mPdqPAoCRi1wmITNfO
         Yj3A+HIgoJ0UvnQmCHoD8lHPNzlLgdSUMZM8hZhO7RYQYnkv9hQcUEsg0bwL6mP+zCfV
         Vp82CQSDrfdBgT+Os7J4gWKu+0HWkC0SDA20UUvwzRema6vQ/SCEfyBEV6K2b4+XaVzx
         eoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5kKBQ+Qqkla12YVhGRy7ZogNeaVCuiLnDorQW/L8Lg=;
        b=pTsVHR2uOeV0pzrtpDbJzCILkRWgaGBs5kD04GTC2XDjJG1WPZv7TLLZRy7T6P4IGK
         3tAIRisAFKJ50UhN/X32IZxlPZGa9d20uyu9DxAvPU5Cy7PiUyUbTsq5JF4O3cOUuY6I
         bcO8JmpP57u+NKZ7WU6Mtz5XUSBWEVKksmRAkWEXl563ZE2sHMsQr4214ua9fMY5gvaE
         BdIK4m1+R42Q0lPw1abDqlekzv2cIvs4WxkttiHuvX2kkFZugtDT0qDJRWUPFiSO/vp4
         0MKRzEj4I+FkeahIjUE0noKnWtq9OJbXLmKZCX1QLYKTStYSLbZmcLqREBwee+jBKCXh
         nfag==
X-Gm-Message-State: AOAM531W3H+nlqZidJy3Xn3YZcnote5+RsGvc95QHUICC7QoH9luo+pY
        dGF0vApX5rGu5a3M72CAdoHJvI/QA9XJEwyo5qqSXg==
X-Google-Smtp-Source: ABdhPJzjmFcv8nAu4i4hfq2V8vemDcfsL5n2zLKWlSW1h5kBa930xplRFRegKu5vXOahPaWbsy6DjmDS3znEbhfd9Sw=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr3782717pfi.55.1601382067482; Tue, 29
 Sep 2020 05:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-7-elver@google.com>
In-Reply-To: <20200921132611.1700350-7-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 29 Sep 2020 14:20:53 +0200
Message-ID: <CAAeHK+yMmGSTpwC1zPxaoBmXsfmmhuLJ3b2N3qUXUjO5U0tM3Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] kfence, kasan: make KFENCE compatible with KASAN
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:26 PM Marco Elver <elver@google.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
>
> We make KFENCE compatible with KASAN for testing KFENCE itself. In
> particular, KASAN helps to catch any potential corruptions to KFENCE
> state, or other corruptions that may be a result of freepointer
> corruptions in the main allocators.
>
> To indicate that the combination of the two is generally discouraged,
> CONFIG_EXPERT=y should be set. It also gives us the nice property that
> KFENCE will be build-tested by allyesconfig builds.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/Kconfig.kfence | 2 +-
>  mm/kasan/common.c  | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> index 4c2ea1c722de..6825c1c07a10 100644
> --- a/lib/Kconfig.kfence
> +++ b/lib/Kconfig.kfence
> @@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
>
>  menuconfig KFENCE
>         bool "KFENCE: low-overhead sampling-based memory safety error detector"
> -       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> +       depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
>         depends on JUMP_LABEL # To ensure performance, require jump labels
>         select STACKTRACE
>         help
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 950fd372a07e..f5c49f0fdeff 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> +#include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/linkage.h>
>  #include <linux/memblock.h>
> @@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         tagged_object = object;
>         object = reset_tag(object);
>
> +       if (is_kfence_address(object))
> +               return false;
> +
>         if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
>             object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
> @@ -444,6 +448,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         if (unlikely(object == NULL))
>                 return NULL;
>
> +       if (is_kfence_address(object))
> +               return (void *)object;
> +
>         redzone_start = round_up((unsigned long)(object + size),
>                                 KASAN_SHADOW_SCALE_SIZE);
>         redzone_end = round_up((unsigned long)object + cache->object_size,
> --
> 2.28.0.681.g6f77f65b4e-goog
>

With KFENCE + KASAN both enabled we need to bail out in all KASAN
hooks that get called from the allocator, right? Do I understand
correctly that these two are the only ones that are called for
KFENCE-allocated objects due to the way KFENCE is integrated into the
allocator?
