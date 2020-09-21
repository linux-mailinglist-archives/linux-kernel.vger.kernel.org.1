Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2F271A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUE6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIUE6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:58:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:58:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f82so12420916ilh.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4gXwE69LF1HdKUHhJjz0jBKMfcrTmUCso3axV/wVC8=;
        b=S9TegCQCcI9TcFGy+ji8vv7Y4QRONWJh/E9HtSqBv8PV/W5dhZJ5/v6RdDjsD8Dhw5
         +8hwf03abeQW+udFiHHa1w1E9Q5fvqYlpDAuQekNTjc95S6edkD9KUpv8mQzbDTrc0ot
         PQTZAH2VCRnjl4MPbtEiZFEf6dDJrzccJ46uh3c1kkzg61hRlDz0TFqPckUMv9ZMUCcX
         EMU9S5CNBA5gdbr88uZjNfTI74RxlhHgddVzGpL+Yed9JlLvQ4qO3FTMoVwOECGXuGvf
         7EKxfOUo2MvyYUflyThkF/2R9tBPrddGSH/6lKdf54mqjDqYiwC/8tQ32YKx0DNE37Pn
         rbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4gXwE69LF1HdKUHhJjz0jBKMfcrTmUCso3axV/wVC8=;
        b=S2AiyUAROdCGmCIsZFHwRDdOZcbt/TFb2eAdt/9OPhUjuXR/QVXaK6tvNqiiCFrA0Y
         LB4QLv1HR0zfPfwXHugeZLbDd+h5LNuOPYv/PSPMwPz+sq5RZKWu8+vk33lHp4vhdzfy
         zo1Z257yrTlSRQsHkh5edndfis8fvC84nn1otLvDAWp6U2A3i6yva3ZdBqn1IqQY/Nlh
         w6Twd4XHgR1NzyLzHMkuBpcOFLBeUXdU04dkbebNIvmOIJHRqMx81DeDZFp/3em2hyh/
         ftKoeiqdy13fuTO+/ZmOuKGisKGg92m7CJo6iBxKPCUW0NEvTs3Px7OwJqydrTYB8Z64
         n8HA==
X-Gm-Message-State: AOAM532uyVikDLaDrsozQc+q+YF/vOCkMeJJBz6PmEjVzJvHIC2uKcff
        NRpYgLHVQn9why4L2aXJx/XM5KRBhNCTjyRVw18=
X-Google-Smtp-Source: ABdhPJyt2FvF2+GPbUjoiGYdX/vs2W9kxcQP9FGbmIp8Tj1bdor5IFZaigUzKQo3L8M/sW0D0N8n2dkHBZP50ukKOtY=
X-Received: by 2002:a92:d18c:: with SMTP id z12mr28163338ilz.142.1600664293031;
 Sun, 20 Sep 2020 21:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200917181347.1359365-1-axelrasmussen@google.com>
In-Reply-To: <20200917181347.1359365-1-axelrasmussen@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 21 Sep 2020 12:57:35 +0800
Message-ID: <CALOAHbDSHGeXjJN3E5mTOAFTVsXAvQL9+nSYTqht5Lz8HRNv0A@mail.gmail.com>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:13 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
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
> These events *do not* include latency bucket information, which means
> for a proper latency histogram users will need to use BPF instead of
> event histograms. The benefit we get from this is simpler code.
>
> This patch is a no-op if the Kconfig option is not enabled. If it is,
> tracepoints are still disabled by default (configurable at runtime);
> the only fixed cost here is un-inlining a few functions. As best as
> I've been able to measure, the overhead this introduces is a small
> fraction of 1%. Actually hooking up the tracepoints to BPF introduces
> additional overhead, depending on exactly what the BPF program is
> collecting.

Are there any methods to avoid un-inlining these wrappers ?

For example,
// include/linux/mmap_lock.h

void mmap_lock_start_trace_wrapper();
void mmap_lock_acquire_trace_wrapper();

static inline void mmap_write_lock(struct mm_struct *mm)
{
    mmap_lock_start_trace_wrapper();
    down_write(&mm->mmap_lock);
    mmap_lock_acquire_trace_wrapper();
}

// mm/mmap_lock.c
void mmap_lock_start_trace_wrapper()
{
    trace_mmap_lock_start();
}

void mmap_lock_start_trace_wrapper()
{
    trace_mmap_lock_acquired();
}



> ---
>  include/linux/mmap_lock.h        |  28 +++-
>  include/trace/events/mmap_lock.h |  73 ++++++++++
>  mm/Kconfig                       |  17 +++
>  mm/Makefile                      |   1 +
>  mm/mmap_lock.c                   | 224 +++++++++++++++++++++++++++++++
>  5 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/mmap_lock.h
>  create mode 100644 mm/mmap_lock.c
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0707671851a8..d12aa2ff6c05 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -1,11 +1,35 @@
>  #ifndef _LINUX_MMAP_LOCK_H
>  #define _LINUX_MMAP_LOCK_H
>
> +#include <linux/lockdep.h>
> +#include <linux/mm_types.h>
>  #include <linux/mmdebug.h>
> +#include <linux/rwsem.h>
> +#include <linux/types.h>
>
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
>
> +#ifdef CONFIG_MMAP_LOCK_STATS
> +
> +void mmap_init_lock(struct mm_struct *mm);
> +void mmap_write_lock(struct mm_struct *mm);
> +void mmap_write_lock_nested(struct mm_struct *mm, int subclass);
> +int mmap_write_lock_killable(struct mm_struct *mm);
> +bool mmap_write_trylock(struct mm_struct *mm);
> +void mmap_write_unlock(struct mm_struct *mm);
> +void mmap_write_downgrade(struct mm_struct *mm);
> +void mmap_read_lock(struct mm_struct *mm);
> +int mmap_read_lock_killable(struct mm_struct *mm);
> +bool mmap_read_trylock(struct mm_struct *mm);
> +void mmap_read_unlock(struct mm_struct *mm);
> +bool mmap_read_trylock_non_owner(struct mm_struct *mm);
> +void mmap_read_unlock_non_owner(struct mm_struct *mm);
> +void mmap_assert_locked(struct mm_struct *mm);
> +void mmap_assert_write_locked(struct mm_struct *mm);
> +
> +#else /* !CONFIG_MMAP_LOCK_STATS */
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> @@ -63,7 +87,7 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>
>  static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>  {
> -       if (down_read_trylock(&mm->mmap_lock)) {
> +       if (mmap_read_trylock(mm)) {
>                 rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
>                 return true;
>         }
> @@ -87,4 +111,6 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
>         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>  }
>
> +#endif /* CONFIG_MMAP_LOCK_STATS */
> +
>  #endif /* _LINUX_MMAP_LOCK_H */
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> new file mode 100644
> index 000000000000..549c662e6ed8
> --- /dev/null
> +++ b/include/trace/events/mmap_lock.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mmap_lock
> +
> +#if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MMAP_LOCK_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/types.h>
> +
> +struct mm_struct;
> +
> +DECLARE_EVENT_CLASS(
> +       mmap_lock_template,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> +               bool write, bool success),
> +
> +       TP_ARGS(mm, memcg_path, duration, write, success),
> +
> +       TP_STRUCT__entry(
> +               __field(struct mm_struct *, mm)
> +               __string(memcg_path, memcg_path)
> +               __field(u64, duration)
> +               __field(bool, write)
> +               __field(bool, success)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->mm = mm;
> +               __assign_str(memcg_path, memcg_path);
> +               __entry->duration = duration;
> +               __entry->write = write;
> +               __entry->success = success;
> +       ),
> +
> +       TP_printk(
> +               "mm=%p memcg_path=%s duration=%llu write=%s success=%s\n",
> +               __entry->mm,
> +               __get_str(memcg_path),
> +               __entry->duration,
> +               __entry->write ? "true" : "false",
> +               __entry->success ? "true" : "false")
> +       );
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_start_locking,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> +               bool write, bool success),
> +
> +       TP_ARGS(mm, memcg_path, duration, write, success)
> +);
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_acquire_returned,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> +               bool write, bool success),
> +
> +       TP_ARGS(mm, memcg_path, duration, write, success)
> +);
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_released,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, u64 duration,
> +               bool write, bool success),
> +
> +       TP_ARGS(mm, memcg_path, duration, write, success)
> +);
> +
> +#endif /* _TRACE_MMAP_LOCK_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c974888f86f..b602df8bcee0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -818,6 +818,23 @@ config DEVICE_PRIVATE
>  config FRAME_VECTOR
>         bool
>
> +config MMAP_LOCK_STATS
> +       bool "mmap_lock stats / instrumentation"
> +       select HISTOGRAM
> +       default n
> +
> +       help
> +         Enables tracepoints around mmap_lock (start aquiring, acquire
> +         returned, and released), which are off by default + controlled at
> +         runtime. These can be used for deeper debugging of contention
> +         issues, via e.g. BPF.
> +
> +         This option has a small (small fraction of 1%) fixed overhead
> +         even if tracepoints aren't actually in use at runtime, since it
> +         requires un-inlining some functions.
> +
> +         If unsure, say "n".
> +
>  config ARCH_USES_HIGH_VMA_FLAGS
>         bool
>  config ARCH_HAS_PKEYS
> diff --git a/mm/Makefile b/mm/Makefile
> index d5649f1c12c0..eb6ed855a002 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> +obj-$(CONFIG_MMAP_LOCK_STATS) += mmap_lock.o
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> new file mode 100644
> index 000000000000..1624f90164c0
> --- /dev/null
> +++ b/mm/mmap_lock.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmap_lock.h>
> +
> +#include <linux/cgroup.h>
> +#include <linux/memcontrol.h>
> +#include <linux/mmap_lock.h>
> +#include <linux/percpu.h>
> +#include <linux/smp.h>
> +#include <linux/trace_events.h>
> +#include <linux/sched/clock.h>
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
> + */
> +static const char *get_mm_memcg_path(struct mm_struct *mm)
> +{
> +       struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> +
> +       if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
> +               char *buf = this_cpu_ptr(trace_memcg_path);
> +
> +               cgroup_path(memcg->css.cgroup, buf, MAX_FILTER_STR_VAL);
> +               return buf;
> +       }
> +       return "";
> +}
> +
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +       do {                                                                   \
> +               if (trace_mmap_lock_##type##_enabled()) {                      \
> +                       get_cpu();                                             \
> +                       trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),      \
> +                                              ##__VA_ARGS__);                 \
> +                       put_cpu();                                             \
> +               }                                                              \
> +       } while (0)
> +
> +#else /* !CONFIG_MEMCG */
> +
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +       trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> +
> +#endif /* CONFIG_MEMCG */
> +
> +/*
> + * Trace calls must be in a separate file, as otherwise there's a circuclar
> + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> + */
> +
> +static void trace_start_locking(struct mm_struct *mm, bool write)
> +{
> +       TRACE_MMAP_LOCK_EVENT(start_locking, mm, 0, write, true);
> +}
> +
> +static void trace_acquire_returned(struct mm_struct *mm, u64 start_time_ns,
> +                                  bool write, bool success)
> +{
> +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm,
> +                             sched_clock() - start_time_ns, write, success);
> +}
> +
> +static void trace_released(struct mm_struct *mm, bool write)
> +{
> +       TRACE_MMAP_LOCK_EVENT(released, mm, 0, write, true);
> +}
> +
> +static bool trylock_impl(struct mm_struct *mm,
> +                        int (*trylock)(struct rw_semaphore *), bool write)
> +{
> +       bool ret;
> +
> +       trace_start_locking(mm, write);
> +       ret = trylock(&mm->mmap_lock) != 0;
> +       /* Avoid calling sched_clock() for trylocks; assume duration = 0. */
> +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, 0, write, ret);
> +       return ret;
> +}
> +
> +static inline void lock_impl(struct mm_struct *mm,
> +                            void (*lock)(struct rw_semaphore *), bool write)
> +{
> +       u64 start_time_ns;
> +
> +       trace_start_locking(mm, write);
> +       start_time_ns = sched_clock();
> +       lock(&mm->mmap_lock);
> +       trace_acquire_returned(mm, start_time_ns, write, true);
> +}
> +
> +static inline int lock_return_impl(struct mm_struct *mm,
> +                                  int (*lock)(struct rw_semaphore *),
> +                                  bool write)
> +{
> +       u64 start_time_ns;
> +       int ret;
> +
> +       trace_start_locking(mm, write);
> +       start_time_ns = sched_clock();
> +       ret = lock(&mm->mmap_lock);
> +       trace_acquire_returned(mm, start_time_ns, write, ret == 0);
> +       return ret;
> +}
> +
> +static inline void unlock_impl(struct mm_struct *mm,
> +                              void (*unlock)(struct rw_semaphore *),
> +                              bool write)
> +{
> +       unlock(&mm->mmap_lock);
> +       trace_released(mm, write);
> +}
> +
> +void mmap_init_lock(struct mm_struct *mm)
> +{
> +       init_rwsem(&mm->mmap_lock);
> +}
> +
> +void mmap_write_lock(struct mm_struct *mm)
> +{
> +       lock_impl(mm, down_write, true);
> +}
> +EXPORT_SYMBOL(mmap_write_lock);
> +
> +void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
> +{
> +       u64 start_time_ns;
> +
> +       trace_start_locking(mm, true);
> +       start_time_ns = sched_clock();
> +       down_write_nested(&mm->mmap_lock, subclass);
> +       trace_acquire_returned(mm, start_time_ns, true, true);
> +}
> +EXPORT_SYMBOL(mmap_write_lock_nested);
> +
> +int mmap_write_lock_killable(struct mm_struct *mm)
> +{
> +       return lock_return_impl(mm, down_write_killable, true);
> +}
> +EXPORT_SYMBOL(mmap_write_lock_killable);
> +
> +bool mmap_write_trylock(struct mm_struct *mm)
> +{
> +       return trylock_impl(mm, down_write_trylock, true);
> +}
> +EXPORT_SYMBOL(mmap_write_trylock);
> +
> +void mmap_write_unlock(struct mm_struct *mm)
> +{
> +       unlock_impl(mm, up_write, true);
> +}
> +EXPORT_SYMBOL(mmap_write_unlock);
> +
> +void mmap_write_downgrade(struct mm_struct *mm)
> +{
> +       downgrade_write(&mm->mmap_lock);
> +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, 0, false, true);
> +}
> +EXPORT_SYMBOL(mmap_write_downgrade);
> +
> +void mmap_read_lock(struct mm_struct *mm)
> +{
> +       lock_impl(mm, down_read, false);
> +}
> +EXPORT_SYMBOL(mmap_read_lock);
> +
> +int mmap_read_lock_killable(struct mm_struct *mm)
> +{
> +       return lock_return_impl(mm, down_read_killable, false);
> +}
> +EXPORT_SYMBOL(mmap_read_lock_killable);
> +
> +bool mmap_read_trylock(struct mm_struct *mm)
> +{
> +       return trylock_impl(mm, down_read_trylock, false);
> +}
> +EXPORT_SYMBOL(mmap_read_trylock);
> +
> +void mmap_read_unlock(struct mm_struct *mm)
> +{
> +       unlock_impl(mm, up_read, false);
> +}
> +EXPORT_SYMBOL(mmap_read_unlock);
> +
> +bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> +{
> +       if (mmap_read_trylock(mm)) {
> +               rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
> +               trace_released(mm, false);
> +               return true;
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL(mmap_read_trylock_non_owner);
> +
> +void mmap_read_unlock_non_owner(struct mm_struct *mm)
> +{
> +       up_read_non_owner(&mm->mmap_lock);
> +       trace_released(mm, false);
> +}
> +EXPORT_SYMBOL(mmap_read_unlock_non_owner);
> +
> +void mmap_assert_locked(struct mm_struct *mm)
> +{
> +       lockdep_assert_held(&mm->mmap_lock);
> +       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> +}
> +EXPORT_SYMBOL(mmap_assert_locked);
> +
> +void mmap_assert_write_locked(struct mm_struct *mm)
> +{
> +       lockdep_assert_held_write(&mm->mmap_lock);
> +       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> +}
> +EXPORT_SYMBOL(mmap_assert_write_locked);
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
Thanks
Yafang
