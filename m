Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6012DAA63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgLOJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgLOJrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:47:15 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78814C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:46:35 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z5so19839696iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXkaXJnHrSo+VKnjcIheG2eitXkcM8HATunVim2yGd0=;
        b=uWr4S4rsbCVhDXYRu3mUPNvTrGFfGpohph3ugXEc45Fn8kD3waYe6/cIDgpJ4VTTAv
         Aa0JzAsDRpyFCx4uacIMXdd2e1ad4kbhjzw/PfqPquStA0DqVbzEN13Cv4TWUthkensN
         ahS8+2l7poxYwdEV5bxvn8YnhS+g5m7qenrR9EqaBlKjCrkVyOjOS140Y5s510G6UGUa
         AYVj0XU6aykonMTS5XZqa/FkQeDpJY2/l5DVy2tfWNA4eArEG/YboqeZYXxq+XGWzBWJ
         7ocGuTRULa3wfh08WgRgHC0rrx+DY3fdaU00l784DNDUp2UczFXEQoyb4GwIh1HWWC5w
         Dgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXkaXJnHrSo+VKnjcIheG2eitXkcM8HATunVim2yGd0=;
        b=Ad/UlaPzDNCuYxq9dx9AW0bzZPZro9vbD5/yNqqCCxj7XId86iuF6EeVbN+Qjl2I5D
         vjFM2/gQRCkhrrRMOupDqpN3JV79AAmc4UC4+Ih2mtsu+MJZzC9Khnp7O/DTyNrTK5ZO
         +ai7WanTGBa9cCjz4+kOZTnKrCOFdzCotfsD7A9O2qEwDiVvR/8bjcfnq+BK0jyTcTrm
         AiLLMDgV9EpRgJ92ZuxchcFo8eUscmQ0xqLF9cld3ZWvjH+UvH2eD6gYNvXVra3O6/pQ
         8zn9AgQEH3nzEVwKAtLFVxuDev0LCeirDr4Ejh5iFxqJFU3ceuELF0MwexIbzk+P/3W6
         nOaQ==
X-Gm-Message-State: AOAM5302e4saiVEZbjXbsYr6t5n3pqs1L2sbMlIVII4m2J+1CTRaa2kj
        mGtSJJ9WTLE7Ma+s5dpaO9M0hXUEPEk8IeMTF5gXdRt75Njb2Q==
X-Google-Smtp-Source: ABdhPJxsVPfKLfRP1C780tVweIHK1LdJ0iprRv6/NSBVCRDaSu4Zn8gwWmTSTml+CkJON/1Q8HPryVW8E5pstEATVfE=
X-Received: by 2002:a6b:441a:: with SMTP id r26mr36593344ioa.105.1608025594915;
 Tue, 15 Dec 2020 01:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20201214155457.3430-1-jiangshanlai@gmail.com> <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
 <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com>
 <20201215075044.GZ3040@hirez.programming.kicks-ass.net> <CAJhGHyA=8vbamdFKwPGFHtL4iObJ929DR+iasVhmODV-u5UNfw@mail.gmail.com>
 <20201215084914.GD3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201215084914.GD3040@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 15 Dec 2020 17:46:23 +0800
Message-ID: <CAJhGHyBhtTDWw_xZ28_+CguhVx=x7pds0dZVkUT7YqjkjUdbNQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 4:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 15, 2020 at 04:14:26PM +0800, Lai Jiangshan wrote:
> > On Tue, Dec 15, 2020 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 01:44:53PM +0800, Lai Jiangshan wrote:
> > > > I don't know how the scheduler distinguishes all these
> > > > different cases under the "new assumption".
> > >
> > > The special case is:
> > >
> > >   (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1
> > >
> > >
> >
> > So unbound per-node workers can possibly match this test. So there is code
> > needed to handle for unbound workers/pools which is done by this patchset.
>
> Curious; how could a per-node worker match this? Only if the node is a
> single CPU, or otherwise too?

We have /sys/devices/virtual/workqueue/cpumask which can be read/written
to access to wq_unbound_cpumask.

A per-node worker's cpumask is wq_unbound_cpumask&possible_cpumask_of_the_node.
Since wq_unbound_cpumask can be changed by system adim, so a per-node
worker's cpumask is possible to be single CPU.

wq_unbound_cpumask is used when a system adim wants to isolate some
CPUs from unbound workqueques.  But I think it is rare case when the
admin causes a per-node worker's cpumask to be single CPU.

Even it is a rare case, we have to handle it.

>
> > Is this the code of is_per_cpu_kthread()? I think I should have also
> > used this function in workqueue and don't break affinity for unbound
> > workers have more than 1 cpu.
>
> Yes, that function captures it. If you want to use it, feel free to move
> it to include/linux/sched.h.

I will.  "single CPU" for unbound workers/pools is the rare case
and enough to bring the code to break affinity for unbound workers.
If we optimize for the common cases (multiple CPUs for unbound workers),
the optimization seems like additional code works only in the slow
path (hotunplug).

I will try it and see if it is worth.

>
> This class of threads is 'special', since it needs to violate the
> regular hotplug rules, and migrate_disable() made it just this little
> bit more special. It basically comes down to how we need certain per-cpu
> kthreads to run on a CPU while it's brought up, before userspace is
> allowed on, and similarly they need to run on the CPU after userspace is
> no longer allowed on in order to bring it down.
>
> (IOW, they must be allowed to violate the active mask)
>
> Due to migrate_disable() we had to move the migration code from the very
> last cpu-down stage, to earlier. This in turn brought the expectation
> (which is normally met) that per-cpu kthreads will stop/park or
> otherwise make themselves scarce when the CPU goes down. We can no
> longer force migrate them.

Thanks for explaining the rationale.

>
> Workqueues are the sole exception to that, they've got some really
> 'dodgy' hotplug behaviour.
>

Indeed.  No one want to wait for workqueue when hotunplug, so we have
to do something after the fact.
