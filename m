Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A932A70E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgKDXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:02:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:43329 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgKDXCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:02:03 -0500
IronPort-SDR: 8a6Me5KAuiSQzYFaWr6De6Op3faT2YVoH20FhpR04VlTCGN/sy97+YosImLIYGblbEMKHHAGRY
 x/acQgQ+YE+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="168515879"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="168515879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:02:03 -0800
IronPort-SDR: RcQ8wOdDMqUzKMR+2dFiho6BkaIj9363eDrmCkK26tEM4EQGbYXHZwWyDsYjqDoqUdNd2TgUI8
 JRr2OWw36eiw==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="539117083"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:01:59 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] entry: Fix spelling/typo errors in irq entry code
Date:   Wed,  4 Nov 2020 15:01:57 -0800
Message-Id: <20201104230157.3378023-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

s/reguired/required/
s/Interupts/Interrupts/
s/quiescient/quiescent/
s/assemenbly/assembly/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/entry-common.h | 4 ++--
 kernel/entry/common.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1a128baf3628..66938121c4b1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -415,7 +415,7 @@ void irqentry_exit_cond_resched(void);
  * @state:	Return value from matching call to irqentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and reguired and returns to
+ * preemption and work checks if possible and required and returns to
  * the caller with interrupts disabled and no further work pending.
  *
  * This is the last action before returning to the low level ASM code which
@@ -438,7 +438,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
  * @regs:	Pointer to pt_regs (NMI entry regs)
  * @irq_state:	Return value from matching call to irqentry_nmi_enter()
  *
- * Last action before returning to the low level assmenbly code.
+ * Last action before returning to the low level assmebly code.
  *
  * Counterpart to irqentry_nmi_enter().
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bc75c114c1b3..fa17baadf63e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -304,7 +304,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * If this entry hit the idle task invoke rcu_irq_enter() whether
 	 * RCU is watching or not.
 	 *
-	 * Interupts can nest when the first interrupt invokes softirq
+	 * Interrupts can nest when the first interrupt invokes softirq
 	 * processing on return which enables interrupts.
 	 *
 	 * Scheduler ticks in the idle task can mark quiescent state and
@@ -315,7 +315,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interupt and eventually claim
-	 * quiescient state and end grace periods prematurely.
+	 * quiescent state and end grace periods prematurely.
 	 *
 	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
 	 * consistent.
-- 
2.28.0.rc0.12.gb6a658bd00c9

