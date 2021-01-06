Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A62EC232
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbhAFR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbhAFR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:28:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F33B923332;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953973;
        bh=JjfeWkGe0y+IZoZeQ03Wc2KTtZlD+m1NdB7T7XrQ+5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rN1MJxcEuT/5SorvhuFvy74fQGxRyZn1tKJ5rXY8vCdrL5xswvqPOgd5D13I6WfEB
         iDfvX/7D6AYiXO2+FoZRBUP8YuOaDHCPlsnsgkc5ciTw+wCWd51KguUgzaff8upxk2
         6SEDe8Y3YFWqMAjSAHtshkK4tp8l78qQDbYfqfrJBvx5d0efwFKUCBGbdvwQQjSVCn
         vbKze6qo2NatVMc/gPccPqcnKXadri/dQLA4syPQnWBQsFdQnxKccMSbAyPanpoGdJ
         3v5eHCC6AgNdRVTMi09mTShO0Sa3zPPH6qo+xUeBOTiStgShTSIbg41QaSGqz4VK+X
         eQX89DkG5CSIw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/20] torture: Do Kconfig analysis only once per scenario
Date:   Wed,  6 Jan 2021 09:26:07 -0800
Message-Id: <20210106172607.22816-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if a scenario is repeated as in "--configs '4*TREE01'",
the Kconfig analysis is performed for each occurrance (four times in
this example) and each analysis places the exact same data into the
exact same files.  This is not really an issue in this repetition-four
example, but it can needlessly consume tens of seconds of wallclock time
for something like "--config '128*TINY01'".

This commit therefore does Kconfig analysis only once per set of
repeats of a given scenario, courtesy of the "sort -u" command and an
automatically generated awk script.

While in the area, this commit also wordsmiths a comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6051868..52a3c35 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -286,7 +286,8 @@ then
 		exit 1
 	fi
 fi
-for CF1 in $configs_derep
+echo 'BEGIN {' > $T/cfgcpu.awk
+for CF1 in `echo $configs_derep | tr -s ' ' '\012' | sort -u`
 do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
@@ -299,12 +300,20 @@ do
 		fi
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
-		echo $CF1 $cpu_count >> $T/cfgcpu
+		echo 'scenariocpu['"$CF1"'] = '"$cpu_count"';' >> $T/cfgcpu.awk
 	else
 		echo "The --configs file $CF1 does not exist, terminating."
 		exit 1
 	fi
 done
+cat << '___EOF___' >> $T/cfgcpu.awk
+}
+{
+	for (i = 1; i <= NF; i++)
+		print $i, scenariocpu[$i];
+}
+___EOF___
+echo $configs_derep | awk -f $T/cfgcpu.awk > $T/cfgcpu
 sort -k2nr $T/cfgcpu -T="$T" > $T/cfgcpu.sort
 
 # Use a greedy bin-packing algorithm, sorting the list accordingly.
@@ -324,11 +333,10 @@ END {
 	batch = 0;
 	nc = -1;
 
-	# Each pass through the following loop creates on test batch
-	# that can be executed concurrently given ncpus.  Note that a
-	# given test that requires more than the available CPUs will run in
-	# their own batch.  Such tests just have to make do with what
-	# is available.
+	# Each pass through the following loop creates on test batch that
+	# can be executed concurrently given ncpus.  Note that a given test
+	# that requires more than the available CPUs will run in its own
+	# batch.  Such tests just have to make do with what is available.
 	while (nc != ncpus) {
 		batch++;
 		nc = ncpus;
-- 
2.9.5

