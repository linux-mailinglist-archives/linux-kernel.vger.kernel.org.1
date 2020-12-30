Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2082E7AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgL3QN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgL3QN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:13:56 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C0C06179E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 08:13:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d8so15737526otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myv7LmSMKbOAYNp52XCR2AQFXn1fM0PNSnfXWuCsuQU=;
        b=wJJqpDxk89FhrSdmeRRbpDpDnzMbDjNxSou/9hUgyYmZtF66AkrGCGkODZCR2Kc1+D
         pxW5SXZl3ATkIAfVNzEFeIoXJJ/XOnDUqc3uWjgRAE7OIvSEQgWRQhtldoxi5NNTCOlv
         nOKWHemXzn2Ryt+hESGzEfuf/nG4U5zGKG7QLzjy36JaCAm8F4+5rNiuiWR2fr4oQ8uT
         3uvGjTTD/wXEUvFQ8KASxQhRfeK/QEVUNPil0N5bEWFdPHkHEA/8lvyFLX887qKgCbUj
         NrWchj6NYB0RLqIEDfjiel0JIAFJVC3xc9rMdztkh5xqix9GQcJVpg8jF2BkRietMZXM
         625Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myv7LmSMKbOAYNp52XCR2AQFXn1fM0PNSnfXWuCsuQU=;
        b=A1qn5voWtTQiSchryG5G+srTrqxpobB8DoMgtLGj8CcXYNjpz2a1FXa+cD1AOAbVpv
         7IhdXTimGEf8/pSmSrg0+OzgXVry3WQnQL+VWswpQ7Hg9351gDtcQ4SEMm+RvCJFOrNM
         yL4MV6vCCTk0UkNb7mhhzzd/Skfk+wyBZ3hO5pN0TU/4t598bPk9eXod3CvMFFlEFyYG
         CHB0BsBG251FCl5CzkcPsLYJvYygus1ZlFJaWVgcb6zM1NAxKJQbEiz8ozZ+a9+7Tk3G
         DiILqr494sdbHpNJh84nolVTQNBQxaDQe8H9ZAf/K+N0UVANS28/+2cVM3GtORfA2IMG
         aPlQ==
X-Gm-Message-State: AOAM533mq4yS4/5hExr3wbRxgd7ZK0mv6L2ylnvqJ9zC/r/GC4cAXynS
        F6P2CJTEtSi2mpduRk/tfy2ZZ2loaCF6sVyojEGyYQ==
X-Google-Smtp-Source: ABdhPJxPkBW7E9CutOixEY/ZTQya+V6WdPstIjPBLkved5QCxIs2boHbguUe4J9GXr2hjHHfu4UXei+SvlzbjsNEnMc=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr41075229ots.251.1609344795027;
 Wed, 30 Dec 2020 08:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org>
In-Reply-To: <20201230154749.746641-1-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Dec 2020 17:13:03 +0100
Message-ID: <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
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
>         bool "Perform checking for unsigned arithmetic overflow"
> +       # clang hugely expands stack usage with -fsanitize=object-size

This is the first time -fsanitize=object-size is mentioned. Typo?

> +       depends on !CC_IS_CLANG
>         depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>         help
>           This option enables -fsanitize=unsigned-integer-overflow which checks
> --
> 2.29.2
>
