Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81D2C94BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgLABe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbgLABe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:34:57 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:34:10 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d8so655561lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6X9ZMHHooCnMQp+SzbmdyUAQaaYH0YuMMWi2FM2VN9c=;
        b=SmlTW/ObRa53mLPh1i6S/K2/7blSxrA34W/q8bmHwcnDusW+OVlvzOmarm/8/SjrXN
         x4Cw9WHqYHW0cU2Lu6RslbCTCsyZuU7c83TNLxaK4t76p/bnhfYhfymacrh8oad/ZQl+
         eJGcFzNiB117r1DwlupPNejq3NqR5o21K60NvYQB0I19hoCt/NhqsfRX72Q9RcqZDArt
         qAN10XJM/iIgEaWOgWCzXA3Z/RPKg7kZEIirr04Qg8xiuiX9eowsHufr5836J2NmdEeO
         VKEIigX74kTx1cJgp+9sCCXS0hHxVj2rBKmpwGco1BZ3gtc8m1U9B1vncpeWwwsoADin
         u2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6X9ZMHHooCnMQp+SzbmdyUAQaaYH0YuMMWi2FM2VN9c=;
        b=EuLPVEqv/w+Aj5JaP7WOBuE5Gf/QpAuUWOuzih8kfXhR4AsKx42j9CXTdRblQ+W2hF
         bAxdg7Fq7to1NjkKLYtcdD6rIMemNFQtXaT+ihzMfAMVzAI984mUNLpIMaQaADAJMoHL
         7rO8U/cuf9+MFf9g59su9lMNKNTjPC93DcAVrtoJqspMsMnUDwEqp2b9IPZdA7xQhTma
         OFqVGjqE1J2H71TEHnXxKT5LMrf2mIqi5+BnVJXZFPTOS11UeNmpHGl2UinyfhMuJX+I
         SlM+V5pWv7eDNihFP5y3EFgmsIMf/k4QrMlSGhoKav6slcSLDAYZJK+vsdTXDvLDypbj
         WfAw==
X-Gm-Message-State: AOAM532dptHHllXR123Fu5GNkg8Kqxd9WtvJLxZPPha9WBMmlux142BL
        NnmwaWWo9x0D3slns3VzkOI/Aksy6aVkcqPdc+03pw==
X-Google-Smtp-Source: ABdhPJxx/YUc+3Ke8u5vopjQdidKKMqOqDp1NnWak7quwKbDWyOOQAr9woFzh7kJHPtG2jCh53MtVUJEblzhLyYGC1M=
X-Received: by 2002:a19:cc42:: with SMTP id c63mr146134lfg.521.1606786448762;
 Mon, 30 Nov 2020 17:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
In-Reply-To: <20201130233504.3725241-1-axelrasmussen@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 30 Nov 2020 17:33:57 -0800
Message-ID: <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> is that an ongoing trace event might race with the tracepoint being
> disabled (and therefore the _unreg() callback being called). Consider
> this ordering:
>
> T1: trace event fires, get_mm_memcg_path() is called
> T1: get_memcg_path_buf() returns a buffer pointer
> T2: trace_mmap_lock_unreg() is called, buffers are freed
> T1: cgroup_path() is called with the now-freed buffer

Any reason to use the cgroup_path instead of the cgroup_ino? There are
other examples of trace points using cgroup_ino and no need to
allocate buffers. Also cgroup namespace might complicate the path
usage.

>
> The solution in this commit is to modify trace_mmap_lock_unreg() to
> first stop new buffers from being handed out, and then to wait (spin)
> until any existing buffer references are dropped (i.e., those trace
> events complete).
>
> I have a simple reproducer program which spins up two pools of threads,
> doing the following in a tight loop:
>
>   Pool 1:
>   mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
>   munmap()
>
>   Pool 2:
>   echo 1 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>   echo 0 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>
> This triggers the use-after-free very quickly. With this patch, I let it
> run for an hour without any BUGs.
>
> While fixing this, I also noticed and fixed a css ref leak. Previously
> we called get_mem_cgroup_from_mm(), but we never called css_put() to
> release that reference. get_mm_memcg_path() now does this properly.
>
> [1]: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
>
> Fixes: 0f818c4bc1f3 ("mm: mmap_lock: add tracepoints around lock acquisition")

The original patch is in mm tree, so the SHA1 is not stabilized.
Usually Andrew squash the fixes into the original patches.

> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/mmap_lock.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 85 insertions(+), 15 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 12af8f1b8a14..be38dc58278b 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -3,6 +3,7 @@
>  #include <trace/events/mmap_lock.h>
>
>  #include <linux/mm.h>
> +#include <linux/atomic.h>
>  #include <linux/cgroup.h>
>  #include <linux/memcontrol.h>
>  #include <linux/mmap_lock.h>
> @@ -18,13 +19,28 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>  #ifdef CONFIG_MEMCG
>
>  /*
> - * Our various events all share the same buffer (because we don't want or need
> - * to allocate a set of buffers *per event type*), so we need to protect against
> - * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
> - * been made.
> + * This is unfortunately complicated... _reg() and _unreg() may be called
> + * in parallel, separately for each of our three event types. To save memory,
> + * all of the event types share the same buffers. Furthermore, trace events
> + * might happen in parallel with _unreg(); we need to ensure we don't free the
> + * buffers before all inflights have finished. Because these events happen
> + * "frequently", we also want to prevent new inflights from starting once the
> + * _unreg() process begins. And, for performance reasons, we want to avoid any
> + * locking in the trace event path.
> + *
> + * So:
> + *
> + * - Use a spinlock to serialize _reg() and _unreg() calls.
> + * - Keep track of nested _reg() calls with a lock-protected counter.
> + * - Define a flag indicating whether or not unregistration has begun (and
> + *   therefore that there should be no new buffer uses going forward).
> + * - Keep track of inflight buffer users with a reference count.
>   */
>  static DEFINE_SPINLOCK(reg_lock);
> -static int reg_refcount;
> +static int reg_types_rc; /* Protected by reg_lock. */
> +static bool unreg_started; /* Doesn't need synchronization. */
> +/* atomic_t instead of refcount_t, as we want ordered inc without locks. */
> +static atomic_t inflight_rc = ATOMIC_INIT(0);
>
>  /*
>   * Size of the buffer for memcg path names. Ignoring stack trace support,
> @@ -46,9 +62,14 @@ int trace_mmap_lock_reg(void)
>         unsigned long flags;
>         int cpu;
>
> +       /*
> +        * Serialize _reg() and _unreg(). Without this, e.g. _unreg() might
> +        * start cleaning up while _reg() is only partially completed.
> +        */
>         spin_lock_irqsave(&reg_lock, flags);
>
> -       if (reg_refcount++)
> +       /* If the refcount is going 0->1, proceed with allocating buffers. */
> +       if (reg_types_rc++)
>                 goto out;
>
>         for_each_possible_cpu(cpu) {
> @@ -62,6 +83,11 @@ int trace_mmap_lock_reg(void)
>                 per_cpu(memcg_path_buf_idx, cpu) = 0;
>         }
>
> +       /* Reset unreg_started flag, allowing new trace events. */
> +       WRITE_ONCE(unreg_started, false);
> +       /* Add the registration +1 to the inflight refcount. */
> +       atomic_inc(&inflight_rc);
> +
>  out:
>         spin_unlock_irqrestore(&reg_lock, flags);
>         return 0;
> @@ -74,7 +100,8 @@ int trace_mmap_lock_reg(void)
>                         break;
>         }
>
> -       --reg_refcount;
> +       /* Since we failed, undo the earlier increment. */
> +       --reg_types_rc;
>
>         spin_unlock_irqrestore(&reg_lock, flags);
>         return -ENOMEM;
> @@ -87,9 +114,23 @@ void trace_mmap_lock_unreg(void)
>
>         spin_lock_irqsave(&reg_lock, flags);
>
> -       if (--reg_refcount)
> +       /* If the refcount is going 1->0, proceed with freeing buffers. */
> +       if (--reg_types_rc)
>                 goto out;
>
> +       /* This was the last registration; start preventing new events... */
> +       WRITE_ONCE(unreg_started, true);
> +       /* Remove the registration +1 from the inflight refcount. */
> +       atomic_dec(&inflight_rc);
> +       /*
> +        * Wait for inflight refcount to be zero (all inflights stopped). Since
> +        * we have a spinlock we can't sleep, so just spin. Because trace events
> +        * are "fast", and because we stop new inflights from starting at this
> +        * point with unreg_started, this should be a short spin.
> +        */
> +       while (atomic_read(&inflight_rc))
> +               barrier();
> +
>         for_each_possible_cpu(cpu) {
>                 kfree(per_cpu(memcg_path_buf, cpu));
>         }
> @@ -102,6 +143,20 @@ static inline char *get_memcg_path_buf(void)
>  {
>         int idx;
>
> +       /*
> +        * If unregistration is happening, stop. Yes, this check is racy;
> +        * that's fine. It just means _unreg() might spin waiting for an extra
> +        * event or two. Use-after-free is actually prevented by the refcount.
> +        */
> +       if (READ_ONCE(unreg_started))
> +               return NULL;
> +       /*
> +        * Take a reference, unless the registration +1 has been released
> +        * and there aren't already existing inflights (refcount is zero).
> +        */
> +       if (!atomic_inc_not_zero(&inflight_rc))
> +               return NULL;
> +
>         idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
>               MEMCG_PATH_BUF_SIZE;
>         return &this_cpu_read(memcg_path_buf)[idx];
> @@ -110,27 +165,42 @@ static inline char *get_memcg_path_buf(void)
>  static inline void put_memcg_path_buf(void)
>  {
>         this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
> +       /* We're done with this buffer; drop the reference. */
> +       atomic_dec(&inflight_rc);
>  }
>
>  /*
>   * Write the given mm_struct's memcg path to a percpu buffer, and return a
> - * pointer to it. If the path cannot be determined, NULL is returned.
> + * pointer to it. If the path cannot be determined, or no buffer was available
> + * (because the trace event is being unregistered), NULL is returned.
>   *
>   * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
>   * disabled by the caller before calling us, and re-enabled only after the
>   * caller is done with the pointer.
> + *
> + * The caller must call put_memcg_path_buf() once the buffer is no longer
> + * needed. This must be done while preemption is still disabled.
>   */
>  static const char *get_mm_memcg_path(struct mm_struct *mm)
>  {
> +       char *buf = NULL;
>         struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>
> -       if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
> -               char *buf = get_memcg_path_buf();
> +       if (memcg == NULL)
> +               goto out;
> +       if (unlikely(memcg->css.cgroup == NULL))
> +               goto out_put;
>
> -               cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
> -               return buf;
> -       }
> -       return NULL;
> +       buf = get_memcg_path_buf();
> +       if (buf == NULL)
> +               goto out_put;
> +
> +       cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
> +
> +out_put:
> +       css_put(&memcg->css);
> +out:
> +       return buf;
>  }
>
>  #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> --
> 2.29.2.454.gaff20da3a2-goog
>
