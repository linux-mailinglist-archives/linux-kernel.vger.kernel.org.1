Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3B293F05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408418AbgJTOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408369AbgJTOuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:50:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47EE6AE5C;
        Tue, 20 Oct 2020 14:50:31 +0000 (UTC)
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201009220524.485102-1-axelrasmussen@google.com>
 <20201009220524.485102-3-axelrasmussen@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 2/2] mmap_lock: add tracepoints around lock acquisition
Message-ID: <1b9238b7-17f2-6c1e-b37e-cf65424f504b@suse.cz>
Date:   Tue, 20 Oct 2020 16:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009220524.485102-3-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/20 12:05 AM, Axel Rasmussen wrote:
> The goal of these tracepoints is to be able to debug lock contention
> issues. This lock is acquired on most (all?) mmap / munmap / page fault
> operations, so a multi-threaded process which does a lot of these can
> experience significant contention.
> 
> We trace just before we start acquisition, when the acquisition returns
> (whether it succeeded or not), and when the lock is released (or
> downgraded). The events are broken out by lock type (read / write).
> 
> The events are also broken out by memcg path. For container-based
> workloads, users often think of several processes in a memcg as a single
> logical "task", so collecting statistics at this level is useful.
> 
> The end goal is to get latency information. This isn't directly included
> in the trace events. Instead, users are expected to compute the time
> between "start locking" and "acquire returned", using e.g. synthetic
> events or BPF. The benefit we get from this is simpler code.
> 
> Because we use tracepoint_enabled() to decide whether or not to trace,
> this patch has effectively no overhead unless tracepoints are enabled at
> runtime. If tracepoints are enabled, there is a performance impact, but
> how much depends on exactly what e.g. the BPF program does.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Yeah I agree with this approach that follows the page ref one.

...

> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> new file mode 100644
> index 000000000000..b849287bd12a
> --- /dev/null
> +++ b/mm/mmap_lock.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmap_lock.h>
> +
> +#include <linux/mm.h>
> +#include <linux/cgroup.h>
> +#include <linux/memcontrol.h>
> +#include <linux/mmap_lock.h>
> +#include <linux/percpu.h>
> +#include <linux/smp.h>
> +#include <linux/trace_events.h>
> +
> +/*
> + * We have to export these, as drivers use mmap_lock, and our inline functions
> + * in the header check if the tracepoint is enabled. They can't be GPL, as e.g.
> + * the nvidia driver is an existing caller of this code.

I don't think this argument works in the kernel community. I would just remove 
this comment.

> + */
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_start_locking);
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_acquire_returned);
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_released);

You can use EXPORT_TRACEPOINT_SYMBOL() here.

> +#ifdef CONFIG_MEMCG
> +
> +DEFINE_PER_CPU(char[MAX_FILTER_STR_VAL], trace_memcg_path);
> +
> +/*
> + * Write the given mm_struct's memcg path to a percpu buffer, and return a
> + * pointer to it. If the path cannot be determined, the buffer will contain the
> + * empty string.
> + *
> + * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
> + * disabled by the caller before calling us, and re-enabled only after the
> + * caller is done with the pointer.
> + */
> +static const char *get_mm_memcg_path(struct mm_struct *mm)
> +{
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> +
> +	if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
> +		char *buf = this_cpu_ptr(trace_memcg_path);
> +
> +		cgroup_path(memcg->css.cgroup, buf, MAX_FILTER_STR_VAL);
> +		return buf;
> +	}
> +	return "";
> +}
> +
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +	do {                                                                   \
> +		if (trace_mmap_lock_##type##_enabled()) {                      \

Is this check really needed? We only got called from the functions inlined in 
the .h file because tracepoint_enabled() was true in the first place, so this 
seems redundant.

> +			get_cpu();                                             \
> +			trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),      \
> +					       ##__VA_ARGS__);                 \
> +			put_cpu();                                             \
> +		}                                                              \
> +	} while (0)
> +
> +#else /* !CONFIG_MEMCG */
> +
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> +
> +#endif /* CONFIG_MEMCG */
> +
> +/*
> + * Trace calls must be in a separate file, as otherwise there's a circular
> + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> + */
> +
> +void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
> +{
> +	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, true);

Seems wasteful to have an always-true success field here. Yeah, not reusing the 
same event class for all three tracepoints means more code, but for tracing 
efficiency it's worth it, IMHO.

> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
> +
> +void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
> +					   bool success)
> +{
> +	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
> +
> +void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
> +{
> +	TRACE_MMAP_LOCK_EVENT(released, mm, write, true);

Ditto.

> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> 

