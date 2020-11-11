Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1262AF457
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKKPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:04:06 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DFC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:04:05 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so1224939qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T/yXDCUDWYrYlUTbV+JUoEICw4sgibdbwn70JC0Gn9g=;
        b=uipkPj5W8JpRde1BZ8RAaTk9NNHw2+YlqXJ9JyUBQZaxzWzWJpraEeWTseMYn8FZXp
         FKIXsmIhMmyw/YkTLrJgima1BzZ45nn97MrH3SBkR1haPsTid1Nw/feF041VY1qzXoXm
         3KQwJmppshISmVLG9BsZWDmtZPd5loGkwaZOX7bkXNAQZqkThZp4m7BXNpCVX9RBW3UY
         ryz1+Ra8ZyoYrNZxsJIexs1r+0TS5decAGbSe8KGMnnCQYWhKs2RiYP8GxFDlHjLeFHl
         EHSRRn/O6GdECsNaDztAisH/9kcU3X4w/Efuw8iD8XrxNp4vg2kDDfvMMv/CQGZ1f8n+
         azyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T/yXDCUDWYrYlUTbV+JUoEICw4sgibdbwn70JC0Gn9g=;
        b=X8f2848uhfe5H8k/lZU7JIHJu0tnXl9lEI2fiEl0b7Qbr07S39Tp1qiKOp4BoVZUgr
         JbRspQKkp4F/n08WkZckXWgTyNfSpelg0x6qkM6L+5HXqqthr5yMElhNwjmkWw5Up2nN
         JNfILsZGMJ5zSXtROwZhm4k8LBebpmSkEsmRanpCcVLklFZ6eYgrRK4SlLUcqP9Hvx1+
         50lbgv14u6LrZfbxDGvM2myln7S6PWCI7zrHIpuGQEPEyh45RlvRM0mw7NePS2QL0YO7
         PlaDiJxTi2puXAGntaDn0hDafV1qJSaZCau7ZBs86KNG+QsVCEuDtxrOU1Jm5f2DW0a5
         CoIA==
X-Gm-Message-State: AOAM5314pNG4j50cFryXBzZ1RpsskVvzAAzvX7Dv9LHHBT+7PRUslELt
        2ZEZzhawrMGJtk/FYsJAKVCq2R/EoWfHVLK5y1Wcpg==
X-Google-Smtp-Source: ABdhPJxwRAJlkZXtCgjwOCfZ+vnUzrbvfBbQunngaC7AOJ1FHkYD1IJxWn+erS2dZuE2R6iUURWasBaDXnRAgK0eLjU=
X-Received: by 2002:ac8:4884:: with SMTP id i4mr24115822qtq.300.1605107044904;
 Wed, 11 Nov 2020 07:04:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <619cb0edad35d946c4796976c25bddb5b3eb0c56.1605046192.git.andreyknvl@google.com>
In-Reply-To: <619cb0edad35d946c4796976c25bddb5b3eb0c56.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:03:52 +0100
Message-ID: <CAG_fn=UKSp8shtYujRbM=8ndhLg_Ccdpk9eSfOeb=KpwNi7HBg@mail.gmail.com>
Subject: Re: [PATCH v9 17/44] kasan, arm64: move initialization message
To:     Andrey Konovalov <andreyknvl@google.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Software tag-based KASAN mode is fully initialized with kasan_init_tags()=
,
> while the generic mode only requires kasan_init(). Move the
> initialization message for tag-based mode into kasan_init_tags().
>
> Also fix pr_fmt() usage for KASAN code: generic.c doesn't need it as it
> doesn't use any printing functions; tag-based mode should use "kasan:"
> instead of KBUILD_MODNAME (which stands for file name).
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Change-Id: Iddca9764b30ff0fab1922f26ca9d4f39b6f22673
> ---
>  arch/arm64/include/asm/kasan.h |  9 +++------
>  arch/arm64/mm/kasan_init.c     | 13 +++++--------
>  mm/kasan/generic.c             |  2 --
>  mm/kasan/sw_tags.c             |  4 +++-
>  4 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasa=
n.h
> index f7ea70d02cab..0aaf9044cd6a 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -12,14 +12,10 @@
>  #define arch_kasan_reset_tag(addr)     __tag_reset(addr)
>  #define arch_kasan_get_tag(addr)       __tag_get(addr)
>
> -#ifdef CONFIG_KASAN
> -void kasan_init(void);
> -#else
> -static inline void kasan_init(void) { }
> -#endif
> -
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
> +void kasan_init(void);
> +
>  /*
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
>   * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresse=
s,
> @@ -43,6 +39,7 @@ void kasan_copy_shadow(pgd_t *pgdir);
>  asmlinkage void kasan_early_init(void);
>
>  #else
> +static inline void kasan_init(void) { }
>  static inline void kasan_copy_shadow(pgd_t *pgdir) { }
>  #endif
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 5172799f831f..e35ce04beed1 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -278,17 +278,14 @@ static void __init kasan_init_depth(void)
>         init_task.kasan_depth =3D 0;
>  }
>
> -#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
> -
> -static inline void __init kasan_init_shadow(void) { }
> -
> -static inline void __init kasan_init_depth(void) { }
> -
> -#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> -
>  void __init kasan_init(void)
>  {
>         kasan_init_shadow();
>         kasan_init_depth();
> +#if defined(CONFIG_KASAN_GENERIC)
> +       /* CONFIG_KASAN_SW_TAGS also requires kasan_init_tags(). */
>         pr_info("KernelAddressSanitizer initialized\n");
> +#endif
>  }

Cannot we have a single kasan_init() function that will call
tool-specific initialization functions and print the message at the
end?

> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index e1af3b6c53b8..adb254df1b1d 100644
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
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index b2638c2cd58a..d25f8641b7cd 100644
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
> @@ -41,6 +41,8 @@ void kasan_init_tags(void)
>
>         for_each_possible_cpu(cpu)
>                 per_cpu(prng_state, cpu) =3D (u32)get_cycles();
> +
> +       pr_info("KernelAddressSanitizer initialized\n");
>  }
>
>  /*
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
