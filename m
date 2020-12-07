Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78142D0FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLGMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgLGMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:00:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57AAC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ruiN8SJtTuUIP3pb9sg0hgod0TOT8rORb9N8dDgUyWY=; b=XL/kUxg7Xe4176O/HRpN2kny/5
        TJiIqz86OTre+mFJndMNODpqB4aHUfhinHIrg8jS+bDklZWmvwbm9I3SWG2rnEHd7Rv3FrcyriZPy
        K75vmVfi55l3vjbd7Mr19j4uQriwVeX4YmH8QcC6EhdrSkA4cvAbmjcp4SyjYElfd8nVaVN4EvAyd
        1ouQCoDWJwecMzcJ8QwVDVRHUdkbuvJsfphnZLwkmpbl+fkRas8+5JEn90S+p3+4VQ8GAPfxAL6Lg
        yyRmBFyDJw6zmp1S0HmoQJd60hT6SyzfOyNkSuydc2bpEFW0kxNtbDNwUYnj4S0rYj+HSuZhkFWAK
        6TesbQEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmFBJ-0000rG-MP; Mon, 07 Dec 2020 11:59:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48A5730700B;
        Mon,  7 Dec 2020 12:59:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E8A52081294F; Mon,  7 Dec 2020 12:59:53 +0100 (CET)
Date:   Mon, 7 Dec 2020 12:59:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 1/3] tick: Remove pointless cpu valid check in hotplug
 code
Message-ID: <20201207115953.GR3021@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.582579516@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206212002.582579516@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:12:54PM +0100, Thomas Gleixner wrote:

>  void tick_handover_do_timer(void)
>  {
> +	if (tick_do_timer_cpu == smp_processor_id())
> +		tick_do_timer_cpu = cpumask_first(cpu_online_mask);

For the paranoid amongst us, would it make sense to add something like:

	/*
	 * There must always be at least one online CPU.
	 */
	WARN_ON_ONCE(tick_do_timer_cpu >= nr_cpu_ids);

>  }
