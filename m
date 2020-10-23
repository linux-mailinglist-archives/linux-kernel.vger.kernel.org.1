Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B013B297109
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750226AbgJWOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:00:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373819AbgJWOAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2286AEC1;
        Fri, 23 Oct 2020 13:59:59 +0000 (UTC)
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201020184746.300555-1-axelrasmussen@google.com>
 <20201020184746.300555-2-axelrasmussen@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/1] mmap_lock: add tracepoints around lock acquisition
Message-ID: <fa6b9d13-0ef5-4d5d-bda3-657300028e23@suse.cz>
Date:   Fri, 23 Oct 2020 15:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201020184746.300555-2-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 8:47 PM, Axel Rasmussen wrote:
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
> Reviewed-by: Michel Lespinasse <walken@google.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

All seem fine to me, except I started to wonder..

> +
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

Is this enough? What if we fill the buffer and then an interrupt comes and the 
handler calls here again? We overwrite the buffer and potentially report a wrong 
cgroup after the execution resumes?
If nothing worse can happen (are interrupts disabled while the ftrace code is 
copying from the buffer?), then it's probably ok?

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
> +		get_cpu();                                                     \
> +		trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),              \
> +				       ##__VA_ARGS__);                         \
> +		put_cpu();                                                     \
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
> +	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
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
> +	TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> 

