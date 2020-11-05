Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914942A8A60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgKEXFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbgKEXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:05:13 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BC020786;
        Thu,  5 Nov 2020 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617512;
        bh=B5qz8/pbLMRfWxS2c3CFYkUImDgnsI9uoX8t8gRK/Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+1XtkRA4CS1RFaCptOXcvVwu9tGhZOQANe4pebOs6PUZD8BU4JbIbRy0jhmPn1Q/
         fc4JtjStzTSf5bKqcz61EWoOSJQkcjFMsz8Udcv0bram6VrqRhwKJn90AbrL1p7KTQ
         px9qhBmEcwrSjDqCNKIjzBu9573AQPcRrWv3N+uA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] doc: Present the role of READ_ONCE()
Date:   Thu,  5 Nov 2020 15:05:07 -0800
Message-Id: <20201105230510.18660-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230444.GA18574@paulmck-ThinkPad-P72>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an explanation of the special cases where READ_ONCE()
may be used in place of a member of the rcu_dereference() family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst       | 7 +++++++
 Documentation/RCU/rcu_dereference.rst | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2efed99..bb7128e 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -314,6 +314,13 @@ over a rather long period of time, but improvements are always welcome!
 	shared between readers and updaters.  Additional primitives
 	are provided for this case, as discussed in lockdep.txt.
 
+	One exception to this rule is when data is only ever added to
+	the linked data structure, and is never removed during any
+	time that readers might be accessing that structure.  In such
+	cases, READ_ONCE() may be used in place of rcu_dereference()
+	and the read-side markers (rcu_read_lock() and rcu_read_unlock(),
+	for example) may be omitted.
+
 10.	Conversely, if you are in an RCU read-side critical section,
 	and you don't hold the appropriate update-side lock, you -must-
 	use the "_rcu()" variants of the list macros.  Failing to do so
diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index c9667eb..f3e587a 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -28,6 +28,12 @@ Follow these rules to keep your RCU code working properly:
 	for an example where the compiler can in fact deduce the exact
 	value of the pointer, and thus cause misordering.
 
+-	In the special case where data is added but is never removed
+	while readers are accessing the structure, READ_ONCE() may be used
+	instead of rcu_dereference().  In this case, use of READ_ONCE()
+	takes on the role of the lockless_dereference() primitive that
+	was removed in v4.15.
+
 -	You are only permitted to use rcu_dereference on pointer values.
 	The compiler simply knows too much about integral values to
 	trust it to carry dependencies through integer operations.
-- 
2.9.5

