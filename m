Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591F32C422E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKYObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgKYObf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:31:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CE8206F9;
        Wed, 25 Nov 2020 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606314694;
        bh=wKP1QfRaO0pncarWwIy2eBfABvq24Ar8n3NiWBXx3OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MioyNkE3mbyp3ub95NlYgl3ZcvcJcJyYbY2ao46SMGhg61vQsfvJFKVqQF4hU8uSV
         G95Y/uxJXhZEOxB9C4rqXTJWjrsZKhSKOLgdCF09sfzMd02EcsUndBN7qbCLoTH4b1
         OL/HEyB5iCiB2DJUH7PLKA3peeYaa4Gm0QOnHNdA=
Date:   Wed, 25 Nov 2020 14:31:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS
 supported
Message-ID: <20201125143128.GC16159@willie-the-truck>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org>
 <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
 <20201125141645.GB2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125141645.GB2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:16:45PM +0100, Peter Zijlstra wrote:
> @@ -207,6 +187,32 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
>  }
>  
> +#endif /* _Q_PENDING_BITS == 8 */
> +
> +#if _Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16
> +
> +/*
> + * xchg_tail - Put in the new queue tail code word & retrieve previous one
> + * @lock : Pointer to queued spinlock structure
> + * @tail : The new queue tail code word
> + * Return: The previous queue tail code word
> + *
> + * xchg(lock, tail), which heads an address dependency
> + *
> + * p,*,* -> n,*,* ; prev = xchg(lock, node)
> + */
> +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> +{
> +	/*
> +	 * We can use relaxed semantics since the caller ensures that the
> +	 * MCS node is properly initialized before updating the tail.
> +	 */
> +	return (u32)xchg_relaxed(&lock->tail,
> +				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> +}
> +
> +#else /* !(_Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16) */

Why can't architectures just implement this with a 32-bit xchg instruction
if they don't have one that operates on 16 bits? Sure, they'll store more
data, but it's atomic so you shouldn't be able to tell... (ignoring parisc
crazy).

Also, I'm surprised qspinlock benefits riscv. On arm64, there's nothing in
it over tickets for <= 16 CPUs.

Will
