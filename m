Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74679285B44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgJGItR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:49:17 -0400
Received: from foss.arm.com ([217.140.110.172]:40222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgJGItQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:49:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4644113E;
        Wed,  7 Oct 2020 01:49:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711A63F71F;
        Wed,  7 Oct 2020 01:49:14 -0700 (PDT)
Date:   Wed, 7 Oct 2020 09:49:11 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, herbert@gondor.apana.org.au,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        ardb@kernel.org, broonie@kernel.org, linux-crypto@vger.kernel.org,
        will@kernel.org, davem@davemloft.net
Subject: Re: [BUG][PATCH v3] crypto: arm64: Use x16 with indirect branch to
 bti_c
Message-ID: <20201007084909.GC6642@arm.com>
References: <20201006163326.2780619-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006163326.2780619-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 11:33:26AM -0500, Jeremy Linton wrote:
> The AES code uses a 'br x7' as part of a function called by
> a macro. That branch needs a bti_j as a target. This results
> in a panic as seen below. Using x16 (or x17) with an indirect
> branch keeps the target bti_c.
> 
>   Bad mode in Synchronous Abort handler detected on CPU1, code 0x34000003 -- BTI
>   CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
>   pstate: 20400c05 (nzCv daif +PAN -UAO BTYPE=j-)
>   pc : aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
>   lr : aesbs_xts_encrypt+0x48/0xe0 [aes_neon_bs]
>   sp : ffff80001052b730
> 
>   aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
>    __xts_crypt+0xb0/0x2dc [aes_neon_bs]
>    xts_encrypt+0x28/0x3c [aes_neon_bs]
>   crypto_skcipher_encrypt+0x50/0x84
>   simd_skcipher_encrypt+0xc8/0xe0
>   crypto_skcipher_encrypt+0x50/0x84
>   test_skcipher_vec_cfg+0x224/0x5f0
>   test_skcipher+0xbc/0x120
>   alg_test_skcipher+0xa0/0x1b0
>   alg_test+0x3dc/0x47c
>   cryptomgr_test+0x38/0x60
> 
> Fixes: 0e89640b640d ("crypto: arm64 - Use modern annotations for assembly functions")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Note, if we ended up with any veneered function calls in the mix while
x16 is live, this register could get clobbered.

Given the self-contained nature of this code though, it seems highly
unlikely that we will ever have multiple code sections of external calls
here.

Cheers
---Dave

> ---
>  arch/arm64/crypto/aes-neonbs-core.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
> index b357164379f6..63a52ad9a75c 100644
> --- a/arch/arm64/crypto/aes-neonbs-core.S
> +++ b/arch/arm64/crypto/aes-neonbs-core.S
> @@ -788,7 +788,7 @@ SYM_FUNC_START_LOCAL(__xts_crypt8)
>  
>  0:	mov		bskey, x21
>  	mov		rounds, x22
> -	br		x7
> +	br		x16
>  SYM_FUNC_END(__xts_crypt8)
>  
>  	.macro		__xts_crypt, do8, o0, o1, o2, o3, o4, o5, o6, o7
> @@ -806,7 +806,7 @@ SYM_FUNC_END(__xts_crypt8)
>  	uzp1		v30.4s, v30.4s, v25.4s
>  	ld1		{v25.16b}, [x24]
>  
> -99:	adr		x7, \do8
> +99:	adr		x16, \do8
>  	bl		__xts_crypt8
>  
>  	ldp		q16, q17, [sp, #.Lframe_local_offset]
> -- 
> 2.25.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
