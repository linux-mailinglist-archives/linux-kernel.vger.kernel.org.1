Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E628342E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgJEKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgJEKtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:31 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA904207F7;
        Mon,  5 Oct 2020 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894971;
        bh=rHkx6svf9mwcImUzQlNqwXYNX6dSG8sb8Pj3ZU25y3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d817h2n6LGjnUBUFujloDPNJD82bbZAKDTmfORQMvOObz9c0O/96kVvpkSFCAgnMp
         wZJx7nOuKaFoMtdYsR8s/47978sCGfifxhwwO19sbSrrDVWfwbNVkrQeU9otZw7zab
         +wkFUJSOMDlE/bmIE4VVosbc400CZKhwf2Rvi9Zg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/5] sched: Detect call to schedule from critical entry code
Date:   Mon,  5 Oct 2020 12:49:17 +0200
Message-Id: <20201005104919.5250-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005104919.5250-1-frederic@kernel.org>
References: <20201005104919.5250-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect calls to schedule() between user_enter() and user_exit(). Those
are symptoms of early entry code that either forgot to protect a call
to schedule() inside exception_enter()/exception_exit() or, in the case
of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
a wrong spot.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..d31a79e073e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4295,6 +4295,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
+	WARN_ON_ONCE(ct_state() == CONTEXT_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
-- 
2.25.1

