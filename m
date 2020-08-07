Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1523F1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHGRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHGRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:07:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C02C061A84
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:07:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so2378287qkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xyb7fCBz+IXsbGOPEfTwIw2JG6kHy9V4i3jra0Cd7aU=;
        b=oKuPqNVpo0uxsiYXNKAhWfqgCeeCjOeuMP4drt3JxZxhqBpl30m7sxL7v/jXWfIvRb
         JqmxW8x394WOGNlAYLANBGIO9OL7gwkRZoKrBXAdOHiLV1Ofb2sMiJD0x/5/wj3NPR/j
         0vHEODIticV8p2IDHjsDOi4BGmOSaI1LktFqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xyb7fCBz+IXsbGOPEfTwIw2JG6kHy9V4i3jra0Cd7aU=;
        b=G1vtkMzUnf/tNXsVuEPQ06VN9Dh4Js7SGDiW7Jwjan5uvceKCmaJtzvZbqamscF64M
         mS3k7wGsIJsyn0dO9Bm62/r2eXVWn1U+vMBSg394zlA0u8JpoYuRZnLO50bEmHWGvYP/
         uwDS1j76x2FFDJgALbzPNJ36gAIU6BssmMO4QffTvEEANyyjF6wRJ9vrz8ny4N/3VsgI
         Ml/ICUVne0uheb6hzcKBe0N9uV/Hw0HxWPHjE4+TXGYFkkdCV+g4ur/VnAFYfNQ80Bo5
         RJM8M8yIyJAjpAlIinKxpMfEUxKbGkTy/p9p558ozrRxdkmEgEclyWvCesR79cpzgwmQ
         3fJQ==
X-Gm-Message-State: AOAM533Sl4KIR91Djt3O8fgsFyeyufbdUmyHgjACg5buXMMP1ph4FBsW
        d0HoIrREINXiXqKixwePFZEze5KnoLM=
X-Google-Smtp-Source: ABdhPJyPSmq9a8wEn+RtkShsfUzXuvw/5IT7WWeiNQRr8Ny7OPuKV+J5r1rQgSOPmV8WQQr4hh+jDw==
X-Received: by 2002:a05:620a:21c1:: with SMTP id h1mr14330762qka.178.1596820052492;
        Fri, 07 Aug 2020 10:07:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w18sm8559905qtk.1.2020.08.07.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:07:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: [PATCH v4 4/5] rcutorture: Force synchronizing of RCU flavor from hotplug notifier
Date:   Fri,  7 Aug 2020 13:07:21 -0400
Message-Id: <20200807170722.2897328-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU has had deadlocks in the past related to synchronizing in a hotplug
notifier. Typically, this has occurred because timer callbacks did not get
migrated before the CPU hotplug notifier requesting RCU's services is
called. If RCU's grace period processing has a timer callback queued in
the meanwhile, it may never get called causing RCU stalls.

These issues have been fixed by removing such dependencies from grace
period processing, however there are no testing scenarios for such
cases.

This commit therefore reuses rcutorture's existing hotplug notifier to
invoke the flavor-specific synchronize callback. If anything locks up,
we expect stall warnings and/or other splats.

Obviously, we need not test for rcu_barrier from a notifier, since those
are not allowed from notifiers. This fact is already detailed in the
documentation as well.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 81 +++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 92cb79620939..083b65e4877d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1645,12 +1645,37 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 read_exit_delay, read_exit_burst);
 }
 
-static int rcutorture_booster_cleanup(unsigned int cpu)
+static bool rcu_torture_can_boost(void)
+{
+	static int boost_warn_once;
+	int prio;
+
+	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
+		return false;
+
+	prio = rcu_get_gp_kthreads_prio();
+	if (!prio)
+		return false;
+
+	if (prio < 2) {
+		if (boost_warn_once  == 1)
+			return false;
+
+		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
+		boost_warn_once = 1;
+		return false;
+	}
+
+	return true;
+}
+
+static int rcutorture_hp_cleanup(unsigned int cpu)
 {
 	struct task_struct *t;
 
-	if (boost_tasks[cpu] == NULL)
+	if (!rcu_torture_can_boost() || boost_tasks[cpu] == NULL)
 		return 0;
+
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
@@ -1662,11 +1687,14 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	return 0;
 }
 
-static int rcutorture_booster_init(unsigned int cpu)
+static int rcutorture_hp_init(unsigned int cpu)
 {
 	int retval;
 
-	if (boost_tasks[cpu] != NULL)
+	/* Force synchronizing from hotplug notifier to ensure it is safe. */
+	cur_ops->sync();
+
+	if (!rcu_torture_can_boost() || boost_tasks[cpu] != NULL)
 		return 0;  /* Already created, nothing more to do. */
 
 	/* Don't allow time recalculation while creating a new task. */
@@ -2336,30 +2364,6 @@ static void rcu_torture_barrier_cleanup(void)
 	}
 }
 
-static bool rcu_torture_can_boost(void)
-{
-	static int boost_warn_once;
-	int prio;
-
-	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
-		return false;
-
-	prio = rcu_get_gp_kthreads_prio();
-	if (!prio)
-		return false;
-
-	if (prio < 2) {
-		if (boost_warn_once  == 1)
-			return false;
-
-		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
-		boost_warn_once = 1;
-		return false;
-	}
-
-	return true;
-}
-
 static bool read_exit_child_stop;
 static bool read_exit_child_stopped;
 static wait_queue_head_t read_exit_wq;
@@ -2503,8 +2507,7 @@ rcu_torture_cleanup(void)
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
-	if (rcu_torture_can_boost())
-		cpuhp_remove_state(rcutor_hp);
+	cpuhp_remove_state(rcutor_hp);
 
 	/*
 	 * Wait for all RCU callbacks to fire, then do torture-type-specific
@@ -2773,21 +2776,21 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+
+	firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
+			rcutorture_hp_init,
+			rcutorture_hp_cleanup);
+	if (firsterr < 0)
+		goto unwind;
+	rcutor_hp = firsterr;
+
 	if (test_boost_interval < 1)
 		test_boost_interval = 1;
 	if (test_boost_duration < 2)
 		test_boost_duration = 2;
-	if (rcu_torture_can_boost()) {
-
+	if (rcu_torture_can_boost())
 		boost_starttime = jiffies + test_boost_interval * HZ;
 
-		firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
-					     rcutorture_booster_init,
-					     rcutorture_booster_cleanup);
-		if (firsterr < 0)
-			goto unwind;
-		rcutor_hp = firsterr;
-	}
 	shutdown_jiffies = jiffies + shutdown_secs * HZ;
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
 	if (firsterr)
-- 
2.28.0.236.gb10cc79966-goog

