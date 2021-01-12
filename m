Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A593B2F4085
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbhAMAm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392021AbhALXyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:54:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:53:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w1so2204279pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XeBDJRibr1ouaq233G4wwpyDOJDmBO5yojbVUYPMv1E=;
        b=OdmEPx3tjMv+nYuUOrb5L41awBIdb+WpTFqUBYqea0EbMGIBmb6SbVBggV867v1I0T
         +Zx/F4isyRClevSEpCt4PJjnYA4BQReK8ISW96uNLNVN+JdkpzVSo07Jhy4d6DvP57UY
         g/8RyuoSgy27smDMXgVKVytkyI7rhFYbrk5uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XeBDJRibr1ouaq233G4wwpyDOJDmBO5yojbVUYPMv1E=;
        b=l1D+z38eeDlNE6FtOfNDtU+cHs0yMixvDZ9HNUkiSmY4at6kQ4Jv1nyHAtOGkO38cG
         sseHhkwBA+x5PEWWQOXJ1EnsyAcaDUxBSrVPCZcIJk0hrXMBDRqd8ghKNIZCaaX4+wOW
         zszuTlz95Sdf8HeR2vdmRIkvwWZMTxwRj74k40mskw24TiUM4AxvKmXVMDJF7mcyATCF
         kLcWFXIWZi75dtAValBarPv+YxkCdJxOx0zE57GTXCO0xhmX51lSNba1URtkv0S2+fLh
         maeFwfwLTz64wDfQL7THScKwcvWdIJ1p9nO5r+5/71xyf7fFTsyY7jCH1FlEwc7KL++V
         dxug==
X-Gm-Message-State: AOAM532BZ80yUdTtTm/v/NS2YPqmYdjTI1d8m3zd8bHoB9J5xzj8vMlF
        AJCCBVnbwTADs2uWRLS5qYizVA==
X-Google-Smtp-Source: ABdhPJwPJp/60Yfdp456SP6YMVAsmFk7NXZd9zaTvAAODiX/ORa+FKlSRBr4xqTbwYOEQccrvAjQKA==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr151155pjb.232.1610495633212;
        Tue, 12 Jan 2021 15:53:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n4sm229667pfu.150.2021.01.12.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 15:53:52 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:53:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] ubsan: disable unsigned-overflow check for i386
Message-ID: <202101121553.D0C3B87D5@keescook>
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

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
