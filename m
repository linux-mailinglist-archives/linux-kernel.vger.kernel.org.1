Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8162975E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbgJWRi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753619AbgJWRi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:38:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02906C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:38:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so1914329pfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DJUxnPz1qfNMYLpAt5xVlprmZzzkEHM3xpAbSqH2VY=;
        b=ABgAteEbdhDZZq55hFyGeQUSwkHVdOlVv4fM5TK99e5OtJik2dv4uTciF9UZ1JV4yF
         xnrp/yjAeqrqfIZVEXaL6Og9I0jY+yFr8s8xRYQYk7UUnFGoMbwiKd0XNcMkMKr2Lthq
         JzCNC0bNRO1UJrfuCpUsZRNiS0C17oFOYQzhvQwsbZ7oAK8BvHN2e5dtEHRD1PCjOFZ1
         3d2KaPH77QFOBymGkPye53fkMHRKu+VgwwFWClr9vSIzA2Gw2wEuOmssvcXKJoZ3gP5E
         h1t5Q7xdwrB8K2nJHH4QMBggN59MeWUBytcOVkyhqgzK1ziTQo2F3lFoTBsra1pdXFID
         qe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DJUxnPz1qfNMYLpAt5xVlprmZzzkEHM3xpAbSqH2VY=;
        b=opN6hOg0xTf3Grr8kNwauid/FJDZ566kE/I82DxlEadzKnhuNKK2cNU69vhebv/xOg
         HpwY+ppurnPA2gKsMupaHngAjr0buL/xbhXEYUblqCKHRDIfQh5mJJvbQp5pvS02BxK0
         AFudp3YwIwMnfOV78eELpXDcR7uI1rZkOPENXMk3bRIaxnW+dcDg98AjbLPgVLdhC43c
         Z5tsCAfcu8yyHaSyDaYA4WQwpE8P3lg3pt9Gb3zr2gNmohOaZ+LVArXJ30ascqkJJMz3
         5OOWuOZZgrxe1cQIPM82VU10JLFcKFRwFtGf+qgYO9F4V8bewdFjUXW3p3fCKdZ0cFhd
         AwdA==
X-Gm-Message-State: AOAM532MuyQD62UpxgLm3Ry/lk9iL8+Yt6Z4gWUuhM0jZFe6w+h5uBOU
        6GuiUYdRKYpaW8rsPM8oAvHDCOMzFVt2N1PjEVQK9g==
X-Google-Smtp-Source: ABdhPJzTAVHPon+h+Q7bqsEe8mbsZYqQUKGTojz0v5PDtYXqIlLdgBAkk97u5UkEmog6rAtficaIPgO1q4MxNWa4nzw=
X-Received: by 2002:a63:78c3:: with SMTP id t186mr3027369pgc.12.1603474737279;
 Fri, 23 Oct 2020 10:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201020184746.300555-1-axelrasmussen@google.com>
 <20201020184746.300555-2-axelrasmussen@google.com> <fa6b9d13-0ef5-4d5d-bda3-657300028e23@suse.cz>
In-Reply-To: <fa6b9d13-0ef5-4d5d-bda3-657300028e23@suse.cz>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 23 Oct 2020 10:38:20 -0700
Message-ID: <CAJHvVcjzZgsvdzciR5v_wkgf3M7aD_vNGv3TXrf5Z5K6SLprSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mmap_lock: add tracepoints around lock acquisition
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 7:00 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/20/20 8:47 PM, Axel Rasmussen wrote:
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
> > Reviewed-by: Michel Lespinasse <walken@google.com>
> > Acked-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> All seem fine to me, except I started to wonder..
>
> > +
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
>
> Is this enough? What if we fill the buffer and then an interrupt comes and the
> handler calls here again? We overwrite the buffer and potentially report a wrong
> cgroup after the execution resumes?
> If nothing worse can happen (are interrupts disabled while the ftrace code is
> copying from the buffer?), then it's probably ok?

I think you're right, get_cpu()/put_cpu() only deals with preemption,
not interrupts.

I'm somewhat sure this code can be called in interrupt context, so I
don't think we can use locks to prevent this situation. I think it
works like this: say we acquire the lock, an interrupt happens, and
then we try to acquire again on the same CPU; we can't sleep, so we're
stuck.

I think we can't kmalloc here (instead of a percpu buffer) either,
since I would guess that kmalloc may also acquire mmap_lock itself?

Is adding local_irq_save()/local_irq_restore() in addition to
get_cpu()/put_cpu() sufficient?

>
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
> > +             get_cpu();                                                     \
> > +             trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),              \
> > +                                    ##__VA_ARGS__);                         \
> > +             put_cpu();                                                     \
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
> > +     TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
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
> > +     TRACE_MMAP_LOCK_EVENT(released, mm, write);
> > +}
> > +EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> >
>
