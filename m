Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68D1AAF78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410954AbgDORYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410926AbgDORYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:24:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78B6215A4;
        Wed, 15 Apr 2020 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971446;
        bh=ce0/MOFaWROP/28uCZGVwEiWJofn9fNNRJUP1FcJJSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGrA3+8ccJ5VD5tLp1pOT3P4Rlt6igp5YmOlHvSz0fnH6Qo91G+N+ueaMFXZFWyjI
         tS6sPSaNUvzd7V8ZooB1Go7Xq1fksMgJtIadzjF8gRnvRgpF8vKn0PtB3WhlYfSjMf
         sVd/wQaZn8JBNdwtqGcH2VQpFJBtDRZzvSowF81g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] rcu: Remove self-stack-trace when all quiescent states seen
Date:   Wed, 15 Apr 2020 10:24:03 -0700
Message-Id: <20200415172403.9647-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415172341.GA9519@paulmck-ThinkPad-P72>
References: <20200415172341.GA9519@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When all quiescent states have been seen, it is normally the grace-period
kthread that is in trouble.  Although the existing stack trace from
the current CPU might possibly provide useful information, experience
indicates that there is too much noise for this to be worthwhile.

This commit therefore removes this stack trace from the output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4da41a6..535762b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -440,8 +440,6 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 			       rcu_state.name, j - gpa, j, gpa,
 			       READ_ONCE(jiffies_till_next_fqs),
 			       rcu_get_root()->qsmask);
-			/* In this case, the current CPU might be at fault. */
-			sched_show_task(current);
 		}
 	}
 	/* Rewrite if needed in case of slow consoles. */
-- 
2.9.5

