Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE832FF232
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbhAURmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388887AbhAURl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:41:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F92C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:40:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f11so3437881ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2Cpd67Ssmhz6ffj791RBLGTQxJBD+P69v5Ph0KgTDM=;
        b=XV2i4SeR4yHciYQOwKOebY/mgyYyE+L+exsHvbUKkCCWVLPFfdLhKqT/huQE6DTehh
         ugCYxh67V3anpC9qsYFCR09MghPkTiTxc5gzYdXNoH7HsfqgAzaRA6ycZPd5V6pB/V3R
         CzKdRASoaBkYLbDt4K6OSo0mC37FGETUEYdqsN1dlp9MYha0ePo301Z6F6nldeGyDe99
         s8xdxaZWQ+xI6xyS2/XQa6XNMvtwjQQcBJlOC7asQ8M1yhYAOe8RLaDBOFrSiXXCiUs6
         kiNYixXtxxralQvb4WJK/0dLbsrmlHjZZj80e/Fb7j7GPDQsTPln7RqMaQeARqkehEw7
         IuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2Cpd67Ssmhz6ffj791RBLGTQxJBD+P69v5Ph0KgTDM=;
        b=Tj2tffncZD0lmZZauosbQverygAM+0VUJgOe7liG1KoGG53bT30ENbLvy22ExoNkwU
         Vag8cr0+5lZr2R6QAjg1f6b33RQUv7jAFLwl3M+NfE5CwOslCDvatUYt9DWDxsmA3Ift
         YqA9B52wSQUVyFaEaV8jUbAO25ILEO0Vq+jsnPyIL4AO/3Uet9/b3rnAbidc1nzdvjVy
         TNwQvCqzlZG8vro0Jv8zduCkm+heI1ZSHTajWUr1jktrjaZDqJK9pPZ6uqmsHi29RsQM
         ccoWhEFnjEwUwZ/ce24TJtgCcZNvEPvJRB/p6i40xkJVZ1W8vyXIEnF50Q8w86is0n1b
         Oqfw==
X-Gm-Message-State: AOAM5317LLUP2cXp+CKtFOQLNVzgp+tYs1knkWbZ9mHO+o1itFWB4P5+
        RugkvIwxioz8mOhgEaGro+nH87YTVUAHQPXnOI0qPg==
X-Google-Smtp-Source: ABdhPJwsMKReGJkSMoU5EdcXP0xfost4pwHuMRaNjiVzzTDVT0QcZxGnJVoMKg98RsIl5DgeA1v1zT2z+zaB+OwR6SY=
X-Received: by 2002:a2e:984a:: with SMTP id e10mr217001ljj.179.1611250846925;
 Thu, 21 Jan 2021 09:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20210121163943.9889-1-vincenzo.frascino@arm.com> <20210121163943.9889-7-vincenzo.frascino@arm.com>
In-Reply-To: <20210121163943.9889-7-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:40:35 +0100
Message-ID: <CAAeHK+yaFtXUDVExoyqkYysOPdxLVhfY53nb-msFYEJLZx6k8Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] kasan: Forbid kunit tests when async mode is enabled
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:40 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Architectures supported by KASAN_HW_TAGS can provide a sync or async
> mode of execution. KASAN KUNIT tests can be executed only when sync
> mode is enabled.
>
> Forbid the execution of the KASAN KUNIT tests when async mode is
> enabled.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/test_kasan.c | 5 +++++
>  mm/kasan/kasan.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 7285dcf9fcc1..1306f707b4fe 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -52,6 +52,11 @@ static int kasan_test_init(struct kunit *test)
>                 return -1;
>         }
>
> +       if (!hw_is_mode_sync()) {
> +               kunit_err(test, "can't run KASAN tests in async mode");
> +               return -1;
> +       }

I'd rather implement this check at the KASAN level, than in arm64
code. Just the way kasan_stack_collection_enabled() is implemented.

Feel free to drop this change and the previous patch, I'll implement
this myself later.

> +
>         multishot = kasan_save_enable_multi_shot();
>         hw_set_tagging_report_once(false);
>         return 0;
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3923d9744105..3464113042ab 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -296,6 +296,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()               arch_enable_tagging_sync()
>  #define hw_enable_tagging_async()              arch_enable_tagging_async()
> +#define hw_is_mode_sync()                      arch_is_mode_sync()
>  #define hw_init_tags(max_tag)                  arch_init_tags(max_tag)
>  #define hw_set_tagging_report_once(state)      arch_set_tagging_report_once(state)
>  #define hw_get_random_tag()                    arch_get_random_tag()
> @@ -306,6 +307,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()
>  #define hw_enable_tagging_async()
> +#define hw_is_mode_sync()
>  #define hw_set_tagging_report_once(state)
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
> --
> 2.30.0
>
