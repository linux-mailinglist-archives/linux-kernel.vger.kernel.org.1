Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B434E294208
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgJTSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgJTSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:18:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EBAC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:18:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so1459479plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6HboVrD2Vhe2nA65C8FtX+ikgZJapeA+m1MOIgVXqLM=;
        b=qfBhdJLPl68eKtjAnzEHdPgp81waz/xyoPwQtYvCqoaARPSV27J60EPxzhx81Ln7/Y
         a6WohdVv0c/hvNq3wCkV7Xu62kY3/rAsTYLKk0rcQYhBK/F5OFrSEr5Lh+L3dW98esQ8
         suSj8M1WnGx2U7YFrTzqdG/aZ/9MnVfQjnqJ0ZrLcv3gC6SGDd7THfxjqWpk59kKUQlX
         rZWN3AXWxUxkLuZisb4mjotgm9sxs2Vg8FmucvseGWx/82XGzfSc2sY9MkK7Mz9afO5O
         IjCqYedaoV4CG2DYJoOkkAsNIUb4oHrUCz62TfQZ5ZdcDP72WdyGo5xHejaKaRRjvQJ8
         LQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6HboVrD2Vhe2nA65C8FtX+ikgZJapeA+m1MOIgVXqLM=;
        b=qnLUs+IqSdfTV/7lG90yMF7hI6lkH9FDiaemnLIvV2aq9fQax26lYM0v1n5Fevw9Hs
         irm3TPUDbOV3vEjfs5ywQeC2FGDYoliOIOM6KEkMrZfU5sq5XjcmDZrBkLERzLbwbygf
         vePkZzaETehQ3HrzjHyKWPz8mxSKz9xezTS6lOwp5e6PHabWxa/WWaz90uZToV7xtGye
         BwIIjVxD0wSMS7iqN6oJ+x6sWi0ihTLM0xGI+nCmvAiD4z0Uk7u3Ynrjf4dGZvAv4rWh
         RUoLVgh2KECtFrIkl+w9nagAXZJsJqPVClXFCPno1+FtVn4zGV1SO/m+kNBTFN2SnKEE
         Y92g==
X-Gm-Message-State: AOAM533YyDTk2kPAzdZHOStVHWQ8yFfY8qDFBpqspWgq8nwSqUaPyTgh
        qY/upimPW6NBVJP0S8/2jIPw8xbznxxEjPdsvWwp9w==
X-Google-Smtp-Source: ABdhPJzq033GBPir40Pqpk+7HfChTLVmIrS875guc+TqYdohTwPKDUmCtyX7Ml9VQp/Es/Jzoz9tg2+UCDSLnldW7pI=
X-Received: by 2002:a17:90a:ed87:: with SMTP id k7mr3870502pjy.127.1603217901251;
 Tue, 20 Oct 2020 11:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201009220524.485102-1-axelrasmussen@google.com>
 <20201009220524.485102-3-axelrasmussen@google.com> <1b9238b7-17f2-6c1e-b37e-cf65424f504b@suse.cz>
In-Reply-To: <1b9238b7-17f2-6c1e-b37e-cf65424f504b@suse.cz>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 20 Oct 2020 11:17:44 -0700
Message-ID: <CAJHvVcgpNLj8u-e+kdLOw8UVyW9vXvMC++dwohZZXCeEwKj7pw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmap_lock: add tracepoints around lock acquisition
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 7:50 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/10/20 12:05 AM, Axel Rasmussen wrote:
> > The goal of these tracepoints is to be able to debug lock contention
> > issues. This lock is acquired on most (all?) mmap / munmap / page fault
> > operations, so a multi-threaded process which does a lot of these can
> > experience significant contention.
> >
> > We trace just before we start acquisition, when the acquisition returns
> > (whether it succeeded or not), and when the lock is released (or
> > downgraded). The events are broken out by lock type (read / write).
> >
> > The events are also broken out by memcg path. For container-based
> > workloads, users often think of several processes in a memcg as a single
> > logical "task", so collecting statistics at this level is useful.
> >
> > The end goal is to get latency information. This isn't directly included
> > in the trace events. Instead, users are expected to compute the time
> > between "start locking" and "acquire returned", using e.g. synthetic
> > events or BPF. The benefit we get from this is simpler code.
> >
> > Because we use tracepoint_enabled() to decide whether or not to trace,
> > this patch has effectively no overhead unless tracepoints are enabled at
> > runtime. If tracepoints are enabled, there is a performance impact, but
> > how much depends on exactly what e.g. the BPF program does.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Yeah I agree with this approach that follows the page ref one.
>
> ...
>
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > new file mode 100644
> > index 000000000000..b849287bd12a
> > --- /dev/null
> > +++ b/mm/mmap_lock.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/mmap_lock.h>
> > +
> > +#include <linux/mm.h>
> > +#include <linux/cgroup.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/mmap_lock.h>
> > +#include <linux/percpu.h>
> > +#include <linux/smp.h>
> > +#include <linux/trace_events.h>
> > +
> > +/*
> > + * We have to export these, as drivers use mmap_lock, and our inline functions
> > + * in the header check if the tracepoint is enabled. They can't be GPL, as e.g.
> > + * the nvidia driver is an existing caller of this code.
>
> I don't think this argument works in the kernel community. I would just remove
> this comment.
>
> > + */
> > +EXPORT_SYMBOL(__tracepoint_mmap_lock_start_locking);
> > +EXPORT_SYMBOL(__tracepoint_mmap_lock_acquire_returned);
> > +EXPORT_SYMBOL(__tracepoint_mmap_lock_released);
>
> You can use EXPORT_TRACEPOINT_SYMBOL() here.

This is simpler, thanks for the pointer!

Agree the comment isn't needed in this case. I added it mainly since
checkpatch.pl doesn't like the EXPORT_SYMBOL-ing things not defined
just above, but EXPORT_TRACEPOINT_SYMBOL won't raise the same
concerns.

>
> > +#ifdef CONFIG_MEMCG
> > +
> > +DEFINE_PER_CPU(char[MAX_FILTER_STR_VAL], trace_memcg_path);
> > +
> > +/*
> > + * Write the given mm_struct's memcg path to a percpu buffer, and return a
> > + * pointer to it. If the path cannot be determined, the buffer will contain the
> > + * empty string.
> > + *
> > + * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
> > + * disabled by the caller before calling us, and re-enabled only after the
> > + * caller is done with the pointer.
> > + */
> > +static const char *get_mm_memcg_path(struct mm_struct *mm)
> > +{
> > +     struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> > +
> > +     if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
> > +             char *buf = this_cpu_ptr(trace_memcg_path);
> > +
> > +             cgroup_path(memcg->css.cgroup, buf, MAX_FILTER_STR_VAL);
> > +             return buf;
> > +     }
> > +     return "";
> > +}
> > +
> > +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> > +     do {                                                                   \
> > +             if (trace_mmap_lock_##type##_enabled()) {                      \
>
> Is this check really needed? We only got called from the functions inlined in
> the .h file because tracepoint_enabled() was true in the first place, so this
> seems redundant.

Right, now that we've moved the check into the header, this isn't needed.

>
> > +                     get_cpu();                                             \
> > +                     trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),      \
> > +                                            ##__VA_ARGS__);                 \
> > +                     put_cpu();                                             \
> > +             }                                                              \
> > +     } while (0)
> > +
> > +#else /* !CONFIG_MEMCG */
> > +
> > +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> > +     trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> > +
> > +#endif /* CONFIG_MEMCG */
> > +
> > +/*
> > + * Trace calls must be in a separate file, as otherwise there's a circular
> > + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> > + */
> > +
> > +void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, true);
>
> Seems wasteful to have an always-true success field here. Yeah, not reusing the
> same event class for all three tracepoints means more code, but for tracing
> efficiency it's worth it, IMHO.

Right, originally I was worried about code size. But, I switched to
not re-using an event class, and I only measure an increase of 524
bytes in .text, which seems trivial.

I'll send a v4 with all of the above changes.

>
> > +}
> > +EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
> > +
> > +void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
> > +                                        bool success)
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> > +}
> > +EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
> > +
> > +void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(released, mm, write, true);
>
> Ditto.
>
> > +}
> > +EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> >
>
