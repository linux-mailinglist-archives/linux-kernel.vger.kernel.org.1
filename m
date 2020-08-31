Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF4258053
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgHaSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbgHaSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311DE2158C;
        Mon, 31 Aug 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897274;
        bh=AoFABMNuUMuKavziJ+CJ7gaWS+Jxe+OMPXmajLA1ulY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXZrD7ndmQd7jEa4Ce6Z2C8dgcrrsnJZ/8Ajjbep7/Y5JVhqiVyorp+uowTqTc2Ni
         QJlZyWGXqeh6mNk2rvB75UhdP35qtaTJQBpgmNz73q1hc4k9kunGutctxr48p+mq2r
         3r7TdB5WRMJ2y4NafeNFLVuCunFQ8G8gON3Zz/2k=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/19] scftorture: Flag errors in torture-compatible manner
Date:   Mon, 31 Aug 2020 11:07:42 -0700
Message-Id: <20200831180749.843-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit prints error counts on the statistics line and also adds a
"!!!" if any of the counters are non-zero.  Allocation failures are
(somewhat) forgiven, but all other errors result in a "FAILURE" print
at the end of the test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 8ab72e5..880c2ce 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -132,6 +132,7 @@ static atomic_t n_mb_in_errs;
 static atomic_t n_mb_out_errs;
 static atomic_t n_alloc_errs;
 static bool scfdone;
+static char *bangstr = "";
 
 DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
@@ -156,12 +157,17 @@ static void scf_torture_stats_print(void)
 		scfs.n_all += scf_stats_p[i].n_all;
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
-	pr_alert("%s scf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
-		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count,
+	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
+	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+		bangstr = "!!! ";
+	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
-	pr_cont("\n");
+	pr_cont("ste: %d stnmie: %d stnmoe: %d staf: %d\n", atomic_read(&n_errs),
+		atomic_read(&n_mb_in_errs), atomic_read(&n_mb_out_errs),
+		atomic_read(&n_alloc_errs));
 }
 
 // Periodically prints torture statistics, if periodic statistics printing
@@ -431,7 +437,7 @@ static void scf_torture_cleanup(void)
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
 	scf_stats_p = NULL;
 
-	if (atomic_read(&n_errs))
+	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) || atomic_read(&n_mb_out_errs))
 		scftorture_print_module_parms("End of test: FAILURE");
 	else if (torture_onoff_failures())
 		scftorture_print_module_parms("End of test: LOCK_HOTPLUG");
-- 
2.9.5

