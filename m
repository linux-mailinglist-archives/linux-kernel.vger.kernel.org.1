Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227E42F40AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393639AbhAMAnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392167AbhAMAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:06:39 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6557C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:05:58 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e22so548335iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdoZ7GoxSEbYVJ01iieMFNr9Ola9MkWTkjbqFK+imx4=;
        b=FVXB+hPoAGRsLiIkV1mLKDp/ZE7NwN9mdWugmqLvJFo6KwNxdVT6Lm478ve/q6lBav
         7YFSl9NA0I1lI5zIZsyxf5FsPAYp/w9Kwm4EApZ5KoyyxbqLCXdsbn7Una8bL6X3CoH3
         m63qUCTbpZE4hWjmJELh0c/OQSxwRL6wzDsu4qQyFmc/O2dvQddps9K1BT+mRZUvIfad
         oEhK4R4oallUniAmGrZ7R6HCxHzf8rLqnbfCweHTiPtTzSiyua54u02TAeFaKl6NlXxI
         Pw394FIlKDDFu4UsO6SkRN2jnEasEF4Mh+gcvtgxgokDjwvDcTNajte5dbVByRNTp/Dq
         iM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdoZ7GoxSEbYVJ01iieMFNr9Ola9MkWTkjbqFK+imx4=;
        b=c7w+ZCXXTXL+3la00Cc0p2RD2sqgFbcIJ/ehWbpmtuVWNHFCme6jiURVN43YwuE2Nz
         zbyyh4Q743MbtA4iqItf/aaoVe3uRGwkNqwcX20OQGpBAHkdIY/5rbqg011wdS4VnPxH
         /tp05FI1W0DmVrqL7X+IXzRiN8Mc48oEUi0nHMGxBrYVLFxprBybJTMFnD4oWik2Z0rJ
         hXxjXSWxuhSp23IN26YHkiBLJzC+e4xxM/qWfLtsUU8sR0Gvp4Emaar/Y1o83QIwh+4A
         Ua6VepvABWrqg1iRvGWq22mhJuwCFZnuEnxgqsnP7k9mfwVPoI2oBc4mep0G2yTIzqgJ
         QuIQ==
X-Gm-Message-State: AOAM530uD0kcwHRzLfgucpit2SSAIOTZkLJGpi+p3lMy793TpJdbx8h0
        CxzcojlHx/kLVUL8NBBzTJM=
X-Google-Smtp-Source: ABdhPJyWpwQHUseTzdlx98/qI24/ANeVWpG1aePKTMPgPved7LjcCpg02Bo6DmE46E69OlyEvgVdEw==
X-Received: by 2002:a5e:9b1a:: with SMTP id j26mr1345463iok.124.1610496358109;
        Tue, 12 Jan 2021 16:05:58 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id e1sm227666iod.17.2021.01.12.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 16:05:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 17:05:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] ubsan: disable unsigned-overflow check for i386
Message-ID: <20210113000555.GA1584947@ubuntu-m3-large-x86>
References: <20210112202922.2454435-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112202922.2454435-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:29:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building ubsan kernels even for compile-testing introduced these
> warnings in my randconfig environment:
> 
> crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> static void blake2b_compress(struct blake2b_state *S,
> crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> 
> Further testing showed that this is caused by
> -fsanitize=unsigned-integer-overflow, but is isolated to the 32-bit
> x86 architecture.
> 
> The one in blake2b immediately overflows the 8KB stack area architectures,
> so better ensure this never happens by disabling the option for 32-bit
> x86.
> 
> Fixes: d0a3ac549f38 ("ubsan: enable for all*config builds")
> Link: https://lore.kernel.org/lkml/20201230154749.746641-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> v2: only turn it off for i386 as discussed
> ---
>  lib/Kconfig.ubsan | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 8b635fd75fe4..3a0b1c930733 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -123,6 +123,7 @@ config UBSAN_SIGNED_OVERFLOW
>  config UBSAN_UNSIGNED_OVERFLOW
>  	bool "Perform checking for unsigned arithmetic overflow"
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> +	depends on !X86_32 # avoid excessive stack usage on x86-32/clang
>  	help
>  	  This option enables -fsanitize=unsigned-integer-overflow which checks
>  	  for overflow of any arithmetic operations with unsigned integers. This
> -- 
> 2.29.2
> 
