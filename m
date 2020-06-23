Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9C2045DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgFWAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbgFWAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A902137B;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=p3AXeB+VOEIX1532PITIGWynvghXPAsUq+RRT6GbDv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCf3ywLixTvLSK63to03mfAKo3/FFbl6Y4zOmoaBW10blwxnmXgdQXVvrg47lp2SG
         qyP/Hpckp2dkriYdLNluw3pmvyl5UEDeHzy+X/CUYNzO9e73HP3FMcUJxfY/NTY9ri
         SJifybKJVc/VjGBqQpaCtTu9hOw0Xoiz47M1ehjE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/23] torture: Correctly summarize build-only runs
Date:   Mon, 22 Jun 2020 17:37:45 -0700
Message-Id: <20200623003752.26872-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, kvm-recheck.sh complains that qemu failed for --buildonly
runs, which is sort of true given that qemu can hardly succeed if not
invoked in the first place.  Nevertheless, this commit swaps the order
of checks in kvm-recheck.sh so that --buildonly runs will be summarized
more straightforwardly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 2261aa6..357899c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -56,15 +56,15 @@ do
 				cat $i/Warnings
 			fi
 		else
-			if test -f "$i/qemu-cmd"
-			then
-				print_bug qemu failed
-				echo "   $i"
-			elif test -f "$i/buildonly"
+			if test -f "$i/buildonly"
 			then
 				echo Build-only run, no boot/test
 				configcheck.sh $i/.config $i/ConfigFragment
 				parse-build.sh $i/Make.out $configfile
+			elif test -f "$i/qemu-cmd"
+			then
+				print_bug qemu failed
+				echo "   $i"
 			else
 				print_bug Build failed
 				echo "   $i"
-- 
2.9.5

