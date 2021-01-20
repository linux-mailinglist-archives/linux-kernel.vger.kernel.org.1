Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8352FCA00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbhATEc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbhATEcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:32:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD50523138;
        Wed, 20 Jan 2021 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611117104;
        bh=Yo6Rl/X65irlG0tJBG8sFBy+6ANz0e/RhHYaD+X8Hxk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tuxlr6q9Ik8XFxclFMMtvvnLv+MwgYuOZ3zb5z+aFJMDNeZmMqIqSN3a3XiwyhpY0
         65DSyHESf0l9vqELswf9/+K8dVhLsX3ISJgxZi966uAeJ0gKXZjt23zuJ/+Z4YtPAA
         SFMTNnaJS1T7Nh4NCoOGyCwherW+uAKs/9J3wreRwVkV+l6FrdL5nGGwuYiydfcfPv
         AOSLDTP5OawvsePKNTiAoRQSxLr+O2tIa76o0hG7jhRrQ/P7qpPYX8RORi1pnVLoJe
         A2nxcLUsWYC9nQd5OU9vws6eGGAZK3PVEFgXSqyuqsR/3gZRQ6IAdxY8c2h6o91r/m
         SHOobmWpq3ENg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7926F35215BE; Tue, 19 Jan 2021 20:31:44 -0800 (PST)
Date:   Tue, 19 Jan 2021 20:31:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, bigeasy@linutronix.de,
        swood@redhat.com
Subject: [PATCH tip/core/rcu 0/4] Fix RCU priority boosting
Message-ID: <20210120043144.GA7045@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series fixes a bug in which an RCU-priority-boosted task can stay
boosted for some time after it has exited its RCU read-side critical
section.  This bug arose during the RCU flavor consolidation effort.
The patches are as follows:

1.	Expedite deboost in case of deferred quiescent state.

2.	Make TREE03 use real-time tree.use_softirq setting.

3.	Run rcuo kthreads at elevated priority in CONFIG_RCU_BOOST
	kernels.

4.	Fix testing of RCU priority boosting.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/rcutorture.c                                    |   36 +++++++------
 kernel/rcu/tree_plugin.h                                   |   28 +++++-----
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot |    1 
 3 files changed, 39 insertions(+), 26 deletions(-)
