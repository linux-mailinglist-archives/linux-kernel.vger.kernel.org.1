Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8452B0293
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgKLKML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKLKML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:12:11 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7263B22201;
        Thu, 12 Nov 2020 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175930;
        bh=kmZSycTo1OJG0RmzJymp5sNd0UwvtRmT+VJBSQ5dgUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mXVRfNZd131W72MvrL8Y61x29PGib7RRXYOzdD+owhET3TvqhmSzsNJ+fwZGVVbH
         etvs521ZcSsoNxjw0jr0TPNgXUfsJCmooRSnd/kTNiEn9nka85l613AJ21NvH3y6dD
         VEUUqH4lfNPVszKIIZf1WBfGBfrCD6nd/aKMre50=
Date:   Thu, 12 Nov 2020 10:12:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-team@android.com
Subject: Re: [PATCH] arm64: Fix off-by-one vdso trampoline return value
Message-ID: <20201112101204.GA19506@willie-the-truck>
References: <20201112001422.340449-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112001422.340449-1-willmcvicker@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:14:22AM +0000, Will McVicker wrote:
> Depending on your host nm version, the generated header
> `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> thumb vdso offset addresses (as observed when using llvm-nm). This
> results in an additional +1 for thumb vdso trampoline return values
> since compat_setup_return() already includes `vdso_trampoline + thumb`.
> As a result, I see a SIGBUS error when running the LTP test
> syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
> vdso_offset in the VDSO_SYMBOL macro.
> 
> Test: LTP test syscalls.rt_sigaction01
> Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  arch/arm64/include/asm/vdso.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index f99dcb94b438..a7384379e8e1 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -23,7 +23,7 @@
>  
>  #define VDSO_SYMBOL(base, name)						   \
>  ({									   \
> -	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> +	(void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \

I don't think we need this in mainline, because the sigreturn trampoline
is just a bunch of .byte directives and I removed the sigreturn code from
the compat vdso in 2d071968a405 ("arm64: compat: Remove 32-bit sigreturn code
from the vDSO").

Might be needed in some stable kernels though (or we just backport the
patch I mentioned above)

Will
