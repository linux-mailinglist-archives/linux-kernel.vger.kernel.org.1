Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01CC286189
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgJGOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:50:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:54038 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgJGOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:50:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B8A72A7955;
        Wed,  7 Oct 2020 10:50:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NHU4u0HGzHRe; Wed,  7 Oct 2020 10:50:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A271C2A7954;
        Wed,  7 Oct 2020 10:50:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A271C2A7954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1602082242;
        bh=ZPJFogIom7TNXY/aN9M5+yDVSXUNvTraxnW1lUqLY0g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DuJP13BCTGgMaBvJyEMmmLYKJ+KqJlMc0R+ifvLXlGF/ahgXAnLC2pW7bN+w792+N
         glXISB9DpOOz/47/T7sh6wkG0Zvnq33KlBtHkFqMRwZuyUyG/6A5i/TllIq4gPfkDJ
         jcNEInsRL90nMwDx2OHmu7ranqkoKltAZwlFgs/6N0hJOuDJkGRnIWAGNGn4PloNWJ
         LnajNghO+Ek/Nx+2isT+jnY0l6Sr3zgxU7v5zTJgj3mKrmibf8AtnstLJ3ELepxEqs
         64HwlDDo2iKgyjgQW+RT1gMjasSnS3NylUZfEOXd1SCTZPrz8xock5ofyiO0dQ7nrb
         4N4vqVFW4f4AQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CDDuwjhyKOnh; Wed,  7 Oct 2020 10:50:42 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8E6B82A7953;
        Wed,  7 Oct 2020 10:50:42 -0400 (EDT)
Date:   Wed, 7 Oct 2020 10:50:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        Huang Ying <ying.huang@intel.com>,
        feng tang <feng.tang@intel.com>,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201002083311.GK393@shao2-debian>
References: <20201002083311.GK393@shao2-debian>
Subject: Re: [sched] bdfcae1140: will-it-scale.per_thread_ops -37.0%
 regression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: bdfcae1140: will-it-scale.per_thread_ops -37.0% regression
Thread-Index: MxiTKsT3W3hsTgTowKS8qM6o33Ibzw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 2, 2020, at 4:33 AM, Rong Chen rong.a.chen@intel.com wrote:

> Greeting,
> 
> FYI, we noticed a -37.0% regression of will-it-scale.per_thread_ops due to
> commit:
> 
> 
> commit: bdfcae11403e5099769a7c8dc3262e3c4193edef ("[RFC PATCH 2/3] sched:
> membarrier: cover kthread_use_mm (v3)")
> url:
> https://github.com/0day-ci/linux/commits/Mathieu-Desnoyers/Membarrier-updates/20200925-012549
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git
> 848785df48835eefebe0c4eb5da7690690b0a8b7
> 
> in testcase: will-it-scale
> on test machine: 104 threads Skylake with 192G memory
> with following parameters:
> 
>	nr_task: 50%
>	mode: thread
>	test: context_switch1
>	cpufreq_governor: performance
>	ucode: 0x2006906
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n
> parallel copies to see if the testcase will scale. It builds both a process and
> threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
>

Hi,

I would like to report what I suspect is a random thread placement issue in the
context_switch1 test used by the 0day bot when running on a machine with hyperthread
enabled.

AFAIU the test code uses hwloc for thread placement which should theoretically ensure
that each thread is placed on same processing unit, core and numa node between runs.

We can find the test code here:

https://github.com/antonblanchard/will-it-scale/blob/master/tests/context_switch1.c

And the main file containing thread setup is here:

https://github.com/antonblanchard/will-it-scale/blob/master/main.c

AFAIU, the test is started without the "-m" switch, which therefore affinitizes
tasks on cores rather than on processing units (SMT threads).

When testcase() creates the child thread with new_task(), it basically issues:

  pthread_create(&threads[nr_threads++], NULL, func, arg);

passing a NULL pthread_attr_t, and not executing any pre_trampoline on the child.
The pre_trampoline would have issued hwloc_set_thread_cpubind if it were executed on
the child, but it's not. Therefore, we expect the cpu affinity mask of the parent to
be copied on clone and used by the child.

A quick test on a machine with hyperthreading enabled shows that the cpu affinity mask
for the parent and child has two bits set:

taskset -p 1868607
pid 1868607's current affinity mask: 10001
taskset -p 1868606
pid 1868606's current affinity mask: 10001

So AFAIU the placement of the parent and child will be random on either the same
processing unit, or on separate processing units within the same core.

I suspect this randomness can significantly affect the performance number between
runs, and trigger unwarranted performance regression warnings.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
