Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0C2A6BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgKDR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbgKDR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:28:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:28:32 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k7so1317273plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oobUaTCyncltoWrqEBGvrcm3OQzVhlM1as7YFTDZv1Q=;
        b=e94ed6x5FCwfZrmS8PN4dn1hnU5uLg30jw+fTQ5DvLYollVJh/Gi7Psnh6Awqglp6p
         C1moH7tNn9ZDwXNnYDpwQaOzg14pxZvZGNrge9I0uTnaCurNlIpg9+fubCfCmA2AF/DB
         x8nGAdRQ9tHjxBc0Oa/IIf/tsWuZ35HPe0pXZxqAfyYie0qxgGs2zQdUZnkHT9Rg2NSE
         c5yBrcU98xFJPgsVfYk7veyhLYxZN1WJGnCUnInsRHniArJ6Hj8f2S7iPNeKRTkYMKCi
         bvSK14kDTO10McxP9PWrQVLBN8UF6QR7Uh3npigRda3iWbXsEMA3BV2Ppyn2BaywLE13
         iZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oobUaTCyncltoWrqEBGvrcm3OQzVhlM1as7YFTDZv1Q=;
        b=Gk41GhTM53glquP1xiwDRiCAnXaXtmVSO+omRzqXC/uopT0izRU0zzX/Iv10RE+VHD
         7D9lPppg+arYnXD3fy9DcQYD6cnuUtlaBYaYWbNR1sFlF8906S7ZPvqeQIQPoixBrBHq
         1uX+/E585thte8eQTE3TWDW1x7B/aW8yv9/5olw/qa08ztBgTM8WVFz+FvdAfcXH/Dlv
         nhHIILHMYZirZOmxh7iY9fzlGGHQe4z6G4Vv2G3CLIF/SxrnQpYnaUYNHchrCB4d2arL
         S5vFUkpfwTbSvVdq+n4nREtq8ifku2U1hCOpN7rEExvE0/O9eV0cWL20k2uvE963R1EN
         B6fw==
X-Gm-Message-State: AOAM530Qgln7TNITWKboXCWrvoCev/ERJuroo3nNWHbJJH9KVn3FMSFD
        FNMTeCbkjeSCyoOzaKe+lFnq9dkUYs/CcavrYA6PgQ==
X-Google-Smtp-Source: ABdhPJyYEtdi9UuKM9WbnUpgbMBpmdvyz77A3mfCGALyCUG7WB9lrAymufDS1wjMtTAhoco0jYTN0Kkgc++q7rWYWmU=
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id
 f19-20020a170902e993b02900d641d89ca3mr31778200plb.57.1604510912336; Wed, 04
 Nov 2020 09:28:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com> <bd64e051e8e36ac25751debc071887af3d7f663f.1604333009.git.andreyknvl@google.com>
In-Reply-To: <bd64e051e8e36ac25751debc071887af3d7f663f.1604333009.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Nov 2020 18:28:21 +0100
Message-ID: <CAAeHK+z3vPpt5DXYU89Q_M1rorYEatV_yHVuGcHWWgC3UX8xmQ@mail.gmail.com>
Subject: Re: [PATCH v7 34/41] kasan, x86, s390: update undef CONFIG_KASAN
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 5:05 PM Andrey Konovalov <andreyknvl@google.com> wrote:
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
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 6d31f1b4c4d1..652decd6c4fc 100644
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
> 2.29.1.341.ge80a0c044ae-goog
>

Hi Vasily,

Could you give your ack on this patch?

The full series is here:

https://lore.kernel.org/linux-arm-kernel/cover.1604333009.git.andreyknvl@google.com/

Thanks!
