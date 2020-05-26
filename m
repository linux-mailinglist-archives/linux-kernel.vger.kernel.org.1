Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BC1BEFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 07:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgD3Fae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 01:30:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60322 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgD3Fae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:30:34 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jU1l1-0005JC-1O; Thu, 30 Apr 2020 15:29:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Apr 2020 15:30:04 +1000
Date:   Thu, 30 Apr 2020 15:30:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Dmitry Golovin <dima@golovin.in>
Subject: Re: [PATCH] lib/mpi: Fix 64-bit MIPS build with Clang
Message-ID: <20200430053004.GC11738@gondor.apana.org.au>
References: <20200421214703.47883-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421214703.47883-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:47:04PM -0700, Nathan Chancellor wrote:
> When building 64r6_defconfig with CONFIG_MIPS32_O32 disabled and
> CONFIG_CRYPTO_RSA enabled:
> 
> lib/mpi/generic_mpih-mul1.c:37:24: error: invalid use of a cast in a
> inline asm context requiring an l-value: remove the cast
> or build with -fheinous-gnu-extensions
>                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/mpi/longlong.h:664:22: note: expanded from macro 'umul_ppmm'
>                  : "=d" ((UDItype)(w0))
>                          ~~~~~~~~~~^~~
> lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a
> inline asm context requiring an l-value: remove the cast
> or build with -fheinous-gnu-extensions
>                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                 ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/mpi/longlong.h:668:22: note: expanded from macro 'umul_ppmm'
>                  : "=d" ((UDItype)(w1))
>                          ~~~~~~~~~~^~~
> 2 errors generated.
> 
> This special case for umul_ppmm for MIPS64r6 was added in
> commit bbc25bee37d2b ("lib/mpi: Fix umul_ppmm() for MIPS64r6"), due to
> GCC being inefficient and emitting a __multi3 intrinsic.
> 
> There is no such issue with clang; with this patch applied, I can build
> this configuration without any problems and there are no link errors
> like mentioned in the commit above (which I can still reproduce with
> GCC 9.3.0 when that commit is reverted). Only use this definition when
> GCC is being used.
> 
> This really should have been caught by commit b0c091ae04f67 ("lib/mpi:
> Eliminate unused umul_ppmm definitions for MIPS") when I was messing
> around in this area but I was not testing 64-bit MIPS at the time.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/885
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  lib/mpi/longlong.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
