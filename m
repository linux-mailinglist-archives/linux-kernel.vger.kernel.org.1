Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EE29D939
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbgJ1WuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389461AbgJ1Wto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:49:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF77C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:49:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id f93so717212qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsdkNzdMfWbXcZddXcT8aNBIhrkn1PkorkEU1qPCnjs=;
        b=EchNxfjWzAUq7C9Ti1qSHxWy2ojph/urHy60IprjNwVnnSHv7akwPxW+W2Gw79lVrr
         LBbC8gDgPCvGF57RQQ7Dilxntcq9QqyIP0hw2I5p0AViyp/dUDzvzA5xOrfpTbIi8+Qs
         8Pv9zi0mH6SAJpljfdLeMgoLkyH3mGsakv8Kcc5zmt0yfZS1SpaQeUwLVrsH5fzsd3lK
         iYnLuOdfZavOXph0Z9SmP8/S8UV6MpNMXLcVwfU4LL/RUeKjJ9nav4TIpS8wHWRitI4c
         PUHVbQ/ww+WTSzqXxmoctill4YXA+t3xUpvV5z1XlFCEzqqmEpb3ZFVcqJbJBMMB3X83
         nFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsdkNzdMfWbXcZddXcT8aNBIhrkn1PkorkEU1qPCnjs=;
        b=lHtI/R499frVhwa0wSV1ozcbxWY+SxiA8+flxIbefmvPGO/TBxi+zRCbLQ+jgs3Ls/
         WBz54KABe4w7fniQX1weu1N0S5Iv99yvKu2SUg02kKLfMS0jtho2Ci9FxVupPabUh7Wq
         NQXHTBxQ27jr9XObMo2/pi8M/0tlJp+EpQ20hVkE1EIQnCgQj1PqRWXNeG1iV1Rd/hDt
         9bdfkpiH73w8BCzntQp3Lh9S5mz8ggQ6htagOSbSDAhp+fbfiEIqTaCP7zAu2SztfttI
         tQr+JtqGoL1N/vPZaXYsLCSjKce5lkUwwIra9C8o+He4R5TTc68PSDE1xN/0EawloU6T
         zgLQ==
X-Gm-Message-State: AOAM532cFTdeyJbi/W0M6eSBw89iBv7KdKzb+ALx+5kCu2Wlsh5/j3cz
        0pKIefqoa3UDCUeez+H1fvuG4Awjw12q0DpOYfIoVHvbvbneVQ==
X-Google-Smtp-Source: ABdhPJydQ3JF4RJPCBrrrnsibfOQNjmnkH8RvdYTDaT4t9agLmajW2JLdDceJKZXK/JBoej4wJGe7HarOCof+hiFJhU=
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr6093592qtu.337.1603882568390;
 Wed, 28 Oct 2020 03:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <1d87f0d5a282d9e8d14d408ac6d63462129f524c.1603372719.git.andreyknvl@google.com>
In-Reply-To: <1d87f0d5a282d9e8d14d408ac6d63462129f524c.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 11:55:57 +0100
Message-ID: <CACT4Y+Y6jbXh28U=9oK_1ihMhePRhZ6WP9vBwr8nVm_aU3BmNQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/21] kasan, arm64: move initialization message
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
> Tag-based KASAN modes are fully initialized with kasan_init_tags(),
> while the generic mode only requireds kasan_init(). Move the
> initialization message for tag-based modes into kasan_init_tags().
>
> Also fix pr_fmt() usage for KASAN code: generic mode doesn't need it,

Why doesn't it need it? What's the difference with tag modes?

> tag-based modes should use "kasan:" instead of KBUILD_MODNAME.

With generic KASAN I currently see:

[    0.571473][    T0] kasan: KernelAddressSanitizer initialized

So KBUILD_MODNAME somehow works. Is there some difference between files?

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Idfd1e50625ffdf42dfc3dbf7455b11bd200a0a49
> ---
>  arch/arm64/mm/kasan_init.c | 3 +++
>  mm/kasan/generic.c         | 2 --
>  mm/kasan/hw_tags.c         | 4 ++++
>  mm/kasan/sw_tags.c         | 4 +++-
>  4 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index b6b9d55bb72e..8f17fa834b62 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -290,5 +290,8 @@ void __init kasan_init(void)
>  {
>         kasan_init_shadow();
>         kasan_init_depth();
> +#if defined(CONFIG_KASAN_GENERIC)
> +       /* CONFIG_KASAN_SW/HW_TAGS also requires kasan_init_tags(). */

A bit cleaner way may be to introduce kasan_init_early() and
kasan_init_late(). Late() will do tag init and always print the
message.

>         pr_info("KernelAddressSanitizer initialized\n");
> +#endif
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index de6b3f03a023..d259e4c3aefd 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -9,8 +9,6 @@
>   *        Andrey Konovalov <andreyknvl@gmail.com>
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 0128062320d5..b372421258c8 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -6,6 +6,8 @@
>   * Author: Andrey Konovalov <andreyknvl@google.com>
>   */
>
> +#define pr_fmt(fmt) "kasan: " fmt
> +
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/memory.h>
> @@ -18,6 +20,8 @@
>  void __init kasan_init_tags(void)
>  {
>         init_tags(KASAN_TAG_MAX);
> +
> +       pr_info("KernelAddressSanitizer initialized\n");
>  }
>
>  void *kasan_reset_tag(const void *addr)
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index bf1422282bb5..099af6dc8f7e 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -6,7 +6,7 @@
>   * Author: Andrey Konovalov <andreyknvl@google.com>
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define pr_fmt(fmt) "kasan: " fmt
>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -41,6 +41,8 @@ void __init kasan_init_tags(void)
>
>         for_each_possible_cpu(cpu)
>                 per_cpu(prng_state, cpu) = (u32)get_cycles();
> +
> +       pr_info("KernelAddressSanitizer initialized\n");
>  }
>
>  /*
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
