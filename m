Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FA2A0890
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgJ3O4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3O4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:56:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB393C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:45:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i18so1035308ots.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/l7OXXa9UuvkPT+n4O4t3Y5d8yYC198Ym1kgNFK1uSc=;
        b=ZFm0kFcro+V05IMdtsrtx/vo9o8fF+HtuBLxfxPZS6T904N++atZAPBiHQmeaSmSdh
         Jdaqu/oB4bN4JqHAhWjey+0PJhXGaS5ER6ZRf+3w6fn3UW6ymuFqnKjiblQUPu9TEdwi
         BOfNy2FAuKBkFObkVK5x3oL2D9BTCsoUz80Qtq/Bb4ZS00ogo5uGkIBMX5w/gVgXPURQ
         DlJ4PyqwVXVLZLubA045vnqlNPp8xUpt6jzc38HUKFHw+f9vQq59yyJOiQ8+TtoBgGhA
         rv0aJzyf+2zyBHjNx2haGi5H3e2E3CIhNudK7Yoa4dA491JK61IpshPU3ILNGZtxUm+G
         kSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/l7OXXa9UuvkPT+n4O4t3Y5d8yYC198Ym1kgNFK1uSc=;
        b=KDBRNbtabv/JpAHUVrigG8eOdJ64n2ygv+kuDnl5gLI2gNRmf9NwoPbNQluz5JUYm0
         nWHhMmlIw6oyetHpgNJ3Mu/1gYd5Us1MH/sdnUSw4gVZmt10keUpI4DkafLM/a1NYK/H
         C9hl4ToS1qSs4aGiGHVz9F1GFXUeTEIH1XVmeFJuAsnMZjuORlNu3JLZBWCEYYZ3cOfL
         H4M6qUBBLZif/a00kWA841oT57mtjK4BeDp06Q9HeJs0YK+QUZUTNM7hIDDtofXncbFZ
         q4goJrPmn2fNps4NzvAv5aGak51nWfRoMdvgkDT6slNw/iP8Bv+wN+CrKh5540X/b2eL
         +h7w==
X-Gm-Message-State: AOAM533wNN2q88NTcUm/s83cOoEnSU7Xs+WxxVeLVX03tbv9dt1qMff7
        rtqn1vG3efLSxWvs68cCvNmFRQMFrUGiilavbBnN1Q==
X-Google-Smtp-Source: ABdhPJxY15nYWXTiFbl1s/chME9yMWamqIVsOT48t27QyzLn4hhUUMlSCrFnyzg36C8tpxklYueWZCrZRlYZRKJjNz0=
X-Received: by 2002:a9d:649:: with SMTP id 67mr1983160otn.233.1604069137790;
 Fri, 30 Oct 2020 07:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
In-Reply-To: <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 15:45:26 +0100
Message-ID: <CANpmjNPxUwrwAjN_c5sfBx5uE+Qf70B=8dbFcYPF2z1hWfpATg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 14/21] kasan: add and integrate kasan boot parameters
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 15:19, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> TODO: no meaningful description here yet, please see the cover letter
>       for this RFC series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
> ---
>  mm/kasan/common.c  |  92 +++++++++++++-----------
>  mm/kasan/generic.c |   5 ++
>  mm/kasan/hw_tags.c | 169 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h   |   9 +++
>  mm/kasan/report.c  |  14 +++-
>  mm/kasan/sw_tags.c |   5 ++
>  6 files changed, 250 insertions(+), 44 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1a5e6c279a72..cc129ef62ab1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -129,35 +129,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         unsigned int redzone_size;
>         int redzone_adjust;
>
> -       /* Add alloc meta. */
> -       cache->kasan_info.alloc_meta_offset = *size;
> -       *size += sizeof(struct kasan_alloc_meta);
> -
> -       /* Add free meta. */
> -       if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> -           (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> -            cache->object_size < sizeof(struct kasan_free_meta))) {
> -               cache->kasan_info.free_meta_offset = *size;
> -               *size += sizeof(struct kasan_free_meta);
> -       }
> -
> -       redzone_size = optimal_redzone(cache->object_size);
> -       redzone_adjust = redzone_size - (*size - cache->object_size);
> -       if (redzone_adjust > 0)
> -               *size += redzone_adjust;
> -
> -       *size = min_t(unsigned int, KMALLOC_MAX_SIZE,
> -                       max(*size, cache->object_size + redzone_size));
> +       if (static_branch_unlikely(&kasan_stack)) {

I just looked at this file in your Github repo, and noticed that this
could just be

if (!static_branch_unlikely(&kasan_stack))
    return;

since the if-block ends at the function. That might hopefully make the
diff a bit smaller.

Thanks,
-- Marco
