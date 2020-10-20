Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C452932D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbgJTBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390215AbgJTBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z2so277898ilh.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhAgMxTS7FfrTqbn56ueMD2c1ZEFO5mefcH6CTcX4Lk=;
        b=sxmA9+QgClJD5dFZcx9OJB/9pGKo8MtzWP09NaVve7lizrAKmJUO4PJ7Y0nxdKWjHM
         5Jri84L80ilytpPSOuZs/NriReCWaYT7CE6Ms/Jal4MDhXrfYq5FZ1WJXYN4FmCvTNAE
         qyOtInr68ifGvHz2tMTBzDGXBcZ8tw3Byp7Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhAgMxTS7FfrTqbn56ueMD2c1ZEFO5mefcH6CTcX4Lk=;
        b=DPlWYAWy4YVnA0+bZgf5QWzy338AfNWEC5aaYth4PMOAowfiY+ncYsEK2R5s1xr27V
         FOmarXbBwIyZYUEdjEBv5UA8BoNhRLZdx6veZfKgdyP/OmPnuQNpIYGzw2R2nwC7EUu3
         n5IEV8VXSg4qhwVV6QxAeVNlkpp/q3n2sUJ7elSTiZ2o78bORtPO+D0vgdSzdU9a5Wcf
         eOSZw0TVN4gtRlxZ9GGFVVF/3wu6CSJBEoRpgW8f9lZ7FJXdUEbdKnNObyBNwU0Aktmx
         s5dgipvHgF4U1TBZ/qFZcoyCcRvgTqFKdGyddAhC8eWfjB4++7QT0c85EUqXgGnTfStU
         n20Q==
X-Gm-Message-State: AOAM531s7efi1CCJgBGq7FZFTVLCNIrI1khTaTdBQlriF+pWSaBjbJKE
        eHWiAfN2Wkw21OgRB7xgBDZqRg==
X-Google-Smtp-Source: ABdhPJzIvhXNa7OYJ/VFoeecUXx/7Dwmt6K+tnmASiy2gvtq8DqG4HlMvdK7FNbhIrdsYjHUdrHm5g==
X-Received: by 2002:a92:b00e:: with SMTP id x14mr275750ilh.4.1603158267791;
        Mon, 19 Oct 2020 18:44:27 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 14/26] entry/idle: Enter and exit kernel protection during idle entry and exit
Date:   Mon, 19 Oct 2020 21:43:24 -0400
Message-Id: <20201020014336.2076526-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic_idle_{enter,exit} helper function to enter and exit kernel
protection when entering and exiting idle, respectively.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/entry-common.h | 18 ++++++++++++++++++
 kernel/sched/idle.c          | 11 ++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 260216de357b..879562d920f2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -402,4 +402,22 @@ void irqentry_exit_cond_resched(void);
  */
 void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
 
+/**
+ * generic_idle_enter - Called during entry into idle for housekeeping.
+ */
+static inline void generic_idle_enter(void)
+{
+	/* Entering idle ends the protected kernel region. */
+	sched_core_unsafe_exit();
+}
+
+/**
+ * generic_idle_enter - Called when exiting idle for housekeeping.
+ */
+static inline void generic_idle_exit(void)
+{
+	/* Exiting idle (re)starts the protected kernel region. */
+	sched_core_unsafe_enter();
+}
+
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a74926be80ac..029ba61576f2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -8,6 +8,7 @@
  */
 #include "sched.h"
 
+#include <linux/entry-common.h>
 #include <trace/events/power.h>
 
 /* Linker adds these: start and end of __cpuidle functions */
@@ -54,6 +55,7 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	generic_idle_enter();
 	trace_cpu_idle(0, smp_processor_id());
 	stop_critical_timings();
 	rcu_idle_enter();
@@ -66,6 +68,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	rcu_idle_exit();
 	start_critical_timings();
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	generic_idle_exit();
 
 	return 1;
 }
@@ -156,11 +159,7 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	/*
-	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more rcu read side critical sections and one more
-	 * step to the grace period
-	 */
+	generic_idle_enter();
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
@@ -225,6 +224,8 @@ static void cpuidle_idle_call(void)
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
+
+	generic_idle_exit();
 }
 
 /*
-- 
2.29.0.rc1.297.gfa9743e501-goog

