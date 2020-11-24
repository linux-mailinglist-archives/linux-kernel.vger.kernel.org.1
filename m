Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6F2C2BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbgKXPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389803AbgKXPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:43:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B442C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9JwNF/HnsOs/5tIwHmp8F8lPNYJfCnT0FcuNfn45GE=; b=UreWVn2423H9nZNcsrO7QRxNCG
        Upj6n43gnmNPt8R4Dk4A1SsM5tcpTceSK+JTYNGQkwOlGaNvqDij9z1bI3ELe2gKGQfy3aPDrfgMi
        /Z7UVrZhh84ZQQz3vA53u0Eklw5PrYsr7pm+HWlj+4OM6O/XU9LLMOJP3ysn7lB7wySzK06RNdVDQ
        PCueenZpuYkXW+hZ5Bp5wi/B+uS0BAsz06uIQJitZx548aJjLBF90zjwpQ2pgIQ78jjmqmL7LCPnS
        5Rqi2VpwPkTG4mjqi7KzQ001SuEUVkvbTjYpRaipMCCu55f3ElfhAPrzkgzBDdrkk2HO/Qnn2ieDb
        A4zVmUBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khaSn-0003nu-NG; Tue, 24 Nov 2020 15:42:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6DA53012DF;
        Tue, 24 Nov 2020 16:42:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE4B42008B34C; Tue, 24 Nov 2020 16:42:37 +0100 (CET)
Date:   Tue, 24 Nov 2020 16:42:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
Message-ID: <20201124154237.GZ3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-15-joel@joelfernandes.org>
 <20201122235456.GF110669@balbir-desktop>
 <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:36:10PM +0800, Li, Aubrey wrote:
> >> +#ifdef CONFIG_SCHED_CORE
> >> +		/*
> >> +		 * Skip this cpu if source task's cookie does not match
> >> +		 * with CPU's core cookie.
> >> +		 */
> >> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> >> +			continue;
> >> +#endif
> >> +
> > 
> > Any reason this is under an #ifdef? In sched_core_cookie_match() won't
> > the check for sched_core_enabled() do the right thing even when
> > CONFIG_SCHED_CORE is not enabed?> 
> Yes, sched_core_enabled works properly when CONFIG_SCHED_CORE is not
> enabled. But when CONFIG_SCHED_CORE is not enabled, it does not make
> sense to leave a core scheduler specific function here even at compile
> time. Also, for the cases in hot path, this saves CPU cycles to avoid
> a judgment.

No, that's nonsense. If it works, remove the #ifdef. Less (#ifdef) is
more.

> >> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> >> +{
> >> +	bool idle_core = true;
> >> +	int cpu;
> >> +
> >> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
> >> +	if (!sched_core_enabled(rq))
> >> +		return true;
> >> +
> >> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> >> +		if (!available_idle_cpu(cpu)) {
> > 
> > I was looking at this snippet and comparing this to is_core_idle(), the
> > major difference is the check for vcpu_is_preempted(). Do we want to
> > call the core as non idle if any vcpu was preempted on this CPU?
> 
> Yes, if there is a VCPU was preempted on this CPU, better not place task
> on this core as the VCPU may be holding a spinlock and wants to be executed
> again ASAP.

If you're doing core scheduling on vcpus, you deserve all the pain
possible.


