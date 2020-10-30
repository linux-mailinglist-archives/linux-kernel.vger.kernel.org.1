Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C352A09A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgJ3PVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgJ3PVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00CEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+Ofgs9mOJTedwsPohBjhpDhprgStlZZcF5JXvqO8jvw=; b=JPKVUE3LlA6ykSG8wopafK9yNk
        56hpyUR5j4Aygf6inxMMuRhHAKvfoVl7yC9Ce4wHCRjvTsaZs2nmiGPxKGOYujKv5IViufH0sNvvY
        V1A6JUc2zRBjjG+aC60Vpi8dQ5nqSmVTtULI/gdTzgFKo2xHMnlgN7iFwMzof4fbIOSLMpv+lifzn
        lOnuzmk95gM2dcfTmvYFZJda7/FReF4Ufv4AoHJdjYmspy8aTP1I0FcK3D/QuYEWhO5VbnPVQ+YVN
        0nFKw6vm3V/Z2G0M6QbihBuvJNjRCxQhKhwQUhudG/l9J13uNuzSHGv69WUllrXSLMcpkxZ13VaXe
        9MDCbpmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDM-0003MA-8l; Fri, 30 Oct 2020 15:21:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AB7930769C;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E6D5F214528A7; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151954.985416146@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 1/6] perf: Reduce stack usage of perf_output_begin()
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__perf_output_begin() has an on-stack struct perf_sample_data in the
unlikely case it needs to generate a LOST record. However, every call
to perf_output_begin() must already have a perf_sample_data on-stack.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/perf/imc-pmu.c     |    2 +-
 arch/s390/kernel/perf_cpum_sf.c |    2 +-
 arch/x86/events/intel/ds.c      |    4 ++--
 include/linux/perf_event.h      |    7 +++++--
 kernel/events/core.c            |   32 +++++++++++++++++---------------
 kernel/events/ring_buffer.c     |   20 +++++++++++---------
 6 files changed, 37 insertions(+), 30 deletions(-)

--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1336,7 +1336,7 @@ static void dump_trace_imc_data(struct p
 			/* If this is a valid record, create the sample */
 			struct perf_output_handle handle;
 
-			if (perf_output_begin(&handle, event, header.size))
+			if (perf_output_begin(&handle, &data, event, header.size))
 				return;
 
 			perf_output_sample(&handle, &header, &data, event);
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -672,7 +672,7 @@ static void cpumsf_output_event_pid(stru
 	rcu_read_lock();
 
 	perf_prepare_sample(&header, data, event, regs);
-	if (perf_output_begin(&handle, event, header.size))
+	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
 	/* Update the process ID (see also kernel/events/core.c) */
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -642,8 +642,8 @@ int intel_pmu_drain_bts_buffer(void)
 	rcu_read_lock();
 	perf_prepare_sample(&header, &data, event, &regs);
 
-	if (perf_output_begin(&handle, event, header.size *
-			      (top - base - skip)))
+	if (perf_output_begin(&handle, &data, event,
+			      header.size * (top - base - skip)))
 		goto unlock;
 
 	for (at = base; at < top; at++) {
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1400,11 +1400,14 @@ perf_event_addr_filters(struct perf_even
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
+			     struct perf_sample_data *data,
 			     struct perf_event *event, unsigned int size);
 extern int perf_output_begin_forward(struct perf_output_handle *handle,
-				    struct perf_event *event,
-				    unsigned int size);
+				     struct perf_sample_data *data,
+				     struct perf_event *event,
+				     unsigned int size);
 extern int perf_output_begin_backward(struct perf_output_handle *handle,
+				      struct perf_sample_data *data,
 				      struct perf_event *event,
 				      unsigned int size);
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7186,6 +7186,7 @@ __perf_event_output(struct perf_event *e
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
 		    int (*output_begin)(struct perf_output_handle *,
+					struct perf_sample_data *,
 					struct perf_event *,
 					unsigned int))
 {
@@ -7198,7 +7199,7 @@ __perf_event_output(struct perf_event *e
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	err = output_begin(&handle, event, header.size);
+	err = output_begin(&handle, data, event, header.size);
 	if (err)
 		goto exit;
 
@@ -7264,7 +7265,7 @@ perf_event_read_event(struct perf_event
 	int ret;
 
 	perf_event_header__init_id(&read_event.header, &sample, event);
-	ret = perf_output_begin(&handle, event, read_event.header.size);
+	ret = perf_output_begin(&handle, &sample, event, read_event.header.size);
 	if (ret)
 		return;
 
@@ -7533,7 +7534,7 @@ static void perf_event_task_output(struc
 
 	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7636,7 +7637,7 @@ static void perf_event_comm_output(struc
 		return;
 
 	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
 
 	if (ret)
@@ -7736,7 +7737,7 @@ static void perf_event_namespaces_output
 
 	perf_event_header__init_id(&namespaces_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7863,7 +7864,7 @@ static void perf_event_cgroup_output(str
 
 	perf_event_header__init_id(&cgroup_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7989,7 +7990,7 @@ static void perf_event_mmap_output(struc
 	}
 
 	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -8299,7 +8300,7 @@ void perf_event_aux_event(struct perf_ev
 	int ret;
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
@@ -8333,7 +8334,7 @@ void perf_log_lost_samples(struct perf_e
 
 	perf_event_header__init_id(&lost_samples_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
 	if (ret)
 		return;
@@ -8388,7 +8389,7 @@ static void perf_event_switch_output(str
 
 	perf_event_header__init_id(&se->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, se->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event, se->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8463,7 +8464,7 @@ static void perf_log_throttle(struct per
 
 	perf_event_header__init_id(&throttle_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
 	if (ret)
 		return;
@@ -8506,7 +8507,7 @@ static void perf_event_ksymbol_output(st
 
 	perf_event_header__init_id(&ksymbol_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8596,7 +8597,7 @@ static void perf_event_bpf_output(struct
 
 	perf_event_header__init_id(&bpf_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, data, event,
 				bpf_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8705,7 +8706,8 @@ static void perf_event_text_poke_output(
 
 	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event,
+				text_poke_event->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8786,7 +8788,7 @@ static void perf_log_itrace_start(struct
 	rec.tid	= perf_event_tid(event, current);
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -147,6 +147,7 @@ ring_buffer_has_space(unsigned long head
 
 static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
+		    struct perf_sample_data *data,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
 {
@@ -237,18 +238,16 @@ __perf_output_begin(struct perf_output_h
 	handle->size = (1UL << page_shift) - offset;
 
 	if (unlikely(have_lost)) {
-		struct perf_sample_data sample_data;
-
 		lost_event.header.size = sizeof(lost_event);
 		lost_event.header.type = PERF_RECORD_LOST;
 		lost_event.header.misc = 0;
 		lost_event.id          = event->id;
 		lost_event.lost        = local_xchg(&rb->lost, 0);
 
-		perf_event_header__init_id(&lost_event.header,
-					   &sample_data, event);
+		/* XXX mostly redundant; @data is already fully initializes */
+		perf_event_header__init_id(&lost_event.header, data, event);
 		perf_output_put(handle, lost_event);
-		perf_event__output_id_sample(event, handle, &sample_data);
+		perf_event__output_id_sample(event, handle, data);
 	}
 
 	return 0;
@@ -263,22 +262,25 @@ __perf_output_begin(struct perf_output_h
 }
 
 int perf_output_begin_forward(struct perf_output_handle *handle,
-			     struct perf_event *event, unsigned int size)
+			      struct perf_sample_data *data,
+			      struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, false);
+	return __perf_output_begin(handle, data, event, size, false);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
+			       struct perf_sample_data *data,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, true);
+	return __perf_output_begin(handle, data, event, size, true);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
+		      struct perf_sample_data *data,
 		      struct perf_event *event, unsigned int size)
 {
 
-	return __perf_output_begin(handle, event, size,
+	return __perf_output_begin(handle, data, event, size,
 				   unlikely(is_write_backward(event)));
 }
 


