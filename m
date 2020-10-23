Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF7297198
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465282AbgJWOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465275AbgJWOq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:46:56 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E104C2168B;
        Fri, 23 Oct 2020 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464416;
        bh=1xqO55vFzsjfMiopdoPnpfcIUGPZU0qCq2lNHBl00fo=;
        h=From:To:Cc:Subject:Date:From;
        b=hWblO5+sUcaOfpbNqQrnUg4FHPKM9yuQ3Ldf8TYAjkugJM+xfbNHOwCGyJI9MfP/H
         mQsJDEatbLwVLc+/sEdzbkTx2jyANEyt36FEyx3hnxophU9x/LSuUahiv2XXifWAv2
         MlR7TozO+y4O9Kw5lZ21XHEi5S36Rv92ZoPoC9os=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 00/16] rcu/nocb: De-offload and re-offload support v3
Date:   Fri, 23 Oct 2020 16:46:33 +0200
Message-Id: <20201023144649.53046-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the third attempt to make rcu-nocb mutable at runtime. See
v2 there: https://lwn.net/Articles/832031/

Many fixes included and rcutorture support:

03: Whitespace fix
04: Add "rcu/nocb: Always init segcblist on CPU up" (Thanks rcutorture!)
05: Add return value for failure on (de)offloading
06: Add "rcu/nocb: Don't deoffload an offline CPU with pending work" (Thanks Paul!)
12: Add "rcu/nocb: Only cond_resched() from actual offloaded batch processing" (Thanks rcutorture!)
14: Write a real and more self-confident changelog
15/16: Add rcutorture support (thanks Paul!)

My last remaining worry, as exposed in 13/16, is that __call_rcu_core()
isn't called during transition states. I need to see how I can handle
that.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/nocb-toggle-v2

HEAD: 0247cd09fd48a38741e5cc6634810985b405baca

Thanks,
	Frederic
---

Frederic Weisbecker (15):
      rcu: Implement rcu_segcblist_is_offloaded() config dependent
      rcu: Turn enabled/offload states into a common flag
      rcu: Provide basic callback offloading state machine bits
      rcu/nocb: Always init segcblist on CPU up
      rcu: De-offloading CB kthread
      rcu/nocb: Don't deoffload an offline CPU with pending work
      rcu: De-offloading GP kthread
      rcu: Re-offload support
      rcu: Shutdown nocb timer on de-offloading
      rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
      rcu: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
      rcu/nocb: Only cond_resched() from actual offloaded batch processing
      rcu: Process batch locally as long as offloading isn't complete
      rcu: Locally accelerate callbacks as long as offloading isn't complete
      tools/rcutorture: Support nocb toggle in TREE01

Paul E. McKenney (1):
      rcutorture: Test runtime toggling of CPUs' callback offloading


 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 include/linux/rcu_segcblist.h                      | 119 +++++++-
 include/linux/rcupdate.h                           |   4 +
 kernel/rcu/rcu_segcblist.c                         |  13 +-
 kernel/rcu/rcu_segcblist.h                         |  45 ++-
 kernel/rcu/rcutorture.c                            |  86 +++++-
 kernel/rcu/tree.c                                  |  47 +--
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_plugin.h                           | 330 +++++++++++++++++++--
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
 10 files changed, 603 insertions(+), 55 deletions(-)
