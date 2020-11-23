Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB22C03C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgKWLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:00:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50167 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgKWLA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:00:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CfkhP4B1Dz9sRR;
        Mon, 23 Nov 2020 22:00:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606129222;
        bh=WHbv/n/zvKljNMxbSr7BFAIxV2SZS7coVExrPbNTHTA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dMgscjRQOsWUveZOjqAndgnfi/FBu263K0v2S0JAt2yM+3OsewrQSvKTxPm6WDSlT
         VpgAaiBwjKdQ5S7ywhelFs0PPx8F9l+DyWPXyPqgrJa6+cMl717s1FxVsecdpNKH1U
         N6J06GiUqNBJHNJnlsX+kdFkv/fCyszAisj0X/5qUmVzlIXXeU+IF7ezUkt9lLJC7b
         hkYnnzhnkMc6kAbYon7FLfTa6OHa9W9z7zS8QrM20oFdiXHqZka4h6Fxwf3ifcMNZU
         UBaBahCof7WZIEKVcTdGVT3KezC7NiuaoMOIzWSqpBQg7WIsN2d1K4kaZRG58lHArI
         KGAPbPb3vL78w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Namhyung Kim <namhyung@kernel.org>,
        "Liang\, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU events
In-Reply-To: <CAM9d7chbQE=zkqYsNFMv+uWEYWdXcGD=fNYT_R2ondwR5zVvaQ@mail.gmail.com>
References: <20201106212935.28943-1-kan.liang@linux.intel.com> <20201109095235.GC2594@hirez.programming.kicks-ass.net> <20201109110405.GN2651@hirez.programming.kicks-ass.net> <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com> <20201111162509.GW2611@hirez.programming.kicks-ass.net> <2dc483f6-7b29-c42b-13a4-4c549d720aa2@linux.intel.com> <CAM9d7cjwFp9JBqs1Ga9n1ojbez9chZLvmOgFv1EE4KDhAa9ryA@mail.gmail.com> <CAM9d7chbQE=zkqYsNFMv+uWEYWdXcGD=fNYT_R2ondwR5zVvaQ@mail.gmail.com>
Date:   Mon, 23 Nov 2020 22:00:17 +1100
Message-ID: <87a6v81gou.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung Kim <namhyung@kernel.org> writes:
> Hi Peter and Kan,
>
> (Adding PPC folks)
>
> On Tue, Nov 17, 2020 at 2:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Thu, Nov 12, 2020 at 4:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> >
>> >
>> >
>> > On 11/11/2020 11:25 AM, Peter Zijlstra wrote:
>> > > On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
>> > >
>> > >> - When the large PEBS was introduced (9c964efa4330), the sched_task() should
>> > >> be invoked to flush the PEBS buffer in each context switch. However, The
>> > >> perf_sched_events in account_event() is not updated accordingly. The
>> > >> perf_event_task_sched_* never be invoked for a pure per-CPU context. Only
>> > >> per-task event works.
>> > >>     At that time, the perf_pmu_sched_task() is outside of
>> > >> perf_event_context_sched_in/out. It means that perf has to double
>> > >> perf_pmu_disable() for per-task event.
>> > >
>> > >> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
>> > >> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
>> > >> sched_cb_list. Yes, the code is very similar to the original codes, but it
>> > >> is actually the new code for per-CPU events. The optimization for per-task
>> > >> events is still kept.
>> > >>    For the case, which has both a CPU context and a task context, yes, the
>> > >> __perf_pmu_sched_task() in this patch is not invoked. Because the
>> > >> sched_task() only need to be invoked once in a context switch. The
>> > >> sched_task() will be eventually invoked in the task context.
>> > >
>> > > The thing is; your first two patches rely on PERF_ATTACH_SCHED_CB and
>> > > only set that for large pebs. Are you sure the other users (Intel LBR
>> > > and PowerPC BHRB) don't need it?
>> >
>> > I didn't set it for LBR, because the perf_sched_events is always enabled
>> > for LBR. But, yes, we should explicitly set the PERF_ATTACH_SCHED_CB
>> > for LBR.
>> >
>> >         if (has_branch_stack(event))
>> >                 inc = true;
>> >
>> > >
>> > > If they indeed do not require the pmu::sched_task() callback for CPU
>> > > events, then I still think the whole perf_sched_cb_{inc,dec}() interface
>> >
>> > No, LBR requires the pmu::sched_task() callback for CPU events.
>> >
>> > Now, The LBR registers have to be reset in sched in even for CPU events.
>> >
>> > To fix the shorter LBR callstack issue for CPU events, we also need to
>> > save/restore LBRs in pmu::sched_task().
>> > https://lore.kernel.org/lkml/1578495789-95006-4-git-send-email-kan.liang@linux.intel.com/
>> >
>> > > is confusing at best.
>> > >
>> > > Can't we do something like this instead?
>> > >
>> > I think the below patch may have two issues.
>> > - PERF_ATTACH_SCHED_CB is required for LBR (maybe PowerPC BHRB as well) now.
>> > - We may disable the large PEBS later if not all PEBS events support
>> > large PEBS. The PMU need a way to notify the generic code to decrease
>> > the nr_sched_task.
>>
>> Any updates on this?  I've reviewed and tested Kan's patches
>> and they all look good.
>>
>> Maybe we can talk to PPC folks to confirm the BHRB case?
>
> Can we move this forward?  I saw patch 3/3 also adds PERF_ATTACH_SCHED_CB
> for PowerPC too.  But it'd be nice if ppc folks can confirm the change.

Sorry I've read the whole thread, but I'm still not entirely sure I
understand the question.

cheers
