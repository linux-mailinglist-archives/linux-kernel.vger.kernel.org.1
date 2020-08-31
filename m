Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B36258025
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgHaSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4751E2083E;
        Mon, 31 Aug 2020 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896879;
        bh=Zbh/pZ6GMYwQgTre3hHAsRC/6AB66SwXMu7uVoO4QyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbICc07Ko9Wh+fbUI14UQsgCqfVCirxKWCeyhXa+vZgJerXFV+0mppE3Csw6mMpAq
         J9pEHKVimc9RPrNUo6Fes7VWbibtq9S/dPs5kzcg0zoQnq1zYTJxrAjV7u9p8M7JTt
         cCHfkm6NNZbmp9//+RgNSGni/iZhJ+NWdv4X8ico=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/24] rcu: Remove KCSAN stubs
Date:   Mon, 31 Aug 2020 11:00:53 -0700
Message-Id: <20200831180116.32690-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..eb36779 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -70,19 +70,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcutree."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 /* Data structures. */
 
 /*
-- 
2.9.5

