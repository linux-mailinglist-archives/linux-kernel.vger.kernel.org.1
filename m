Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524FE2045D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgFWAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgFWAhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141D320738;
        Tue, 23 Jun 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872674;
        bh=VrUSpxkjktIEJodASfU7Z21kK0CmqzW1YdDym97jZQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxCYfi4GEc+W/lzA59Qs89EdsV150P8PWbsqefOgSFHi2zbzl56Hqy+Ikp24P+EwU
         +8ieNykvB5gYVzTgumA199kLZLawxj/S0KI42F071lX3MpCt1wVYMCUT6L893CUr18
         AmiRG8/GVR091YqpWwRsNm2dSx/hrxVRGAI/9UBQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH tip/core/rcu 01/23] torture:  Remove qemu dependency on EFI firmware
Date:   Mon, 22 Jun 2020 17:37:30 -0700
Message-Id: <20200623003752.26872-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

On some (probably misconfigured) systems, the torture-test scripting
will cause qemu to complain about missing EFI firmware, often because
qemu is trying to traverse broken symbolic links to find that firmware.
Which is a bit silly given that the default torture-test guest OS has
but a single binary for its userspace, and thus is unlikely to do much
in the way of networking in any case.

This commit therefore avoids such problems by specifying "-net none"
to qemu unless the TORTURE_QEMU_INTERACTIVE environment variable is set
(for example, by having specified "--interactive" to kvm.sh), in which
case "-net nic -net user" is specified to qemu instead.  Either choice
may be overridden by specifying the "-net" argument of your choice to
the kvm.sh "--qemu-args" parameter.

Link: https://lore.kernel.org/lkml/20190701141403.GA246562@google.com
Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 21 ++++++++++++++++++---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh      |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 1281022..436b154 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -215,9 +215,6 @@ identify_qemu_args () {
 		then
 			echo -device spapr-vlan,netdev=net0,mac=$TORTURE_QEMU_MAC
 			echo -netdev bridge,br=br0,id=net0
-		elif test -n "$TORTURE_QEMU_INTERACTIVE"
-		then
-			echo -net nic -net user
 		fi
 		;;
 	esac
@@ -275,3 +272,21 @@ specify_qemu_cpus () {
 		esac
 	fi
 }
+
+# specify_qemu_net qemu-args
+#
+# Appends a string containing "-net none" to qemu-args, unless the incoming
+# qemu-args already contains "-smp" or unless the TORTURE_QEMU_INTERACTIVE
+# environment variable is set, in which case the string that is be added is
+# instead "-net nic -net user".
+specify_qemu_net () {
+	if echo $1 | grep -q -e -net
+	then
+		echo $1
+	elif test -n "$TORTURE_QEMU_INTERACTIVE"
+	then
+		echo $1 -net nic -net user
+	else
+		echo $1 -net none
+	fi
+}
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6ff611c..1b9aebd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -141,6 +141,7 @@ then
 	cpu_count=$TORTURE_ALLOTED_CPUS
 fi
 qemu_args="`specify_qemu_cpus "$QEMU" "$qemu_args" "$cpu_count"`"
+qemu_args="`specify_qemu_net "$qemu_args"`"
 
 # Generate architecture-specific and interaction-specific qemu arguments
 qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
-- 
2.9.5

