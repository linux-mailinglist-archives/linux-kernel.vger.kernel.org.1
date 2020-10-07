Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679D28613D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgJGOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgJGOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:30:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33BEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yTfeX1ci9j7ZauhhKxi2hhInMlgF4k0GjsYaZ47d3qM=; b=mYqZhM/r8JQ8Z+QST83P7tUkSJ
        k5SCczMfY+IdY0hDQw/Do61d8EaF31KbWgs7m5vT0wjRnxMwkUT9KB/gQrLNBp63jr3wzVM9zP6cF
        EUWiblusmlM1Ikz0YErFWm6Hyzxk6nH1u7d3xAKbJfUrVi+CwBSjBQDeorpdTyUYUf7IXbq/sr4RX
        1jrpgaOKjwhKSeHjHDq4dJVI5qT5frrO5a3W+WBXhH9JsE59+GeOGJz/qtwy6ZqBLmO3/7MNtHUdn
        acMy7HGeOYTGNeueVOVBOBnQyv9YKk4NA2Y71t+XQx2dLUl8XS1Enom+u8z7y1ZzvgVQk8pOg+KPM
        mtM9Id5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQARx-0004yB-VO; Wed, 07 Oct 2020 14:29:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAF73300B22;
        Wed,  7 Oct 2020 16:29:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 931E12BC16208; Wed,  7 Oct 2020 16:29:47 +0200 (CEST)
Date:   Wed, 7 Oct 2020 16:29:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v3)
Message-ID: <20201007142947.GG2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
 <20200924172508.8724-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924172508.8724-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:25:06PM -0400, Mathieu Desnoyers wrote:
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 733e80f334e7..0767a2dbf245 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -475,7 +475,19 @@ static void exit_mm(void)
>  	BUG_ON(mm != current->active_mm);
>  	/* more a memory barrier than a real lock */
>  	task_lock(current);
> +	/*
> +	 * When a thread stops operating on an address space, the loop
> +	 * in membarrier_private_expedited() may not observe that
> +	 * tsk->mm, and the loop in membarrier_global_expedited() may
> +	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
> +	 * rq->membarrier_state, so those would not issue an IPI.
> +	 * Membarrier requires a memory barrier after accessing
> +	 * user-space memory, before clearing tsk->mm or the
> +	 * rq->membarrier_state.
> +	 */
> +	smp_mb__after_spinlock();
>  	current->mm = NULL;
> +	membarrier_update_current_mm(NULL);
>  	mmap_read_unlock(mm);
>  	enter_lazy_tlb(mm, current);
>  	task_unlock(current);

This site seems to be lacking in IRQ disabling. As proposed it will
explode on RT.

Something like so to match kthread_unuse_mm().

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -486,11 +486,13 @@ static void exit_mm(void)
 	 * rq->membarrier_state.
 	 */
 	smp_mb__after_spinlock();
+	local_irq_disable()
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
-	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
+	local_irq_enable();
 	task_unlock(current);
+	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
