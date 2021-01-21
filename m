Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923342FF23A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbhAURnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbhAURmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:42:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C06C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:41:20 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 3so3473235ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6niekSQOjT6sl668qL1auwEOgCZByDONjvQaO9EkZdk=;
        b=CgTgPusWLqVTdnJRaNHaIHb645mPVxSj5IEAFVf+DDphZl3ILTLi74TwQLZ8cN7yc6
         tImSPrMUB+IPHWZW5OrGDhLwGpC9dosVQs7Qr/OVFwM+H6DJcP1xuS/anPWIjLB7aA1b
         OOlRET8DE8SKv0kT5zMmYn+lBYdNzXUGOre9EJvDjc/ju5pk50hLmV5a8eUL1pQOEvHs
         oCFgPQ703sSifnEn79SyuFveVcz1pK2XiCeQZdGcRK7rL0g6Cm/QCdwe1ZLxV7zc74pq
         Y30INusD+EgR8uISbIWpUvqoTZJ1KT53N3+z59WHrgUsDLM3XKLS65m0sVejH6ngsR2n
         Kd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6niekSQOjT6sl668qL1auwEOgCZByDONjvQaO9EkZdk=;
        b=BEw4PdfrvmWKFrglDqN2lRyw66cTNhwHWDFgCraQt+xikTLh91O4+jgwXfvMHOK5ke
         XueBNTF4LJDEwHB0nRKU2QyY8rUPmeWTytDeUQwhBMctlzXNYso6NRD9EPq33d+3ouIq
         PJj+yBAjIl+k4AmCc5rJWCvGNQXVjFGfCQ4jhdZDunnG5uNLLxFdM/xcSrwGC3tF1x8O
         go9J3tHAMEyB1odkWeWzJikM+9/sQ0UEpBe0M9cb5hlmSA2PD4bXEJnqQxf8HMVb0GeX
         2Alwy+suHJKq/nlmXioeh+0JUIHnSlmSiiGbP6r9+gWxsnTI13zOdy16a6UuvI3po9kF
         Ldgw==
X-Gm-Message-State: AOAM531A/N8+z8vpi9uupcKjn1RoTG2keJk4Felm9PegOCXfT8G/ox5n
        m2GZWRasvkfjaPI9sEe3vdpaPlPzQMZV0c94+xdlNA==
X-Google-Smtp-Source: ABdhPJwptTdVF/1f6HWKlBPLspNCkz1QfZlovTMNf88Aj+DwlELob5YAs3KqaRv4wuzQJXFWb7kcskZstKKksK7ka7I=
X-Received: by 2002:a2e:b5ce:: with SMTP id g14mr200976ljn.493.1611250879144;
 Thu, 21 Jan 2021 09:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20210121163943.9889-1-vincenzo.frascino@arm.com> <20210121163943.9889-6-vincenzo.frascino@arm.com>
In-Reply-To: <20210121163943.9889-6-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:41:07 +0100
Message-ID: <CAAeHK+y9Je7nwRAJ+t5Yw0d3Bmrrn-mhqdw4uqLMSdHaRjZm1A@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] arm64: mte: Expose execution mode
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
> MTE enabled arm64 HW can be configured in synchronous or asynchronous
> tagging mode of execution.
> In synchronous mode, an exception is triggered if a tag check fault
> occurs.
> In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register
> is updated asynchronously. The kernel checks the corresponding bits
> periodically.
>
> Introduce an API that exposes the mode of execution to the kernel.
>
> Note: This API will be used by KASAN KUNIT tests to forbid the execution
> when async mode is enable.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    | 1 +
>  arch/arm64/include/asm/mte-kasan.h | 6 ++++++
>  arch/arm64/kernel/mte.c            | 8 ++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index df96b9c10b81..1d4eef519fa6 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -233,6 +233,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define arch_enable_tagging_sync()             mte_enable_kernel_sync()
>  #define arch_enable_tagging_async()            mte_enable_kernel_async()
> +#define arch_is_mode_sync()                    mte_is_mode_sync()
>  #define arch_set_tagging_report_once(state)    mte_set_report_once(state)
>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>  #define arch_get_random_tag()                  mte_get_random_tag()
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 76b6a5988ce5..c216160e805c 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -31,6 +31,7 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
>
>  void mte_enable_kernel_sync(void);
>  void mte_enable_kernel_async(void);
> +bool mte_is_mode_sync(void);
>  void mte_init_tags(u64 max_tag);
>
>  void mte_set_report_once(bool state);
> @@ -64,6 +65,11 @@ static inline void mte_enable_kernel_sync(void)
>  {
>  }
>
> +static inline bool mte_is_mode_sync(void)
> +{
> +       return false;
> +}
> +
>  static inline void mte_init_tags(u64 max_tag)
>  {
>  }
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 7763ac1f2917..1cc3fc173b97 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -26,6 +26,7 @@
>  u64 gcr_kernel_excl __ro_after_init;
>
>  static bool report_fault_once = true;
> +static bool __mte_mode_sync = true;
>
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
> @@ -169,9 +170,16 @@ void mte_enable_kernel_sync(void)
>
>  void mte_enable_kernel_async(void)
>  {
> +       __mte_mode_sync = false;
> +
>         __mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
>  }
>
> +bool mte_is_mode_sync(void)
> +{
> +       return __mte_mode_sync;
> +}
> +
>  void mte_set_report_once(bool state)
>  {
>         WRITE_ONCE(report_fault_once, state);
> --
> 2.30.0
>

(See my comment on patch #6.)
