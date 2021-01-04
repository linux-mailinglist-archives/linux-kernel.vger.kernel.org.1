Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC52EA0FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhADXhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbhADXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:37:46 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C3DC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:37:05 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id t8so26604666iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uxg7zL2o2W1pUcEzcScyKfNn1LjA1ShXjqEgvTJLC0E=;
        b=P6kivpFJamY083IAC1lr8AMM6N3XqD7SYdgsJ25mjg95b3MCh7l+PDPM0jBgb/FgQK
         3mBx+slDciyhEQJIJDKBElOSGt689rDwR0aQbfaKkjHMUjPaWuklCLCLOdVOzHGfTvdf
         tkMD6x7IXW7XOnGzcBMjKUjGnToyJE2+gYFWgLlgdF0juLojL2MWx+z4hf8CvMFti7fr
         h2fTymO9v2l1Vr1jveICCzCY032bixvyCe+402b8aNlFnopUm9Am37bZ164uXM0fhSQq
         ppxDb7RgoPzjCXVIPR3LiMve4x/ojEp6u8hKsahu58uxGY6mYHmJrwzUNmmtr/rYNgBd
         ayjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uxg7zL2o2W1pUcEzcScyKfNn1LjA1ShXjqEgvTJLC0E=;
        b=cLMyZeiOhBYfG0YwYZzM8DFvVjvejdwAeA3aKLj9ozhKKxJNLxk4ANtZFnAkAcNFNl
         eaDzlf7PkqCmUP+Lhzoz2rR+ydPcb1WO4gqL5zlwWiMbvo+9BknUKTiSYroPoz/xGeqA
         W0rq+NvQ5EMGPbynWNZbODdGiz0+hrNKiceR+BwOWQ8CY7mD6iV5MxHGLc/23ZwxQsm5
         JtUzd053MqSEjxAetzl4l9az4CxPOw244iB38KQRcQ58/675oolUXnV/JCOg77jYpPbt
         ErnhYV0t7cMEUGPx+R4zu+1UPjo03Pk/50MO4x9LX46nA8/WCXAZ5uh97dSRchvUtdYN
         scgw==
X-Gm-Message-State: AOAM530u65dNJKTpHRcENM2uTEpXUhbQWKYYNgcLT4hz1oTjrjtLNgAe
        rMikqZVlhP0e1Nuo8qaP6B1StNg38WmpDg==
X-Google-Smtp-Source: ABdhPJx/iP03RX9GE/9NzPXKGFWKrd5tKCEignBAuMnq/kjM0Vs2V5YXMLBJRPBc1W4nIz8S35oN8g==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr41268979qtn.199.1609799618534;
        Mon, 04 Jan 2021 14:33:38 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 74sm37192516qko.59.2021.01.04.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:33:37 -0800 (PST)
Date:   Mon, 4 Jan 2021 15:33:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <20210104223336.GA2562866@ubuntu-m3-large-x86>
References: <20201230154749.746641-1-arnd@kernel.org>
 <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 05:13:03PM +0100, Marco Elver wrote:
> On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Building ubsan kernels even for compile-testing introduced these
> > warnings in my randconfig environment:
> >
> > crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> > static void blake2b_compress(struct blake2b_state *S,
> > crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> > static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> > lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> > static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> > lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> > static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> >
> > Further testing showed that this is caused by
> > -fsanitize=unsigned-integer-overflow.
> >
> > The one in blake2b immediately overflows the 8KB stack area on 32-bit
> > architectures, so better ensure this never happens by making this
> > option gcc-only.

This patch also fixes the failed BUILD_BUG issue in mm/mremap.c that you
sent a patch for [1], along with a couple of other issues I see such as:

ld.lld: error: undefined symbol: __bad_mask
>>> referenced by gpi.c
>>>               dma/qcom/gpi.o:(gpi_update_reg) in archive
>>>               drivers/built-in.a
>>> referenced by gpi.c
>>>               dma/qcom/gpi.o:(gpi_update_reg) in archive
>>>               drivers/built-in.a

[1]: https://lore.kernel.org/lkml/20201230154104.522605-1-arnd@kernel.org/

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> > Fixes: d0a3ac549f38 ("ubsan: enable for all*config builds")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  lib/Kconfig.ubsan | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 8b635fd75fe4..e23873282ba7 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> >
> >  config UBSAN_UNSIGNED_OVERFLOW
> >         bool "Perform checking for unsigned arithmetic overflow"
> > +       # clang hugely expands stack usage with -fsanitize=object-size
> 
> This is the first time -fsanitize=object-size is mentioned. Typo?

Copy and paste issue from CONFIG_UBSAN_OBJECT_SIZE

> > +       depends on !CC_IS_CLANG
> >         depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> >         help
> >           This option enables -fsanitize=unsigned-integer-overflow which checks
> > --
> > 2.29.2
> >
