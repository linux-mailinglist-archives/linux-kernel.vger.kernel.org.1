Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7891E287454
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgJHMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgJHMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:35:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28572C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rbMMA5ddCtH0CeBWsyrtswzbqS4bo1z2oWqSBhMisi0=; b=j/kzKFAGLZk0It+frHihiWN1Rr
        1oGGcXt+WT/HFHQkVVT3UCYsUBa/qZxviKPzdgZq7AKsYrYimFYhM7kGO1T8Zc4/9VDQA98BR4Bu5
        L+3B7tqYP/OkIVsmIzVvDu4Ve8eNyqGJUdQ1+tHH60UgZjQskgwGSZl9sFDYduIWqAHO21HKa8gYP
        dZnWOajWWoSQWIh/MF8Kpaoh+Ry5wg0lvC0NN+S+jk18kJ6r8dyKGp1EsTXn/VDg0JjzKF5el5Z6E
        S1S4dDYMuuQJv0ErTstv2FKhH26oCBnQJrrZID+zX6cTnDiXlyv24JtxMS0FnC1s8HveclssI+J7S
        03bK8ocw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQV98-0002m6-Pa; Thu, 08 Oct 2020 12:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BD62301A42;
        Thu,  8 Oct 2020 14:35:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58EC02B262237; Thu,  8 Oct 2020 14:35:44 +0200 (CEST)
Date:   Thu, 8 Oct 2020 14:35:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 2/2] nohz: change signal tick dependency to wakeup CPUs
 of member tasks
Message-ID: <20201008123544.GX2628@hirez.programming.kicks-ass.net>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.765691166@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007180229.765691166@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:01:53PM -0300, Marcelo Tosatti wrote:
> Rather than waking up all nohz_full CPUs on the system, only wakeup 
> the target CPUs of member threads of the signal.
> 
> Reduces interruptions to nohz_full CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -398,7 +398,15 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
>   */
>  void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
>  {
> -	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
> +	int prev;
> +
> +	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
> +	if (!prev) {
> +		rcu_read_lock();
> +		for_each_thread(sig, t)
> +			tick_nohz_kick_task(t);
> +		rcu_read_unlock();
> +	}
>  }

AFAICT, and this makes perfect sense, this function is only ever used
while holding sighand->siglock, which makes the RCU read lock
superfluous.

Would it make sense to change the signal_struct argument to task_struct,
such that we can write:

	lockdep_assert_held(&p->sighand->siglock);
	for_each_thread(p->signal, t)
		tick_nohz_kick_task(t);

?

