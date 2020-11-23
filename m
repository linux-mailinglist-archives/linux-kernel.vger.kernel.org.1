Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8982A2C0FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbgKWQIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbgKWQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:08:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61367C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=id/l05lUXRZXVoeT5E2V5g7f5O6E+dlvltH8HKfDmtQ=; b=R9Cz4Sm0LqXno5jNhdi2wuzuFe
        wpU4YHQTOPAaHjnyfWvgccWkR5bZIQ6Q3mHioTe3kDtaBt/9FWD/fi0QsLt6E2ANWwfcJK2VbnlFv
        ZzYnDU7cJWiLq99XkaMTtvpwLICLlMFeht9oxNtCuhTT75TAs/eL0KTRFJ4AgJW9nI/Bkt5Zp3HwQ
        sekTmartdABgp/vS68owgxY3JqtmG+Q9UahyU4cBwFmqFS8eVIHef6SB7qhRFOQWf+lg+my9N9d4n
        Ax/CJys262sHwABSJaVAvmG9GTNs15QUST/df6X7sDN+acTYRl67Il6YaOhgCuFACZaPMoQ1ZmRQn
        pQkWDBSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khEOA-0003Rv-8D; Mon, 23 Nov 2020 16:08:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CCF53070F9;
        Mon, 23 Nov 2020 17:08:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81ACC20222D93; Mon, 23 Nov 2020 17:08:23 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:08:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcsan: Avoid scheduler recursion by using
 non-instrumented preempt_{disable,enable}()
Message-ID: <20201123160823.GC2414@hirez.programming.kicks-ass.net>
References: <20201123132300.1759342-1-elver@google.com>
 <20201123135512.GM3021@hirez.programming.kicks-ass.net>
 <CANpmjNPwuq8Hph3oOyJCVgWQ_d-gOTPEOT3BpbR2pnm5LBeJbw@mail.gmail.com>
 <20201123155746.GA2203226@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123155746.GA2203226@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 04:57:46PM +0100, Marco Elver wrote:
> Let me know what you prefer.
> 

> @@ -288,27 +288,19 @@ static u32 kcsan_prandom_u32_max(u32 ep_ro)
>  	u32 res;
>  
>  	/*
> +	 * Avoid recursion with scheduler by disabling KCSAN because
> +	 * preempt_enable_notrace() will still call into scheduler code.
>  	 */
> +	kcsan_disable_current();
>  	preempt_disable_notrace();
>  	state = raw_cpu_ptr(&kcsan_rand_state);
>  	res = prandom_u32_state(state);
> +	preempt_enable_notrace();
> +	kcsan_enable_current_nowarn();
>  
>  	return (u32)(((u64) res * ep_ro) >> 32);
>  }

This is much preferred over the other. The thing with _no_resched is that
you can miss a preemption for an unbounded amount of time, which is bad.

The _only_ valid use of _no_resched is when there's a call to schedule()
right after it.
