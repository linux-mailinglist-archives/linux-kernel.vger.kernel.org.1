Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ADF2045DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgFWAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbgFWAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF0D21473;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=Ydu2oBm0v1WiaUpnb+3/siqJX72BjmdCrHbn1bkGYeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0Oas14gBB0UKOXnlZSq27adUvTbyhNK/30CdYOFhIHN/hs10SJX06vwkhX6pbZmQ
         nafAnk5NM2tsHsVWJn80W9RTQswJbJz7aRIDi6pJ0lZIKU9DohYvz99Xf4MRnxqWI0
         gMzdPtqgY4zRc9sx9BZWDh5TTZ+mrVeN2nj876IA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/23] torture: Add more tracing crib notes to kvm.sh
Date:   Mon, 22 Jun 2020 17:37:47 -0700
Message-Id: <20200623003752.26872-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a few more hints about how to use tracing as comments
at the end of kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3578c85..bdfa0c0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -503,3 +503,7 @@ fi
 # Tracing: trace_event=rcu:rcu_grace_period,rcu:rcu_future_grace_period,rcu:rcu_grace_period_init,rcu:rcu_nocb_wake,rcu:rcu_preempt_task,rcu:rcu_unlock_preempted_task,rcu:rcu_quiescent_state_report,rcu:rcu_fqs,rcu:rcu_callback,rcu:rcu_kfree_callback,rcu:rcu_batch_start,rcu:rcu_invoke_callback,rcu:rcu_invoke_kfree_callback,rcu:rcu_batch_end,rcu:rcu_torture_read,rcu:rcu_barrier
 # Function-graph tracing: ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
 # Also --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y"
+# Control buffer size: --bootargs trace_buf_size=3k
+# Get trace-buffer dumps on all oopses: --bootargs ftrace_dump_on_oops
+# Ditto, but dump only the oopsing CPU: --bootargs ftrace_dump_on_oops=orig_cpu
+# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn
-- 
2.9.5

