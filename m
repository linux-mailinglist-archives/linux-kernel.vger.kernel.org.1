Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910D2287B55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgJHSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:04:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F1C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 11:04:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g9so4967137pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6l1DK1e7gAIZzYCOUa+9DeHIxDGazGiF/4pcELUamXc=;
        b=cK8+ANXFk3tz3l8K+RbBq0vC7MmDU/n/U9ksam7NlERPgeqtRkRL9UCcc2mqxnZQCT
         NCq6AyXAl1Ut/Bxk52WLelFJtVbD9SPVXNToK8KcxNdCmMopH0AhOhsHoFVBu5FmAGq8
         DxpqLiX8SwZ3LuejagSLYNLvcEzK1RkrA4H/hMI21cnodnO3S1gXiNxEIDWKKie+szDD
         YVxaWPQN/llo8TE1y2FbxBl1vKZVJ9KvOsgStZD9xZbLkDiHX/FyKSUC/OSTNQcn6s5+
         jLWZRIYYDBuMcOM5BJfnUIkldky/8g/B70BFeAw6r+GcuH+ZPIZoJhSko29U+KqocyDD
         +O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6l1DK1e7gAIZzYCOUa+9DeHIxDGazGiF/4pcELUamXc=;
        b=n1iPP89eQ3zq+vv7LBhqygA/WYsZ9+629nsYOAg/1qK9raTJShGIXMHCnzaZQQOIX3
         aV/W3pd244Lr3e7VmKXPy7VRRi5RbaBprOtOvOec3akXqc9Dn0iQwHpQnO4q/9H7PbQc
         51VsjEHsZ9Ji/MYmFbgCzmDeZ+B0Z0Bdoa5UcTjoe+s1nonWaFuvfPer58m51H8tud52
         Jnzq6CxLFH47PVNDddJNC+vlVBOKVhgtgSc+WPWL7wksnrR/yXpbnOATPSZ7mqGUlyGT
         63ipIc+hZQrOXluPvE9xqKol275irdTbjkbAMXavb/0B99fOe72VifVLznytCyBmarhG
         7cdA==
X-Gm-Message-State: AOAM530dxEp4ADUT/uL8xBoE3N7Vif1CAlKye+F0iQtJRApxyF5COG3u
        nucNlTlQcVCIM2Z7/ZiMEhZcrnN0BKNO/8+StOs8iA==
X-Google-Smtp-Source: ABdhPJzmzHf4fPlIRX7zPtPyr2lguPurZk3aFDe2PCGkXR1mMJ+DUReB5Ul00NgUBULZPmZgbaHSi2QkLNv30QeJzHg=
X-Received: by 2002:a62:2bd4:0:b029:152:8c07:d72b with SMTP id
 r203-20020a622bd40000b02901528c07d72bmr8843188pfr.42.1602180277281; Thu, 08
 Oct 2020 11:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201007184403.1902111-1-axelrasmussen@google.com>
 <20201007184403.1902111-3-axelrasmussen@google.com> <CANN689F4jcm_rx3t8hwD7-F-kwJpMJRsi50ab9eh039ZzVBOQg@mail.gmail.com>
In-Reply-To: <CANN689F4jcm_rx3t8hwD7-F-kwJpMJRsi50ab9eh039ZzVBOQg@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 8 Oct 2020 11:04:00 -0700
Message-ID: <CAJHvVchQT621m3+CeAwouL7Fub5=axV+TGys8KvEOWCqCQGvXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmap_lock: add tracepoints around lock acquisition
To:     Michel Lespinasse <walken@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 12:40 AM Michel Lespinasse <walken@google.com> wrote:
>
> On Wed, Oct 7, 2020 at 11:44 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
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
> Thanks for working on this.
>
> I like that there is no overhead unless CONFIG_TRACING is set.

Actually, it's even a bit better. Even if CONFIG_TRACING is set, the
only overhead we add is a single static_key branch (much cheaper than
a normal branch). The overhead is only introduced when the tracepoints
are enabled at runtime, e.g. by writing to
/sys/kernel/trace/events/(event)/enabled.


> However, I think the __mmap_lock_traced_lock and similar functions are
> the wrong level of abstraction, especially considering that we are
> considering to switch away from using rwsem as the underlying lock
> implementation. Would you consider something along the following lines
> instead for include/linux/mmap_lock.h ?

Sure, there's no reason that can't work. It's just a tradeoff:

Breaking up these helpers the way you describe makes the locking
functions more verbose (more repeated code; overall this file would be
longer), but there are a few less lines to change when we switch from
rwsem to something else (because we'd only need to change the lock
functions vs. as-is we'd have to change a couple of lines in each of
the helpers too).

I prefer the way it is, but I don't feel that strongly about it. I'll
refactor and send a v3 that looks as you describe.

>
> #ifdef CONFIG_TRACING
>
> DECLARE_TRACEPOINT(...);
>
> void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write);
>
> static inline void mmap_lock_trace_start_locking(struct mm_struct *mm,
> bool write)
> {
>   if (tracepoint_enabled(mmap_lock_start_locking))
>     __mmap_lock_do_trace_start_locking(mm, write);
> }
>
> #else
>
> static inline void mmap_lock_trace_start_locking(struct mm_struct *mm,
> bool write) {}
>
> #endif
>
> static inline void mmap_write_lock(struct mm_struct *mm)
> {
>   mmap_lock_trace_start_locking(mm, true);
>   down_write(&mm->mmap_lock);
>   mmap_lock_trace_acquire_returned(mm, true, true);
> }
>
> I think this is more straightforward, and also the
> mmap_lock_trace_start_locking and similar functions don't depend on
> the underlying lock implementation.
>
> The changes to the other files look fine to me.
>
> --
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.
