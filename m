Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D92F84FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbhAOTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbhAOTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:00:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12EC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:59:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b3so6075781pft.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mshc83SuDBHE0gmn74N7RVlZXLCk81hGs63s6jVC/4c=;
        b=P4vaNsmj8rn3xPZ225h/E7uqHWdcoyTzLSCWq2NAjIgPr3UksXGHhYRjHKBt/YEkvz
         +dFobldsqXdtOXyi3Oh4NqrMbgkiDhS8bF1qME05vi9lk6cwWAqGuqQT3X7ygil92BGf
         /0pwvla65I3DQHqaUUvoSoAAMMBrg66f/vmhg137zCjUrakSpSlw76bEsaCW6NFOmcHI
         aWJEeMo0L+5DG8GRHZRBuMwF69g9MSWU7kps6x+EATniISrNUsv6N4uChEEXQgrjlm60
         oFtyvE4BBe6OQeu//mERXEYN9mIZ0s19TgJPLVOl/bHN4pQz7wpfaGOWewYeJTEgUJYb
         FgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mshc83SuDBHE0gmn74N7RVlZXLCk81hGs63s6jVC/4c=;
        b=l5dnVW4LPe/grKg/46N2pe7Q4GeoMHRkGF2g1X5xB1G4i1p7dg3FdOUC2PVXZgzAQu
         jNZYSF9RrIBoEN8jAW5kgPPBFmMsd9zDPJoeuIPvN4YPk5O5nUFdsK08IZe0x87mlSFS
         wuTdlpnhWt5AblYO0xAscKaN9kK5qtNVKggHNjBrEMqkSj2SZIScnjJgh+8l1YQHrDnr
         KQ4YyakO0iiqJ7Bs5m7aKdethiKdkJvq8xcLpnRd0YucNPpbHg1OG2jB6OV79n/F73KA
         xd8vXY6+A1NIYZLmA8UkYikqRHdZZCmY5nPi0/hzoAnO7iabXz1tc7gAo+OeDjKCAw1y
         4UMQ==
X-Gm-Message-State: AOAM532MYr79nhzenpAVN/5/qXHc8x/YxJ+tFAXaO14tY/ouKr5kzIO/
        Y5SuuBgmU+PYYrIcTgT9HSlxhu8Qau0a4k5KWm44ug==
X-Google-Smtp-Source: ABdhPJwM5gZpWoXV/Z3NrJomVWzxm9pK0f0JpH0bM6cpvD5czDDpnCT+jtN+GTZXd2XwC9K51uZVx6zeoMki3YGm8kk=
X-Received: by 2002:a65:430b:: with SMTP id j11mr13654991pgq.130.1610737165149;
 Fri, 15 Jan 2021 10:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20210115120043.50023-1-vincenzo.frascino@arm.com> <20210115120043.50023-2-vincenzo.frascino@arm.com>
In-Reply-To: <20210115120043.50023-2-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 19:59:14 +0100
Message-ID: <CAAeHK+xt4MWuxAxx_5nJNvC5_d7tvZDqPaA19bV0GNXsAzYfOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
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

On Fri, Jan 15, 2021 at 1:00 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Architectures supported by KASAN HW can provide a light mode of
> execution. On an MTE enabled arm64 hw for example this can be identified
> with the asynch mode of execution.
> In this mode, if a tag check fault occurs, the TFSR_EL1 register is
> updated asynchronously. The kernel checks the corresponding bits
> periodically.
>
> KASAN requires a specific mode of execution to make use of this hw feature.
>
> Add KASAN HW light execution mode.
>
> Note: This patch adds the KASAN_ARG_MODE_LIGHT config option and the
> "light" kernel command line option to enable the described feature.
> This patch introduces the kasan_def.h header to make easier to propagate
> the relevant enumerations to the architectural code.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    |  2 +-
>  arch/arm64/include/asm/mte-kasan.h |  5 +++--
>  arch/arm64/kernel/mte.c            |  2 +-
>  include/linux/kasan.h              |  1 +
>  include/linux/kasan_def.h          | 10 ++++++++++
>  mm/kasan/hw_tags.c                 | 19 ++++++++++++++++++-
>  mm/kasan/kasan.h                   |  2 +-
>  7 files changed, 35 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/kasan_def.h
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 18fce223b67b..3a7c5beb7096 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -231,7 +231,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  }
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define arch_enable_tagging()                  mte_enable_kernel()
> +#define arch_enable_tagging(mode)              mte_enable_kernel(mode)
>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>  #define arch_get_random_tag()                  mte_get_random_tag()
>  #define arch_get_mem_tag(addr)                 mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 26349a4b5e2e..5402f4c8e88d 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -9,6 +9,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/kasan_def.h>
>  #include <linux/types.h>
>
>  /*
> @@ -29,7 +30,7 @@ u8 mte_get_mem_tag(void *addr);
>  u8 mte_get_random_tag(void);
>  void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
>
> -void mte_enable_kernel(void);
> +void mte_enable_kernel(enum kasan_hw_tags_mode mode);
>  void mte_init_tags(u64 max_tag);
>
>  #else /* CONFIG_ARM64_MTE */
> @@ -52,7 +53,7 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>         return addr;
>  }
>
> -static inline void mte_enable_kernel(void)
> +static inline void mte_enable_kernel(enum kasan_hw_tags_mode mode)
>  {
>  }
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index dc9ada64feed..53a6d734e29b 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -151,7 +151,7 @@ void mte_init_tags(u64 max_tag)
>         write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>  }
>
> -void mte_enable_kernel(void)
> +void mte_enable_kernel(enum kasan_hw_tags_mode mode)
>  {
>         /* Enable MTE Sync Mode for EL1. */
>         sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5e0655fb2a6f..026031444217 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_KASAN_H
>  #define _LINUX_KASAN_H
>
> +#include <linux/kasan_def.h>
>  #include <linux/static_key.h>
>  #include <linux/types.h>
>
> diff --git a/include/linux/kasan_def.h b/include/linux/kasan_def.h
> new file mode 100644
> index 000000000000..0a55400809c9
> --- /dev/null
> +++ b/include/linux/kasan_def.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KASAN_DEF_H
> +#define _LINUX_KASAN_DEF_H
> +
> +enum kasan_hw_tags_mode {
> +       KASAN_HW_TAGS_SYNC,
> +       KASAN_HW_TAGS_ASYNC,
> +};
> +
> +#endif /* _LINUX_KASAN_DEF_H */
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 55bd6f09c70f..6c3b0742f639 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -22,6 +22,7 @@
>  enum kasan_arg_mode {
>         KASAN_ARG_MODE_DEFAULT,
>         KASAN_ARG_MODE_OFF,
> +       KASAN_ARG_MODE_LIGHT,
>         KASAN_ARG_MODE_PROD,
>         KASAN_ARG_MODE_FULL,
>  };
> @@ -60,6 +61,8 @@ static int __init early_kasan_mode(char *arg)
>
>         if (!strcmp(arg, "off"))
>                 kasan_arg_mode = KASAN_ARG_MODE_OFF;
> +       else if (!strcmp(arg, "light"))
> +               kasan_arg_mode = KASAN_ARG_MODE_LIGHT;

Hi Vincenzo,

I've just mailed the change to KASAN parameters [1] as discussed, so
we should use a standalone parameter here (kasan.trap?).

Thanks!

[1] https://lkml.org/lkml/2021/1/15/1242
