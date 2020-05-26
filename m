Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639141AAF59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbgDORTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404505AbgDORT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:19:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329982076D;
        Wed, 15 Apr 2020 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971165;
        bh=1zWOuMcANkwMvPuhTGi4zdHmCsARxtLLlEWSWYI+/9c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=o1tP4q9g0TSM0PpKe9WdHxSx11Ak0Ua/xag7w3zsdsNt8FMEB0KcIDAu5DEkGKbIT
         yTyJHZCW0IOgbt6/I/rucsQO1xa9SWq00Tpope8AwQ1B7yBKWPLUm6JGCe14pmxCGe
         mWv0oDFWLSRUJPGPZKl/MoKMM2x0DvCGEIWNQUTk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F2B3B3522AD1; Wed, 15 Apr 2020 10:19:24 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:19:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] kfree_rcu() updates for v5.8
Message-ID: <20200415171924.GA9270@paulmck-ThinkPad-P72>
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

This series updates kfree_rcu() testing and OOM handling.  It also
provides a rcu_gp_might_be_stalled() function that judges whether or
not RCU is being stalled.

1.	Add ability to increase object allocation size, courtesy
	of Joel Fernandes.

2.	rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu()
	batching, courtesy of Joel Fernandes.

3.	rcu/tree: Count number of batched kfree_rcu() locklessly,
	courtesy of Joel Fernandes.

4.	Add rcu_gp_might_be_stalled() to indicate whether or not there
	is currently a good chance that the current RCU grace period
	is being stalled.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcutiny.h |    1 
 include/linux/rcutree.h |    1 
 kernel/rcu/rcuperf.c    |    5 ++-
 kernel/rcu/tree.c       |   70 +++++++++++++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree_stall.h |   40 ++++++++++++++++++++++++---
 5 files changed, 106 insertions(+), 11 deletions(-)
