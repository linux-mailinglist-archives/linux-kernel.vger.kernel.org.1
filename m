Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B72D13E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLGOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:42:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLGOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:42:29 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607352107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwUjGjGnOr0+2J/b3b6gBDFZmKNjzCTEHweOTNbP8XQ=;
        b=gZAj9pJlrYsm7iAeUWeY2F4XrQr7OXjNCnLCa0C/lDrRdLMBAP38JVnOLlrLeN1fZuIGeA
        hMGSK2mtbycU6vO5hUxH0K7HUBoHi0iMtvNdV4U7ymgeN1oH1JLLSI5anMXL1Gth2vHVkb
        4SiNF9svjGxsyXUyBuJmDXP7N86EiLd4xGDj8YRC9ecgbD/gVwzE3T24Z+lSusvXzyStrA
        4qM9VgrGwXNi1Z4U+Hvh2bJnXuEu7aDu9L3rS55uW8h6TFZ7VhSCgvsd77TinPe2LblHOS
        xyBtq9haw2LstqKvC0nq968EwbotgBiT9ArUPqI7qxNsx9qZDOVVJWABRt5V5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607352107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwUjGjGnOr0+2J/b3b6gBDFZmKNjzCTEHweOTNbP8XQ=;
        b=Yr+mkKCCZW1w6dEjE/eXegzqii2lPHXs5hJ40g0NBlJ3GaaYYq91/SI1It0njjnSQ/S/kd
        sf+6MSGWCibiAnBg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: tick/sched: Make jiffies update quick check more robust
In-Reply-To: <20201207095907.GI3040@hirez.programming.kicks-ass.net>
References: <87czzpc02w.fsf@nanos.tec.linutronix.de> <20201207095907.GI3040@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 15:41:47 +0100
Message-ID: <877dpt7k5w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 10:59, Peter Zijlstra wrote:
>> +	if (IS_ENABLED(CONFIG_64BIT)) {
>> +		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
>> +			return;
>
> Explicit ACQUIRE
>
>> +	} else {
>> +		unsigned int seq;
>> +
>> +		/*
>> +		 * Avoid contention on jiffies_lock and protect the quick
>> +		 * check with the sequence count.
>> +		 */
>> +		do {
>> +			seq = read_seqcount_begin(&jiffies_seq);
>> +			nextp = tick_next_period;
>> +		} while (read_seqcount_retry(&jiffies_seq, seq));
>> +
>> +		if (ktime_before(now, nextp))
>> +			return;
>
> Actually has an implicit ACQUIRE:
>
> 	read_seqcount_retry() implies smp_rmb(), which ensures
> 	LOAD->LOAD order, IOW any later load must happen after our
> 	@tick_next_period load.
>
> 	Then it has a control dependency on ktime_before(,nextp), which
> 	ensures LOAD->STORE order.
>
> 	Combined we have a LOAD->{LOAD,STORE} order on the
> 	@tick_next_period load, IOW ACQUIRE.
>
>> +	}
>>  
>> +	/* Quick check failed, i.e. update is required. */
>>  	raw_spin_lock(&jiffies_lock);
>
> Another ACQUIRE, which means the above ACQUIRE only ensures we load the
> lock value after?
>
> Or are we trying to guarantee the caller is sure to observe the new
> jiffies value if we return?

The guarantee we need on 64bit for the check w/o seqcount is:

CPU0                                         CPU1

 if (ktime_before(now, tick_next_period))
 	return;

 raw_spin_lock(&jiffies_lock);
 ....
 jiffies_64 += ticks;                           
 
 tick_next_period = next;                   if (ktime_before(now, tick_next_period))
  	                                           return;

When CPU1 returns because it observes the new value in tick_next_period
then it has to be guaranteed that jiffies_64 is observable as well.

I might have gotten it completely wrong again.

Thanks,

        tglx


  
