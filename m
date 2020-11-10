Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA832AC9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgKJA42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgKJA4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:24 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10EC2078D;
        Tue, 10 Nov 2020 00:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969784;
        bh=CYq5L7aKyPaBeb3sSYl/+uF8Y+2Sxn2f3Nh5Rwl3ey8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxuhK+7FNRjD1qf/ZlSVQNWAuowWJAmTqkjJLwkmfgNaxdh7EbBB17m2GkuFTgJ8j
         nEIaGu/z9uzcvyHyjd1fSkFA4DVJxOVpUkf/TXS+BOPhqmyQ1/n184gyQ+qAPqPXR1
         KZtI07gn2en+B1OC/fJCpHAWI98osSL1BilNDvmQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 3/7] preempt: Introduce CONFIG_PREEMPT_DYNAMIC
Date:   Tue, 10 Nov 2020 01:56:05 +0100
Message-Id: <20201110005609.40989-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110005609.40989-1-frederic@kernel.org>
References: <20201110005609.40989-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@kernel.org>

Preemption mode selection is currently hardcoded on Kconfig choices.
Introduce a dedicated option to tune preemption flavour at boot time,

This will be only available on architectures efficiently supporting
static calls in order not to tempt with the feature against additional
overhead that might be prohibitive or undesirable.

CONFIG_PREEMPT_DYNAMIC is automatically selected by CONFIG_PREEMPT if
the architecture provides the necessary support (CONFIG_STATIC_CALL_INLINE,
CONFIG_GENERIC_ENTRY, and provide with __preempt_schedule_function() /
__preempt_schedule_notrace_function()).

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
[Added documentation, reorganize dependencies on top of static call,
 etc...]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 arch/Kconfig                                  |  9 +++++++++
 arch/x86/Kconfig                              |  1 +
 kernel/Kconfig.preempt                        | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..f03c4c447871 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3902,6 +3902,13 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	preempt=	[KNL]
+			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
+			none - Limited to cond_resched() calls
+			voluntary - Limited to cond_resched() and might_sleep() calls
+			full - Any section that isn't explicitly preempt disabled
+			       can be preempted anytime.
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..69e0c7f15a7f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1028,6 +1028,15 @@ config HAVE_STATIC_CALL_INLINE
 	bool
 	depends on HAVE_STATIC_CALL
 
+config HAVE_PREEMPT_DYNAMIC
+	bool
+	depends on HAVE_STATIC_CALL_INLINE
+	depends on GENERIC_ENTRY
+	help
+	   Select this if the architecture support boot time preempt setting
+	   on top of static calls. It is strongly advised to support inline
+	   static call to avoid any overhead.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..8a57fdfd3372 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -217,6 +217,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
+	select HAVE_PREEMPT_DYNAMIC		if HAVE_STATIC_CALL_INLINE
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..416017301660 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -40,6 +40,7 @@ config PREEMPT
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -80,3 +81,21 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config PREEMPT_DYNAMIC
+	bool
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model defined during compile time.
+
+	  The feature is primarily interesting for Linux distributions which
+	  provide a pre-built kernel binary to reduce the number of kernel
+	  flavors they offer while still offering different usecases.
+
+	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
+	  but if runtime patching is not available for the specific architecture
+	  then the potential overhead should be considered.
+
+	  Interesting if you want the same pre-built kernel should be used for
+	  both Server and Desktop workloads.
-- 
2.25.1

