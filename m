Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315A02A8AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgKEXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:39:01 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EA620704;
        Thu,  5 Nov 2020 23:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604619541;
        bh=yjwzr/YRUw2JY6AsTHtslAYWJbL5WqB/UMvBg5am32k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tk3ZAM6R/RaiEyOdH+x1+OtiWUXTtTcGrP8jPH+WLJQSrkJsy1qBYNMf3rGpuqhb3
         rGp+NnLVRtvPpARcnc3s30b9+OKJ7sWGUa8cBiYSdXHB+bZVQvNCl7VyW+cGJf7lyp
         wVLV9P0F8/1jfOo0RMh86rq8Eds7/STKcV+dAQsI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ABCB63522A76; Thu,  5 Nov 2020 15:39:00 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:39:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] RCU-tasks updates for v5.11
Message-ID: <20201105233900.GA20676@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates to the various RCU-tasks flavors:

1.	Make preemptible TRACE02 enable lockdep.

2.	Convert rcu_tasks_wait_gp() for-loop to while-loop.

3.	Make grace-period kthread report match RCU flavor being tested.

4.	Make the units of ->init_fract be jiffies.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/rcu.h                                       |   16 +++++
 kernel/rcu/rcutorture.c                                |   11 +++
 kernel/rcu/tasks.h                                     |   49 +++++++----------
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    6 +-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    6 +-
 5 files changed, 52 insertions(+), 36 deletions(-)
