Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351053005EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbhAVOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbhAVOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:47:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:46:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kx7so3797538pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1AbIZrJERg8kpP9b2k7FTBNRitSl0TDoTbXm4ZySsk=;
        b=rpdT9oqcosb6A0f/AHspYPylqTLN9xsaGoioXlQCOaowJIvqbT1m4Nu/Xu7Br+6LuK
         0lflK7FzE1pPlyLGtsC7nFAlqiSYWE/3Wt/a3GHnZcnE+UO300CcMMl1Whw2PR/24xFB
         4yPPMyADS9/tPPx/McZ/u/gRF2wVOd3IIWdZH5zdPj30nysCNR27+ResbENic8F/ypGr
         EAQR7SvNUfmtFbpsoZNRBcSoqpvV0TdDK/XG45HKX4qPygkvQFPwRl3qKSB12hFPZ3n8
         tFUX9NHmQ53EmTA5y2+1ZAyQAnF04TclP9NE2xnS3q3FhFPxC3VVvVpbsEVN6hyn9aAz
         qORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1AbIZrJERg8kpP9b2k7FTBNRitSl0TDoTbXm4ZySsk=;
        b=TcXUACRwbNOHe9NKBZ7w3n9JyrJIp8vtAKRd1QVJrZToxijp1VH1VS/TdZOUSjtF2u
         isFsSAKxPU+hnwklockpV/O3HbrEQioV0/23VhztLrHcM2TKj9zXR7VA+4aC42Xzjrqf
         nOsOdybZevveO85uT8xIkANVyNOVnyDjoUinYTw29B687RvyTbPKeJH92axKgPrtWsSe
         U8yLvd/7V5hYXeZyMCUNEMiU0gxb7/xLcLQeBQSmThEFagD1s3GX2moCEgf6naD9Q3Ye
         PipdEutOT979dMrPP8mxnaB99iQ11SqbyBWAo/KQJgvXExrVHqj0fXwRYnQjsVo1IrCw
         KT8A==
X-Gm-Message-State: AOAM531mqJJ9lgV9HI42K+72+0zeMafyeFqxF4Gakblg0L41RwqXznyk
        yNH2clOpgPoFa1RpRXNmr8rpiZ4N2cNLl82JjPmLpg==
X-Google-Smtp-Source: ABdhPJzAkNme0Ln/dfT80F+KxHP9wbD5M2iWDo1O1wJQDetyIzu1vqcr/qB/WRL2sRiRaoATMkvNkYdzRT0gNx91jJM=
X-Received: by 2002:a17:90a:ce10:: with SMTP id f16mr5863900pju.136.1611326808923;
 Fri, 22 Jan 2021 06:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20210122143748.50089-1-vincenzo.frascino@arm.com> <20210122143748.50089-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210122143748.50089-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 15:46:37 +0100
Message-ID: <CAAeHK+yyJia6zOCMpy6ZJDX-Brvr_s88gZ6HwG2TxfLgtw=SSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
> the address passed as a parameter.

It doesn't dereference the address, it accesses the metadata. And only
when addr_has_metadata() succeeds.

>
> Add a comment to make sure that the preconditions to the function are
> explicitly clarified.
>
> Note: An invalid address (e.g. NULL) passed to the function when,
> KASAN_HW_TAGS is enabled, leads to a kernel panic.

This is no longer true, right? Commit description needs to be updated.

>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h | 7 +++++++
>  mm/kasan/kasan.h      | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index fe1ae73ff8b5..0aea9e2a2a01 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -333,6 +333,13 @@ static inline void *kasan_reset_tag(const void *addr)
>         return (void *)arch_kasan_reset_tag(addr);
>  }
>
> +/**
> + * kasan_report - print a report about a bad memory access detected by KASAN
> + * @addr: address of the bad access
> + * @size: size of the bad access
> + * @is_write: whether the bad access is a write or a read
> + * @ip: instruction pointer for the accessibility check or the bad access itself
> + */

Looks good, thanks!

>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc4d9e1d49b1..8c706e7652f2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -209,7 +209,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>
>  static inline bool addr_has_metadata(const void *addr)
>  {
> -       return true;
> +       return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>  }

Let's put this change into a separate patch.

>
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> --
> 2.30.0
>
