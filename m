Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5F204540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgFWAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgFWAYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EE720702;
        Tue, 23 Jun 2020 00:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871863;
        bh=a5jLBi6LcqgzU1CHaVUmq462KXGA+/QhM1CIaE6EJKI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Z+ryXX6qW7cqTVDttGtmhj4DNa2dVcLWVd5Gj/staJr5azFSoylSDFdxJ+ZKt21NV
         dgpTBE41NRWvioDgz2UbskpldSznjvgFsvko1RKfbu3Odez0IOyaaQZ8OTh7Th14iv
         GkPo3zAPi7lzi7jCoUUFlIIAnbnSIUn94Fu4wlyM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D5DA352306A; Mon, 22 Jun 2020 17:24:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:24:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] RCU tasks updates for v5.9
Message-ID: <20200623002423.GA25869@paulmck-ThinkPad-P72>
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

This series contains code-style and build-issue fixes to the various
RCU Tasks flavors.

1.	rcu-tasks: Convert sleeps to idle priority.

2.	rcu-tasks: Make rcu_tasks_postscan() be static.

3.	rcu-tasks: Add #include of rcupdate_trace.h to update.c.

4.	rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads().

5.	rcu-tasks: Fix code-style issues.

						Thanx, Paul

------------------------------------------------------------------------

 tasks.h  |   28 +++++++++++++++++++++-------
 update.c |    1 +
 2 files changed, 22 insertions(+), 7 deletions(-)
