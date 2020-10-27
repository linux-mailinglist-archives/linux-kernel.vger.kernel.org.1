Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C829B5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794979AbgJ0POm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1744585AbgJ0PIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:08:55 -0400
Received: from localhost.localdomain (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA2322202;
        Tue, 27 Oct 2020 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811335;
        bh=XOYPcNdLuOm9X4SGxF8og/EAggpsSwLDja/L9sZfhxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWGmjzbGQ4LSt+WFI06bcozH23WPt5xGrTogLTqIfzzaNlK3fh2kXVpLpCbWKtesu
         b6c8x5FViHvnsiDFPWvBZhaE7BydL7I0IKgKM1HYPanUCfS7sBU/CJF6yOV3zgjncC
         zXeGaa5h/97tgLhg/PPwn1caKiHOBN6zFSqDX4ag=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/5] sched: Detect call to schedule from critical entry code
Date:   Tue, 27 Oct 2020 16:08:25 +0100
Message-Id: <20201027150827.148821-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027150827.148821-1-frederic@kernel.org>
References: <20201027150827.148821-1-frederic@kernel.org>
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
index d2003a7d5ab5..c23d7cb5aee3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4291,6 +4291,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
+	SCHED_WARN_ON(ct_state() == CONTEXT_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
-- 
2.25.1

