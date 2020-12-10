Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CE2D60D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbgLJQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:50070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403878AbgLJQCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:02:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UBdhfTeZFPV/WlRCoCmgMOObv3xVeQp7Xthma7ZsbQ=;
        b=iSAhx4Glh/qHIPRMVFfarsTbpAwI8izNB4FbBDdU4IpHKcwGJxCiFGr1wcgu3ey6gs2fFF
        WgP09aUXcCugYhDfWiterar4/hb4oitAZOwRfzzFEaUsPT991g+OaqQqMa9hZUMcB8Zxue
        9g/UXDyaZ5i77z8P1sOyPawQsYGUMRo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 979E0AF21;
        Thu, 10 Dec 2020 16:00:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 5/7] watchdog: Fix barriers when printing backtraces from all CPUs
Date:   Thu, 10 Dec 2020 17:00:36 +0100
Message-Id: <20201210160038.31441-6-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any parallel softlockup reports are skipped when one CPU is already
printing backtraces from all CPUs.

The exclusive rights are synchronized using one bit in
soft_lockup_nmi_warn. There is also one memory barrier that
does not make much sense.

Use two barriers on the right location to prevent mixing two
reports.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index dc8a0bf943f5..6dc1f79e36aa 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -409,12 +409,18 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (kvm_check_and_clear_guest_paused())
 			return HRTIMER_RESTART;
 
+		/*
+		 * Prevent multiple soft-lockup reports if one cpu is already
+		 * engaged in dumping all cpu back traces.
+		 */
 		if (softlockup_all_cpu_backtrace) {
-			/* Prevent multiple soft-lockup reports if one cpu is already
-			 * engaged in dumping cpu back traces
-			 */
 			if (test_and_set_bit(0, &soft_lockup_nmi_warn))
 				return HRTIMER_RESTART;
+			/*
+			 * Make sure that reports are serialized. Start
+			 * printing after getting the exclusive rights.
+			 */
+			smp_mb__after_atomic();
 		}
 
 		/* Start period for the next softlockup warning. */
@@ -431,14 +437,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			dump_stack();
 
 		if (softlockup_all_cpu_backtrace) {
-			/* Avoid generating two back traces for current
-			 * given that one is already made above
-			 */
 			trigger_allbutself_cpu_backtrace();
-
+			/*
+			 * Make sure that everything is printed before
+			 * another CPU is allowed to report lockup again.
+			 */
+			smp_mb__before_atomic();
+			/* Allow a further report. */
 			clear_bit(0, &soft_lockup_nmi_warn);
-			/* Barrier to sync with other cpus */
-			smp_mb__after_atomic();
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-- 
2.26.2

