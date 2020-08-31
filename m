Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5F25804A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgHaSHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgHaSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2602083E;
        Mon, 31 Aug 2020 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897252;
        bh=mT02m9LGUtdJx/MKBCUbSyBlurnYCmp8psFx934v7p4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=zF8T3gDWq9H4HHxIvZK47lvmNSqfROe5nq5Ndp/1i20quLpSUkkym6oKmeUMYzAJH
         yVazf0g04b9TjiOQk1SXjE4TmzYyEGwxXIf80wRRjA09i+7wQ9O385kQGRnNoZ/Dol
         WFl6qYqQ99KAbAWtgXI6Q3YoXtrt5O/tuUodNlKo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DD25D35230F1; Mon, 31 Aug 2020 11:07:31 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:07:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/19] New smp_call_function() torture test for
 v5.10
Message-ID: <20200831180731.GA582@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series introduces a new torture test for smp_call_function()
and friends:

1.	Add smp_call_function() torture test.

2.	Declare parse-console.sh independence from rcutorture.

3.	Add scftorture to the rcutorture scripting.

4.	Implement weighted primitive selection.

5.	tick-sched: Clarify "NOHZ: local_softirq_pending" warning.

6.	Summarize per-thread statistics.

7.	Add smp_call_function_single() memory-ordering checks.

8.	Add smp_call_function_many() memory-ordering checks.

9.	Add smp_call_function() memory-ordering checks.

10.	Consolidate scftorture_invoke_one() check and kfree().

11.	Consolidate scftorture_invoke_one() scf_check initialization.

12.	Flag errors in torture-compatible manner.

13.	Prevent compiler from reducing race probabilities.

14.	Make symbol 'scf_torture_rand' static.

15.	Check unexpected "switch" statement value.

16.	Block scftorture_invoker() kthreads for offline CPUs.

17.	Adapt memory-ordering test to UP operation.

18.	Add cond_resched() to test loop.

19.	Change rcuperf to rcuscale.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt                       |  128 +
 b/MAINTAINERS                                                           |    3 
 b/kernel/Makefile                                                       |    2 
 b/kernel/rcu/Kconfig.debug                                              |    2 
 b/kernel/rcu/Makefile                                                   |    2 
 b/kernel/rcu/rcuscale.c                                                 |  330 ++--
 b/kernel/scftorture.c                                                   |  755 ++++++++--
 b/kernel/time/tick-sched.c                                              |    2 
 b/lib/Kconfig.debug                                                     |   10 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh |    6 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh        |   14 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh             |   38 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                         |   10 
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh               |   11 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon          |    2 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh  |    4 
 b/tools/testing/selftests/rcutorture/configs/scf/CFLIST                 |    2 
 b/tools/testing/selftests/rcutorture/configs/scf/CFcommon               |    2 
 b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT              |    9 
 b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot         |    1 
 b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT                |    9 
 b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh       |   30 
 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon             |    2 
 23 files changed, 1073 insertions(+), 301 deletions(-)
