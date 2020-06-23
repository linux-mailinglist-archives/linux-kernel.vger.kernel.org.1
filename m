Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE612045D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgFWAiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732168AbgFWAh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3512F214F1;
        Tue, 23 Jun 2020 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872678;
        bh=E5BTfsexFc4oh65As9t//1pXobSpwnW5MPrv9R7gL+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEvkdc82MT4vwxvl5zDY9TfZ/kQ1EESvAHTVxULFhU6dIgmDO4vBgEY9eC3Zt7sGq
         cKL8sXWJ6Exvqv5FtrB6hSu5R+FqzceP826Ls1oD3ge/z95amjuOcpnHL3UVqhgXGy
         U459BI7MUORTurdxozc9B7PIluu+0MmKdYe/62Qk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/23] torture: Avoid duplicate specification of qemu command
Date:   Mon, 22 Jun 2020 17:37:50 -0700
Message-Id: <20200623003752.26872-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the qemu command is constructed twice, once to dump it
to the qemu-cmd file and again to execute it.  This is of course an
accident waiting to happen, but is done to ensure that the remainder
of the script has an accurate idea of the running qemu command's PID.
This commit therefore places both the qemu command and the PID capture
into a new temporary file and sources that temporary file.  Thus the
single construction of the qemu command into the qemu-cmd file suffices
for both purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 5ec095d..484445b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -161,8 +161,16 @@ then
 	touch $resdir/buildonly
 	exit 0
 fi
+
+# Decorate qemu-cmd with redirection, backgrounding, and PID capture
+sed -e 's/$/ 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
+echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
+
+# In case qemu refuses to run...
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-( $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append "$qemu_append $boot_args" > $resdir/qemu-output 2>&1 & echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
+
+# Attempt to run qemu
+( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 sleep 10 # Give qemu's pid a chance to reach the file
 if test -s "$resdir/qemu_pid"
-- 
2.9.5

