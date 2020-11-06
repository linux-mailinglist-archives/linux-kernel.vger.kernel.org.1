Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59C2A8AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbgKEXsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbgKEXrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F330A2222A;
        Thu,  5 Nov 2020 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620051;
        bh=uT5n8qK9bxjpcW9G+W8gBoRmQpU8JHI58eqEgyEwSJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFeU/bIG0zeHjjxYtWEKumsdeVWmaDxI3Tv5eOAOMNufb1NUds3/IgXEO72h8koTT
         gNXzF/Kcg07asPJRV8gflNfuOgXxBZdlk+u4zbTHtDpedN19vUx1wMFj76PJ9ToarB
         /Nzk4MGqHmMRMxtyqkuG/nPWjAiQQQl2iNMO4JP8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/28] torture: Make kvm-check-branches.sh use --allcpus
Date:   Thu,  5 Nov 2020 15:47:17 -0800
Message-Id: <20201105234719.23307-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently the kvm-check-branches.sh script calculates the number of CPUs
and passes this to the kvm.sh --cpus command-line argument.  This works,
but this commit saves a line by instead using the new kvm.sh --allcpus
command-line argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index 6e65c13..370406b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -52,8 +52,7 @@ echo Results directory: $resdir/$ds
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
-cpus="`identify_qemu_vcpus`"
-echo Using up to $cpus CPUs.
+echo Using all `identify_qemu_vcpus` CPUs.
 
 # Each pass through this loop does one command-line argument.
 for gitbr in $@
@@ -74,7 +73,7 @@ do
 		# Test the specified commit.
 		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
 		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --cpus $cpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		kvm.sh --allcpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
 		ret=$?
 		echo kvm.sh return code $ret for commit $i from branch $gitbr
 
-- 
2.9.5

