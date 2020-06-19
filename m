Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9481FFFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgFSBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFSBgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:36:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0548C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ec10so3752978qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZBQrP9iCJp5rt26MNBEb8ukF4wAmzkjI1ZYpMMV/kg=;
        b=rfUqKPxDZ7oii+GOuaUbm7rAoepsBo/NFJ0hdYja0XPYwo23WmcCFNBl3kusyCKuun
         mi8aMGm+JHjeQwaTTeD/GP/XJxPuYpNUDVYDn5LRU4RIUgWGMzsK+/fj36JChN5KiUws
         FeGJHWP9WQH1ewYH9LBkerF5/U7qSrfzlQXUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZBQrP9iCJp5rt26MNBEb8ukF4wAmzkjI1ZYpMMV/kg=;
        b=rN495uCHNT4beICAta7UVCB3IuSQpIrPF8wGOzhX7KVJKVfWwAxv7h46mcjw+Pw+RE
         crWAQSK8XIypFT1rkLpUmW5Hi3iElNolwaYXKHaf070jZxF+psnJN+ZpKJgG5hL5nu3q
         k5DIHpF/KMF87e+SYnZ4ACH144ZrR96zWy6INAFdCkjszoY5Iy8QjpHhYUuoXa3SFInJ
         apq9jRFvca5cG6R6XeMrlmdly9HGSK4WVPwbsWbYEEwXhsSTmjaVTyTLNSvW88vZMxQg
         BRLP01VQuYnzz3/pTHrdcPQAFYVmjX5EnCDSpODs4VAQADJrWmmsuEcXuMccGfct17tp
         QjWQ==
X-Gm-Message-State: AOAM532Eu6Zw/CpnQkoHJo49Wg9DAQ+tdjAM4GU8BQqi571jNmxBR3Fx
        BX7Y8NkLlGsJWvsIEk7Go6W31gHdoik=
X-Google-Smtp-Source: ABdhPJziJ6x825cN+3xl89dn809OO90XptMruTwUkuVIn9zZM6jpFqnuSvH/bpDbdB/BRV/W2Y5dLw==
X-Received: by 2002:ad4:4627:: with SMTP id x7mr6629406qvv.54.1592530606881;
        Thu, 18 Jun 2020 18:36:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s15sm5379570qtc.95.2020.06.18.18.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:36:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/3] rcu/trace: Print negative GP numbers correctly
Date:   Thu, 18 Jun 2020 21:36:39 -0400
Message-Id: <20200619013641.63453-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GP numbers start from -300 and gp_seq numbers start of -1200 (for a
shift of 2). These negative numbers are printed as unsigned long which
not only takes up more text space, but is rather confusing to the reader
as they have to constantly expend energy to truncate the number. Just
print the negative numbering directly.

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 54 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ced71237b7e4a..155b5cb43cfd3 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -74,17 +74,17 @@ TRACE_EVENT_RCU(rcu_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
+	TP_printk("%s %ld %s",
 		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
 );
 
@@ -114,8 +114,8 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
-		__field(unsigned long, gp_seq_req)
+		__field(long, gp_seq)
+		__field(long, gp_seq_req)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -124,16 +124,16 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
-		__entry->gp_seq_req = gp_seq_req;
+		__entry->gp_seq = (long)gp_seq;
+		__entry->gp_seq_req = (long)gp_seq_req;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
+	TP_printk("%s %ld %ld %u %d %d %s",
+		  __entry->rcuname, (long)__entry->gp_seq, (long)__entry->gp_seq_req, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -153,7 +153,7 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -162,14 +162,14 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->qsmask = qsmask;
 	),
 
-	TP_printk("%s %lu %u %d %d %lx",
+	TP_printk("%s %ld %u %d %d %lx",
 		  __entry->rcuname, __entry->gp_seq, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->qsmask)
 );
@@ -197,17 +197,17 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpseq)
+		__field(long, gpseq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpseq = gpseq;
+		__entry->gpseq = (long)gpseq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
+	TP_printk("%s %ld %s",
 		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
 );
 
@@ -316,17 +316,17 @@ TRACE_EVENT_RCU(rcu_preempt_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d",
+	TP_printk("%s %ld %d",
 		  __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
@@ -343,17 +343,17 @@ TRACE_EVENT_RCU(rcu_unlock_preempted_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
+	TP_printk("%s %ld %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
 /*
@@ -374,7 +374,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(unsigned long, mask)
 		__field(unsigned long, qsmask)
 		__field(u8, level)
@@ -385,7 +385,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->mask = mask;
 		__entry->qsmask = qsmask;
 		__entry->level = level;
@@ -394,7 +394,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 		__entry->gp_tasks = gp_tasks;
 	),
 
-	TP_printk("%s %lu %lx>%lx %u %d %d %u",
+	TP_printk("%s %ld %lx>%lx %u %d %d %u",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->mask, __entry->qsmask, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gp_tasks)
@@ -415,19 +415,19 @@ TRACE_EVENT_RCU(rcu_fqs,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, cpu)
 		__field(const char *, qsevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->cpu = cpu;
 		__entry->qsevent = qsevent;
 	),
 
-	TP_printk("%s %lu %d %s",
+	TP_printk("%s %ld %d %s",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->cpu, __entry->qsevent)
 );
-- 
2.27.0.111.gc72c7da667-goog

