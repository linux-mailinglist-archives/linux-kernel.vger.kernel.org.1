Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA72AF462
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKKPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgKKPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:05:31 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:05:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so1486067qtj.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVdrwVonW2YmXNPICNMVskHoelIG7HcDSMAakdQ5R6o=;
        b=UTLVB2hxRZ/vVu4f9fiQEG+572Ji8mJIvg81MhD1NKB8alyp4D9lxULtwx/j4lo4TM
         OQzjOn9CAAntKjtWTi5fWbneXByjeFFiw6ul/xnriHlNj70+ACy6FQTAfkMaQfDolpMj
         MIFDWODOrDZN8hkQ8cpkayyDTMiMku/Z7cyTJL44pmzuSsLYH0mGDNpv2wNb+ZYnITj+
         jrv+UvXCbloCxgk/Vx3uuvSUo4f/VVy8J2+k5KifavD9zZgiYCNlEzqWpDp01TjNdDu7
         w+g9QhteNmqGkwOvf3rEI4ShiHQaq3QBfbBX05vmNKtQszPocEfvoAAmc87lUUkdXC2W
         DkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVdrwVonW2YmXNPICNMVskHoelIG7HcDSMAakdQ5R6o=;
        b=DeB8HZLCiBGi9SMDeRKV2DXncLPLyvKkMSvaSOjuo8Dfu8jlSeS/LLM+ZYqSxoxxHt
         iVUTXl20aVcZ5WjwmDbaQcK63MHiqHZAxx90qTRzWGbctELbKkzOTq+zE6ZkTnGdF9Ft
         OXNfcmVarSrW4OqowFVaGtf6Xn65LGd1DEakvSfhNKgMsppiLq9vezcRJTFHAdKUWGJC
         E2+FvFhwOFzwerPdsizq+3TnhEp1vCULq6jvCwU6RfEL+MMKZaBT+DNipf/ZV5kpE61s
         G4WvZo3/FOkwctbLCkSOgQoQpGbxBSCt57U+cjY6Elb8/7ssOLbY4hPmNtvRiEQoX8S0
         afpA==
X-Gm-Message-State: AOAM530f4FxcD9QQyhN1iAF49YIyZ35wEdc/Kt/oZ3PhpDT6hnZUBri1
        jdiL7XjCGDk7l9xM6kXez+mlylx5+5dJStWjpTtTeA==
X-Google-Smtp-Source: ABdhPJw24Rx52XOMBeEDYI2jpfkJiXThsY1TFAHA5j0XDpiaYS3zyLLvmBaCBeWAwKffx7zqXwgny9qoHMU3iEKwT3U=
X-Received: by 2002:ac8:4884:: with SMTP id i4mr24122947qtq.300.1605107129800;
 Wed, 11 Nov 2020 07:05:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <8b8345f75fa75638328d684b826b1118e2649e30.1605046192.git.andreyknvl@google.com>
In-Reply-To: <8b8345f75fa75638328d684b826b1118e2649e30.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:05:17 +0100
Message-ID: <CAG_fn=UDk95kK-ZsJDe43VUCTUvUmYfFmONKWAAxoXMvoXv6DQ@mail.gmail.com>
Subject: Re: [PATCH v9 18/44] kasan, arm64: rename kasan_init_tags and mark as __init
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
> Rename kasan_init_tags() to kasan_init_sw_tags() as the upcoming hardware
> tag-based KASAN mode will have its own initialization routine.
> Also similarly to kasan_init() mark kasan_init_tags() as __init.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I99aa2f7115d38a34ed85b329dadab6c7d6952416
> ---
>  arch/arm64/kernel/setup.c  | 2 +-
>  arch/arm64/mm/kasan_init.c | 2 +-
>  include/linux/kasan.h      | 4 ++--
>  mm/kasan/sw_tags.c         | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 133257ffd859..bb79b09f73c8 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -358,7 +358,7 @@ void __init __no_sanitize_address setup_arch(char **c=
mdline_p)
>         smp_build_mpidr_hash();
>
>         /* Init percpu seeds for random tags after cpus are set up. */
> -       kasan_init_tags();
> +       kasan_init_sw_tags();
>
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>         /*
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index e35ce04beed1..d8e66c78440e 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -283,7 +283,7 @@ void __init kasan_init(void)
>         kasan_init_shadow();
>         kasan_init_depth();
>  #if defined(CONFIG_KASAN_GENERIC)
> -       /* CONFIG_KASAN_SW_TAGS also requires kasan_init_tags(). */
> +       /* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
>         pr_info("KernelAddressSanitizer initialized\n");
>  #endif
>  }
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 979d598e1c30..1d6ec3325163 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -191,7 +191,7 @@ static inline void kasan_record_aux_stack(void *ptr) =
{}
>
>  #ifdef CONFIG_KASAN_SW_TAGS
>
> -void kasan_init_tags(void);
> +void __init kasan_init_sw_tags(void);
>
>  void *kasan_reset_tag(const void *addr);
>
> @@ -200,7 +200,7 @@ bool kasan_report(unsigned long addr, size_t size,
>
>  #else /* CONFIG_KASAN_SW_TAGS */
>
> -static inline void kasan_init_tags(void) { }
> +static inline void kasan_init_sw_tags(void) { }
>
>  static inline void *kasan_reset_tag(const void *addr)
>  {
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index d25f8641b7cd..b09a2c06abad 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -35,7 +35,7 @@
>
>  static DEFINE_PER_CPU(u32, prng_state);
>
> -void kasan_init_tags(void)
> +void __init kasan_init_sw_tags(void)
>  {
>         int cpu;
>
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
