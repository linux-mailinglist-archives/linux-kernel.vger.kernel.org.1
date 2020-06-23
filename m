Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5E204567
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgFWAbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbgFWAaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C2420776;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=IZSNB4AWn6OuXatm8zVziiAtvfUYw2x70nXoriANTTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnHn3n48N9gZljrx59kSS/CL7ijWi8m1BRUJcEmPX3bCBOr8vZqHuDkyKJG1h9yvp
         szNFKGTMswpZkLMvLz8dIAwCKK7myT//CqYkXX49j50kY070vOJEN7MwN1yc8F+d1t
         rolFfWUwR0rTBXyZ5wbPCLaYcZYRbFuLaxgXftk8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/30] refperf: Output per-experiment data points
Date:   Mon, 22 Jun 2020 17:30:01 -0700
Message-Id: <20200623003013.26252-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, it is necessary to manually edit the console output to see
anything more than statistics, and sometimes the statistics can indicate
outliers that need more investigation.  This commit therefore dumps out
the per-experiment measurements, sorted in ascending order, just before
dumping out the statistics.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
index 0660f3f..0e29cfd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -59,6 +59,10 @@ END {
 		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
 	else
 		medianvalue = readertimes[medianidx];
+	points = "Points:";
+	for (i = 1; i <= newNR; i++)
+		points = points " " readertimes[i];
+	print points;
 	print "Average reader duration: " sum / newNR " nanoseconds";
 	print "Minimum reader duration: " readertimes[1];
 	print "Median reader duration: " medianvalue;
-- 
2.9.5

