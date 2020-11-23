Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF42C0D69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgKWOXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgKWOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:23:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4HcrpPNsaDhsBRXNbURm0nHzAexL56mK85NAlc6od+Q=; b=mHcejKCI9P7BHJt9Ji3ashJTDn
        shFeesPF1awnREzo13cdnTBKD0GWUAQjvV7RzK9hnxREAoB2cmePWbx9cvK1ksCRCffcDfeMVxdYj
        ZfYto/8AZKKBUnFonCE43qGqJ+j//Q5Yi9EFFpF5j7HaLMbCqyr5w8jS4tZNHuTd8p1X7C7B7AnSY
        l3g6NfQEPFUJ8CSz8IvX5Ci8+KRHMQHWLSMNdcVg7tli6IPZXod2uR9/FVUCWfc1kH9SiyQnXg/ww
        tMSTfsvQxsqLjtsy/dSE9ELKknKKGNrADYs+lRvlL+JxvCLYr0Sh+fghpp/OjGd6CLyKIZzCiQx2x
        okB4OTgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCkU-0008Ng-59; Mon, 23 Nov 2020 14:23:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47C40301124;
        Mon, 23 Nov 2020 15:23:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32D7D201B3F6A; Mon, 23 Nov 2020 15:23:21 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:23:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
Message-ID: <20201123142321.GP3021@hirez.programming.kicks-ass.net>
References: <20201121025011.227781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121025011.227781-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 11:50:11AM +0900, Namhyung Kim wrote:
> When large PEBS is enabled, the below warning is triggered:
> 
>   [6070379.453697] WARNING: CPU: 23 PID: 42379 at arch/x86/events/core.c:1466 x86_pmu_stop+0x95/0xa0
>   ...
>   [6070379.453831] Call Trace:
>   [6070379.453840]  x86_pmu_del+0x50/0x150
>   [6070379.453845]  event_sched_out.isra.0+0x95/0x200
>   [6070379.453848]  group_sched_out.part.0+0x53/0xd0
>   [6070379.453851]  __perf_event_disable+0xee/0x1e0
>   [6070379.453854]  event_function+0x89/0xd0
>   [6070379.453859]  remote_function+0x3e/0x50
>   [6070379.453866]  generic_exec_single+0x91/0xd0
>   [6070379.453870]  smp_call_function_single+0xd1/0x110
>   [6070379.453874]  event_function_call+0x11c/0x130
>   [6070379.453877]  ? task_ctx_sched_out+0x20/0x20
>   [6070379.453880]  ? perf_mux_hrtimer_handler+0x370/0x370
>   [6070379.453882]  ? event_function_call+0x130/0x130
>   [6070379.453886]  perf_event_for_each_child+0x34/0x80
>   [6070379.453889]  ? event_function_call+0x130/0x130
>   [6070379.453891]  _perf_ioctl+0x24b/0x6a0
>   [6070379.453898]  ? sched_setaffinity+0x1ad/0x2a0
>   [6070379.453904]  ? _cond_resched+0x15/0x30
>   [6070379.453906]  perf_ioctl+0x3d/0x60
>   [6070379.453912]  ksys_ioctl+0x87/0xc0
>   [6070379.453917]  __x64_sys_ioctl+0x16/0x20
>   [6070379.453923]  do_syscall_64+0x52/0x180
>   [6070379.453928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
> bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
> called recursively (like when it losts some samples) like below:
> 
>   x86_pmu_stop
>     intel_pmu_disable_event  (x86_pmu_disable)
>       intel_pmu_pebs_disable
>         intel_pmu_drain_pebs_buffer
>           x86_pmu_stop
> 

This shouldn't be possible; intel_pmu_drain_pebs_buffer() calls
drain_pebs(.iregs=NULL), which means that __intel_pmu_pebs_event()
should not end up x86_pmu_stop().

Are you running some old kernel?
