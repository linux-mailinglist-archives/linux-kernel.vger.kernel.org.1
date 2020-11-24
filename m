Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979A02C29A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgKXO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388885AbgKXO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:29:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C936C0613D6;
        Tue, 24 Nov 2020 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f3fcIKxHhOodlzZ3Xl2mDhvARrazRpJYqfbYOY9E1Hg=; b=ZvC48PVvb6e9xxZKtAlWV2gAzm
        mUu/M9+HXxyILHTsrw0l7U98q4LIzPSu4BCQYvOBP/IRJj3NMaxQ9FTCQcH6x9gfutvdjx9jvbhP0
        9YYmw1Rn2zqBxQiieOHHsqcR5ELvSuKkbZwgm1mdHR6kyTL1Fyx7Gt4ttm/IzEsuy7i36bpL4XQuT
        JqJSa9CIBFixmkwA/dhx4C5KSHQzOj7BDzYdpKnY40cF2t7YS+M/rcZIWJfLTeXVPvq9x5McGf8z4
        L7ROMBXxfyfaw0IKbD3iDSHYgJ9oaoFXTkBjX6TYK2wBxw86yeyoAhOBRNUhOy0cvSH5nP0oep55D
        uUv4Z5uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZJd-0003ca-9P; Tue, 24 Nov 2020 14:29:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F862307005;
        Tue, 24 Nov 2020 15:29:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75D6620222D7E; Tue, 24 Nov 2020 15:29:05 +0100 (CET)
Date:   Tue, 24 Nov 2020 15:29:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Subject: Re: [PATCH 1/5] riscv: Coding convention for xchg
Message-ID: <20201124142905.GH2414@hirez.programming.kicks-ass.net>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606225437-22948-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:43:53PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This is prepare for QUEUED_SPINLOCKS which need xchg support short
> type value.
>  - Remove unused codes (xchg32, xchg64, cmpxchg32 ...)
>  - Combine xchg_relaxed, xchg_acquire, xchg_release into one asm
>  - Make atomic.aq/rl with seperated fence acquire & release

Every time you find yourself doing multiple things, make it multiple
patches.

> @@ -242,58 +239,58 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
>   * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
>   * {cmp,}xchg and the operations that return, so they need a full barrier.
>   */
> +#define ATOMIC_OP(c_t, prefix)						\
>  static __always_inline							\
>  c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)		\
>  {									\
> +	return xchg_relaxed(&(v->counter), n);				\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)		\
>  {									\
> +	return xchg_acquire(&(v->counter), n);				\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)		\
>  {									\
> +	return xchg_release(&(v->counter), n);				\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)			\
>  {									\
> +	return xchg(&(v->counter), n);					\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,		\
>  				     c_t o, c_t n)			\
>  {									\
> +	return cmpxchg_relaxed(&(v->counter), o, n);			\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,		\
>  				     c_t o, c_t n)			\
>  {									\
> +	return cmpxchg_acquire(&(v->counter), o, n);			\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,		\
>  				     c_t o, c_t n)			\
>  {									\
> +	return cmpxchg_release(&(v->counter), o, n);			\
>  }									\
>  static __always_inline							\
>  c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
>  {									\
> +	return cmpxchg(&(v->counter), o, n);				\
>  }

> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 262e5bb..5609185 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -44,118 +44,31 @@
>  					    _x_, sizeof(*(ptr)));	\
>  })
>  
>  #define xchg_acquire(ptr, x)						\
>  ({									\
> +	__typeof__(*(ptr)) _x_ = (x);					\
> +	__ret = __xchg_relaxed((ptr), _x_, sizeof(*(ptr)));		\
> +	__acquire_fence();						\
>  	__ret;								\
>  })
>  
>  #define xchg_release(ptr, x)						\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
> +	__release_fence();						\
> +	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
>  					    _x_, sizeof(*(ptr)));	\
>  })
>  
>  #define xchg(ptr, x)							\
>  ({									\
> +	__typeof__(*(ptr)) __ret;					\
>  	__typeof__(*(ptr)) _x_ = (x);					\
> +	__smp_mb();							\
> +	__ret = __xchg_relaxed((ptr), _x_, sizeof(*(ptr)));		\
> +	__smp_mb();							\
> +	__ret;								\
>  })
>  
>  /*

Why are you defining *{,_acquire,_release}() at all, doesn't
atomic-fallback.h DTRT for you?
