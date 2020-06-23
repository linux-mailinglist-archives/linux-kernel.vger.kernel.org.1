Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB01E2045DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgFWAih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbgFWAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6E32145D;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=9I5Y27ZTrQcqUy9STDR0VsTK0ZGdaJ7BMzoY/xb3kxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4Y/I3gbmY4zViJgTtXf10veRE6ew/UhIVsRqUgFvjAdj/74jNrsmF0S3jMN6S1UL
         oJibePoDe52q01F/iTo34EuGxKQZjFgC0a1Lfzyshd+TvQY2FlTG7dDr1NMK/dgRWn
         E5UF6zsv3HMnEPh5wqRaHBjAaHfm47gSFzcZ6NPg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/23] torture: Improve diagnostic for KCSAN-incapable compilers
Date:   Mon, 22 Jun 2020 17:37:46 -0700
Message-Id: <20200623003752.26872-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Using --kcsan when the compiler does not support KCSAN results in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16

This is a bit obtuse, so this commit adds checks resulting in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Compiler or architecture does not support KCSAN!
Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 357899c..840a467 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -44,7 +44,8 @@ do
 			then
 				echo QEMU killed
 			fi
-			configcheck.sh $i/.config $i/ConfigFragment
+			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
+			cat $T
 			if test -r $i/Make.oldconfig.err
 			then
 				cat $i/Make.oldconfig.err
@@ -73,7 +74,11 @@ do
 	done
 	if test -f "$rd/kcsan.sum"
 	then
-		if test -s "$rd/kcsan.sum"
+		if grep -q CONFIG_KCSAN=y $T
+		then
+			echo "Compiler or architecture does not support KCSAN!"
+			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
+		elif test -s "$rd/kcsan.sum"
 		then
 			echo KCSAN summary in $rd/kcsan.sum
 		else
-- 
2.9.5

