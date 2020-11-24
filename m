Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC72C1D31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 06:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKXFBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 00:01:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35032 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgKXFBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 00:01:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id a9so27057210lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 21:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tw9tEl8HsC5phWE6SeIajx+7chMdjb6Qew6OhM7+E0=;
        b=ulih0gW1PhxeL1J3l640O90mYgm1vCmV/729Ci5dZI4+59VLMODEna/IVdnKJvEUPI
         OJztJAnesr8G8XRAbIFKLUycVByQr0fmvU0CjUqsexnCkF7mQjwax73j6lyEyuVNMG0O
         zGE/37IBV6Idoamr39Tx6SjRwjirTQAg9piAHQoKeiM569K3MwsXmOS5zV+zPvprtski
         QW3XCO+ApwILk4o/4JGx7MkDHWZ7mxEOHMy2dPx+NjAzIahCIU4HmaWls8/tf1zzuls1
         s6zwb2sqADlxQxyFO9bMR4bNtMhS6a1f8TCXoehaRulbKpUhxpPIARub+ErvBuXTxgEv
         q4ew==
X-Gm-Message-State: AOAM533YDSKc6l5Eviv3L2xkJdija60G+ZepGJEW0t+xNHcjiPttqrTq
        MZwiFVq/cQjLRRmVDYf7dD19ZsiiCS2OhoS8seB2D0KSXRQ=
X-Google-Smtp-Source: ABdhPJzMAeUu9MM6xDV4zIB9z+NcIm4nuelXSsVwPbkFuxBLVw4QmsHEcQEyyTeOUvkpN2w8AjZO2Eam6ixRhb2HFz0=
X-Received: by 2002:a19:4154:: with SMTP id o81mr990652lfa.540.1606194110433;
 Mon, 23 Nov 2020 21:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20201121025011.227781-1-namhyung@kernel.org> <20201123142321.GP3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123142321.GP3021@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Nov 2020 14:01:39 +0900
Message-ID: <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Nov 23, 2020 at 11:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Nov 21, 2020 at 11:50:11AM +0900, Namhyung Kim wrote:
> > When large PEBS is enabled, the below warning is triggered:
> >
> >   [6070379.453697] WARNING: CPU: 23 PID: 42379 at arch/x86/events/core.c:1466 x86_pmu_stop+0x95/0xa0
> >   ...
> >   [6070379.453831] Call Trace:
> >   [6070379.453840]  x86_pmu_del+0x50/0x150
> >   [6070379.453845]  event_sched_out.isra.0+0x95/0x200
> >   [6070379.453848]  group_sched_out.part.0+0x53/0xd0
> >   [6070379.453851]  __perf_event_disable+0xee/0x1e0
> >   [6070379.453854]  event_function+0x89/0xd0
> >   [6070379.453859]  remote_function+0x3e/0x50
> >   [6070379.453866]  generic_exec_single+0x91/0xd0
> >   [6070379.453870]  smp_call_function_single+0xd1/0x110
> >   [6070379.453874]  event_function_call+0x11c/0x130
> >   [6070379.453877]  ? task_ctx_sched_out+0x20/0x20
> >   [6070379.453880]  ? perf_mux_hrtimer_handler+0x370/0x370
> >   [6070379.453882]  ? event_function_call+0x130/0x130
> >   [6070379.453886]  perf_event_for_each_child+0x34/0x80
> >   [6070379.453889]  ? event_function_call+0x130/0x130
> >   [6070379.453891]  _perf_ioctl+0x24b/0x6a0
> >   [6070379.453898]  ? sched_setaffinity+0x1ad/0x2a0
> >   [6070379.453904]  ? _cond_resched+0x15/0x30
> >   [6070379.453906]  perf_ioctl+0x3d/0x60
> >   [6070379.453912]  ksys_ioctl+0x87/0xc0
> >   [6070379.453917]  __x64_sys_ioctl+0x16/0x20
> >   [6070379.453923]  do_syscall_64+0x52/0x180
> >   [6070379.453928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
> > bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
> > called recursively (like when it losts some samples) like below:
> >
> >   x86_pmu_stop
> >     intel_pmu_disable_event  (x86_pmu_disable)
> >       intel_pmu_pebs_disable
> >         intel_pmu_drain_pebs_buffer
> >           x86_pmu_stop
> >
>
> This shouldn't be possible; intel_pmu_drain_pebs_buffer() calls
> drain_pebs(.iregs=NULL), which means that __intel_pmu_pebs_event()
> should not end up x86_pmu_stop().
>
> Are you running some old kernel?

Well, it's actually 5.7.17 but I think the latest version has the same problem.

Yes, it's not about __intel_pmu_pebs_event().  I'm looking at
intel_pmu_drain_pebs_nhm() specifically.  There's code like

        /* log dropped samples number */
        if (error[bit]) {
            perf_log_lost_samples(event, error[bit]);

            if (perf_event_account_interrupt(event))
                x86_pmu_stop(event, 0);
        }

        if (counts[bit]) {
            __intel_pmu_pebs_event(event, iregs, base,
                           top, bit, counts[bit],
                           setup_pebs_fixed_sample_data);
        }

There's a path to x86_pmu_stop() when an error bit is on.

Thanks,
Namhyung
