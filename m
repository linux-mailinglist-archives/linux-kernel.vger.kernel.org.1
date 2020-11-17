Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA952B6DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKQTBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKQTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:01:05 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D99C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:01:05 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so10747944pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYseXDP4i2Hhs9DKh0McOND6mIxwYGtf78PBSIeQhlo=;
        b=chs8hXLcwd8v9y7yYPXw8+lpeD8ILMsYdq9M/QbiFunuKosgKrQiGFGhM/sdSNogEy
         y5FfPEAmg+uQyaYiJjNGok+rMJ+0yycAVzRmf/9oduyoN8qTx/xfR7C2clvGuZlvrSWm
         h6uHL4U70EPBHKI/1HFJ4P1SlY8UG/T8TjZodhVXNlUmiiElibOjwtnIlTngdpxF44l4
         cCw9lczormZiwbDCu10NzFeEWNVXO6tTqdAGXJXhLoRCNJrtFD5N7lxotBuqMMngIfLn
         LSexRkOzUEp0CuuC6tJX50yWmoeveA7MmM9ViI5QqXT9mS5bDX1jjDVGsQ0Z29y3/aVj
         2q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYseXDP4i2Hhs9DKh0McOND6mIxwYGtf78PBSIeQhlo=;
        b=lOGkro0oWonmki75BIHrg17PNyd0Z7Y51xygB3vfoyBqHzANeYQMtD9+CHfX5ro23S
         k1+2hQs8vGRJa+DyTZe2B6MJ24kDTFH25njjN69IjmG9gsQ/J8lZBF5urk0XC60WODyM
         hrxcxFeWrW5pRbdJYEUfm16mLiE3WsJA+ssA6R2rAc0aLAlqv6F+zCfE7UEM3Hk3yqRz
         BPStW1Xr2e6a3L47WAryEpmgO/a+4nDRV5C5lolpgGkBC0ER5m97pzciBZg0zTaExLFI
         K6NqlZi9shkWk3l3chf55O1e0lOKJJZhoiray8SBNE7tUptvf8WjQ8Sc9NQwyxHZ3tjA
         /xXw==
X-Gm-Message-State: AOAM533tYhvhSnyN16SaCt18QqCsujyLZZc+mXHf+7y0h2HsB7USgS32
        1e1OfS5/tJbICH0cUb/DauxKMf9Ct1CtF2qG/GnzkJ3R8lSqVg==
X-Google-Smtp-Source: ABdhPJzOldRgN7SwijtAG+tyo1d3bxVSfLlQ9ioQKrAyDUF3ZWvrGjttGmCw3KlHNpWoKDPJBLlEPsGTDtV8hBGihh0=
X-Received: by 2002:a17:90a:d250:: with SMTP id o16mr449165pjw.25.1605639664820;
 Tue, 17 Nov 2020 11:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20201117013951.7827-1-rdunlap@infradead.org>
In-Reply-To: <20201117013951.7827-1-rdunlap@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Nov 2020 11:00:54 -0800
Message-ID: <CAKwvOdmESwnF14TLjRfzJg8Dau8XW0LgoDvXtdPjPOqdf211SQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: fix barrier() use in <vdso/processor.h>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 5:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> riscv's <vdso/processor.h> uses barrier() so it should
> #include <asm/barrier.h> to prevent build errors.
>
> Fixes this build error:
>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
> In file included from ./include/vdso/processor.h:10,
>                  from ./arch/riscv/include/asm/processor.h:11,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>    14 |  barrier();
>
> This happens with a total of 5 networking drivers -- they all use
> <linux/prefetch.h>.
>
> rv64 allmodconfig now builds cleanly after this patch.
>
> Fixes fallout from:
> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>
> Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")

Hi Randy,
Thanks for the patch, it looks good to me.  I only had a question on
the commit message.

Is this also related to:
commit 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")

I plan to backport 3347acc6fcd4, so it would be good if all of the
follow ups are all tagged accordingly with fixes tags, so that I don't
break anything backporting 3347acc6fcd4 because I forgot or missed any
follow ups that also needed to be backported.

> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: clang-built-linux@googlegroups.com
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/include/asm/vdso/processor.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
> +++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
> @@ -4,6 +4,8 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
> +
>  static inline void cpu_relax(void)
>  {
>  #ifdef __riscv_muldiv



-- 
Thanks,
~Nick Desaulniers
