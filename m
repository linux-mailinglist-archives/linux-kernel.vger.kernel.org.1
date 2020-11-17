Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A732C2B6750
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKQOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgKQOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:21 -0500
Message-Id: <20201117132006.660902274@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UsP2g8myaOh8ImRMhGICrJ9Xf/zgu9DkLjqH3753JA=;
        b=CueIWo4PHVBFNa+6oNLDmabyxupMzBr1fONJx73niki83XcLzOVaAlw5EqFAj4dOvY4ukB
        ASSsuLXWU4Ya2qNr8s3AQwjLa94W1+eqFr6Z4GawbqqcNt9lA136R4BBTGeCbSZYF6Raoi
        MOP1DBV/PRJkqmBITtaKzpQKbcgef5AKScRbu0B2o0HBUpDTsGjSl75HHUYbbnakR7HpbC
        hjBCKnHgJILAP7CYy8HVhrMU3v9p1cEhS31R4j9FgBGa1peXDxcZNyVoQeIrpkgDXQUsGp
        02exPWHOl/SZNRA1SAUHLCE1KdyqOJzTkN20Ys+W/ymJ3PUvPiC+VM3kGh+qOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UsP2g8myaOh8ImRMhGICrJ9Xf/zgu9DkLjqH3753JA=;
        b=sdOjvCwway79kSFJBgpX5gEH7Q2oD3O1bifsIGcQqWvVUrftNfqg95LbP1tojZfiKdCxzl
        raZn3DlZVfERwsBQ==
Date:   Tue, 17 Nov 2020 14:19:48 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 6/7] tick/sched: Release seqcount before invoking calc_load_global()
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calc_load_global() does not need the sequence count protection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -20,6 +20,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/nohz.h>
+#include <linux/sched/loadavg.h>
 #include <linux/module.h>
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
@@ -107,7 +108,8 @@ static void tick_do_update_jiffies64(kti
 						tick_period);
 	}
 
-	do_timer(ticks);
+	/* Advance jiffies to complete the jiffies_seq protected job */
+	jiffies_64 += ticks;
 
 	/*
 	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
@@ -116,7 +118,15 @@ static void tick_do_update_jiffies64(kti
 	WRITE_ONCE(tick_next_period,
 		   ktime_add(last_jiffies_update, tick_period));
 
+	/*
+	 * Release the sequence count. calc_global_load() below is not
+	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * concurrent invocations.
+	 */
 	write_seqcount_end(&jiffies_seq);
+
+	calc_global_load();
+
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }

