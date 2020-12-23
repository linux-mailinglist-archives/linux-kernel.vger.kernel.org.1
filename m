Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0911B2E1DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgLWPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgLWPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:02:45 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:02:04 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w17so8648575ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pas4F4s3SAK/0+tdQBDlVkn0LmanFBkKFOJypVnipFo=;
        b=LMd3Hj9d86o7xxxPau/D6tflVdl/Lt7LhZXMrdCL1rL4DBGgcpKZyB8xRrNzC7DoLx
         7IeXMwLtk4/dtaBAmC6LMW/iLNxWtjQ4rSxaUpUgIJ0JfS3g73QWKwbAOHVywR1OrhQU
         WhkVbrU57oPEqBxEzak9tgSQ8xIKawaUozfMaHBUGvCa1FbMQGAOpLoMUOvHVl4bCETs
         b0RE/J7QkxZ5q/vVbBSJz+n70ztGqbPe9bnfiCRF6FZBC87lx4dOIK8MmZ8wsbkzTI1X
         yxsUWvsIqlsx5IW8/5gGshezlqnxpAcK8Qm56q9fiFAiiln3tGsO42opOD1Uuc5+5FG4
         VTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pas4F4s3SAK/0+tdQBDlVkn0LmanFBkKFOJypVnipFo=;
        b=HsHcbDNT2Bs0cMy+hihWUK7m6MkjqO4erdnEZVR+oVzM/TbeZSdd2FKjVhUvmTfOtX
         o4UT54Z5R13ZME5hWgtdMvDoJbaxKpK2PMfM0qlsDLzLTwtLOd4HgkSyyJxxwHEbztXK
         ujCM6hGhBWNLE0GuZVc7aCvUME5UhMI2QRUrrbmlSIaMCVT/GPp0cyCthk4P/3r1fCap
         LBprVnuun+hjwQY3phNnpNqLii5lYdbgpCnIiF5l3ctgr+gSp9RJlxZyJIBnAHoXOt9k
         BGet1g3SR4fZBdBhWgxxGLIFF3FFKwIhdmbknBOqzwQ6Rh5ebNbv+RJ/zoZvK52C0d0k
         QzCw==
X-Gm-Message-State: AOAM531FNNp2rrwJoDRhZX2U9zVirl6f1evEfyIGJCUe5qB9I+5TxBAg
        d2c2/m11BOsa5LOEE6ltfeuHBHxEpo7IpQtjJ0c=
X-Google-Smtp-Source: ABdhPJxlg93jiblZJONCraxTb5YjsjKt7d2FootjTX1pok2aTBXyjpevPGOGi76qPWjYLdMrZ1zc7wbxxLoXjyuG99E=
X-Received: by 2002:a92:c26d:: with SMTP id h13mr24282243ild.52.1608735724269;
 Wed, 23 Dec 2020 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201218170919.2950-1-jiangshanlai@gmail.com> <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
In-Reply-To: <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 23 Dec 2020 23:01:53 +0800
Message-ID: <CAJhGHyDWswu4gzT0qJzR3vBC6ESm1yui+JHFHfueXan95i0NUg@mail.gmail.com>
Subject: Re: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 5:39 AM Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
>
> On Fri, Dec 18, 2020 at 8:11 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > said that scheduler will not force break affinity for us.
> >
> > But workqueue highly depends on the old behavior. Many parts of the codes
> > relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > is not enough to change it, and the commit has flaws in itself too.
> >
> > It doesn't handle for worker detachment.
> > It doesn't handle for worker attachement, mainly worker creation
> >   which is handled by Valentin Schneider's patch [1].
> > It doesn't handle for unbound workers which might be possible
> > per-cpu-kthread.
> >
> > We need to thoroughly update the way workqueue handles affinity
> > in cpu hot[un]plug, what is this patchset intends to do and
> > replace the Valentin Schneider's patch [1].  The equivalent patch
> > is patch 10.
> >
> > Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
> > I have to include this fix because later patches depends on it.
> >
> > The patchset is based on tip/master rather than workqueue tree,
> > because the patchset is a complement for 06249738a41a ("workqueue:
> > Manually break affinity on hotplug") which is only in tip/master by now.
> >
> > And TJ acked to route the series through tip.
> >
> > Changed from V1:
> >         Add TJ's acked-by for the whole patchset
> >
> >         Add more words to the comments and the changelog, mainly derived
> >         from discussion with Peter.
> >
> >         Update the comments as TJ suggested.
> >
> >         Update a line of code as Valentin suggested.
> >
> >         Add Valentin's ack for patch 10 because "Seems alright to me." and
> >         add Valentin's comments to the changelog which is integral.
> >
> > [1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
> > [V1 patcheset]: https://lore.kernel.org/lkml/20201214155457.3430-1-jiangshanlai@gmail.com/
> >
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Qian Cai <cai@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> > Cc: Tejun Heo <tj@kernel.org>
> >
> > Lai Jiangshan (10):
> >   workqueue: restore unbound_workers' cpumask correctly
> >   workqueue: use cpu_possible_mask instead of cpu_active_mask to break
> >     affinity
> >   workqueue: Manually break affinity on pool detachment
> >   workqueue: don't set the worker's cpumask when kthread_bind_mask()
> >   workqueue: introduce wq_online_cpumask
> >   workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
> >   workqueue: Manually break affinity on hotplug for unbound pool
> >   workqueue: reorganize workqueue_online_cpu()
> >   workqueue: reorganize workqueue_offline_cpu() unbind_workers()
> >   workqueue: Fix affinity of kworkers when attaching into pool
> >
> >  kernel/workqueue.c | 214 ++++++++++++++++++++++++++++-----------------
> >  1 file changed, 132 insertions(+), 82 deletions(-)
> >
> > --
> > 2.19.1.6.gb485710b
>
> Hi,
> I tested this patchset on today's tip.git's master branch
> (981316394e35 ("Merge branch 'locking/urgent'")).
>
> Every time the kernel boots with 32 CPUs (I'm running the Linux VM on
> Hyper-V), I get the below warning.
> (BTW, with 8 or 16 CPUs, I don't see the warning).
> By printing the cpumasks with "%*pbl", I know the warning happens because:
> new_mask = 16-31
> cpu_online_mask= 0-16
> cpu_active_mask= 0-15
> p->nr_cpus_allowed=16
>
> 2374         if (p->flags & PF_KTHREAD) {
> 2375                 /*
> 2376                  * For kernel threads that do indeed end up on online &&
> 2377                  * !active we want to ensure they are strict
> per-CPU threads.
> 2378                  */
> 2379                 WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
> 2380                         !cpumask_intersects(new_mask, cpu_active_mask) &&
> 2381                         p->nr_cpus_allowed != 1);
> 2382         }
> 2383
>

Hello, Dexuan

Could you omit patch4 of the patchset and test it again, please?
("workqueue: don't set the worker's cpumask when kthread_bind_mask()")

kthread_bind_mask() set the worker task to the pool's cpumask without
any check. And set_cpus_allowed_ptr() finds that the task's cpumask
is unchanged (already set by kthread_bind_mask()) and skips all the checks.

And I found that numa=fake=2U seems broken on cpumask_of_node() in my box.

Thanks,
Lai
