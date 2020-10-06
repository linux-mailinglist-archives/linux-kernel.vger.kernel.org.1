Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCDE284716
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJFH0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:26:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B4C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xENzTHFzaXi/jzE+/UY1sLe+a8GOwjtfxQ4NuWU0g1s=; b=PQJi2HxsUTZyQtvCbMKKpFVYB5
        sI48ALsxwCfaQdQaT0Fis/Q52PnhrbyO5B8LngR3bsVKa2S+2vUoUxEDcLfh6ajdBjeRRNDN5FizL
        EUcrXMMrj+fMtas3TaMcujzgKdZWlKISqemabpLAEpAceQ7i41UpRIlT4Soz39Bt86Dd+RDIdFP6H
        AejnJEHrvMzw6uP9o5ESIY5aRwUbWby+o9WuJOt7dKOlJt/lAfDf9Kl3z87EQfWsVQDsDy1NrezSc
        ZOqE+Fu2D0EII/Mh/xR0W6trthpZBKk3y2Iu4pzVFNsxAV6s3N3LL6bMud5YkMo0/Bcb5H/yPjN/F
        UCG80GVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPhM1-0007L8-KE; Tue, 06 Oct 2020 07:25:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28A6D300B22;
        Tue,  6 Oct 2020 09:25:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 074E92B7E371B; Tue,  6 Oct 2020 09:25:40 +0200 (CEST)
Date:   Tue, 6 Oct 2020 09:25:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 03/17] sched/hotplug: Ensure only per-cpu kthreads
 run during hotplug
Message-ID: <20201006072540.GK2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150921.257350016@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150921.257350016@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:57:20PM +0200, Peter Zijlstra wrote:
> +static inline void balance_switch(struct rq *rq)
> +{
> +	if (unlikely(rq->balance_flags)) {
> +		/*
> +		 * Run the balance_callbacks, except on hotplug
> +		 * when we need to push the current task away.
> +		 */
> +		if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
> +		    !(rq->balance_flags & BALANCE_PUSH) ||
> +		    !balance_push(rq))
> +			__balance_callbacks(rq);
> +	}
> +}

> @@ -1392,12 +1396,13 @@ queue_balance_callback(struct rq *rq,
>  {
>  	lockdep_assert_held(&rq->lock);
>  
> -	if (unlikely(head->next))
> +	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
>  		return;

With this bit from Valentin we can probably simplify the above function,
but I've not thought about that yet.
