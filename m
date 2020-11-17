Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB252B7244
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKQXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKQXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:50 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id z17so87634qvy.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqTucxK+Xw24pDxWNrMrQc6dBy5DDtbN0w21uUUW7+k=;
        b=DMrT2JbfIok6BMejkHIlxakaldKvrVqvafoZS8YbTx9hoSCl6sB93/HCTahVB7j7F0
         o75VFTcLuGmhHbEX9wQgELOYjf1l4GpeIuY0wdIGreYP40cixCuAjy5pO2mRcIO5wmRu
         1thTNbzjFwAYo86wd84sqgvYCMS0ACATqxjPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqTucxK+Xw24pDxWNrMrQc6dBy5DDtbN0w21uUUW7+k=;
        b=tJEBju2dLmIbMbQSxiNW/7gPgQusxDFPiEIW2mDvnrmuFYKqMnwrAaswfatRZcRmEz
         GC9GBxnyCNzi2icKefO5Yef2DH2zovpC2F3Px1+dTSWDLLtZaY8t7oqRXZ77Or9hs0sF
         y9G1vD8lRuE03e4pK0HshfzF3Bj6lZd7BzkFSt2WK2rbu3qrtn6C/AHjktq/NezEhMg7
         mM9kVN8OPhySChnsKJph4WAWTxkaURsAWGHBKVnKwwVIFe0aVaU0vk+/LHNxiDpy32sX
         eRVFcLFc13lfbGwee9mTj6A/n/aOXnWVNX1xqX1Urt5BJkzbP3zMAXFTrzuuTkFVmF/J
         2mPQ==
X-Gm-Message-State: AOAM532r7Gv2See/vsqWVtMNWCKceINGdPytogeiTb3ELecfOiiYFgkK
        o0QgpAtpBCVhoT1xyk2GEBMU6w==
X-Google-Smtp-Source: ABdhPJxZ7QchmhqBgkosqp+8UWeU+KV3MiqAKQcU4mLhAAp5i5X2tWLA2dWEGwFIuqLToFKFiQggtw==
X-Received: by 2002:ad4:4e13:: with SMTP id dl19mr2165035qvb.24.1605655249886;
        Tue, 17 Nov 2020 15:20:49 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:49 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 19/32] entry/idle: Enter and exit kernel protection during idle entry and exit
Date:   Tue, 17 Nov 2020 18:19:49 -0500
Message-Id: <20201117232003.3580179-20-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic_idle_{enter,exit} helper function to enter and exit kernel
protection when entering and exiting idle, respectively.

While at it, remove a stale RCU comment.

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/entry-common.h | 18 ++++++++++++++++++
 kernel/sched/idle.c          | 11 ++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 022e1f114157..8f34ae625f83 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -454,4 +454,22 @@ static inline bool entry_kernel_protected(void)
 	return IS_ENABLED(CONFIG_SCHED_CORE) && sched_core_kernel_protected()
 		&& _TIF_UNSAFE_RET != 0;
 }
+
+/**
+ * generic_idle_enter - General tasks to perform during idle entry.
+ */
+static inline void generic_idle_enter(void)
+{
+	/* Entering idle ends the protected kernel region. */
+	sched_core_unsafe_exit();
+}
+
+/**
+ * generic_idle_exit  - General tasks to perform during idle exit.
+ */
+static inline void generic_idle_exit(void)
+{
+	/* Exiting idle (re)starts the protected kernel region. */
+	sched_core_unsafe_enter();
+}
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8bdb214eb78f..ee4f91396c31 100644
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
2.29.2.299.gdc1121823c-goog

