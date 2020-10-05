Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EA2831E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgJEI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:26:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B71C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d+YxHpF6mTYuxekjJW/kDThuTR3EAkaMwG8Gs0SnhyY=; b=svQS837BUTWR/aGPEWGg8PlibA
        CtCBhZ3/0YzVzNxyHGjr9ICSTfTNCcgRrYGG+tADK+rkPCvXwWPg7cXf2fkHjCjfl/8pNJvl4dg3h
        1PQiafCIhTG4z60QmttmmZnkHoEJzpPllSF+dcgc+7TNyW127Gxl6QyRM8Skl4QoHnR+qjSH1hgll
        jSYtp90dHEczGxunnyVOVMnhWiXt86jPtSh0dSsJ+oC3uErTSvDHHFuYquivRoCSh+rMtHSKbc0jG
        KdejmTpO3OIXPVMni/l61KLiyYpIYhKpd4W6/bJPUBAXqXRo/Y+KNNw3M3vS/RBmL4VuCrHEHNy6I
        Qmp0zVCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPLoy-00089k-7l; Mon, 05 Oct 2020 08:26:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7EC03013E5;
        Mon,  5 Oct 2020 10:26:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D83429E6CACF; Mon,  5 Oct 2020 10:26:11 +0200 (CEST)
Date:   Mon, 5 Oct 2020 10:26:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kim.phillips@amd.com
Subject: [PATCH] perf/x86: Fix n_metric for cancelled txn
Message-ID: <20201005082611.GH2628@hirez.programming.kicks-ass.net>
References: <20200930142935.13482-1-kan.liang@linux.intel.com>
 <20201002110258.GV2628@hirez.programming.kicks-ass.net>
 <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:16:11AM -0400, Liang, Kan wrote:
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

---
Subject: perf/x86: Fix n_metric for cancelled txn
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Oct  5 10:10:24 CEST 2020

When a group that has TopDown members is failed to be scheduled, any
later TopDown groups will not return valid values.

Here is an example.

A background perf that occupies all the GP counters and the fixed
counter 1.
 $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
                 cycles,cycles}:D" -a

A user monitors a TopDown group. It works well, because the fixed
counter 3 and the PERF_METRICS are available.
 $perf stat -x, --topdown -- ./workload
   retiring,bad speculation,frontend bound,backend bound,
   18.0,16.1,40.4,25.5,

Then the user tries to monitor a group that has TopDown members.
Because of the cycles event, the group is failed to be scheduled.
 $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
                     topdown-fe-bound,topdown-bad-spec,cycles}'
                     -- ./workload
    <not counted>,,slots,0,0.00,,
    <not counted>,,topdown-retiring,0,0.00,,
    <not counted>,,topdown-be-bound,0,0.00,,
    <not counted>,,topdown-fe-bound,0,0.00,,
    <not counted>,,topdown-bad-spec,0,0.00,,
    <not counted>,,cycles,0,0.00,,

The user tries to monitor a TopDown group again. It doesn't work anymore.
 $perf stat -x, --topdown -- ./workload

    ,,,,,

In a txn, cancel_txn() is to truncate the event_list for a canceled
group and update the number of events added in this transaction.
However, the number of TopDown events added in this transaction is not
updated. The kernel will probably fail to add new Topdown events.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |    3 +++
 arch/x86/events/perf_event.h |    1 +
 2 files changed, 4 insertions(+)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1066,6 +1066,7 @@ static int add_nr_metric_event(struct cp
 		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
 			return -EINVAL;
 		cpuc->n_metric++;
+		cpuc->n_txn_metric++;
 	}
 
 	return 0;
@@ -2065,6 +2066,7 @@ static void x86_pmu_start_txn(struct pmu
 	perf_pmu_disable(pmu);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
 	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_metric, 0);
 }
 
 /*
@@ -2091,6 +2093,7 @@ static void x86_pmu_cancel_txn(struct pm
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
+	__this_cpu_sub(cpu_hw_events.n_metric, __this_cpu_read(cpu_hw_events.n_txn_metric));
 	perf_pmu_enable(pmu);
 }
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -236,6 +236,7 @@ struct cpu_hw_events {
 	int			n_txn;    /* the # last events in the below arrays;
 					     added in the current transaction */
 	int			n_txn_pair;
+	int			n_txn_metric;
 	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
 	u64			tags[X86_PMC_IDX_MAX];
 
