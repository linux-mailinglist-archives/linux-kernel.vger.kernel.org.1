Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7359C2A8AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgKEXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKEXrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F88A20786;
        Thu,  5 Nov 2020 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620042;
        bh=/lJf2+3oQzzr/BP2vTNimxkzBn9BBeAJK3y0XemQ29k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW4jgD4UYCXz3n+kANrZWiAx9wjAKa3hAhsyxVUb4t+cVzBNzjYL7pKPdolQoeWPl
         jBJt3Lz3nxXVaqepKPM7GQNrQ8hKVKcBGzWMG+N3twasG2ifFFJgdqdM5fa+wGYGp3
         o7QKbfS09qqc4Xc6jK9fx920OW4b1vjGb+SKAPsE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/28] torture: Don't kill gdb sessions
Date:   Thu,  5 Nov 2020 15:46:53 -0800
Message-Id: <20201105234719.23307-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture scripting will do a "kill -9" on any guest OS that exceeds
its --duration by more than a few minutes, which is very valuable when
bugs result in hangs.  However, this is a problem when the "hang" was due
to a --gdb debugging session.

This commit therefore refrains from killing the guest OS when a debugging
session is in progress.  This means that the user must manually kill the
kvm.sh process group if a hang really does occur.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6dc2b49..d04966a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -206,7 +206,10 @@ do
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
-		if test $kruntime -ge $seconds -o -f "$TORTURE_STOPFILE"
+		if test -n "$TORTURE_KCONFIG_GDB_ARG"
+		then
+			:
+		elif test $kruntime -ge $seconds || test -f "$TORTURE_STOPFILE"
 		then
 			break;
 		fi
-- 
2.9.5

