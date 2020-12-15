Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16462DA940
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgLOIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLOIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:34:24 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9DC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:33:44 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so18402525ilm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2HPSs1zu78/kYwlPXOqkQ1oICZWiiO8CF88Nrkr1gg=;
        b=dCGP78NRVXV7sS1LfgDMso9EEmHWbzYlTdyUUBEu3RVO13CV31fbF3k2mnuQIEZggy
         EeUbvEBLLxoSF5MjOauYSMOTxkMamkkd7d9uki1z/olfO7wW1KRsKEQm1/6wcnY022Jc
         8BsMN7Bcl1NizLzvRx6Aq968mRfjBrDO6zWS55FaCq87Ftu4b8YqWwn4GUbJXw3hfDiC
         EGu7nbAhqnG3IY2SFvSn4Lzo62RheBRP21jcaczsFtmUrSVYI2wwQkkq5vUxfTZ3IBdO
         UUOfsbD3nozvZrpLGMHZHO9gczb66leiNEdwSFuvi4P4PMDyOKWkx9SJ2SLrzGgCFHHn
         uyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2HPSs1zu78/kYwlPXOqkQ1oICZWiiO8CF88Nrkr1gg=;
        b=NHMdPk1EMjlz9prtK0QhAfarQfPt9z6qjsjCOXj627S6wBG9vp3jD7pMBHkE6jytRz
         Lm9+FUucjOT1KcjCZVuYxFp8IdN+K6yzLZFD92v3WaRKnd6egSk+ykkKyCOn/qPT9oAq
         NDEcCF4hh2nrb60q5O+gBqMr0cHv4zuyhxt27ft4PdlzoLc79jUbnPbv+XEqzA393g5T
         J9B/pHS6pEJq+HvnjOqUFpZqLrolJIXHFrdub/jrn4xnaPWppyeVpAJfGZa2jshfF1J9
         nQ9l98egPL9kxs0fvH/rlmCVGCFqs18Ab2qrDDfWtjqMOW4ALR+XIFmTz5tHGAa2fHha
         xyaA==
X-Gm-Message-State: AOAM5309tZvwq1cQ9oiV+TcJeuFIfljSGGrEo2pT9ZMvY46Nx0k+LD+T
        dEex94YpKpTe80nu/nsyhlmLG/fAYpzyAXC4GpE=
X-Google-Smtp-Source: ABdhPJyvw02FAtCUQ5JxfZnZ86I01bQLGZaYq7HMtSeiQlGie+XHJqj0HRDJ4jLgvEZ5+LU273cs+SUf2mQ0VpMWHaU=
X-Received: by 2002:a05:6e02:188f:: with SMTP id o15mr17817234ilu.308.1608021223886;
 Tue, 15 Dec 2020 00:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20201214155457.3430-1-jiangshanlai@gmail.com> <20201214155457.3430-3-jiangshanlai@gmail.com>
 <X9egDheiQPLdR0IS@hirez.programming.kicks-ass.net>
In-Reply-To: <X9egDheiQPLdR0IS@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 15 Dec 2020 16:33:32 +0800
Message-ID: <CAJhGHyBG-7=zpNjDOXmgLwOiE26YHJ6vSfY_ZGH0s7M4QD0bJw@mail.gmail.com>
Subject: Re: [PATCH 02/10] workqueue: use cpu_possible_mask instead of
 cpu_active_mask to break affinity
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 1:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 14, 2020 at 11:54:49PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > There might be other CPU online. The workers losing binding on its CPU
> > should have chance to work on those later onlined CPUs.
> >
> > Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/workqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index aba71ab359dd..1f5b8385c0cf 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4909,8 +4909,9 @@ static void unbind_workers(int cpu)
> >
> >               raw_spin_unlock_irq(&pool->lock);
> >
> > +             /* don't rely on the scheduler to force break affinity for us. */
> >               for_each_pool_worker(worker, pool)
> > -                     WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
> > +                     WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>
> Please explain this one.. it's not making sense. Also the Changelog
> doesn't seem remotely related to the actual change.

If the scheduler doesn't break affinity for us any more, I hope that
we can "emulate" previous behavior when the scheduler did breaks affinity
for us. The behavior is "changing the cpumask to cpu_possible_mask".

And there might be some other CPUs online later while the worker is
still running with the pending work items.  I hope the worker can also
use the later online CPUs as before.  If we use cpu_active_mask here,
we can't achieve this.   This is what the changelog said.  I don't know
which wording is better, I will combine both if this reason stands.


>
> Afaict this is actively wrong.
>
> Also, can you please not Cc me parts of a series? That's bloody
> annoying.


Sorry about it.  I was taught "once don't send the whole series to
someone" and very probably I missed the conditions about it.  I think
in this case, I should Cc you the whole series.  May I?

Thanks
Lai
