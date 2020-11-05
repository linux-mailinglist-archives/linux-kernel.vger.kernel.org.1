Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5032A8AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbgKEXjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:39:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2169B20704;
        Thu,  5 Nov 2020 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604619575;
        bh=FN0GDxwCweIQTkcMLdFcjtU5Xjcus1pqSAOX2aT1Ris=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdMLJW5uplmF8sDus1Wl651AgtJSHAwifj7nvMG8D2BkUeezOQX+9+gFELNkFt3GU
         nbbUfSx1qd61o4R7RAeRT6+zUs639gkiGnaRQTkm4sD6jLjZOtTmpeVfiWfwzCweyp
         9VSW7MmbpcF7fpd6YFnG3VR41GpO8EwFJgcuIp9A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] rcutorture: Make preemptible TRACE02 enable lockdep
Date:   Thu,  5 Nov 2020 15:39:30 -0800
Message-Id: <20201105233933.20748-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105233900.GA20676@paulmck-ThinkPad-P72>
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the CONFIG_PREEMPT_NONE=y rcutorture TRACE01 rcutorture
scenario enables lockdep.  This limits its ability to find bugs due to
non-preemptible sections of code being RCU readers, and pretty much all
code thus appearing to lockdep to be an RCU reader.  This commit therefore
moves lockdep testing to the CONFIG_PREEMPT=y rcutorture TRACE02 scenario.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 | 6 +++---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02 | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 12e7661..34c8ff5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
 CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index b69ed66..77541ee 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
-- 
2.9.5

