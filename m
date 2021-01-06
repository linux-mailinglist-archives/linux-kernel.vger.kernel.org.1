Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758252EC5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAFV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbhAFV56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:57:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 13:57:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so2236939plp.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 13:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WOP/JQcRWppeMUbSb8zNlIsrDTGlMJqIRNx0QEh8i0o=;
        b=FSKh9c3s51wOpqj3W1aMxGdVDrs0sbkZ08Kqj9GjFYgi0wMdQolD8/4ogtdmhiwFZv
         gF5jFRcDoiJRdRkDesyUbrFruI99qDzRTKVwXTh1noJK5ef/DBnggSDr4bS+uc7sQj1A
         yu6dxK47GlIrkTD4s3L56DfKqYh0NxH+SY1qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOP/JQcRWppeMUbSb8zNlIsrDTGlMJqIRNx0QEh8i0o=;
        b=gCxKpiIsfq+DistztCOagnJnCYmWY/STZPgl3P/6pUnwkbx8FyvtxYSzJhUNjZu5IF
         hTFzGVYawXbw3SDiizV/fhzR8F7Za1aLN2CAIsFhwPWGpk5kWxhZshCVO+b9RegKVf9l
         pJJdowRH1WcF71SwXUiFtlz5fPmMqnROyuFMvEiFYjviA5KM+MfHU1WjAFFtj+jy8p5p
         dtY8+t3buiZDRS6d0MxIwcmWWcMroUq6JQUIwYk5mExE4Cv2Q/X3/hbLKX2D2dRhvRHC
         z3WaApILH9xsOrvlWOSj6XvaWIKi43wPNrIR4R/uLtVZFBlJmqCuWpNEQGsLFatDEDaq
         mnlw==
X-Gm-Message-State: AOAM531bEWIrC+A1sQVMG0vzfYeL+tjTTjY18FvNKCTrAhNzfnYZpvsd
        6ls5CefZJXhBBI4XrCdn+qM3BA==
X-Google-Smtp-Source: ABdhPJydhjolQfh9BHShbehtf4H/P9Qp9aTohevB6N9HJd2+j9CRu0vRdqFkgqKyiiFq7Ve/OYG2vg==
X-Received: by 2002:a17:902:7207:b029:da:fd0c:521a with SMTP id ba7-20020a1709027207b02900dafd0c521amr6196896plb.45.1609970237539;
        Wed, 06 Jan 2021 13:57:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d124sm3739593pgc.68.2021.01.06.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 13:57:16 -0800 (PST)
Date:   Wed, 6 Jan 2021 13:57:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <202101061350.913E1FDF6@keescook>
References: <20201230154749.746641-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230154749.746641-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
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
> -fsanitize=unsigned-integer-overflow.
> 
> The one in blake2b immediately overflows the 8KB stack area on 32-bit
> architectures, so better ensure this never happens by making this
> option gcc-only.
> 
> Fixes: d0a3ac549f38 ("ubsan: enable for all*config builds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.ubsan | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 8b635fd75fe4..e23873282ba7 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
>  
>  config UBSAN_UNSIGNED_OVERFLOW
>  	bool "Perform checking for unsigned arithmetic overflow"
> +	# clang hugely expands stack usage with -fsanitize=object-size
> +	depends on !CC_IS_CLANG
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)

Because of Clang implementation issues (see commit c637693b20da), this is
already "default n" (and not supported under GCC at all). IIUC, setting
this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?

Is there some better way to mark this as "known to have issues, please
don't include in randconfig?"

I'd like to keep it around so people can continue to work out the
problems with it, but not have unexpecting folks trip over it. ;)

-- 
Kees Cook
