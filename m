Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34E2A8AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgKEXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732723AbgKEXr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461A422210;
        Thu,  5 Nov 2020 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620047;
        bh=EUfmz7vlnAcV4PmVQNw94o5UzBa+JkcC4cHH7Yx8oLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqbi7hzO5DOwKdOKuerDJ5JqjnfeZND4DjRvrDkpHZyc5QBLA0fXq0dpCEnA5Wku1
         eXLl1EIYach9i3OdVkRehcchJ/u1lVKARqzBQoEFxxO5xmt8QIg5zV0HcLyw7NKgBU
         AyL3/VOb51ut1ijvW6IfpMjzbQmU8baA3pGfszOI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/28] torture: Prevent jitter processes from delaying failed run
Date:   Thu,  5 Nov 2020 15:47:06 -0800
Message-Id: <20201105234719.23307-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Even when the kernel panics and qemu dies, runs with jitter enabled will
continue uselessly until the jitter.sh processes terminate.  This can
be annoying if a planned one-hour run instead dies during boot.

This commit therefore kills the jitter.sh processes when the run ends
more than one minute prior to the termination time specified by the
kvm.sh --duration argument or its default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 14 ++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index d04966a..3cd03d0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -226,6 +226,20 @@ do
 				echo "ps -fp $killpid" >> $resdir/Warnings 2>&1
 				ps -fp $killpid >> $resdir/Warnings 2>&1
 			fi
+			# Reduce probability of PID reuse by allowing a one-minute buffer
+			if test $((kruntime + 60)) -lt $seconds && test -s "$resdir/../jitter_pids"
+			then
+				awk < "$resdir/../jitter_pids" '
+				NF > 0 {
+					pidlist = pidlist " " $1;
+					n++;
+				}
+				END {
+					if (n > 0) {
+						print "kill " pidlist;
+					}
+				}' | sh
+			fi
 		else
 			echo ' ---' `date`: "Kernel done"
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6eb1d3f..5ad3882 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -459,8 +459,11 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	for (j = 0; j < njitter; j++)
+	print "\techo > " rd "jitter_pids"
+	for (j = 0; j < njitter; j++) {
 		print "\tjitter.sh " j " " dur " " ja[2] " " ja[3] "&"
+		print "\techo $! >> " rd "jitter_pids"
+	}
 	print "\twait"
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
-- 
2.9.5

