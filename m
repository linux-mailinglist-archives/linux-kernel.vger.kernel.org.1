Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2861AAF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416437AbgDORMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410720AbgDORLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE3621D93;
        Wed, 15 Apr 2020 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970660;
        bh=HKQ+woHhGtl4OllltC1lRFunVAzpZUkFuZ2hz9tJ/8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwEJP9sAmOJGw6ueYuEcXKyG5pxn+L8uOez8zVGnh89mchj8YZ1B7x1ANE7c1wJrN
         lOlY8r77JrsD99tpjQOMtq4yiRH/3Rw8bkoobJoHsab7DHj5vKUpe0P7xZHzEft32c
         JSVPEkrVN5Vd6DZEKa02o9vr4mW+E7er4kjIFEWA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/19] rcu: Get rid of some doc warnings in update.c
Date:   Wed, 15 Apr 2020 10:10:48 -0700
Message-Id: <20200415171054.9013-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This commit escapes *ret, because otherwise the documentation system
thinks that this is an incomplete emphasis block:

	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:70: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:82: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 28a8bdc..72461dd8 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -63,12 +63,12 @@ module_param(rcu_normal_after_boot, int, 0);
  * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
  * @ret:	Best guess answer if lockdep cannot be relied on
  *
- * Returns true if lockdep must be ignored, in which case *ret contains
+ * Returns true if lockdep must be ignored, in which case ``*ret`` contains
  * the best guess described below.  Otherwise returns false, in which
- * case *ret tells the caller nothing and the caller should instead
+ * case ``*ret`` tells the caller nothing and the caller should instead
  * consult lockdep.
  *
- * If CONFIG_DEBUG_LOCK_ALLOC is selected, set *ret to nonzero iff in an
+ * If CONFIG_DEBUG_LOCK_ALLOC is selected, set ``*ret`` to nonzero iff in an
  * RCU-sched read-side critical section.  In absence of
  * CONFIG_DEBUG_LOCK_ALLOC, this assumes we are in an RCU-sched read-side
  * critical section unless it can prove otherwise.  Note that disabling
@@ -82,7 +82,7 @@ module_param(rcu_normal_after_boot, int, 0);
  *
  * Note that if the CPU is in the idle loop from an RCU point of view (ie:
  * that we are in the section between rcu_idle_enter() and rcu_idle_exit())
- * then rcu_read_lock_held() sets *ret to false even if the CPU did an
+ * then rcu_read_lock_held() sets ``*ret`` to false even if the CPU did an
  * rcu_read_lock().  The reason for this is that RCU ignores CPUs that are
  * in such a section, considering these as in extended quiescent state,
  * so such a CPU is effectively never in an RCU read-side critical section
-- 
2.9.5

