Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1E1AAFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404717AbgDORap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411102AbgDORai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:30:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F442076D;
        Wed, 15 Apr 2020 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971837;
        bh=hW9m1HKvvZPLpR5oWB0oo/Sta70eFShr77qVrs4Ya58=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lNBsdDqUTKazdIrU3BeWCs2JBFrG+Z+FzxMBTXN706tHIyKvtw9xtfAl3EetG6nkT
         bomMLEwjVN6NYeiQ7MppTT5h62wPszF97MYzmKPbFMug8Ew50bpZTWP4Glo98HPusX
         vEehiQ/coJL03IuYvehJprdCBuaysZbG1ONmtLno=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3F2B3522AD1; Wed, 15 Apr 2020 10:30:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:30:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Torture-test updates for v5.8
Message-ID: <20200415173037.GA9768@paulmck-ThinkPad-P72>
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

This series contains a variety of torture-test updates:

1.	Add KCSAN stubs.

2.	Make kvm-recheck-rcu.sh handle truncated lines.

3.	Mark data-race potential for rcu_barrier() test statistics.

4.	locktorture.c: Fix if-statement empty body warnings, courtesy
	of Randy Dunlap.

5.	Default enable RCU list lockdep debugging with PROVE_RCU,
	courtesy of Madhuparna Bhowmik.

6.	Add flag to produce non-busy-wait task stalls.

7.	Right-size TREE10 CPU consumption.

8.	Allow rcutorture to starve grace-period kthread.

9.	Add --kcsan argument to top-level kvm.sh script.

10.	Make --kcsan argument also create a summary.

11.	Make rcu_fwds and rcu_fwd_emergency_stop static, courtesy of
	Jason Yan.

12.	Eliminate duplicate #CHECK# from ConfigFragment.

13.	Abstract application of additional Kconfig options.

14.	Allow --kconfig options to override --kcsan defaults.

15.	Allow scenario-specific Kconfig options to override CFcommon.

16.	Save a few lines by using config_override_param initially.

17.	Add a --kasan argument.

18.	Convert ULONG_CMP_LT() to time_before().

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt           |   12 +
 include/linux/torture.h                                   |    2 
 kernel/rcu/Kconfig.debug                                  |   11 -
 kernel/rcu/rcu.h                                          |    2 
 kernel/rcu/rcutorture.c                                   |   63 +++++++--
 kernel/rcu/tree.c                                         |   27 ++++
 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh  |   22 +++
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh |   16 ++
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     |    9 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh  |   90 +++++++-------
 tools/testing/selftests/rcutorture/bin/kvm.sh             |   17 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE10     |    2 
 12 files changed, 198 insertions(+), 75 deletions(-)
