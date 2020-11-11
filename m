Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0262AF38F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgKKOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:30:37 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F70C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:30:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so1801035qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/BqGgtubdX37tmwe08Rq/1pXj9l2Bza+T3BZlmbJiM=;
        b=jvL+NTnBHSWLApmS7P+p19pqyWxpgB69jp9uis0hZF42uoT1XBnYFN9NaAsKlKEASe
         uLIq9e2d44ooNO/MNgOUL0JOwRBhmd7/PgJJIX16fc3mKZgm2FBx8nw7gei6jegiqeeR
         sdhTv70Bs/qQjzy6ZSoT3Q2yL8+mWAxuXtzBHmcIyoZOCJU3yBdYiNrNX8f4Pf4dhIZc
         aCJnxCPX4ug/8Oxl3oftLj5SqRHMigxoH48jO4FloEHaMA9GnPX4JzdAs05y788Nbn+e
         /cZOvwwfUw23tXlNFRpUgGAk5Gx5bpgailYjw2c08mjEAkLHFZlLDf5MYjeUQPm+EPuF
         Q7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/BqGgtubdX37tmwe08Rq/1pXj9l2Bza+T3BZlmbJiM=;
        b=Du+EnzZvWo6+khSQC1Mo4i+pI+fD8tcJgA9Ve16BhnB2Tj8Bz/4u4lYMM/Mz5E2B7F
         85DrZ4OxBcHKMabLXH2104quNXLklxoqfY5J/4vubBgIf8gcx9kZqX6h1q6BusR3+7Bm
         m3nsRPO3ZNUDcaBM3KdO+FKDpYkAM2+J1JkJ4yNA7vhIcGbJ4oGTmkEWuFwyo69HfGBV
         xlQ7hSXVl7XrtcKeS8IzsYz4Y8kOJDNod8Q7gVplniDi2xJFxmQ+p1LHw9C3Vbeiho0z
         VQqNiJkQ6uYha8WcV5f1bEktuxmeJFY1B/KVeCvBJDlqEICiEaI6bZQ0uJYYObo9Vm38
         Vz7Q==
X-Gm-Message-State: AOAM531O++/mIBouEjvilmmDzOTA9H3ogx0uEdQlpQ8oBnQDyEdapMrb
        QVlKmxlJceE8Gf6zIxDFMtveRrWsi6GeRbJoKxT8Ag==
X-Google-Smtp-Source: ABdhPJyD3/xRKtJaSbF5ZNq+W+FQDm38hz+bmHdD0jgz0vEW7Rwi9biDt4z3OdyzDxWL4SWvUZu8Z7RK8lNOhpzQ7+4=
X-Received: by 2002:a37:b545:: with SMTP id e66mr8296564qkf.392.1605105035446;
 Wed, 11 Nov 2020 06:30:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <3aae3b3f931618b4418af7992bff1e258e4eb1ad.1605046192.git.andreyknvl@google.com>
In-Reply-To: <3aae3b3f931618b4418af7992bff1e258e4eb1ad.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:30:23 +0100
Message-ID: <CAG_fn=Vze9yV7Hy6rf-Sy+F0NP-bPPZZ8QYa3QQu5J8a1q=5hw@mail.gmail.com>
Subject: Re: [PATCH v9 15/44] kasan, arm64: only init shadow for software modes
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
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> Hardware tag-based KASAN won't be using shadow memory. Only initialize
> it when one of the software KASAN modes are enabled.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: I055e0651369b14d3e54cdaa8c48e6329b2e8952d
> ---
>  arch/arm64/include/asm/kasan.h |  8 ++++++--
>  arch/arm64/mm/kasan_init.c     | 15 ++++++++++++++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasa=
n.h
> index b0dc4abc3589..f7ea70d02cab 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -13,6 +13,12 @@
>  #define arch_kasan_get_tag(addr)       __tag_get(addr)
>
>  #ifdef CONFIG_KASAN
> +void kasan_init(void);
> +#else
> +static inline void kasan_init(void) { }
> +#endif
> +
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
>  /*
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -33,12 +39,10 @@
>  #define _KASAN_SHADOW_START(va)        (KASAN_SHADOW_END - (1UL << ((va)=
 - KASAN_SHADOW_SCALE_SHIFT)))
>  #define KASAN_SHADOW_START      _KASAN_SHADOW_START(vabits_actual)
>
> -void kasan_init(void);
>  void kasan_copy_shadow(pgd_t *pgdir);
>  asmlinkage void kasan_early_init(void);
>
>  #else
> -static inline void kasan_init(void) { }
>  static inline void kasan_copy_shadow(pgd_t *pgdir) { }
>  #endif
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index b24e43d20667..ffeb80d5aa8d 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -21,6 +21,8 @@
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
>
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +
>  static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
>
>  /*
> @@ -208,7 +210,7 @@ static void __init clear_pgds(unsigned long start,
>                 set_pgd(pgd_offset_k(start), __pgd(0));
>  }
>
> -void __init kasan_init(void)
> +static void __init kasan_init_shadow(void)
>  {
>         u64 kimg_shadow_start, kimg_shadow_end;
>         u64 mod_shadow_start, mod_shadow_end;
> @@ -269,6 +271,17 @@ void __init kasan_init(void)
>
>         memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>         cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> +}
> +
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
> +
> +static inline void __init kasan_init_shadow(void) { }
> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +void __init kasan_init(void)
> +{
> +       kasan_init_shadow();
>
>         /* At this point kasan is fully initialized. Enable error message=
s */
>         init_task.kasan_depth =3D 0;
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
