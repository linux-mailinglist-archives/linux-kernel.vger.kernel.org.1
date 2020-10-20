Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB112289E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgJJFmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 01:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgJJFcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 01:32:22 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 22:32:22 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 67so12514928iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UA2pc8QLpwV1dhnUZK1/iY2LKiaZD/wPoHBXE8fh1Y=;
        b=DevqdA32VdzJkKing90EWzqLGnw+kjM916H3bG1aWsNeso0ejyCv7Ub9hDqJ2qYHhe
         novL1d8mU/0oqWVC14ypAaq3/18z1QN7kYALOrHcErnQmpPu/oePXvsRbNTf2seU5S2h
         4tE4ELqQ31qh/l7AqI+TU6kC6tHaxhuX3eeAsMu92pDqYoTVHk7Jdo20vBb62sueW8cW
         v6RGyOoGiBcNr/vtCoZDSKKoYFntmqWrCIGw/F3QufKI6+SgJ0KSBthWPteB7OgrgN7t
         7kd8VGqjMwTfVXL0MK2cQz0P9FyoqEdrjZJzMDoSbqMkE/era6XcU3k27ucdMIFh8KK7
         iLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UA2pc8QLpwV1dhnUZK1/iY2LKiaZD/wPoHBXE8fh1Y=;
        b=agZS7Z3G2O35WYVR7PZsun+xsLZtXfBMMJJTyd5NsWDhyD6P9u0riKkZOG2rZffvOE
         WkukX2EgAvfz5bTzHvEcMLyREv5pUbQG5L+cf0MsqR12pUdCA7a+kPhPH6QpvSDqAUXE
         DsxmhIiyWkXeAklc3roViyEenvm48r8uXwBmVrhHTlibHD7N4LQ0pN+EidH27pmwR/Z/
         XtmhAY5aB/zEn0kbbg/6FhV7B1u2C68by3ohXrl07bgzpRoQkReg/yYq+nJhlmQhSzy3
         suynEN+mVp6L51/TtLLmbx10BjnRm1gO3QH9Pm5E495xgqyv03uH2lg36eDL85rAE6CY
         Ux2w==
X-Gm-Message-State: AOAM5303UKuFiKmwadiAelxYSW2WdaAy+NDPzFG/VqZmuRRzXWB07XN1
        ZK9fF9OVaeHbu92z5r1Y29ZqRjry8/X/KFW4XsY=
X-Google-Smtp-Source: ABdhPJygZXwsheO/cRfwxmLsEwEiwnu4iu4G5BxXFJksYMjTBQIJQcUmD9v1FL0TooTV1JgsV18VFXuP7NkWdUc+IdY=
X-Received: by 2002:a02:9543:: with SMTP id y61mr13710702jah.64.1602307940962;
 Fri, 09 Oct 2020 22:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201009220524.485102-1-axelrasmussen@google.com> <20201009220524.485102-3-axelrasmussen@google.com>
In-Reply-To: <20201009220524.485102-3-axelrasmussen@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 10 Oct 2020 13:31:43 +0800
Message-ID: <CALOAHbCjr6y=zcUkMS1xN_GLPacyNCCgmRb9RRaaxOvMe3DHDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmap_lock: add tracepoints around lock acquisition
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 6:05 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/linux/mmap_lock.h        | 93 ++++++++++++++++++++++++++++++--
>  include/trace/events/mmap_lock.h | 70 ++++++++++++++++++++++++
>  mm/Makefile                      |  2 +-
>  mm/mmap_lock.c                   | 87 ++++++++++++++++++++++++++++++
>  4 files changed, 246 insertions(+), 6 deletions(-)
>  create mode 100644 include/trace/events/mmap_lock.h
>  create mode 100644 mm/mmap_lock.c
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0707671851a8..6586b42b4faa 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -1,11 +1,63 @@
>  #ifndef _LINUX_MMAP_LOCK_H
>  #define _LINUX_MMAP_LOCK_H
>
> +#include <linux/lockdep.h>
> +#include <linux/mm_types.h>
>  #include <linux/mmdebug.h>
> +#include <linux/rwsem.h>
> +#include <linux/tracepoint-defs.h>
> +#include <linux/types.h>
>
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
>
> +DECLARE_TRACEPOINT(mmap_lock_start_locking);
> +DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
> +DECLARE_TRACEPOINT(mmap_lock_released);
> +
> +#ifdef CONFIG_TRACING
> +
> +void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write);
> +void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
> +                                          bool success);
> +void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write);
> +
> +static inline void __mmap_lock_trace_start_locking(struct mm_struct *mm,
> +                                                  bool write)
> +{
> +       if (tracepoint_enabled(mmap_lock_start_locking))
> +               __mmap_lock_do_trace_start_locking(mm, write);
> +}
> +
> +static inline void __mmap_lock_trace_acquire_returned(struct mm_struct *mm,
> +                                                     bool write, bool success)
> +{
> +       if (tracepoint_enabled(mmap_lock_acquire_returned))
> +               __mmap_lock_do_trace_acquire_returned(mm, write, success);
> +}
> +
> +static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
> +{
> +       if (tracepoint_enabled(mmap_lock_released))
> +               __mmap_lock_do_trace_released(mm, write);
> +}
> +
> +#else /* !CONFIG_TRACING */
> +
> +static inline void __mmap_lock_trace_start_locking(struct mm_struct *mm,
> +                                                  bool write)
> +{
> +}
> +static inline void __mmap_lock_trace_acquire_returned(struct mm_struct *mm,
> +                                                     bool write, bool success)
> +{
> +}
> +static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
> +{
> +}
> +
> +#endif /* CONFIG_TRACING */
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> @@ -13,58 +65,88 @@ static inline void mmap_init_lock(struct mm_struct *mm)
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
> +       __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
>  static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
>  {
> +       __mmap_lock_trace_start_locking(mm, true);
>         down_write_nested(&mm->mmap_lock, subclass);
> +       __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
>  static inline int mmap_write_lock_killable(struct mm_struct *mm)
>  {
> -       return down_write_killable(&mm->mmap_lock);
> +       int ret;
> +
> +       __mmap_lock_trace_start_locking(mm, true);
> +       ret = down_write_killable(&mm->mmap_lock);
> +       __mmap_lock_trace_acquire_returned(mm, true, ret == 0);
> +       return ret;
>  }
>
>  static inline bool mmap_write_trylock(struct mm_struct *mm)
>  {
> -       return down_write_trylock(&mm->mmap_lock) != 0;
> +       bool ret;
> +
> +       __mmap_lock_trace_start_locking(mm, true);
> +       ret = down_write_trylock(&mm->mmap_lock) != 0;
> +       __mmap_lock_trace_acquire_returned(mm, true, ret);
> +       return ret;
>  }
>
>  static inline void mmap_write_unlock(struct mm_struct *mm)
>  {
>         up_write(&mm->mmap_lock);
> +       __mmap_lock_trace_released(mm, true);
>  }
>
>  static inline void mmap_write_downgrade(struct mm_struct *mm)
>  {
>         downgrade_write(&mm->mmap_lock);
> +       __mmap_lock_trace_acquire_returned(mm, false, true);
>  }
>
>  static inline void mmap_read_lock(struct mm_struct *mm)
>  {
> +       __mmap_lock_trace_start_locking(mm, false);
>         down_read(&mm->mmap_lock);
> +       __mmap_lock_trace_acquire_returned(mm, false, true);
>  }
>
>  static inline int mmap_read_lock_killable(struct mm_struct *mm)
>  {
> -       return down_read_killable(&mm->mmap_lock);
> +       int ret;
> +
> +       __mmap_lock_trace_start_locking(mm, false);
> +       ret = down_read_killable(&mm->mmap_lock);
> +       __mmap_lock_trace_acquire_returned(mm, false, ret == 0);
> +       return ret;
>  }
>
>  static inline bool mmap_read_trylock(struct mm_struct *mm)
>  {
> -       return down_read_trylock(&mm->mmap_lock) != 0;
> +       bool ret;
> +
> +       __mmap_lock_trace_start_locking(mm, false);
> +       ret = down_read_trylock(&mm->mmap_lock) != 0;
> +       __mmap_lock_trace_acquire_returned(mm, false, ret);
> +       return ret;
>  }
>
>  static inline void mmap_read_unlock(struct mm_struct *mm)
>  {
>         up_read(&mm->mmap_lock);
> +       __mmap_lock_trace_released(mm, false);
>  }
>
>  static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>  {
> -       if (down_read_trylock(&mm->mmap_lock)) {
> +       if (mmap_read_trylock(mm)) {
>                 rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
> +               __mmap_lock_trace_released(mm, false);
>                 return true;
>         }
>         return false;
> @@ -73,6 +155,7 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>  {
>         up_read_non_owner(&mm->mmap_lock);
> +       __mmap_lock_trace_released(mm, false);
>  }
>
>  static inline void mmap_assert_locked(struct mm_struct *mm)
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> new file mode 100644
> index 000000000000..ca652b52510e
> --- /dev/null
> +++ b/include/trace/events/mmap_lock.h
> @@ -0,0 +1,70 @@
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
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> +               bool success),
> +
> +       TP_ARGS(mm, memcg_path, write, success),
> +
> +       TP_STRUCT__entry(
> +               __field(struct mm_struct *, mm)
> +               __string(memcg_path, memcg_path)
> +               __field(bool, write)
> +               __field(bool, success)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->mm = mm;
> +               __assign_str(memcg_path, memcg_path);
> +               __entry->write = write;
> +               __entry->success = success;
> +       ),
> +
> +       TP_printk(
> +               "mm=%p memcg_path=%s write=%s success=%s\n",
> +               __entry->mm,
> +               __get_str(memcg_path),
> +               __entry->write ? "true" : "false",
> +               __entry->success ? "true" : "false")
> +       );
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_start_locking,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> +               bool success),
> +
> +       TP_ARGS(mm, memcg_path, write, success)
> +);
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_acquire_returned,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> +               bool success),
> +
> +       TP_ARGS(mm, memcg_path, write, success)
> +);
> +
> +DEFINE_EVENT(mmap_lock_template, mmap_lock_released,
> +
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> +               bool success),
> +
> +       TP_ARGS(mm, memcg_path, write, success)
> +);
> +
> +#endif /* _TRACE_MMAP_LOCK_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/Makefile b/mm/Makefile
> index d5649f1c12c0..1a7ea212fd8b 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -52,7 +52,7 @@ obj-y                 := filemap.o mempool.o oom_kill.o fadvise.o \
>                            mm_init.o percpu.o slab_common.o \
>                            compaction.o vmacache.o \
>                            interval_tree.o list_lru.o workingset.o \
> -                          debug.o gup.o $(mmu-y)
> +                          debug.o gup.o mmap_lock.o $(mmu-y)
>
>  # Give 'page_alloc' its own module-parameter namespace
>  page-alloc-y := page_alloc.o
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
> + */
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_start_locking);
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_acquire_returned);
> +EXPORT_SYMBOL(__tracepoint_mmap_lock_released);
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
> + * Trace calls must be in a separate file, as otherwise there's a circular
> + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> + */
> +
> +void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
> +{
> +       TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, true);
> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
> +
> +void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
> +                                          bool success)
> +{
> +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
> +
> +void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
> +{
> +       TRACE_MMAP_LOCK_EVENT(released, mm, write, true);
> +}
> +EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> --
> 2.28.0.1011.ga647a8990f-goog
>


-- 
Thanks
Yafang
