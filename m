Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0B2AC2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbgKIRlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbgKIRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:41:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED057C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jH/FHNxxlNOfEWO/tYirhsoUTcjI82xLvbA8vXx5jkc=; b=NOXK091Dm9fv+T85ewZdMkQhK2
        lCRWs8dZFpU/ruzbYPh02BR6Z3Iqg//KpI48mnexaZ78FE7yO29JY2e+mnK9Ob22o1zNarJrr06il
        ZUwTM5e1y36kKSGiFPzG4AqXBm2S/4XFamM6i12W0w1zACBiwx5Qoag3IFdTXt1sZTRKuW9p118kF
        o20ZVWjPhN+7py2vNFzTxhuD59hBFhLGgYGF1dDuwsvxldfIwz2wSg7mBvipxv5lgyQSG2ddgH/E3
        wEKAizOC2Y8N4oonzcMEG7slacvM187NouqqvJFrzIv0gqHMyZ7WRKctJ5Co5OQHlkXnBxWWBPtG7
        MOS4bm4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcBA4-0005kk-MW; Mon, 09 Nov 2020 17:41:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D34D8302753;
        Mon,  9 Nov 2020 18:40:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFF4A2C17FC37; Mon,  9 Nov 2020 18:40:59 +0100 (CET)
Date:   Mon, 9 Nov 2020 18:40:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201109174059.GN2611@hirez.programming.kicks-ass.net>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net>
 <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:

> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
> sched_cb_list. Yes, the code is very similar to the original codes, but it
> is actually the new code for per-CPU events. The optimization for per-task
> events is still kept.
>   For the case, which has both a CPU context and a task context, yes, the
> __perf_pmu_sched_task() in this patch is not invoked. Because the
> sched_task() only need to be invoked once in a context switch. The
> sched_task() will be eventually invoked in the task context.
> 
> 
> - The following patch 3 tries to optimize the sched_task() further.
>   - We handle the per-CPU event and per-task event in different places. In a
> pure per-task context, we don't need to go through the sched_cb_list. We can
> get the information from task->perf_event_ctxp. We introduce a flag to
> distinguish them.
>   - For most of the cases, we don't need to invoke the sched_task() in both
> sched in and sched out. We also introduce a flag for PMUs to avoid
> unnecessary calls.
> 

There's a further optimiation possible; we can have pmu::swap_task_ctx()
imply pmu::sched_task() (both in and out).


It's all a bit of a mess though.. let me consider.
