Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D802C81E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgK3KMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3KMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:12:45 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4930C2084C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606731124;
        bh=OUoOtW4lBenGi23Wz7t8BDhA9SuUIWePJByVutkXN2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yB06povjZQQt7022LVGtINtLDKdT7KyFGXk3ka8wvFUcrYh8xnQyoTy/Sf82vAuK4
         JLCk6shAh+aJVelfnOvKmA9O4FqTsGhBkKPAJVCPJoRWk4Pg+kp8xOVKN9pTNEtbfT
         y9TsehasTDOotUaaj9FIiCmocC4fnyTM5m2BSGmg=
Received: by mail-oi1-f182.google.com with SMTP id c80so13604575oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:12:04 -0800 (PST)
X-Gm-Message-State: AOAM531k/3PEf2fdVh7yxXrSWzqua+LsGUxklbRf+y94d1MqlFN0xkuH
        2/jWWfXc2twSoeLjUYepEHtJtJLsR5teRovLnJ4=
X-Google-Smtp-Source: ABdhPJyeCz2B+eaeR1po/79yPrzNZYkGlD6jbwJa0EhpzVynm1nd+4smoBxo1z+I6bxdb6BwG+a2jQ1c+GlrVzGE+FY=
X-Received: by 2002:aca:c657:: with SMTP id w84mr13797116oif.47.1606731123515;
 Mon, 30 Nov 2020 02:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com>
In-Reply-To: <20201123073634.6854-1-swpenim@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 11:11:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
Message-ID: <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Antony Yu <swpenim@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 08:39, Antony Yu <swpenim@gmail.com> wrote:
>
> __do_div64 clobbers the input register r0 in little endian system.
> According to the inline assembly document, if an input operand is
> modified, it should be tied to a output operand. This patch can
> prevent compilers from reusing r0 register after asm statements.
>
> Signed-off-by: Antony Yu <swpenim@gmail.com>
> ---
>  arch/arm/include/asm/div64.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 898e9c78a7e7..809efc51e90f 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>         asm(    __asmeq("%0", __xh)
>                 __asmeq("%1", "r2")
>                 __asmeq("%2", "r0")
> -               __asmeq("%3", "r4")
> +               __asmeq("%3", "r0")
> +               __asmeq("%4", "r4")
>                 "bl     __do_div64"
> -               : "=r" (__rem), "=r" (__res)
> +               : "=r" (__rem), "=r" (__res), "=r" (__n)
>                 : "r" (__n), "r" (__base)
>                 : "ip", "lr", "cc");
>         *n = __res;
> --
> 2.23.0
>

Agree that using r0 as an input operand only is incorrect, and not
only on Clang. The compiler might assume that r0 will retain its value
across the asm() block, which is obviously not the case.

However, your patch will likely break big-endian, since in that case,
__xh == r0, and so it will appear twice.

Perhaps it would be better to change the type of __rem to unsigned
long long as well?
