Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341FE2B4210
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgKPLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgKPLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:02:12 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E052C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:02:12 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so12534207qtj.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCo6s0/nkYmCiNM2lfhtKvRgQtlMOZhZ3Qm9cvd64Ns=;
        b=lNCRW+LNnYPOTpjevlte99nCLT2HMxsgx6b9KCNPN1i7t/jyjkxlKwSMJs3N2L5wTd
         ynAGz/3jyrYBHX2xrO4+WpF8g6na67LjGc6LKCuuQPkwd4b66UxvPdWp3TiIVtq80U5F
         zWiNN2SdF/8hOpiwPDfJArEGqn9A84+tYQLpHN/BYNiJ6EFirgALBrjqhht6qMM0wM/Z
         GS0ywEZs3i6JMltN+3hS/j6IWE3l/WnKvsQo60YJCInQSdogsUhsBXqG94UMnfF1MY5g
         qbpc/C02zUF+/H9BFmcb61r210ZHRxQbUVYiDpfexiNaWOHDaDomLOy8XsJpbMc1ANo9
         +inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCo6s0/nkYmCiNM2lfhtKvRgQtlMOZhZ3Qm9cvd64Ns=;
        b=SZekuRqdrS7zdYEkHYg1BhOEX7yCaR0Y8Zi4RQecLTZwuNANqkWiVL4j39XhQ8is/T
         aCQeLeONIQvBB+PWnKILVtXFmJs4y6Y7Zj9U8kWs5YqjtnS+FR4dBq1zSt6mWB8cT41s
         u7RyAfdj5evZhOGi3EaUZlwEUDe5oPNxHy4Rs6kmwXcrRkvnCmZJmhZlnyaWPt0waPE9
         O36AUfA0PNMuJrtkZt2wYvrNiYHBla0vmyo2kbs1sYAgol0NbcD8P54sjGqUIyUlJgY3
         HIwHVp+5sfQNJlarrpj/+99g3csWwIhWgkVuAO/sdHTVNpG1MJfUjq3cz8o+tVfZsuIk
         zAiA==
X-Gm-Message-State: AOAM531f+L/3N1y3BHzMlX5uCz2E+n9JvhKB4Q35W0zMiW+4c5fGWF/D
        szpi5dyp2tjIatplIlRp+4c/oJ4/hNxc5mM/2803Mg==
X-Google-Smtp-Source: ABdhPJylpRqoKHtntW8fFWc1VJ/EQduNKuCqw1hVdAm2eojeSLqU2wxALt8OoDfygEbNvYO11xXxOHSiK338yJA3LU8=
X-Received: by 2002:aed:2744:: with SMTP id n62mr13892523qtd.67.1605524531286;
 Mon, 16 Nov 2020 03:02:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <89bf275f233121fc0ad695693a072872d4deda5d.1605305978.git.andreyknvl@google.com>
In-Reply-To: <89bf275f233121fc0ad695693a072872d4deda5d.1605305978.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Nov 2020 12:01:59 +0100
Message-ID: <CACT4Y+Y+5g24oAMDL7SKESXO6p6tW=OrC9Y8S1=Lhs6DwAkuUA@mail.gmail.com>
Subject: Re: [PATCH mm v3 05/19] kasan: allow VMAP_STACK for HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Even though hardware tag-based mode currently doesn't support checking
> vmalloc allocations, it doesn't use shadow memory and works with
> VMAP_STACK as is. Change VMAP_STACK definition accordingly.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> ---
>  arch/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9ebdab3d0ca2..546869c3269d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -921,16 +921,16 @@ config VMAP_STACK
>         default y
>         bool "Use a virtually-mapped stack"
>         depends on HAVE_ARCH_VMAP_STACK
> -       depends on !KASAN || KASAN_VMALLOC
> +       depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
>         help
>           Enable this if you want the use virtually-mapped kernel stacks
>           with guard pages.  This causes kernel stack overflows to be
>           caught immediately rather than causing difficult-to-diagnose
>           corruption.
>
> -         To use this with KASAN, the architecture must support backing
> -         virtual mappings with real shadow memory, and KASAN_VMALLOC must
> -         be enabled.
> +         To use this with software KASAN modes, the architecture must support
> +         backing virtual mappings with real shadow memory, and KASAN_VMALLOC
> +         must be enabled.
>
>  config ARCH_OPTIONAL_KERNEL_RWX
>         def_bool n
> --
> 2.29.2.299.gdc1121823c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/89bf275f233121fc0ad695693a072872d4deda5d.1605305978.git.andreyknvl%40google.com.
