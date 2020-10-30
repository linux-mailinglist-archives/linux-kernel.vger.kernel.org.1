Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865B2A09A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgJ3PVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbgJ3PVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2l/qC1jwM6t3e+tdI1lGZZVuKdjuPujKR38kVWl2ARM=; b=21ueIa7A0dBTJ98Bp31u3Uj3M+
        abmCmmVXO0KxbajDCIxZR4c6pGeXpgYWl7uWms73+VQ5MS1H9kHRw2iTFR9G7VcGWcePJfUhUiEcA
        46My4nKB393SuNJn6L9ISH5zBmeIntHtLHSmLp3YXFvAv02q1/ouuAtkNSf6ITgi/1oAZ2RmygegP
        vRUVnucNtuDDT11b/ikvbKZEb4CgctlftJfcVbo9ZX+XqjMGAHx9ZXYcYFCwIJdkDmtEhKpmUb09H
        Z00QF40nAZhBpP8nDDhpIEpnrqnYLS6RxiJaJwlSBgjV+URmXBpvaDmM1r6DKRL9NYyF1wcPpy2P3
        OykJL2+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDK-0003Ld-HD; Fri, 30 Oct 2020 15:21:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EF3730785A;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E91212B708594; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151955.054099690@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 2/6] perf/x86: Reduce stack usage for x86_pmu::drain_pebs()
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmu_drain_pebs_*() is typically called from handle_pmi_common(),
both have an on-stack struct perf_sample_data, which is *big*. Rewire
things so that drain_pebs() can use the one handle_pmi_common() has.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |    2 -
 arch/x86/events/intel/ds.c   |   47 ++++++++++++++++++++++---------------------
 arch/x86/events/perf_event.h |    2 -
 3 files changed, 27 insertions(+), 24 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2630,7 +2630,7 @@ static int handle_pmi_common(struct pt_r
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
 		handled++;
-		x86_pmu.drain_pebs(regs);
+		x86_pmu.drain_pebs(regs, &data);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -670,7 +670,9 @@ int intel_pmu_drain_bts_buffer(void)
 
 static inline void intel_pmu_drain_pebs_buffer(void)
 {
-	x86_pmu.drain_pebs(NULL);
+	struct perf_sample_data data;
+
+	x86_pmu.drain_pebs(NULL, &data);
 }
 
 /*
@@ -1719,19 +1721,20 @@ intel_pmu_save_and_restart_reload(struct
 	return 0;
 }
 
-static void __intel_pmu_pebs_event(struct perf_event *event,
-				   struct pt_regs *iregs,
-				   void *base, void *top,
-				   int bit, int count,
-				   void (*setup_sample)(struct perf_event *,
-						struct pt_regs *,
-						void *,
-						struct perf_sample_data *,
-						struct pt_regs *))
+static __always_inline void
+__intel_pmu_pebs_event(struct perf_event *event,
+		       struct pt_regs *iregs,
+		       struct perf_sample_data *data,
+		       void *base, void *top,
+		       int bit, int count,
+		       void (*setup_sample)(struct perf_event *,
+					    struct pt_regs *,
+					    void *,
+					    struct perf_sample_data *,
+					    struct pt_regs *))
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_sample_data data;
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
@@ -1752,14 +1755,14 @@ static void __intel_pmu_pebs_event(struc
 		iregs = &dummy_iregs;
 
 	while (count > 1) {
-		setup_sample(event, iregs, at, &data, regs);
-		perf_event_output(event, &data, regs);
+		setup_sample(event, iregs, at, data, regs);
+		perf_event_output(event, data, regs);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		count--;
 	}
 
-	setup_sample(event, iregs, at, &data, regs);
+	setup_sample(event, iregs, at, data, regs);
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -1767,18 +1770,18 @@ static void __intel_pmu_pebs_event(struc
 		 * last record the same as other PEBS records, and doesn't
 		 * invoke the generic overflow handler.
 		 */
-		perf_event_output(event, &data, regs);
+		perf_event_output(event, data, regs);
 	} else {
 		/*
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, &data, regs))
+		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1812,7 +1815,7 @@ static void intel_pmu_drain_pebs_core(st
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, at, top, 0, n,
+	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
 			       setup_pebs_fixed_sample_data);
 }
 
@@ -1835,7 +1838,7 @@ static void intel_pmu_pebs_event_update_
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1942,14 +1945,14 @@ static void intel_pmu_drain_pebs_nhm(str
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, base,
+			__intel_pmu_pebs_event(event, iregs, data, base,
 					       top, bit, counts[bit],
 					       setup_pebs_fixed_sample_data);
 		}
 	}
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1997,7 +2000,7 @@ static void intel_pmu_drain_pebs_icl(str
 		if (WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
-		__intel_pmu_pebs_event(event, iregs, base,
+		__intel_pmu_pebs_event(event, iregs, data, base,
 				       top, bit, counts[bit],
 				       setup_pebs_adaptive_sample_data);
 	}
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -727,7 +727,7 @@ struct x86_pmu {
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
-	void		(*drain_pebs)(struct pt_regs *regs);
+	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	unsigned long	large_pebs_flags;


