Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C42D6226
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbgLJQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:39:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:50072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403877AbgLJQCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:02:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XJru3oceA6SYsxNHW2407YnJ691ilSchVA0HaatcT8=;
        b=p7S5EekdT7CCmlJ/mbg63d91Fa67EbCpDGZbWzq96/ZpfAGHnrjGpq6BcxfMU9O82WXJLm
        VepYOODAlcn2VM3zAKlpWxkVGwFaDW3IqgghR5BUJbh1q4s9zmIB7yk2ozGk2L7DSu+p9f
        Anq8Y37fLyXkNzzZSKD+0q9I6kiqeME=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D35BAF1F;
        Thu, 10 Dec 2020 16:00:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/7] watchdog/softlockup: Remove logic that tried to prevent repeated reports
Date:   Thu, 10 Dec 2020 17:00:35 +0100
Message-Id: <20201210160038.31441-5-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup detector does some gymnastic with the variable
soft_watchdog_warn. It was added by the commit 58687acba59266735ad
("lockup_detector: Combine nmi_watchdog and softlockup detector").

The purpose is not completely clear. There are the following clues.
They describe the situation how it looked after the above mentioned
commit:

  1. The variable was checked with a comment "only warn once".

  2. The variable was set when softlockup was reported. It was cleared
     only when the CPU was not longer in the softlockup state.

  3. watchdog_touch_ts was not explicitly updated when the softlockup
     was reported. Without this variable, the report would normally
     be printed again during every following watchdog_timer_fn()
     invocation.

The logic has got even more tangled up by the commit ed235875e2ca98
("kernel/watchdog.c: print traces for all cpus on lockup detection").
After this commit, soft_watchdog_warn is set only when
softlockup_all_cpu_backtrace is enabled. But multiple reports
from all CPUs are prevented by a new variable soft_lockup_nmi_warn.

Conclusion:

The variable probably never worked as intended. In each case, it has
not worked last many years because the softlockup was reported
repeatedly after the full period defined by watchdog_thresh.

The reason is that watchdog gets touched in many known slow paths,
for example, in printk_stack_address(). This code is called also when
printing the softlockup report. It means that the watchdog timestamp
gets updated after each report.

Solution:

Simply remove the logic. People want the periodic report anyway.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6259590d6474..dc8a0bf943f5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -179,7 +179,6 @@ static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 static DEFINE_PER_CPU(unsigned long, watchdog_report_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
-static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
@@ -410,19 +409,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (kvm_check_and_clear_guest_paused())
 			return HRTIMER_RESTART;
 
-		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true)
-			return HRTIMER_RESTART;
-
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
 			 * engaged in dumping cpu back traces
 			 */
-			if (test_and_set_bit(0, &soft_lockup_nmi_warn)) {
-				/* Someone else will report us. Let's give up */
-				__this_cpu_write(soft_watchdog_warn, true);
+			if (test_and_set_bit(0, &soft_lockup_nmi_warn))
 				return HRTIMER_RESTART;
-			}
 		}
 
 		/* Start period for the next softlockup warning. */
@@ -452,9 +444,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
-		__this_cpu_write(soft_watchdog_warn, true);
-	} else
-		__this_cpu_write(soft_watchdog_warn, false);
+	}
 
 	return HRTIMER_RESTART;
 }
-- 
2.26.2

