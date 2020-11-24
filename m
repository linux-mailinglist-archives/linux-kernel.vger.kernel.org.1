Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789822C29D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgKXOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388014AbgKXOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:39:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D759C0613D6;
        Tue, 24 Nov 2020 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GoAdl81v24i3KsrF6FHK8OdnyGReQyFmhhFDfl2mi5w=; b=1g5qNX881el/fk6Sv2uY+C8dhY
        zzpMv7XUcsQ5wTVG8oLNmnOk6ImoBNp9uWh+F6AVzc0o27Qn8itc+D0HUyRwSdVU7D0VWt5qJuJ0I
        Jy5FYe5YfynbojKOi9wwn3d40997Y+WW+A9wH++F4uSXzbkHt9T7xHL6GCDqLbfhh33RZXb0A1yHv
        HIPsJTqM4AGX5uBVQdj0Wud7YM6+KcA8THCtaDMmKYI8gmn2E/SHsk2YGvJOTJuG/Nxhc9bj1iSoh
        4p9RWVKAGFmLDSjGlEb0q6sCB0hwLbZqD4BL1sJviLXdkfedqsC/YsRpi8FWRbd/5VoS6+y0Ub0bQ
        VZAjSCyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZTh-0004Bj-Bh; Tue, 24 Nov 2020 14:39:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFED53012DF;
        Tue, 24 Nov 2020 15:39:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D902820222D65; Tue, 24 Nov 2020 15:39:31 +0100 (CET)
Date:   Tue, 24 Nov 2020 15:39:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS
 supported
Message-ID: <20201124143931.GI2414@hirez.programming.kicks-ass.net>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606225437-22948-2-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:43:54PM +0000, guoren@kernel.org wrote:
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 59dd7be..6f5f438 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -6,3 +6,6 @@ generic-y += kvm_para.h
>  generic-y += local64.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> +generic-y += mcs_spinlock.h
> +generic-y += qrwlock.h
> +generic-y += qspinlock.h
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 5609185..e178700 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -16,7 +16,43 @@
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(new) __new = (new);					\
>  	__typeof__(*(ptr)) __ret;					\
> +	register unsigned long __rc, tmp, align, addr;			\
>  	switch (size) {							\
> +	case 2:								\
> +		align = ((unsigned long) __ptr & 0x3);			\
> +		addr = ((unsigned long) __ptr & ~0x3);			\
> +		if (align) {						\
> +		__asm__ __volatile__ (					\
> +			"0:	lr.w %0, 0(%z4)\n"			\
> +			"	move %1, %0\n"				\
> +			"	slli %1, %1, 16\n"			\
> +			"	srli %1, %1, 16\n"			\
> +			"	move %2, %z3\n"				\
> +			"	slli %2, %2, 16\n"			\
> +			"	or   %1, %2, %1\n"			\
> +			"	sc.w %2, %1, 0(%z4)\n"			\
> +			"	bnez %2, 0b\n"				\
> +			"	srli %0, %0, 16\n"			\
> +			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
> +			: "rJ" (__new), "rJ"(addr)			\
> +			: "memory");					\
> +		} else {						\
> +		__asm__ __volatile__ (					\
> +			"0:	lr.w %0, (%z4)\n"			\
> +			"	move %1, %0\n"				\
> +			"	srli %1, %1, 16\n"			\
> +			"	slli %1, %1, 16\n"			\
> +			"	move %2, %z3\n"				\
> +			"	or   %1, %2, %1\n"			\
> +			"	sc.w %2, %1, 0(%z4)\n"			\
> +			"	bnez %2, 0b\n"				\
> +			"	slli %0, %0, 16\n"			\
> +			"	srli %0, %0, 16\n"			\
> +			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
> +			: "rJ" (__new), "rJ"(addr)			\
> +			: "memory");					\
> +		}							\
> +		break;							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"	amoswap.w %0, %2, %1\n"			\

I'm pretty sure there's a handfull of implementations like this out
there... if only we could share.

Anyway, this too should be an independent patch.
