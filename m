Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B72486DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHRONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHROMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F5C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YCNRxVdwXiAUVSTcLJEk+raGgN9RNB/RFHzydfwKP+4=; b=LzUtemkPN2Bw62TsYPnGfZZZH0
        SJNb/OorO37uBdmaRbE1sYpD1UdY6fBNNAePp4kLbPsoMNgDtwKG2bMJR004aPGquEYYhnixrmNSq
        SeDMW0BQTh/bFMPR1ASTsF/6JnDQKWFbUdSUEh/JXXXqipCkuDV+VDmgN0iS/z/oVU7zoKJcy+Q5/
        /QLoNZPE45GN5zGPMoRBHUYAcTmo9I7uPM9Uiy1HDlbCmr7ERX8ULUTcPqCnIj6dijHVUBMtzTggM
        dhgonSevu3W9r6boK7FIdFd1usraegKPktwkMMbZeg1SBPUqnPt7J5Pq/qxHLNWvAWiQrXp3twxNd
        4zvvkhDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LI-0006Uy-Vv; Tue, 18 Aug 2020 14:12:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA6693075F1;
        Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9D84123D42BFF; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135804.385360407@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v7 02/18] module: Fix up module_notifier return values
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While auditing all module notifiers I noticed a whole bunch of fail
wrt the return value. Notifiers have a 'special' return semantics.

As is; NOTIFY_DONE vs NOTIFY_OK is a bit vague; but
notifier_from_errno(0) results in NOTIFY_OK and NOTIFY_DONE has a
comment that says "Don't care".

>From this I've used NOTIFY_DONE when the function completely ignores
the callback and notifier_to_error() isn't used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Robert Richter <rric@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/oprofile/buffer_sync.c |    4 ++--
 kernel/trace/bpf_trace.c       |    8 ++++++--
 kernel/trace/trace.c           |    2 +-
 kernel/trace/trace_events.c    |    2 +-
 kernel/trace/trace_printk.c    |    4 ++--
 kernel/tracepoint.c            |    2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -116,7 +116,7 @@ module_load_notify(struct notifier_block
 {
 #ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_COMING)
-		return 0;
+		return NOTIFY_DONE;
 
 	/* FIXME: should we process all CPU buffers ? */
 	mutex_lock(&buffer_mutex);
@@ -124,7 +124,7 @@ module_load_notify(struct notifier_block
 	add_event_entry(MODULE_LOADED_CODE);
 	mutex_unlock(&buffer_mutex);
 #endif
-	return 0;
+	return NOTIFY_OK;
 }
 
 
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1451,10 +1451,11 @@ static int bpf_event_notify(struct notif
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
+	int ret = 0;
 
 	if (mod->num_bpf_raw_events == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
-		return 0;
+		goto out;
 
 	mutex_lock(&bpf_module_mutex);
 
@@ -1464,6 +1465,8 @@ static int bpf_event_notify(struct notif
 		if (btm) {
 			btm->module = module;
 			list_add(&btm->list, &bpf_trace_modules);
+		} else {
+			ret = -ENOMEM;
 		}
 		break;
 	case MODULE_STATE_GOING:
@@ -1479,7 +1482,8 @@ static int bpf_event_notify(struct notif
 
 	mutex_unlock(&bpf_module_mutex);
 
-	return 0;
+out:
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block bpf_module_nb = {
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8696,7 +8696,7 @@ static int trace_module_notify(struct no
 		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2442,7 +2442,7 @@ static int trace_module_notify(struct no
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -95,7 +95,7 @@ static int module_trace_bprintk_format_n
 		if (val == MODULE_STATE_COMING)
 			hold_module_trace_bprintk_format(start, end);
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
 /*
@@ -173,7 +173,7 @@ __init static int
 module_trace_bprintk_format_notify(struct notifier_block *self,
 		unsigned long val, void *data)
 {
-	return 0;
+	return NOTIFY_OK;
 }
 static inline const char **
 find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -521,7 +521,7 @@ static int tracepoint_module_notify(stru
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block tracepoint_module_nb = {


