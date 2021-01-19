Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5602FBF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390660AbhASS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392477AbhASSLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:11:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC4C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c22so13403212pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnrMrldg8mnofkcXZdxW4LOH+ARI4N3c8/lAl3ZaiEY=;
        b=RPraS7hBjtDF5mjOrr31U578ApkT7gS9aiXusTgV38Ob1+0f93nRNc7k7Xw1C2CeFr
         iT7ATpakwjX6PTW0DrcOoQzw7lUesfpiQFz1yDh/9MzPzjYfu40ARdud6PAj7qpRUg3Y
         F79A7o8f8nlwfHKnIfM5KVD+Txue/rBjNXo3CXnA8ndH6Ulvvp3E7vocGL3d5H+CrFLN
         lh5cThCgF3Uv1YsAREldRqM5yDlU3lhv12dG4kTBR0ajETsSnFUxbdAp/0kzgHQufn78
         JXyNl3vli3OeGS9KUEjvWOXabzPAyFcXdX4Gyn1/lBFvUFg0NR+hTOiw/c/GBUK0z6+A
         5m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnrMrldg8mnofkcXZdxW4LOH+ARI4N3c8/lAl3ZaiEY=;
        b=MfhLCqyW7742RVm00rF6zlnuiaCxR5APfM5vpJKOYYTcL24bPiC5bwVbKTI+PICRL/
         wrbhroGv2JhH0VTmaIVZM5xpYCd0z3qAT6f5ViK9OzSybAnE3uPPqZu8orBciOrBEwiG
         jH7BtJFPrImC1Eiz2RlMvjLFCVt75dbyMRSeDf3BQIq8Er22AGIF08K7vFSQ9POYkrO1
         g+6Tlf5TmplbWsogzrr8HMv9EaBmikOu2azyZraShM4XUeNhS9sRtQAde2UHFVRroZTx
         7SAD7HNC6dsUKDtjTY8GDXcuW9Gqv8X89udBgFn4V0y9CKm1l6TAksv84gU/SJYoEhtH
         w1JA==
X-Gm-Message-State: AOAM5331DvsCUQjL8MrjjsHlHt5uYhRN54hbchLTy3t6A7P7ArhpknIz
        RQSXGUczLJgqY4eXaEeu+4qE/cuCpd3HCu75K08NwA==
X-Google-Smtp-Source: ABdhPJz5O/8nG+xL9+eq/liJkYZ+QzJv2tw9EKHY/+vtnzG86Csmxf5bp5m/DtFwVIvXR43zHErnLlf19fNsJ58FHY4=
X-Received: by 2002:aa7:8597:0:b029:1b9:38bd:d0dc with SMTP id
 w23-20020aa785970000b02901b938bdd0dcmr5074425pfn.24.1611079822481; Tue, 19
 Jan 2021 10:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com> <20210118183033.41764-2-vincenzo.frascino@arm.com>
In-Reply-To: <20210118183033.41764-2-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:10:11 +0100
Message-ID: <CAAeHK+xMk=7pkOi2UtYZzxOhrnVRe+CYcyjBBHKUW3jmfg64Ww@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: mte: Add asynchronous mode support
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

On Mon, Jan 18, 2021 at 7:30 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> MTE provides an asynchronous mode for detecting tag exceptions. In
> particular instead of triggering a fault the arm64 core updates a
> register which is checked by the kernel after the asynchronous tag
> check fault has occurred.
>
> Add support for MTE asynchronous mode.
>
> The exception handling mechanism will be added with a future patch.
>
> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
> The default mode is set to synchronous.
> The code that verifies the status of TFSR_EL1 will be added with a
> future patch.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    |  3 ++-
>  arch/arm64/include/asm/mte-kasan.h |  9 +++++++--
>  arch/arm64/kernel/mte.c            | 16 ++++++++++++++--
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 18fce223b67b..233d9feec45c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -231,7 +231,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  }
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define arch_enable_tagging()                  mte_enable_kernel()
> +#define arch_enable_tagging_sync()             mte_enable_kernel_sync()
> +#define arch_enable_tagging_async()            mte_enable_kernel_async()
>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>  #define arch_get_random_tag()                  mte_get_random_tag()
>  #define arch_get_mem_tag(addr)                 mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 26349a4b5e2e..9a5e30dbe12a 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -29,7 +29,8 @@ u8 mte_get_mem_tag(void *addr);
>  u8 mte_get_random_tag(void);
>  void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
>
> -void mte_enable_kernel(void);
> +void mte_enable_kernel_sync(void);
> +void mte_enable_kernel_async(void);
>  void mte_init_tags(u64 max_tag);
>
>  #else /* CONFIG_ARM64_MTE */
> @@ -52,7 +53,11 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>         return addr;
>  }
>
> -static inline void mte_enable_kernel(void)
> +static inline void mte_enable_kernel_sync(void)
> +{
> +}
> +
> +static inline void mte_enable_kernel_sync(void)
>  {
>  }
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index dc9ada64feed..78fc079a3b1e 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -151,11 +151,23 @@ void mte_init_tags(u64 max_tag)
>         write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>  }
>
> -void mte_enable_kernel(void)
> +static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>  {
>         /* Enable MTE Sync Mode for EL1. */
> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, tcf);
>         isb();
> +
> +       pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
> +}
> +
> +void mte_enable_kernel_sync(void)
> +{
> +       __mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
> +}
> +
> +void mte_enable_kernel_async(void)
> +{
> +       __mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
>  }
>
>  static void update_sctlr_el1_tcf0(u64 tcf0)
> --
> 2.30.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
