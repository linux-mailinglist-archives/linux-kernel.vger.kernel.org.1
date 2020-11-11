Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD492AF5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:15:59 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71666C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:15:59 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so2139900qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OzAPueyrhVv88UcsvPpSA8EQHYLLbDVW6Lc+mOLNNXQ=;
        b=Vjz+TKcmMvDIi4x/ar4uY4t318aSssb/Bi00N/cvybkvZ0bQuWCHSXXWjFNDdo/AW5
         wf3BRNBsjczZqvgOnjodmE94tf+FxWGAwT9KfeklgDukMqe8wbEiRed+i3KckYdMRj2t
         w3iMvHe+vGvgBMHY/k9S6RcEG2tO6ZXg/dkdI5iq9oLCrIlwTTSJIzOUnfnylaSffYoM
         w+J56PLndPh1ZLAcHJqUhlJcSGmxHptSW1hUtZL8piWgcQhc/XwbNQN4OWKonflAXMU8
         faY+AJ/FjycggZSbb8QJgzEDaJgFuDNTcf5dTKXWOHl9PUbIJAXBen3gXzi8h7goKMwb
         YefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OzAPueyrhVv88UcsvPpSA8EQHYLLbDVW6Lc+mOLNNXQ=;
        b=fn0ap/LfYwrL6QNAW9hS6l6Yddpf3WJYvHxfF3SuxT8svjQifdp0VQkKprOo+ShUkC
         KMYn24BroZ7n3Wklo9IXV3CulFdO0fHHbv18/TuQURIfGFiO7I1mZvmdonF2CPBsUjN7
         7B7ethkWRpYTWjleLlFb2L7IkEPFt1Va894ae4WGmGiCvRDocEHNUVZjIyQS5kN57wX5
         7uwbTDhDqwZVSx5AmVqNBF/tmAkNhVItOuXCJKN+OcIdhmSenDIol8z9JwQzAIeh2I1r
         DDPM0KC4JgKXnnR3RBUVnUi9k0U3Dy0I64Eu7e7seL6M3OWQraq/7/RbwcygAbXbWKgI
         +1ag==
X-Gm-Message-State: AOAM530H2K0/INLom43O4VYYYI3wBw5K06svIMXUvSyxJuHhaNS922BU
        KhyKW8AqQzX6wXUErgh+wSW/ElBMxjjzEc/Bg0O9ig==
X-Google-Smtp-Source: ABdhPJziyGpIKAWU3FNOuQHdFdj+U2aB2YZwjumAvSOhwce7yiugHZwFMB9uqvmIVjmm8tY3TwPsTYRlCHUQXCJsmcs=
X-Received: by 2002:a37:b545:: with SMTP id e66mr8798166qkf.392.1605111358447;
 Wed, 11 Nov 2020 08:15:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <096906ff06c532bbd0e9bda53bcba2ba0a1da873.1605046192.git.andreyknvl@google.com>
In-Reply-To: <096906ff06c532bbd0e9bda53bcba2ba0a1da873.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:15:46 +0100
Message-ID: <CAG_fn=U5bs8U8uw1765wDXuWg+0uGWkxUw4THjmW5cgVv3rrVw@mail.gmail.com>
Subject: Re: [PATCH v9 37/44] kasan, x86, s390: update undef CONFIG_KASAN
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
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> With the intoduction of hardware tag-based KASAN some kernel checks of
> this kind:
>
>   ifdef CONFIG_KASAN
>
> will be updated to:
>
>   if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
> x86 and s390 use a trick to #undef CONFIG_KASAN for some of the code
> that isn't linked with KASAN runtime and shouldn't have any KASAN
> annotations.
>
> Also #undef CONFIG_KASAN_GENERIC with CONFIG_KASAN.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I2a622db0cb86a8feb60c30d8cb09190075be2a90
> ---
>  arch/s390/boot/string.c         | 1 +
>  arch/x86/boot/compressed/misc.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
> index b11e8108773a..faccb33b462c 100644
> --- a/arch/s390/boot/string.c
> +++ b/arch/s390/boot/string.c
> @@ -3,6 +3,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #undef CONFIG_KASAN
> +#undef CONFIG_KASAN_GENERIC
>  #include "../lib/string.c"
>
>  int strncmp(const char *cs, const char *ct, size_t count)
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/m=
isc.h
> index d9a631c5973c..901ea5ebec22 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -12,6 +12,7 @@
>  #undef CONFIG_PARAVIRT_XXL
>  #undef CONFIG_PARAVIRT_SPINLOCKS
>  #undef CONFIG_KASAN
> +#undef CONFIG_KASAN_GENERIC
>
>  /* cpu_feature_enabled() cannot be used this early */
>  #define USE_EARLY_PGTABLE_L5
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
