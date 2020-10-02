Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B32810DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgJBLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:03:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91ECC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=krvsfsMusA6skiBDCbI7ny36B3e7HL+7rrL6WuPgsJk=; b=trgu0XGZ/Da+lKicGTmTuOeidT
        rJeCsOSGPTtSbNzUR3X6kWhlcp6CSOi/SlwQRpmoL+vy5Hh2yac/KATPYCjH85lbuol0P1oqhaJaW
        bkNEPFWI+CYUXCLeWjfdNicJyQrHb5QayPtbzaSPfpbM+A8qQ7uU3VEA+mi9QYkVJ2LioqSPe5/LM
        IqSsaP0R7nxa8Ffh5tg9waiJhCQOfOolP1neb2OfXaj2EBINYXYg5dNxJd/4z5SQIWVJqljb7tIj9
        HH8jasO62es7Efefe4CudkdddjFC8p5gC0PAPrcPhX2364qyGbTkPGNC0xquS27hKvvjnNau0o+hx
        P8GIlF7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOIq5-0007te-KN; Fri, 02 Oct 2020 11:03:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 107B23006D0;
        Fri,  2 Oct 2020 13:02:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C68272148A62C; Fri,  2 Oct 2020 13:02:58 +0200 (CEST)
Date:   Fri, 2 Oct 2020 13:02:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kim.phillips@amd.com
Subject: Re: [PATCH] perf/x86/intel: Fix n_metric for the canceled group
Message-ID: <20201002110258.GV2628@hirez.programming.kicks-ass.net>
References: <20200930142935.13482-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930142935.13482-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:29:35AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> When a group that has TopDown members is failed to be scheduled, any
> later TopDown groups will not return valid values.
> 
> Here is an example.
> 
> A background perf that occupies all the GP counters and the fixed
> counter 1.
>  $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
>                  cycles,cycles}:D" -a
> 
> A user monitors a TopDown group. It works well, because the fixed
> counter 3 and the PERF_METRICS are available.
>  $perf stat -x, --topdown -- ./workload
>    retiring,bad speculation,frontend bound,backend bound,
>    18.0,16.1,40.4,25.5,
> 
> Then the user tries to monitor a group that has TopDown members.
> Because of the cycles event, the group is failed to be scheduled.
>  $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
>                      topdown-fe-bound,topdown-bad-spec,cycles}'
>                      -- ./workload
>     <not counted>,,slots,0,0.00,,
>     <not counted>,,topdown-retiring,0,0.00,,
>     <not counted>,,topdown-be-bound,0,0.00,,
>     <not counted>,,topdown-fe-bound,0,0.00,,
>     <not counted>,,topdown-bad-spec,0,0.00,,
>     <not counted>,,cycles,0,0.00,,
> 
> The user tries to monitor a TopDown group again. It doesn't work anymore.
>  $perf stat -x, --topdown -- ./workload
> 
>     ,,,,,
> 
> In a txn, cancel_txn() is to truncate the event_list for a canceled
> group and update the number of events added in this transaction.
> However, the number of TopDown events added in this transaction is not
> updated. The kernel will probably fail to add new Topdown events.
> 
> Check if the canceled group has Topdown events. If so, subtract the
> TopDown events from n_metric accordingly.
> 
> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0f3d01562ded..4cb3ccbe2d62 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2017,6 +2017,7 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
>  {
>  	unsigned int txn_flags;
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int i;
>  
>  	WARN_ON_ONCE(!cpuc->txn_flags);	/* no txn in flight */
>  
> @@ -2031,6 +2032,15 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
>  	 */
>  	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
>  	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
> +
> +	/* Subtract Topdown events in the canceled group from n_metric */
> +	if (x86_pmu.intel_cap.perf_metrics && cpuc->n_metric) {
> +		for (i = 0; i < cpuc->n_txn; i++) {
> +			if (is_metric_event(cpuc->event_list[i + cpuc->n_events]))
> +				__this_cpu_dec(cpu_hw_events.n_metric);
> +		}
> +		WARN_ON_ONCE(__this_cpu_read(cpu_hw_events.n_metric) < 0);
> +	}
>  	perf_pmu_enable(pmu);
>  }


Urgh, I'd much rather we add n_txn_metric. But also, while looking at
this, don't we have the same problem with n_pair ?

Something like this perhaps...

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 757e49755e7c..9b7792c0b6fb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1066,6 +1066,7 @@ static int add_nr_metric_event(struct cpu_hw_events *cpuc,
 		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
 			return -EINVAL;
 		cpuc->n_metric++;
+		cpuc->n_txn_metric++;
 	}
 
 	return 0;
@@ -1089,8 +1090,10 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
 		return -EINVAL;
 
 	cpuc->event_list[n] = event;
-	if (is_counter_pair(&event->hw))
+	if (is_counter_pair(&event->hw)) {
 		cpuc->n_pair++;
+		cpuc->n_txn_pair++;
+	}
 
 	return 0;
 }
@@ -2062,6 +2065,8 @@ static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 
 	perf_pmu_disable(pmu);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_metric, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
 }
 
 /*
@@ -2087,6 +2092,8 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 	 */
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
+	__this_cpu_sub(cpu_hw_events.n_metric, __this_cpu_read(cpu_hw_events.n_txn_metric));
+	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
 	perf_pmu_enable(pmu);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 345442410a4d..6348105b6d30 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -235,6 +235,8 @@ struct cpu_hw_events {
 					     they've never been enabled yet */
 	int			n_txn;    /* the # last events in the below arrays;
 					     added in the current transaction */
+	int			n_txn_metric;
+	int			n_txn_pair;
 	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
 	u64			tags[X86_PMC_IDX_MAX];
 
