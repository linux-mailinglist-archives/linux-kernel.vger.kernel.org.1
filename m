Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D1207CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406340AbgFXUMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406231AbgFXUMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C479E2081A;
        Wed, 24 Jun 2020 20:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029520;
        bh=Ud+RpLMV4dWOyKjdxATNiBtJWY31iUXVLUKQ0Pw1OEs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Sn8K7bJI2A2bReHxyKOVrn40YgYXvT6VRe4UiqcQ8SuYRzjDU6jCotK4fb0cmghkE
         iEpCpHtGTVnfLJNGkMM97h32Kll7pdcMi5nausdVV3hF1iT7HsxoHZSAF9OKHVbG28
         bA+GJroXFubeCOb1DuR1OTdBkNFJ/FWcqh0PZetQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF09435228BC; Wed, 24 Jun 2020 13:12:00 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:12:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/17] kfree_rcu updates for v5.9
Message-ID: <20200624201200.GA28901@paulmck-ThinkPad-P72>
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

This series contains kfree_rcu() updates.  Unless otherwise noted,
these are all courtesy of Uladzislau Rezki.

1.	Fix a kernel-doc warnings for "count", courtesy of Mauro Carvalho
	Chehab.

2.	rcu/tree: Keep kfree_rcu() awake during lock contention, courtesy
	of Joel Fernandes.

3.	rcu/tree: Skip entry into the page allocator for PREEMPT_RT,
	courtesy of Joel Fernandes.

4.	rcu/tree: Repeat the monitor if any free channel is busy.

5.	rcu/tree: Make debug_objects logic independent of rcu_head,
	courtesy of Joel Fernandes.

6.	rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro.

7.	rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate
	functions.

8.	rcu/tree: Use static initializer for krc.lock, courtesy of
	Sebastian Andrzej Siewior.

9.	rcu/tree: cache specified number of objects.

10.	rcu/tree: Maintain separate array for vmalloc ptrs.

11.	rcu/tiny: support vmalloc in tiny-RCU.

12.	Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*.

13.	mm/list_lru.c: Rename kvfree_rcu() to local variant.

14.	Introduce 2 arg kvfree_rcu() interface.

15.	Support reclaim for head-less object.

16.	Introduce single argument kvfree_rcu() interface.

17.	lib/test_vmalloc.c: Add test cases for kvfree_rcu().

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    8 
 include/linux/rcupdate.h                        |   61 ++-
 include/linux/rcutiny.h                         |   20 -
 include/linux/rcutree.h                         |    2 
 include/trace/events/rcu.h                      |    8 
 kernel/rcu/tiny.c                               |    7 
 kernel/rcu/tree.c                               |  443 ++++++++++++++++--------
 lib/test_vmalloc.c                              |  103 +++++
 mm/list_lru.c                                   |    6 
 9 files changed, 481 insertions(+), 177 deletions(-)
