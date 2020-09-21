Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC81127240E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIUMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUMn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:43:59 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD70B207BC;
        Mon, 21 Sep 2020 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692239;
        bh=fnLtNJEFMST8awpeW6Hn7JMM8HGpVria0cGjQ9BO2YY=;
        h=From:To:Cc:Subject:Date:From;
        b=P4Ni938D0cmr0+JWSYs0loUfL+Dum0wZuXeP3lfrKf7RovnXjG4KziooL+YHcpX1f
         1uejVI2J1PBoln7HzgS5M2vp+dlfI5LoUSARVZ3ZYzFjhh6Gmz879TEaNLJtQA2Sf1
         Bb7w6sNcxMkykmb0WwA50RAYPI2tcuAL5hL3wr1o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 00/12] rcu/nocb: De-offload and re-offload support v2
Date:   Mon, 21 Sep 2020 14:43:39 +0200
Message-Id: <20200921124351.24035-1-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second attempt to make rcu-nocb mutable at runtime. See
v1 there: https://lwn.net/Articles/820544/

This time a new approach, as per Paul's suggestion, is to ensure that
callbacks are still served locally until nocb kthreads are fully ready
or fully asleep. This is using a state machine implemented with a mask
(see patch 3/12 for details).

There is still some small polishing to do, as can be seen in the last
patches, to make sure that local callbacks processing is correctly
handled outside of strict softirq (or rcuc) mode.

Thanks.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/nocb

HEAD: 6abe8408307eaeb03b4a0470945943c1decbc4b3

Thanks,
	Frederic
---

Frederic Weisbecker (12):
      rcu: Implement rcu_segcblist_is_offloaded() config dependent
      rcu: Turn enabled/offload states into a common flag
      rcu: Provide basic callback offloading state machine bits
      rcu: De-offloading CB kthread
      rcu: De-offloading GP kthread
      rcu: Re-offload support
      rcu: Shutdown nocb timer on de-offloading
      rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
      rcu: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
      rcu: Process batch locally as long as offloading isn't complete
      rcu: Locally accelerate callbacks as long as offloading isn't complete
      rcu: Nocb (de)activate through sysfs


 include/linux/rcu_segcblist.h | 119 ++++++++++++++++-
 include/linux/rcupdate.h      |   4 +
 kernel/cpu.c                  |  23 ++++
 kernel/rcu/rcu_segcblist.c    |  13 +-
 kernel/rcu/rcu_segcblist.h    |  45 ++++++-
 kernel/rcu/tree.c             |  32 ++---
 kernel/rcu/tree.h             |   2 +
 kernel/rcu/tree_plugin.h      | 297 +++++++++++++++++++++++++++++++++++++++---
 8 files changed, 491 insertions(+), 44 deletions(-)
