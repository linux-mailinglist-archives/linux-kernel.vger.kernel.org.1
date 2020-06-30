Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A320F9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbgF3Qpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 12:45:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgF3Qps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:45:48 -0400
Date:   Tue, 30 Jun 2020 18:45:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593535545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKzUY+hmQUu/W4w+kArUyMIrhlys8QtCqB3RBXTws4o=;
        b=gVLp5Z8jdAB/EZKmgGSiSlpoIpwwchn9I2vLKuZ9KKWJjuDpll4+SWIihzscdnxaDZMqN4
        MZceui4yk56Opq+OdBkC8mD4uLVyaHV4fIGeI/hvopvJgOHan8GcTzZ8G8MED4z5mxR87j
        tMFcoRGBUXy3rvvFkt1k5QYFcCTYioWqGDwQPRdpIYBmd1EmtorPkFyhbsjDPscvqhiR+j
        kz4VU4vIyc4XnWSYIqB/4/hl2J1ZAuxb30P+zc77TOnpuQEHcAWLNoeLLsEaA0ST0n59zc
        igoYQ/coSbgHjr4a7Qnv0hgxri7sntKVFu020M2Cv4hYIzQqAL/2uI4IpjbmkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593535545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKzUY+hmQUu/W4w+kArUyMIrhlys8QtCqB3RBXTws4o=;
        b=whEEw8J5kOhJKqD0Lg6sELfcqODNNGzov72aoYNZiUGNWyKt7a7dsS8ttp2yBYb4OLe8ZP
        aGZqRbaHEwEcnaDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624201226.21197-3-paulmck@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 13:12:12 [-0700], paulmck@kernel.org wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> To keep the kfree_rcu() code working in purely atomic sections on RT,
> such as non-threaded IRQ handlers and raw spinlock sections, avoid
> calling into the page allocator which uses sleeping locks on RT.
> 
> In fact, even if the  caller is preemptible, the kfree_rcu() code is
> not, as the krcp->lock is a raw spinlock.
> 
> Calling into the page allocator is optional and avoiding it should be
> Ok, especially with the page pre-allocation support in future patches.
> Such pre-allocation would further avoid the a need for a dynamically
> allocated page in the first place.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 64592b4..dbdd509 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3184,6 +3184,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  		if (!bnode) {
>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>  
> +			/*
> +			 * To keep this path working on raw non-preemptible
> +			 * sections, prevent the optional entry into the
> +			 * allocator as it uses sleeping locks. In fact, even
> +			 * if the caller of kfree_rcu() is preemptible, this
> +			 * path still is not, as krcp->lock is a raw spinlock.
> +			 * With additional page pre-allocation in the works,
> +			 * hitting this return is going to be much less likely.
> +			 */
> +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +				return false;

This is not going to work together with the "wait context validator"
(CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
printk() which is why it is still disabled by default.

So assume that this is fixed and enabled then on !PREEMPT_RT it will
complain that you have a raw_spinlock_t acquired (the one from patch
02/17) and attempt to acquire a spinlock_t in the memory allocator.

>  			bnode = (struct kfree_rcu_bulk_data *)
>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>  		}

Sebastian
