Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DA2A8AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgKEXrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgKEXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FD02222B;
        Thu,  5 Nov 2020 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620049;
        bh=T0FjSb+2JUQyF55Pcp5FDweFnihJ+OfAM/8uHYew/vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0v51xrdiHPgSqeHAvxPK2yl8h+744xcbnIIJbGp2HDBtD5+2dZQdqrRcrSZkv1Ad3
         QICOObSfZnbS6Iv1l+l5MtribX9uOi0G2nlOUkPyC4BQq8J7H67zYM3jpDh9WYq/ha
         cFt/TRcm3nGNhdoOj4L6e3s4VFB2oZ/lsCieCRVM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/28] torture: Allow alternative forms of kvm.sh command-line arguments
Date:   Thu,  5 Nov 2020 15:47:12 -0800
Message-Id: <20201105234719.23307-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit allows --build-only as a synonym for --buildonly, --kconfigs
for --kconfig, and --kmake-args for --kmake-arg.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c348d96..45d07b7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -93,7 +93,7 @@ do
 		TORTURE_BOOT_IMAGE="$2"
 		shift
 		;;
-	--buildonly)
+	--buildonly|--build-only)
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
@@ -160,7 +160,7 @@ do
 		jitter="$2"
 		shift
 		;;
-	--kconfig)
+	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="$2"
 		shift
@@ -171,7 +171,7 @@ do
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
-	--kmake-arg)
+	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		TORTURE_KMAKE_ARG="$2"
 		shift
-- 
2.9.5

