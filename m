Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3434C1AAFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411400AbgDORez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411117AbgDORbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2C621556;
        Wed, 15 Apr 2020 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971863;
        bh=o7s+nb4IFo8XsLFZfVkqmDwCaBeH1xn6gx6poVypWSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvRLqN988VVb5QUKsDLwBqM7YkO341Ci3TtURo19wgMCT9b7FniEspc9D+GO/q2UY
         ZfXuq7g0NwprToDo2RFD5FM5q416uqve4Pl/d998GkyulP2VAU3p2NekCEg7QjjRd2
         XaG6QqJJT3W1Krpis08SZiuDoUQukpWc1XjorqzI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/18] locktorture.c: Fix if-statement empty body warnings
Date:   Wed, 15 Apr 2020 10:30:46 -0700
Message-Id: <20200415173100.9927-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When using -Wextra, gcc complains about torture_preempt_schedule()
when its definition is empty (i.e., when CONFIG_PREEMPTION is not
set/enabled).  Fix these warnings by adding an empty do-while block
for that macro when CONFIG_PREEMPTION is not set.
Fixes these build warnings:

../kernel/locking/locktorture.c:119:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:166:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:337:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:490:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:528:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:553:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

I have verified that there is no object code change (with gcc 7.5.0).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
---
 include/linux/torture.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 6241f59..629b66e 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -89,7 +89,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() preempt_schedule()
 #else
-#define torture_preempt_schedule()
+#define torture_preempt_schedule()	do { } while (0)
 #endif
 
 #endif /* __LINUX_TORTURE_H */
-- 
2.9.5

