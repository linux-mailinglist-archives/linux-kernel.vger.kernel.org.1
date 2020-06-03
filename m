Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1C1ECB51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFCIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:21:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8BC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 01:21:55 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jgOeg-0004fB-Dr; Wed, 03 Jun 2020 10:21:46 +0200
Date:   Wed, 3 Jun 2020 10:21:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] mm: swap: remove lru drain waiters
Message-ID: <20200603082145.jfgmzozx42rjxegx@linutronix.de>
References: <20200601143734.9572-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200601143734.9572-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 22:37:34 [+0800], Hillf Danton wrote:
> 
> After updating the lru drain sequence, new comers avoid waiting for
> the current drainer, because he is flushing works on each online CPU,
> by trying to lock the mutex; the drainer OTOH tries to do works for
> those who fail to acquire the lock by checking the lru drain sequence
> after releasing lock.
> 
> See eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
> for reasons why we can skip waiting for the lock.
> 
> The memory barriers around the sequence and the lock come together
> to remove waiters without their drain works bandoned.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> This is inspired by one of the works from Sebastian.

Not me, it was Ahmed.

> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -714,10 +714,11 @@ static void lru_add_drain_per_cpu(struct
>   */
>  void lru_add_drain_all(void)
>  {
> -	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
> +	static unsigned int lru_drain_seq;
>  	static DEFINE_MUTEX(lock);
>  	static struct cpumask has_work;
> -	int cpu, seq;
> +	int cpu;
> +	unsigned int seq;
>  
>  	/*
>  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> @@ -726,18 +727,16 @@ void lru_add_drain_all(void)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  
> -	seq = raw_read_seqcount_latch(&seqcount);
> +	lru_drain_seq++;
> +	smp_mb();
>  
> -	mutex_lock(&lock);
> +more_work:
>  
> -	/*
> -	 * Piggyback on drain started and finished while we waited for lock:
> -	 * all pages pended at the time of our enter were drained from vectors.
> -	 */
> -	if (__read_seqcount_retry(&seqcount, seq))
> -		goto done;
> +	if (!mutex_trylock(&lock))
> +		return;
>  
> -	raw_write_seqcount_latch(&seqcount);
> +	smp_mb();
> +	seq = lru_drain_seq;
>  
>  	cpumask_clear(&has_work);
>  
> @@ -759,8 +758,11 @@ void lru_add_drain_all(void)
>  	for_each_cpu(cpu, &has_work)
>  		flush_work(&per_cpu(lru_add_drain_work, cpu));
>  
> -done:
>  	mutex_unlock(&lock);
> +
> +	smp_mb();
> +	if (seq != lru_drain_seq)
> +		goto more_work;
>  }
>  #else
>  void lru_add_drain_all(void)
> --

Sebastian
