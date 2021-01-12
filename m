Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF82F3FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394995AbhALW6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbhALW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:58:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB11C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c22so152573pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxAkmwxb7Jch7hX628XbmNuyb4EGPA1xgS4DeA/319Y=;
        b=tDKDcAzEz3WwPCPNt+v2uC1jxdjv1rjACWYnbcW/j4vI53KSQedBcrzf7CCTxI0ZNr
         rQHLsbW+FAkWXXFeYGFLcmXQudU6y2IjfVFIjEZixvakTqlgdJ3qLPVkxKvhxezCCUQR
         KE5jsp2MKpPP34PAfwnb+qUORuaOgCybjUgHY9d+huEI4ewd9tdgfyhuMYndK+2LrJGl
         UEbXwlyPbxMhGWloVzIiqQuF7l6n+DoY33qD08zFuRkHobxzt2E5BcKqzxsCVRWKQY04
         kjIUz8xWusENmoLAhZCRRsyWxKcprczfruIIxiCpnq66yzy/0Nm4eCATR+QbvjHPZ66l
         xppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxAkmwxb7Jch7hX628XbmNuyb4EGPA1xgS4DeA/319Y=;
        b=QPqwHWHJJI6dqPU0RhznSQVeKy6f0TweM6ivvgVBYTNXTm5Sgp5dxBtmAFHmxUn1Hw
         eEZZCJ8wqhzyzB6yISOdFpx21Ic62V2e2urOs5SBL88FDIHE8cOYwIfv31L7d86/9vKz
         WhxX7107s1pzr5e4aK/Nttlfrd7XXaCvy453MrrJ0TwXfSNzUE9qRXex+m/PcXkJu//h
         pfQRWupK3kf+Z8eQyx2+kWgxtvTAj0Y56f8EzeX0BEXHkllYa+EXTn7XflpOixDT7inV
         tMs7ZxySxUBK+bppdFDf8kleDAiHjWTINuB5XHa9qWEqvPNpZAf4PHWDUA+hQHQ6qsCc
         vR0w==
X-Gm-Message-State: AOAM532mhCVa5QNQXYKJTMMvjsIEEXLz+fi+DqfoQ8ElVIZFUWnMR3BL
        ZdLZsoZ4nvlurmR/tNvapvc/NiLq+wNZR/pX0u601g==
X-Google-Smtp-Source: ABdhPJxvcMtLEVRqyGAHW9W3PmBTdROOaH6OH2mll2Mf5jRH5krZTGTd8yLR5VUbJ3F0IWTkTYYE3ZFgytGGRr4bNC0=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr1348109pfy.15.1610492290506; Tue, 12
 Jan 2021 14:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org>
In-Reply-To: <20210112224832.10980-1-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jan 2021 14:57:58 -0800
Message-ID: <CAKwvOd=U1bpjbCeTjB_P+F3BYPD6THricJ5fpfjF9CgNRvJFMg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:48 PM Will Deacon <will@kernel.org> wrote:
>
> GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
> beyond the stack pointer, resulting in memory corruption if an interrupt
> is taken after the stack pointer has been adjusted but before the
> reference has been executed. This leads to subtle, infrequent data
> corruption such as the EXT4 problems reported by Russell King at the
> link below.
>
> Life is too short for buggy compilers, so raise the minimum GCC version
> required by arm64 to 5.1.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Link: https://lore.kernel.org/r/20210105154726.GD1551@shell.armlinux.org.uk
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler-gcc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 74c6c0486eed..555ab0fddbef 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -13,6 +13,12 @@
>  /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
>  #if GCC_VERSION < 40900
>  # error Sorry, your version of GCC is too old - please use 4.9 or newer.
> +#elif defined(CONFIG_ARM64) && GCC_VERSION < 50100
> +/*
> + * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
> + * https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
> + */
> +# error Sorry, your version of GCC is too old - please use 5.1 or newer.
>  #endif
>
>  /*
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>


-- 
Thanks,
~Nick Desaulniers
