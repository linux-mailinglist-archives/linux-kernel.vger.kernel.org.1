Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591362CAA51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgLAR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgLAR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:57:08 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F61C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:56:22 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id f2so1791600qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RxC4eruZSZFdoQocSF0whgMTFMUPV6msBdcd+PCemIw=;
        b=EgydIdIW4HGjUCEEThrBIWtshCR+G+ZYFU8FBUDu8GKJjWmfkFAP6G39kxI6SPg/HT
         FvPMpnFDU4OufgUEcZ2qXzMBENnRy9dtEl+GudPIsLVCBfMilwfDz/SnpqWHuzYIEF1e
         7agiGuNzCP3nKAVjE05y/CQAQ4miZLwtGFYbn4A9TiW6XA3GhpQye93g5NA5htaC1B9i
         9dtNf1erO5wHORJnR10y2m5nN2KHgqCc7d7Ev2dLgg/pzWtuOa2O+1APw9g1rNijpW2x
         ZsaQGfmfElVNtt6KhNuOzrI2kQYcXF0R+5cfM9X6odHtj+L14KkUSNcVrTNb6ZxV1icC
         cGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RxC4eruZSZFdoQocSF0whgMTFMUPV6msBdcd+PCemIw=;
        b=sS7vh3fm+U9e+NaoMXo9X27+bcRlKeLSQ4HEKMGu4rtnXxdkhesef0nCSjpVS5fdWr
         7OQroK+CteWLwuByADIm67EEyXxusXEXVKb42j96L4arbQZPhiqyxpM8vnycfgDCmk2V
         GS2nozPDs1BKpv+LV/wv65quzf/WymXMi3/qHwCLVfQgZy6p0IeV0PYmYkYLnTuChvBd
         cAHJ6wheQx3GwLg8Aywx3IHOcgau3j/SAxYkAm5u8/3Z3EMOw4TEgp8CJK6Qdz8oipGC
         PeJsj+Vm9Gp1epccMgnjjYqnuDo5fkADO2MGM2fiJPmeqW8FsKJQtOu38TPHSZI4RI6p
         5S6w==
X-Gm-Message-State: AOAM530QDhmoUdXv3ytK/LKKmqBVpPhqhCmPacOLncGtrHiDHI//PYoJ
        hEqwL90mcEtEz9iDTj49RZZzVHh2H9MR
X-Google-Smtp-Source: ABdhPJwyBIKW8A83j3TsftVk5SD90Otc7+F1pw60x9Apjp1hXP/J1maoSswpR9gPbE7xih06rh9rqnZlWooV
Sender: "gthelen via sendgmr" <gthelen@gthelen.svl.corp.google.com>
X-Received: from gthelen.svl.corp.google.com ([2620:15c:2cd:202:8edc:d4ff:fe33:9605])
 (user=gthelen job=sendgmr) by 2002:a0c:f4d0:: with SMTP id
 o16mr4378037qvm.43.1606845381350; Tue, 01 Dec 2020 09:56:21 -0800 (PST)
Date:   Tue, 01 Dec 2020 09:56:18 -0800
In-Reply-To: <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
Message-Id: <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com> <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
From:   Greg Thelen <gthelen@google.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Shakeel Butt <shakeelb@google.com>
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

Axel Rasmussen <axelrasmussen@google.com> wrote:

> On Mon, Nov 30, 2020 at 5:34 PM Shakeel Butt <shakeelb@google.com> wrote:
>>
>> On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>> >
>> > syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
>> > is that an ongoing trace event might race with the tracepoint being
>> > disabled (and therefore the _unreg() callback being called). Consider
>> > this ordering:
>> >
>> > T1: trace event fires, get_mm_memcg_path() is called
>> > T1: get_memcg_path_buf() returns a buffer pointer
>> > T2: trace_mmap_lock_unreg() is called, buffers are freed
>> > T1: cgroup_path() is called with the now-freed buffer
>>
>> Any reason to use the cgroup_path instead of the cgroup_ino? There are
>> other examples of trace points using cgroup_ino and no need to
>> allocate buffers. Also cgroup namespace might complicate the path
>> usage.
>
> Hmm, so in general I would love to use a numeric identifier instead of a string.
>
> I did some reading, and it looks like the cgroup_ino() mainly has to
> do with writeback, instead of being just a general identifier?
> https://www.kernel.org/doc/Documentation/cgroup-v2.txt
>
> There is cgroup_id() which I think is almost what I'd want, but there
> are a couple problems with it:
>
> - I don't know of a way for userspace to translate IDs -> paths, to
> make them human readable?

The id => name map can be built from user space with a tree walk.
Example:

$ find /sys/fs/cgroup/memory -type d -printf '%i %P\n'                                                                          # ~ [main] 
20387 init.scope                                                         
31 system.slice

> - Also I think the ID implementation we use for this is "dense",
> meaning if a cgroup is removed, its ID is likely to be quickly reused.
>
>>
>> >
>> > The solution in this commit is to modify trace_mmap_lock_unreg() to
>> > first stop new buffers from being handed out, and then to wait (spin)
>> > until any existing buffer references are dropped (i.e., those trace
>> > events complete).
>> >
>> > I have a simple reproducer program which spins up two pools of threads,
>> > doing the following in a tight loop:
>> >
>> >   Pool 1:
>> >   mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>> >        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
>> >   munmap()
>> >
>> >   Pool 2:
>> >   echo 1 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>> >   echo 0 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>> >
>> > This triggers the use-after-free very quickly. With this patch, I let it
>> > run for an hour without any BUGs.
>> >
>> > While fixing this, I also noticed and fixed a css ref leak. Previously
>> > we called get_mem_cgroup_from_mm(), but we never called css_put() to
>> > release that reference. get_mm_memcg_path() now does this properly.
>> >
>> > [1]: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
>> >
>> > Fixes: 0f818c4bc1f3 ("mm: mmap_lock: add tracepoints around lock acquisition")
>>
>> The original patch is in mm tree, so the SHA1 is not stabilized.
>> Usually Andrew squash the fixes into the original patches.
>
> Ah, I added this because it also shows up in linux-next, under the
> next-20201130 tag. I'll remove it in v2, squashing is fine. :)
>
>>
>> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> > ---
>> >  mm/mmap_lock.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
>> >  1 file changed, 85 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
>> > index 12af8f1b8a14..be38dc58278b 100644
>> > --- a/mm/mmap_lock.c
>> > +++ b/mm/mmap_lock.c
>> > @@ -3,6 +3,7 @@
>> >  #include <trace/events/mmap_lock.h>
>> >
>> >  #include <linux/mm.h>
>> > +#include <linux/atomic.h>
>> >  #include <linux/cgroup.h>
>> >  #include <linux/memcontrol.h>
>> >  #include <linux/mmap_lock.h>
>> > @@ -18,13 +19,28 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>> >  #ifdef CONFIG_MEMCG
>> >
>> >  /*
>> > - * Our various events all share the same buffer (because we don't want or need
>> > - * to allocate a set of buffers *per event type*), so we need to protect against
>> > - * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
>> > - * been made.
>> > + * This is unfortunately complicated... _reg() and _unreg() may be called
>> > + * in parallel, separately for each of our three event types. To save memory,
>> > + * all of the event types share the same buffers. Furthermore, trace events
>> > + * might happen in parallel with _unreg(); we need to ensure we don't free the
>> > + * buffers before all inflights have finished. Because these events happen
>> > + * "frequently", we also want to prevent new inflights from starting once the
>> > + * _unreg() process begins. And, for performance reasons, we want to avoid any
>> > + * locking in the trace event path.
>> > + *
>> > + * So:
>> > + *
>> > + * - Use a spinlock to serialize _reg() and _unreg() calls.
>> > + * - Keep track of nested _reg() calls with a lock-protected counter.
>> > + * - Define a flag indicating whether or not unregistration has begun (and
>> > + *   therefore that there should be no new buffer uses going forward).
>> > + * - Keep track of inflight buffer users with a reference count.
>> >   */
>> >  static DEFINE_SPINLOCK(reg_lock);
>> > -static int reg_refcount;
>> > +static int reg_types_rc; /* Protected by reg_lock. */
>> > +static bool unreg_started; /* Doesn't need synchronization. */
>> > +/* atomic_t instead of refcount_t, as we want ordered inc without locks. */
>> > +static atomic_t inflight_rc = ATOMIC_INIT(0);
>> >
>> >  /*
>> >   * Size of the buffer for memcg path names. Ignoring stack trace support,
>> > @@ -46,9 +62,14 @@ int trace_mmap_lock_reg(void)
>> >         unsigned long flags;
>> >         int cpu;
>> >
>> > +       /*
>> > +        * Serialize _reg() and _unreg(). Without this, e.g. _unreg() might
>> > +        * start cleaning up while _reg() is only partially completed.
>> > +        */
>> >         spin_lock_irqsave(&reg_lock, flags);
>> >
>> > -       if (reg_refcount++)
>> > +       /* If the refcount is going 0->1, proceed with allocating buffers. */
>> > +       if (reg_types_rc++)
>> >                 goto out;
>> >
>> >         for_each_possible_cpu(cpu) {
>> > @@ -62,6 +83,11 @@ int trace_mmap_lock_reg(void)
>> >                 per_cpu(memcg_path_buf_idx, cpu) = 0;
>> >         }
>> >
>> > +       /* Reset unreg_started flag, allowing new trace events. */
>> > +       WRITE_ONCE(unreg_started, false);
>> > +       /* Add the registration +1 to the inflight refcount. */
>> > +       atomic_inc(&inflight_rc);
>> > +
>> >  out:
>> >         spin_unlock_irqrestore(&reg_lock, flags);
>> >         return 0;
>> > @@ -74,7 +100,8 @@ int trace_mmap_lock_reg(void)
>> >                         break;
>> >         }
>> >
>> > -       --reg_refcount;
>> > +       /* Since we failed, undo the earlier increment. */
>> > +       --reg_types_rc;
>> >
>> >         spin_unlock_irqrestore(&reg_lock, flags);
>> >         return -ENOMEM;
>> > @@ -87,9 +114,23 @@ void trace_mmap_lock_unreg(void)
>> >
>> >         spin_lock_irqsave(&reg_lock, flags);
>> >
>> > -       if (--reg_refcount)
>> > +       /* If the refcount is going 1->0, proceed with freeing buffers. */
>> > +       if (--reg_types_rc)
>> >                 goto out;
>> >
>> > +       /* This was the last registration; start preventing new events... */
>> > +       WRITE_ONCE(unreg_started, true);
>> > +       /* Remove the registration +1 from the inflight refcount. */
>> > +       atomic_dec(&inflight_rc);
>> > +       /*
>> > +        * Wait for inflight refcount to be zero (all inflights stopped). Since
>> > +        * we have a spinlock we can't sleep, so just spin. Because trace events
>> > +        * are "fast", and because we stop new inflights from starting at this
>> > +        * point with unreg_started, this should be a short spin.
>> > +        */
>> > +       while (atomic_read(&inflight_rc))
>> > +               barrier();
>> > +
>> >         for_each_possible_cpu(cpu) {
>> >                 kfree(per_cpu(memcg_path_buf, cpu));
>> >         }
>> > @@ -102,6 +143,20 @@ static inline char *get_memcg_path_buf(void)
>> >  {
>> >         int idx;
>> >
>> > +       /*
>> > +        * If unregistration is happening, stop. Yes, this check is racy;
>> > +        * that's fine. It just means _unreg() might spin waiting for an extra
>> > +        * event or two. Use-after-free is actually prevented by the refcount.
>> > +        */
>> > +       if (READ_ONCE(unreg_started))
>> > +               return NULL;
>> > +       /*
>> > +        * Take a reference, unless the registration +1 has been released
>> > +        * and there aren't already existing inflights (refcount is zero).
>> > +        */
>> > +       if (!atomic_inc_not_zero(&inflight_rc))
>> > +               return NULL;
>> > +
>> >         idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
>> >               MEMCG_PATH_BUF_SIZE;
>> >         return &this_cpu_read(memcg_path_buf)[idx];
>> > @@ -110,27 +165,42 @@ static inline char *get_memcg_path_buf(void)
>> >  static inline void put_memcg_path_buf(void)
>> >  {
>> >         this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
>> > +       /* We're done with this buffer; drop the reference. */
>> > +       atomic_dec(&inflight_rc);
>> >  }
>> >
>> >  /*
>> >   * Write the given mm_struct's memcg path to a percpu buffer, and return a
>> > - * pointer to it. If the path cannot be determined, NULL is returned.
>> > + * pointer to it. If the path cannot be determined, or no buffer was available
>> > + * (because the trace event is being unregistered), NULL is returned.
>> >   *
>> >   * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
>> >   * disabled by the caller before calling us, and re-enabled only after the
>> >   * caller is done with the pointer.
>> > + *
>> > + * The caller must call put_memcg_path_buf() once the buffer is no longer
>> > + * needed. This must be done while preemption is still disabled.
>> >   */
>> >  static const char *get_mm_memcg_path(struct mm_struct *mm)
>> >  {
>> > +       char *buf = NULL;
>> >         struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>> >
>> > -       if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
>> > -               char *buf = get_memcg_path_buf();
>> > +       if (memcg == NULL)
>> > +               goto out;
>> > +       if (unlikely(memcg->css.cgroup == NULL))
>> > +               goto out_put;
>> >
>> > -               cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
>> > -               return buf;
>> > -       }
>> > -       return NULL;
>> > +       buf = get_memcg_path_buf();
>> > +       if (buf == NULL)
>> > +               goto out_put;
>> > +
>> > +       cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
>> > +
>> > +out_put:
>> > +       css_put(&memcg->css);
>> > +out:
>> > +       return buf;
>> >  }
>> >
>> >  #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
>> > --
>> > 2.29.2.454.gaff20da3a2-goog
>> >
