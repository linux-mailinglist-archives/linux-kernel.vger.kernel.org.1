Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0407D2EC21E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbhAFR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbhAFR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB26D23133;
        Wed,  6 Jan 2021 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953969;
        bh=5iIO47PhcBcNvzRC7tTRuDZwefPyekFksblsx7V83oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxcB+AinGyPnAEW+e3OkwJRYW8qL7yTMGDc2QGhPQXIF1L8aj/gi6FG8HewwT4Iyz
         KvYy4VPNDSBtrAbTjxe3t9XGnXdXAUdaKT4Am+NF/CGJZobPmwIVwDgurXyK32cxY6
         LlbAiGqXcVorRrEse+4GiPgdE+Kt5GWYgKNyNTFtg+HeN+wxM02fMIExOQOonLI1Hs
         GvhYqAi/54SC3GGwJwvTZMazYeD+fxypk/iYv9IY8JiO7MR7DghOCqV1ZJfCXR1M39
         vQzTcReFVSiBstREYQehGF/ly/Pv3bvQrlMw3DI5f+j6p7q+mHNuVvsmhIrD/XZ1v7
         r+tpUMSqSWs8Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/20] torture: Make kvm.sh "--dryrun sched" summarize number of builds
Date:   Wed,  6 Jan 2021 09:25:50 -0800
Message-Id: <20210106172607.22816-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Knowing the number of builds that kvm.sh will split a run into allows
estimation of the duration of a test, give or take build duration.
This commit therefore adds a line of output to "--dryrun sched" that
gives the number of builds that will be run.  This excludes "builds"
for repeated scenarios that reuse an earlier build.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1078be1..55a18a9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -536,6 +536,10 @@ then
 	egrep 'Start batch|Starting build\.' $T/script |
 		grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
+	nbuilds="`grep 'Starting build\.' $T/script |
+		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
+		  awk '{ print $1 }' | grep -v '\.' | wc -l`"
+	echo Total number of builds: $nbuilds
 	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
 	echo Total number of batches: $nbatches
 	exit 0
-- 
2.9.5

