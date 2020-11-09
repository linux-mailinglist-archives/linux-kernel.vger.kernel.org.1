Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43752AB404
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgKIJwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKIJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:52:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3E2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/kiXkiX5D7NVvwDSqhlwDi0UU90V4tHPpuN14UrYDIg=; b=SumctV0EALjb5+6tBIJn5XjlhQ
        9aUmtw6uSjOiDijb0EzdjFUlRZQ62bd73/vryFtvlTV7RrRHNsDYCRbUCWSFi0CwxFepi1Xmlqvp2
        A558M0MQMhQKLZPe0d2TOjipuzvOk0vsX/REimehSc7eDc+nMUu1Ai3ueuphiREW1KyoMKv0guJ9n
        tbjDfVjv6fNw2H05lj7CF7jbPT7bCi/hNDkAZRZ2xe7ySAYGi5YsTljCltppXR4jYqvXRaA/VjKfZ
        SFal5m5Ns1GbHGfmV371gETwFvcR9QuTRNS/kUrcRw4rz+utOEDAD0ZuqKgwSiV3iU1Mss9xzBZPV
        Kv1LwNKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc3qm-0008JB-RJ; Mon, 09 Nov 2020 09:52:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDE17301324;
        Mon,  9 Nov 2020 10:52:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B29CD2B09ACF8; Mon,  9 Nov 2020 10:52:35 +0100 (CET)
Date:   Mon, 9 Nov 2020 10:52:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201109095235.GC2594@hirez.programming.kicks-ass.net>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106212935.28943-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 01:29:33PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Sometimes the PMU internal buffers have to be flushed for per-CPU events
> during a context switch, e.g., large PEBS. Otherwise, the perf tool may
> report samples in locations that do not belong to the process where the
> samples are processed in, because PEBS does not tag samples with PID/TID.
> 
> The current code only flush the buffers for a per-task event. It doesn't
> check a per-CPU event.
> 
> Add a new event state flag, PERF_ATTACH_SCHED_CB, to indicate that the
> PMU internal buffers have to be flushed for this event during a context
> switch.
> 
> Add sched_cb_entry and perf_sched_cb_usages back to track the PMU/cpuctx
> which is required to be flushed.
> 
> Only need to invoke the sched_task() for per-CPU events in this patch.
> The per-task events have been handled in perf_event_context_sched_in/out
> already.
> 
> Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")

Are you sure? In part this patch looks like a revert of:

  44fae179ce73a26733d9e2d346da4e1a1cb94647
  556cccad389717d6eb4f5a24b45ff41cad3aaabf


> +static void perf_pmu_sched_task(struct task_struct *prev,
> +				struct task_struct *next,
> +				bool sched_in)
> +{
> +	struct perf_cpu_context *cpuctx;
> +
> +	if (prev == next)
> +		return;
> +
> +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> +		/* will be handled in perf_event_context_sched_in/out */
> +		if (cpuctx->task_ctx)
> +			continue;

This seems wrong; cpuctx->task_ctx merely indicates that there is a
task-ctx for this CPU. Not that the event you're interested in is in
fact there.

So consider the case where the event is on the CPU context, but we also
have a task context. Then we'll not issue this call.

> +
> +		__perf_pmu_sched_task(cpuctx, sched_in);
> +	}
> +}
