Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842742861D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJGPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:09:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B319C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RHSEd0oqAXk7M7wtta2ctcMpKzkRDNIQmVoYJi4x5yE=; b=t4JwYuvLJfZX1qg/Awu/Sm/OG2
        +6nhxRp6HS4xcMA+tpK2IjYYDrlSf2UqWnVERG7qLyVDdlaEDmmcNgCmSESyMDobrKh5MxjjOShd/
        JwVtMkzLuZeusmT0lA0eC5NoQueJwuWJH7kMDwEmZTs3aeWgRr9HJfIm4nB8J1AOw091aTH7Faxbq
        LQNwp10UIvARV1a9Z1aLdaQwwkdELm8/TaGSoQv1zxM/C8/jOB6gWPA1530n2iac9pXoNB+AYU6fa
        C/zr5ZtwjUo1PRLJGj7DWRKuzxIUUlVbJDZp9WAVx8RqBavyJKrzpgPatYMlKSdO9ZNdgi1QcLflt
        6NOg30fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQB42-0001eb-OB; Wed, 07 Oct 2020 15:09:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D84B23019CE;
        Wed,  7 Oct 2020 17:09:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C57F929C75E31; Wed,  7 Oct 2020 17:09:08 +0200 (CEST)
Date:   Wed, 7 Oct 2020 17:09:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v3)
Message-ID: <20201007150908.GI2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
 <20200924172508.8724-2-mathieu.desnoyers@efficios.com>
 <20201007142947.GG2628@hirez.programming.kicks-ass.net>
 <1929468067.11124.1602082672412.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1929468067.11124.1602082672412.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:57:52AM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 7, 2020, at 10:29 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Thu, Sep 24, 2020 at 01:25:06PM -0400, Mathieu Desnoyers wrote:
> >> diff --git a/kernel/exit.c b/kernel/exit.c
> >> index 733e80f334e7..0767a2dbf245 100644
> >> --- a/kernel/exit.c
> >> +++ b/kernel/exit.c
> >> @@ -475,7 +475,19 @@ static void exit_mm(void)
> >>  	BUG_ON(mm != current->active_mm);
> >>  	/* more a memory barrier than a real lock */
> >>  	task_lock(current);
> >> +	/*
> >> +	 * When a thread stops operating on an address space, the loop
> >> +	 * in membarrier_private_expedited() may not observe that
> >> +	 * tsk->mm, and the loop in membarrier_global_expedited() may
> >> +	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
> >> +	 * rq->membarrier_state, so those would not issue an IPI.
> >> +	 * Membarrier requires a memory barrier after accessing
> >> +	 * user-space memory, before clearing tsk->mm or the
> >> +	 * rq->membarrier_state.
> >> +	 */
> >> +	smp_mb__after_spinlock();
> >>  	current->mm = NULL;
> >> +	membarrier_update_current_mm(NULL);
> >>  	mmap_read_unlock(mm);
> >>  	enter_lazy_tlb(mm, current);
> >>  	task_unlock(current);
> > 
> > This site seems to be lacking in IRQ disabling. As proposed it will
> > explode on RT.
> 
> Right, so irq off is needed for accessing this_rq()'s fields safely,
> correct ?

Yes, but also we're having IRQs disabled on ever other site that mucks
with ->mm these days.
