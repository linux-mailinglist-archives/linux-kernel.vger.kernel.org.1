Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175852044FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgFWAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbgFWAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85C020738;
        Tue, 23 Jun 2020 00:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870963;
        bh=tZm7U5xLo6MC8JKAoRbOzi5s59HZtP/yhPCcV6s19NU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=MVEDvT/3Yg8PjIXvfEFxzsxkEQWBqjKElNcY0/0Ei46NZa0JRW1Vt0O02tmRf7zPd
         WAMHKRpRqrX5vS4GGUcoF/GA6VadksNaazHfJ2SXDfLWuAKhMZNpVKQaut/wcfpE3e
         9IvGYOg75lifG8QPazN7gXF0xeq8AHn/5KyvSYaI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7DED6352306A; Mon, 22 Jun 2020 17:09:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:09:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] Documentation updates for v5.9
Message-ID: <20200623000923.GA25047@paulmck-ThinkPad-P72>
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

This series provides documentation updates.


1-7.	Convert Documentation/RCU files to .rst, courtesy of Mauro
	Carvalho Chehab.

8.	RCU: Don't duplicate chapter names in rculist_nulls.rst, courtesy
	of Mauro Carvalho Chehab.

9.	Timer problems can cause RCU CPU stall warnings.

10.	Tasks RCU must protect instructions before trampoline.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/rculist_nulls.txt                      |  172 ------------
 b/Documentation/RCU/Design/Requirements/Requirements.rst |    7 
 b/Documentation/RCU/checklist.rst                        |   17 -
 b/Documentation/RCU/index.rst                            |    9 
 b/Documentation/RCU/lockdep-splat.rst                    |  109 ++++----
 b/Documentation/RCU/lockdep.rst                          |   12 
 b/Documentation/RCU/rculist_nulls.rst                    |  200 +++++++++++++++
 b/Documentation/RCU/rcuref.rst                           |  199 +++++++-------
 b/Documentation/RCU/stallwarn.rst                        |   62 +++-
 b/Documentation/RCU/torture.rst                          |  117 ++++----
 b/Documentation/locking/locktorture.rst                  |    2 
 b/MAINTAINERS                                            |    4 
 b/include/linux/rculist_nulls.h                          |    2 
 b/kernel/rcu/rcutorture.c                                |    2 
 b/kernel/rcu/tree_stall.h                                |    4 
 b/net/core/sock.c                                        |    4 
 16 files changed, 509 insertions(+), 413 deletions(-)
