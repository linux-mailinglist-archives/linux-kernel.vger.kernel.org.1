Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B22831DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJEIZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEIZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:25:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD5C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sgZX0CSQSkAx/FW8NJOKyPpcaw5lepotpcpZ+fYNql4=; b=f+lVv+3nk6I61cyD3Mc3w+xOF6
        AX6hYon0CglN9NnSHz22RQ9ij9uXFbxpnFzPL4w+3qcvCAEWkvb9zH/iV32OQmeSV/lt9z4iGGyes
        BPhkyYi/4AlRQYUfMnax6KIWS+y2urTACgdt6Xmsrzk+SydBt2s+luYFhbO9GLHOlQOt8z9GGX1D3
        EjawhYh1h5ISFSkdAInR5SOIqPUWb5qSdyAjxVJ2ygHPVdXxXoTwtT+xvR+s8OvGI1YA1xnoGNJe+
        SAZYH2Pc8U24S5T4OFU1vt+yKT+Dt6b3PhouVEc1hiTOMbDLSHlXl6Qq46lsENgqqDYHB22l7W6SO
        /Z4QgCOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPLo6-00087G-6D; Mon, 05 Oct 2020 08:25:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E0BC300B22;
        Mon,  5 Oct 2020 10:25:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C34282010461A; Mon,  5 Oct 2020 10:25:16 +0200 (CEST)
Date:   Mon, 5 Oct 2020 10:25:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: [PATCH] perf/x86: Fix n_pair for cancelled txn
Message-ID: <20201005082516.GG2628@hirez.programming.kicks-ass.net>
References: <20200930142935.13482-1-kan.liang@linux.intel.com>
 <20201002110258.GV2628@hirez.programming.kicks-ass.net>
 <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
 <fc89da87-6070-beda-2437-4089257c55aa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc89da87-6070-beda-2437-4089257c55aa@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 04:10:42PM -0500, Kim Phillips wrote:
> Tested-by: Kim Phillips <kim.phillips@amd.com>

---
Subject: perf/x86: Fix n_pair for cancelled txn
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Oct  5 10:09:06 CEST 2020

Kan reported that n_metric gets corrupted for cancelled transactions;
a similar issue exists for n_pair for AMD's Large Increment thing.

The problem was confirmed and confirmed fixed by Kim using:

  sudo perf stat -e "{cycles,cycles,cycles,cycles}:D" -a sleep 10 &

  # should succeed:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

  # should fail:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all,fp_ret_sse_avx_ops.all,cycles}:D" -a workload

  # previously failed, now succeeds with this patch:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/events/core.c       |    6 +++++-
 arch/x86/events/perf_event.h |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1089,8 +1089,10 @@ static int collect_event(struct cpu_hw_e
 		return -EINVAL;
 
 	cpuc->event_list[n] = event;
-	if (is_counter_pair(&event->hw))
+	if (is_counter_pair(&event->hw)) {
 		cpuc->n_pair++;
+		cpuc->n_txn_pair++;
+	}
 
 	return 0;
 }
@@ -2062,6 +2064,7 @@ static void x86_pmu_start_txn(struct pmu
 
 	perf_pmu_disable(pmu);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
 }
 
 /*
@@ -2087,6 +2090,7 @@ static void x86_pmu_cancel_txn(struct pm
 	 */
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
+	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
 	perf_pmu_enable(pmu);
 }
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -235,6 +235,7 @@ struct cpu_hw_events {
 					     they've never been enabled yet */
 	int			n_txn;    /* the # last events in the below arrays;
 					     added in the current transaction */
+	int			n_txn_pair;
 	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
 	u64			tags[X86_PMC_IDX_MAX];
 
