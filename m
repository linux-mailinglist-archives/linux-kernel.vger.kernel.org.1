Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A859F2A8AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgKEXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732755AbgKEXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E68322240;
        Thu,  5 Nov 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620048;
        bh=96ODmDJ3cRDcTeRTDXrjnZS4XG/tyf14tEuJmUfzLjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOGtiFWnBA8yRd4bMmwb9Lg4LzERVsZ3GWoPlPcYz7J/7/wtEI4WE403slwIVP/OB
         vFR3sLTidbmLH3I1XLACkiZR86y2vq56qirwOZV2Ta5KTU80eEa/l8l14qWS11yvfz
         j8Fyibtmnc8G31EAeH1Q6PKxTxznd+UCjvIwBNjk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/28] torture: Accept time units on kvm.sh --duration argument
Date:   Thu,  5 Nov 2020 15:47:10 -0800
Message-Id: <20201105234719.23307-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The "--duration <minutes>" has worked well for a very long time, but
it can be inconvenient to compute the minutes for (say) a 28-hour run.
It can also be annoying to have to let a simple boot test run for a full
minute.  This commit therefore permits an "s" suffix to specify seconds,
"m" to specify minutes (which remains the default), "h" suffix to specify
hours, and "d" to specify days.

With this change, "--duration 5" still specifies that each scenario
run for five minutes, but "--duration 30s" runs for only 30 seconds,
"--duration 8h" runs for eight hours, and "--duration 2d" runs for
two days.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 5ad3882..c348d96 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -58,7 +58,7 @@ usage () {
 	echo "       --datestamp string"
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
-	echo "       --duration minutes"
+	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
 	echo "       --interactive"
@@ -128,8 +128,20 @@ do
 		shift
 		;;
 	--duration)
-		checkarg --duration "(minutes)" $# "$2" '^[0-9]*$' '^error'
-		dur=$(($2*60))
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		dur=$(($ts*mult))
 		shift
 		;;
 	--gdb)
-- 
2.9.5

