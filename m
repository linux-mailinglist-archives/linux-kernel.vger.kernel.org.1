Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B742AF448
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKKO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKKO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:59:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1EAC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:59:48 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so1850758qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/fDcpIY0qGq2TOyxo24BIpfp3mzq21GpKr2EDtPYTac=;
        b=Ty273gzZBP5AOxstBsw1RhEtCdmjvUJfpOoPRJq/s43OIbRVjaGFiKolBDbmN776NY
         robjSmaetRwjV8fMVSijm05FCY5AU9myta6xfkHhebc9pN0+O+TKhGXyytCVNn0ccVqE
         QsvoNat6t7+FCjoABUzlCWErE9262ZzaQhX/YNZA5eYJuKkAfuu0nO4U6t8k1+XpbNEC
         tZPe3V61YUtGIDyHJWqh8yK2+D0z+jAQlHzI3bn/56FJTRNDSlOtp/CLBkem4LNxkoQU
         FUna472XPWJJsmujQ2nwxS4eNp7VtxmRbo7Z5FP7lU9d+oVq8xNF3XjbxNTrXiyfhbaV
         8dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fDcpIY0qGq2TOyxo24BIpfp3mzq21GpKr2EDtPYTac=;
        b=uDFea+wsPwY4tq5W9S0lBaLWcgtu3yUVaXLc8soATb0Kw4EU55o/u+ffqyxiWVQP7K
         SJr8f2plhNGYSmPXP0xR/0YgBeVQRWKx9Xiucg8axyePnyzaZOwbnNM8aGwSzbLgy2O2
         2Hp+KF3sVOQLm5bZT0wLpJiURD+/7JivkfcSbVPoo5WcFHd89FC3dGYb0JoQvJt6KMVf
         AiJG1a6N67InmYZnTZtZSbiM4mI4uzGWR/44etQ7l4sWYWCqea96pHYPDrGuPXpzpWRo
         pY2TRSzGhXUgInaXUFyiJwMYuk6QwK40TV5qXqvi2H4Xc6QCy/B49m+bTUA2xkBH2PCg
         FBDg==
X-Gm-Message-State: AOAM532ZQWHfttYpV7D9jprykEMbiVdaH71LJPloAfV2o5kYxQTeq7v0
        bWdR/17pPCHSHoIM+7a2w53BuHWvaL+dRYzp9Gw26g==
X-Google-Smtp-Source: ABdhPJzbjy27RIkLLWvoPaUvOZWfgFRUJVg0/tpesY09y+nx6VSIwS50KV49LKHnYDskEH5yMx2VLlDTj12KJuOcwK8=
X-Received: by 2002:a05:620a:f95:: with SMTP id b21mr16896205qkn.403.1605106786994;
 Wed, 11 Nov 2020 06:59:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <91b3defa17748a61d1432929a80890043ca8dcda.1605046192.git.andreyknvl@google.com>
In-Reply-To: <91b3defa17748a61d1432929a80890043ca8dcda.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:59:34 +0100
Message-ID: <CAG_fn=VhzzFSXE19KJ+0-q1WitAu08scm8s-eXvQWYSqJTub=w@mail.gmail.com>
Subject: Re: [PATCH v9 16/44] kasan, arm64: only use kasan_depth for software modes
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
> Hardware tag-based KASAN won't use kasan_depth. Only define and use it
> when one of the software KASAN modes are enabled.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I6109ea96c8df41ef6d75ad71bf22c1c8fa234a9a
> ---
>  arch/arm64/mm/kasan_init.c | 11 ++++++++---
>  include/linux/kasan.h      | 18 +++++++++---------
>  include/linux/sched.h      |  2 +-
>  init/init_task.c           |  2 +-
>  mm/kasan/common.c          |  2 ++
>  mm/kasan/report.c          |  2 ++
>  6 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index ffeb80d5aa8d..5172799f831f 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -273,17 +273,22 @@ static void __init kasan_init_shadow(void)
>         cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>  }
>
> +static void __init kasan_init_depth(void)
> +{
> +       init_task.kasan_depth =3D 0;
> +}
> +
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
>
>  static inline void __init kasan_init_shadow(void) { }
>
> +static inline void __init kasan_init_depth(void) { }
> +
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  void __init kasan_init(void)
>  {
>         kasan_init_shadow();
> -
> -       /* At this point kasan is fully initialized. Enable error message=
s */
> -       init_task.kasan_depth =3D 0;
> +       kasan_init_depth();
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f6435b9f889c..979d598e1c30 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -51,6 +51,12 @@ static inline void *kasan_mem_to_shadow(const void *ad=
dr)
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>
> +/* Enable reporting bugs after kasan_disable_current() */
> +extern void kasan_enable_current(void);
> +
> +/* Disable reporting bugs for current task */
> +extern void kasan_disable_current(void);
> +
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> @@ -61,16 +67,13 @@ static inline void kasan_remove_zero_shadow(void *sta=
rt,
>                                         unsigned long size)
>  {}
>
> +static inline void kasan_enable_current(void) {}
> +static inline void kasan_disable_current(void) {}
> +
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  #ifdef CONFIG_KASAN
>
> -/* Enable reporting bugs after kasan_disable_current() */
> -extern void kasan_enable_current(void);
> -
> -/* Disable reporting bugs for current task */
> -extern void kasan_disable_current(void);
> -
>  void kasan_unpoison_memory(const void *address, size_t size);
>
>  void kasan_unpoison_task_stack(struct task_struct *task);
> @@ -121,9 +124,6 @@ static inline void kasan_unpoison_memory(const void *=
address, size_t size) {}
>
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {=
}
>
> -static inline void kasan_enable_current(void) {}
> -static inline void kasan_disable_current(void) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int ord=
er) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int orde=
r) {}
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 063cd120b459..81b09bd31186 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1197,7 +1197,7 @@ struct task_struct {
>         u64                             timer_slack_ns;
>         u64                             default_timer_slack_ns;
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         unsigned int                    kasan_depth;
>  #endif
>
> diff --git a/init/init_task.c b/init/init_task.c
> index a56f0abb63e9..39703b4ef1f1 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -176,7 +176,7 @@ struct task_struct init_task
>         .numa_group     =3D NULL,
>         .numa_faults    =3D NULL,
>  #endif
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         .kasan_depth    =3D 1,
>  #endif
>  #ifdef CONFIG_KCSAN
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 543e6bf2168f..d0b3ff410b0c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -46,6 +46,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t f=
lags)
>         track->stack =3D kasan_save_stack(flags);
>  }
>
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  void kasan_enable_current(void)
>  {
>         current->kasan_depth++;
> @@ -55,6 +56,7 @@ void kasan_disable_current(void)
>  {
>         current->kasan_depth--;
>  }
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  static void __kasan_unpoison_stack(struct task_struct *task, const void =
*sp)
>  {
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b18d193f7f58..af9138ea54ad 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -292,8 +292,10 @@ static void print_shadow_for_address(const void *add=
r)
>
>  static bool report_enabled(void)
>  {
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         if (current->kasan_depth)
>                 return false;
> +#endif
>         if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
>                 return true;
>         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
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
