Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC429DB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgJ1X4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgJ1Xyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:54:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:54:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so662026qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yocub4/NVz4KlLozUgrX2nJOzM43s4whYSIptCsoCIk=;
        b=Q9nge9gMiLXlFZ1m5PE+nDxynqlYfzn8yzOXGoFblPig66+uzCPgMm89ild2Gb3RAK
         8r2QwjzXoZL7oJrUCzeY8MqWkUijMGsB3ZXqxHLM0seqK+CbLNlS+/AgPEKJ3qBBUbyj
         sgvXmtizeI7Vy/O2zIEczskGUuFyBahvb7wPbAbrvsMuV4Ub900PTPTim2xmOLWbpyE7
         JTaM9axhHt9kBU/5lyXe/3XwpxjfGDrTjuEBFujtRjDjjL06AF9AnraO04ZjHaJLdHlk
         7lQrRFNu5q+XoSKaKkACYNiMX39K6ZBI5uuLyHAppFumg9AJVlyqJQvfV2GHlnZ1JpET
         XynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yocub4/NVz4KlLozUgrX2nJOzM43s4whYSIptCsoCIk=;
        b=Sqh1gkloROv93c9R+WxxQs7b0t0pkjSfQID6HLNz1Xf8Beb/3jWsvY4HBOUr+Qeirw
         NnsdYFVf7VPEZtFeNdlv3xTH2dhbjBnKZEFp8jt25yqFNryv5M/Zg/IXc/qL/R2jMnDL
         3MlmlwUCyHVDk8L/8BNNWgQCwfjFHP7tOU5nd9Ix02IH8sqDPmrdHwHCG2vs7STDGgMA
         O/jp7pUobIxI2K5+LVMLLphjuIZkNzw0p4yQvO1CPHSaA0fbDk8vjIH9/tbov3VCWOOx
         sCNtXNO9Bm56Uu/nK+dp9mEuEfI6Q5KjDf5EpI1/2fxA9tQBDpt6PqoAHFeJ5GpIlwtE
         d+lQ==
X-Gm-Message-State: AOAM532PzJuPcb0gU2rZ+PRKtfUH8NwGk9xfzaceK3+VkPv9yz2WsOp5
        8xdJ5yo1Km1JtVXaA2KZH7Dy6OBN7Nyez02SCmJmgZaWKzZJdA==
X-Google-Smtp-Source: ABdhPJw265zSdXuALcCIjGUJXH/5SXILO9QwgtEBENOm2U+pi9cmySnrxqxx9XEv3TaEFBW0w/wfkzPBU7LW15RXnF4=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr617658qke.231.1603879691392;
 Wed, 28 Oct 2020 03:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl@google.com>
In-Reply-To: <155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 11:08:00 +0100
Message-ID: <CACT4Y+Z9iE2u1g9Yg=y2TPuRaYVq3TQoJ-81cYzODso_3aJcGg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/21] kasan: mark kasan_init_tags as __init
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

On Thu, Oct 22, 2020 at 3:19 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Similarly to kasan_init() mark kasan_init_tags() as __init.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

init_tags itself is not __init, but that's added in a different patch.
I've commented on that patch.


> ---
>  include/linux/kasan.h | 2 +-
>  mm/kasan/hw_tags.c    | 2 +-
>  mm/kasan/sw_tags.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 7be9fb9146ac..93d9834b7122 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
> -void kasan_init_tags(void);
> +void __init kasan_init_tags(void);
>
>  void *kasan_reset_tag(const void *addr);
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 2a38885014e3..0128062320d5 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -15,7 +15,7 @@
>
>  #include "kasan.h"
>
> -void kasan_init_tags(void)
> +void __init kasan_init_tags(void)
>  {
>         init_tags(KASAN_TAG_MAX);
>  }
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index c10863a45775..bf1422282bb5 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -35,7 +35,7 @@
>
>  static DEFINE_PER_CPU(u32, prng_state);
>
> -void kasan_init_tags(void)
> +void __init kasan_init_tags(void)
>  {
>         int cpu;
>
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl%40google.com.
