Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D685258069
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgHaSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgHaSLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:02 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21292068E;
        Mon, 31 Aug 2020 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897461;
        bh=uvz6DOzkrc6ir/K8vblcwThBOBUJencSAy9QHcrbWDM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hxVI56iLEFi2VXeGaE0DFz5n1O3kiZRPpFBMsC7PZUB4t9usCo524tBHEMy2dCn7f
         TFQb3itNREW3kUv2Ow0GNzlqQw6GGmQpcGm5JFeDtbcGIaRxwWgN6D11tXUZiA0Xbk
         BVkT4pcqmN8zqg0WhXH0P5AfgxkG1ueHUD0BneGg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C2C1A35230F1; Mon, 31 Aug 2020 11:11:01 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:11:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/13] Add strict grace periods for KASAN use for
 v5.10
Message-ID: <20200831181101.GA950@paulmck-ThinkPad-P72>
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

This series adds strict grace periods that are as short as is reasonably
practical.  This feature is enabled using a new RCU_STRICT_GRACE_PERIOD
Kconfig option, and severely degrades performance and scalability.
It should therefore be avoided in production.

1.	Add Kconfig option for strict RCU grace periods.

2.	Reduce leaf fanout for strict RCU grace periods.

3.	Restrict default jiffies_till_first_fqs for strict RCU GPs.

4.	Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs.

5.	Always set .need_qs from __rcu_read_lock() for strict GPs.

6.	Do full report for .need_qs for strict GPs.

7.	Attempt QS when CPU discovers GP for strict GPs.

8.	IPI all CPUs at GP start for strict GPs.

9.	IPI all CPUs at GP end for strict GPs.

10.	Provide optional RCU-reader exit delay for strict GPs.

11.	Execute RCU reader shortly after rcu_core for strict GPs.

12.	Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs.

13.	Remove unused "cpu" parameter from rcu_report_qs_rdp().

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    9 ++
 include/linux/rcupdate.h                        |    7 ++
 kernel/rcu/Kconfig                              |    8 +-
 kernel/rcu/Kconfig.debug                        |   15 ++++
 kernel/rcu/tree.c                               |   73 ++++++++++++++++++++----
 kernel/rcu/tree.h                               |    1 
 kernel/rcu/tree_plugin.h                        |   52 +++++++++++++----
 7 files changed, 139 insertions(+), 26 deletions(-)
