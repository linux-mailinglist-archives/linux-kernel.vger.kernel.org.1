Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E12BA8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKTLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:24:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36021 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKTLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:24:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id f11so12966134lfs.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6hJpjNZpPh/Wclumi9gysfMabj8yLmD4uYAC2Efgs0=;
        b=mzk2zX95DJI/LuH2mTu9U+tMaYuC8FP9CgzbkgZ+1f92RCFFZiulzuZ1FiO7Wx6xU1
         1XDWthFvM5mlM7WJ3Au04l49A/IBqz2R6Xf+/3K0kW8nHmHADPNnb3NDzG+zJqlfyMl3
         Kbj8yJlrLg1PDScMKCqvoWV29Pr4Tr8E9DyMQCZ045kTC7wB+jLqoXZmB9LkOYy5swG7
         SeLcjO+PxBGZSZXSFGeG3DOgwsm51o/d275+nZvB7T1te5H/bwm4e8Wj3kxdH2dK5wbd
         gbT5Ro9vVtBS0Fa+Yv6U+rRZV4GzbwpsOMy6c4b0X3XTvf5Th5XBqYM5DZPUR+GjFUbW
         3s4Q==
X-Gm-Message-State: AOAM530k4u9BkW9L79u3meHtOsuzZW2V8LhpRvtbjYAcBH5bN/ekOjL4
        0CEd8+MYTW4rqv9LdHcyMY6Fd0K9S+UfhK7bhHU=
X-Google-Smtp-Source: ABdhPJxyq0tm5kIxw6XDxpUG8lE8cBfUdPQSbVOR/q0ApXZeGHTt8KFBDqjPwUIz9Dxvssjb+384HWiffH/QurZNhys=
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr8604886lfr.149.1605871457832;
 Fri, 20 Nov 2020 03:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net> <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com> <20201111162509.GW2611@hirez.programming.kicks-ass.net>
 <2dc483f6-7b29-c42b-13a4-4c549d720aa2@linux.intel.com> <CAM9d7cjwFp9JBqs1Ga9n1ojbez9chZLvmOgFv1EE4KDhAa9ryA@mail.gmail.com>
In-Reply-To: <CAM9d7cjwFp9JBqs1Ga9n1ojbez9chZLvmOgFv1EE4KDhAa9ryA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Nov 2020 20:24:06 +0900
Message-ID: <CAM9d7chbQE=zkqYsNFMv+uWEYWdXcGD=fNYT_R2ondwR5zVvaQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Kan,

(Adding PPC folks)

On Tue, Nov 17, 2020 at 2:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Nov 12, 2020 at 4:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 11/11/2020 11:25 AM, Peter Zijlstra wrote:
> > > On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
> > >
> > >> - When the large PEBS was introduced (9c964efa4330), the sched_task() should
> > >> be invoked to flush the PEBS buffer in each context switch. However, The
> > >> perf_sched_events in account_event() is not updated accordingly. The
> > >> perf_event_task_sched_* never be invoked for a pure per-CPU context. Only
> > >> per-task event works.
> > >>     At that time, the perf_pmu_sched_task() is outside of
> > >> perf_event_context_sched_in/out. It means that perf has to double
> > >> perf_pmu_disable() for per-task event.
> > >
> > >> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
> > >> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
> > >> sched_cb_list. Yes, the code is very similar to the original codes, but it
> > >> is actually the new code for per-CPU events. The optimization for per-task
> > >> events is still kept.
> > >>    For the case, which has both a CPU context and a task context, yes, the
> > >> __perf_pmu_sched_task() in this patch is not invoked. Because the
> > >> sched_task() only need to be invoked once in a context switch. The
> > >> sched_task() will be eventually invoked in the task context.
> > >
> > > The thing is; your first two patches rely on PERF_ATTACH_SCHED_CB and
> > > only set that for large pebs. Are you sure the other users (Intel LBR
> > > and PowerPC BHRB) don't need it?
> >
> > I didn't set it for LBR, because the perf_sched_events is always enabled
> > for LBR. But, yes, we should explicitly set the PERF_ATTACH_SCHED_CB
> > for LBR.
> >
> >         if (has_branch_stack(event))
> >                 inc = true;
> >
> > >
> > > If they indeed do not require the pmu::sched_task() callback for CPU
> > > events, then I still think the whole perf_sched_cb_{inc,dec}() interface
> >
> > No, LBR requires the pmu::sched_task() callback for CPU events.
> >
> > Now, The LBR registers have to be reset in sched in even for CPU events.
> >
> > To fix the shorter LBR callstack issue for CPU events, we also need to
> > save/restore LBRs in pmu::sched_task().
> > https://lore.kernel.org/lkml/1578495789-95006-4-git-send-email-kan.liang@linux.intel.com/
> >
> > > is confusing at best.
> > >
> > > Can't we do something like this instead?
> > >
> > I think the below patch may have two issues.
> > - PERF_ATTACH_SCHED_CB is required for LBR (maybe PowerPC BHRB as well) now.
> > - We may disable the large PEBS later if not all PEBS events support
> > large PEBS. The PMU need a way to notify the generic code to decrease
> > the nr_sched_task.
>
> Any updates on this?  I've reviewed and tested Kan's patches
> and they all look good.
>
> Maybe we can talk to PPC folks to confirm the BHRB case?

Can we move this forward?  I saw patch 3/3 also adds PERF_ATTACH_SCHED_CB
for PowerPC too.  But it'd be nice if ppc folks can confirm the change.

Thanks,
Namhyung
