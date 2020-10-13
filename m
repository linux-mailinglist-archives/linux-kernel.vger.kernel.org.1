Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E7128CE28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgJMMQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgJMMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:56 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E962122244;
        Tue, 13 Oct 2020 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=hNQ982P1mw1THcDhWH8BgWNVkAtYrFPtF5vVvTMsPDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWX56QfzgpCDD9hyEemc2eRFmpCq7l4yvkI5SPxikqEbLF/GyIeZs4H6OildTgbbW
         lyz0BNUj+Nm0oZk/ddCESjGVjQrISU61nVmvfuiqA1EkjkDG3qaIytqyq06X25t80J
         pyvd632C4e0lgAoawSMD6IdA0WjhlHgatsqSK+o8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006Cnx-PS; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/24] docs: lockdep-design: fix some warning issues
Date:   Tue, 13 Oct 2020 14:14:31 +0200
Message-Id: <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several warnings caused by a recent change
224ec489d3cd ("lockdep/Documention: Recursive read lock detection reasoning")

Those are reported by htmldocs build:

    Documentation/locking/lockdep-design.rst:429: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/locking/lockdep-design.rst:452: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/locking/lockdep-design.rst:453: WARNING: Unexpected indentation.
    Documentation/locking/lockdep-design.rst:453: WARNING: Blank line required after table.
    Documentation/locking/lockdep-design.rst:454: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/locking/lockdep-design.rst:455: WARNING: Unexpected indentation.
    Documentation/locking/lockdep-design.rst:455: WARNING: Blank line required after table.
    Documentation/locking/lockdep-design.rst:456: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/locking/lockdep-design.rst:457: WARNING: Unexpected indentation.
    Documentation/locking/lockdep-design.rst:457: WARNING: Blank line required after table.

Besides the reported issues, there are some missing blank
lines that ended producing wrong html output, and some
literals are not properly identified.

Also, the symbols used at the irq enabled/disable table
are not displayed as expected, as they're not literals.
Also, on another table they're using a different notation.

Fixes: 224ec489d3cd ("lockdep/Documention: Recursive read lock detection reasoning")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/locking/lockdep-design.rst | 69 ++++++++++++++----------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index cec03bd1294a..7ac0c5092c21 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -42,6 +42,7 @@ The validator tracks lock-class usage history and divides the usage into
 (4 usages * n STATEs + 1) categories:
 
 where the 4 usages can be:
+
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
@@ -49,10 +50,12 @@ where the 4 usages can be:
 
 where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
 now they include:
+
 - hardirq
 - softirq
 
 where the last 1 category is:
+
 - 'ever used'                                       [ == !unused        ]
 
 When locking rules are violated, these usage bits are presented in the
@@ -71,12 +74,12 @@ of the lock and readlock (if exists), for each of the n STATEs listed
 above respectively, and the character displayed at each bit position
 indicates:
 
-   ===  ===================================================
-   '.'  acquired while irqs disabled and not in irq context
-   '-'  acquired in irq context
-   '+'  acquired with irqs enabled
-   '?'  acquired in irq context with irqs enabled.
-   ===  ===================================================
+   =====  ===================================================
+   ``.``  acquired while irqs disabled and not in irq context
+   ``-``  acquired in irq context
+   ``+``  acquired with irqs enabled
+   ``?``  acquired in irq context with irqs enabled.
+   =====  ===================================================
 
 The bits are illustrated with an example::
 
@@ -96,14 +99,14 @@ exact case is for the lock as of the reporting time.
   +--------------+-------------+--------------+
   |              | irq enabled | irq disabled |
   +--------------+-------------+--------------+
-  | ever in irq  |      ?      |       -      |
+  | ever in irq  |    ``?``    |     ``-``    |
   +--------------+-------------+--------------+
-  | never in irq |      +      |       .      |
+  | never in irq |    ``+``    |     ``.``    |
   +--------------+-------------+--------------+
 
-The character '-' suggests irq is disabled because if otherwise the
-charactor '?' would have been shown instead. Similar deduction can be
-applied for '+' too.
+The character ``-`` suggests irq is disabled because if otherwise the
+charactor ``?`` would have been shown instead. Similar deduction can be
+applied for ``+`` too.
 
 Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
@@ -216,7 +219,7 @@ looks like this::
        BD_MUTEX_PARTITION
   };
 
-mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
+  mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
 
 In this case the locking is done on a bdev object that is known to be a
 partition.
@@ -334,7 +337,7 @@ Troubleshooting:
 ----------------
 
 The validator tracks a maximum of MAX_LOCKDEP_KEYS number of lock classes.
-Exceeding this number will trigger the following lockdep warning:
+Exceeding this number will trigger the following lockdep warning::
 
 	(DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
 
@@ -420,7 +423,8 @@ the critical section of another reader of the same lock instance.
 
 The difference between recursive readers and non-recursive readers is because:
 recursive readers get blocked only by a write lock *holder*, while non-recursive
-readers could get blocked by a write lock *waiter*. Considering the follow example:
+readers could get blocked by a write lock *waiter*. Considering the follow
+example::
 
 	TASK A:			TASK B:
 
@@ -448,20 +452,22 @@ There are simply four block conditions:
 
 Block condition matrix, Y means the row blocks the column, and N means otherwise.
 
-	    | E | r | R |
 	+---+---+---+---+
-	  E | Y | Y | Y |
+	|   | E | r | R |
 	+---+---+---+---+
-	  r | Y | Y | N |
+	| E | Y | Y | Y |
+	+---+---+---+---+
+	| r | Y | Y | N |
+	+---+---+---+---+
+	| R | Y | Y | N |
 	+---+---+---+---+
-	  R | Y | Y | N |
 
 	(W: writers, r: non-recursive readers, R: recursive readers)
 
 
 acquired recursively. Unlike non-recursive read locks, recursive read locks
 only get blocked by current write lock *holders* other than write lock
-*waiters*, for example:
+*waiters*, for example::
 
 	TASK A:			TASK B:
 
@@ -491,7 +497,7 @@ Recursive locks don't block each other, while non-recursive locks do (this is
 even true for two non-recursive read locks). A non-recursive lock can block the
 corresponding recursive lock, and vice versa.
 
-A deadlock case with recursive locks involved is as follow:
+A deadlock case with recursive locks involved is as follow::
 
 	TASK A:			TASK B:
 
@@ -510,7 +516,7 @@ because there are 3 types for lockers, there are, in theory, 9 types of lock
 dependencies, but we can show that 4 types of lock dependencies are enough for
 deadlock detection.
 
-For each lock dependency:
+For each lock dependency::
 
 	L1 -> L2
 
@@ -525,20 +531,25 @@ same types).
 With the above combination for simplification, there are 4 types of dependency edges
 in the lockdep graph:
 
-1) -(ER)->: exclusive writer to recursive reader dependency, "X -(ER)-> Y" means
+1) -(ER)->:
+	    exclusive writer to recursive reader dependency, "X -(ER)-> Y" means
 	    X -> Y and X is a writer and Y is a recursive reader.
 
-2) -(EN)->: exclusive writer to non-recursive locker dependency, "X -(EN)-> Y" means
+2) -(EN)->:
+	    exclusive writer to non-recursive locker dependency, "X -(EN)-> Y" means
 	    X -> Y and X is a writer and Y is either a writer or non-recursive reader.
 
-3) -(SR)->: shared reader to recursive reader dependency, "X -(SR)-> Y" means
+3) -(SR)->:
+	    shared reader to recursive reader dependency, "X -(SR)-> Y" means
 	    X -> Y and X is a reader (recursive or not) and Y is a recursive reader.
 
-4) -(SN)->: shared reader to non-recursive locker dependency, "X -(SN)-> Y" means
+4) -(SN)->:
+	    shared reader to non-recursive locker dependency, "X -(SN)-> Y" means
 	    X -> Y and X is a reader (recursive or not) and Y is either a writer or
 	    non-recursive reader.
 
-Note that given two locks, they may have multiple dependencies between them, for example:
+Note that given two locks, they may have multiple dependencies between them,
+for example::
 
 	TASK A:
 
@@ -592,11 +603,11 @@ circles that won't cause deadlocks.
 
 Proof for sufficiency (Lemma 1):
 
-Let's say we have a strong circle:
+Let's say we have a strong circle::
 
 	L1 -> L2 ... -> Ln -> L1
 
-, which means we have dependencies:
+, which means we have dependencies::
 
 	L1 -> L2
 	L2 -> L3
@@ -633,7 +644,7 @@ a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn is waitin
 for a lock held by P1. Let's name the lock Px is waiting as Lx, so since P1 is waiting
 for L1 and holding Ln, so we will have Ln -> L1 in the dependency graph. Similarly,
 we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, which means we
-have a circle:
+have a circle::
 
 	Ln -> L1 -> L2 -> ... -> Ln
 
-- 
2.26.2

