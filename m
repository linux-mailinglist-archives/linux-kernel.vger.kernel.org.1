Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10E2A8AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgKEXXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgKEXXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:23:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51B520704;
        Thu,  5 Nov 2020 23:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618625;
        bh=6Ud0SjnsNaVe3Aygv4dl9iOgUwfB3qZdDMAv3XVy98I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QJKfWjKTyo5mkJeZNKRw3Q7I+ap1w0g1n0J4iC8qa+aOOEh+Pjj+A/hTKm6vgNl4E
         VzCQkainbhwB7S6jEm+SawDknSFOwBBb0tnI6vi89weswSKHQk4TwwKZpZ3pq+Kbyr
         3G8di1WhPL5tLRklrqse0dN6tGPCUGDZUHWP4ITc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5CC703522A76; Thu,  5 Nov 2020 15:23:45 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:23:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/7] Lockdep-RCU updates for v5.11
Message-ID: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series simplifies use of the lockdep-RCU API, all courtesy of
Jakub Kicinski:

1.	Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP.

2.	Un-hide RCU lockdep maps for !LOCKDEP.

3.	Un-hide networking lockdep_sock_is_held() for !LOCKDEP.

4.	Remove broken definitions in sched and un-hide for !LOCKDEP.

5.	Use a more appropriate lockdep helper in SRCU.

6.	Provide dummy forward declaration of *_is_held() helpers.

7.	Prevent RCU_LOCKDEP_WARN() from swallowing the condition.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/lockdep.h        |    6 ++++++
 include/linux/rcupdate.h       |   11 ++++++-----
 include/linux/rcupdate_trace.h |    4 ++--
 include/linux/sched/task.h     |    2 --
 include/net/sch_generic.h      |   12 ------------
 include/net/sock.h             |    2 --
 kernel/rcu/srcutree.c          |    2 +-
 7 files changed, 15 insertions(+), 24 deletions(-)
