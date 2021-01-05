Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135F2EA690
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbhAEIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:24:36 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE93C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:23:56 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 75so27801533ilv.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AFVO2vMpVZ5jq5qo8aLfV1mcP+kckr+/XzUO/WHcrg=;
        b=SkSDqb1kmN0HYKhVyF6HSBrE0pdbv5FkcHfyeMGTs6MLLg3c/TUJUkbuOSl92knX/f
         U2xPij1iarMMrVKWQHMVExY0Hw4tSZLrPFY2XmdV/HgzNif2DSKUssjPUAHSyaV5iFNz
         94OkQgDSDd0zice/1TNmuUOBv9nghVI0jOaHAdQhN5PvnDEofmMqjKUGPsrOKeLpJAyk
         YkYbpLxkcWDyZc94FmvUrRXHvATuSerCMDgVOLDX9s/Te8v+d7gBDcvp3HdfPqkDIoeW
         vhw7njsbvILm3lG/o1OMJPqWZoz9HdQHXQtl9yhqTWQ/Of+RihUo6fiPU6nRh2XN7CJo
         ZJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AFVO2vMpVZ5jq5qo8aLfV1mcP+kckr+/XzUO/WHcrg=;
        b=Iss12Lb0+LQHGMn5iMGhR4+GPb7iAkgAx/Oe2/VEfQ5uH5JeIadT3SbyN3IhJE0Y73
         a1GOMI+dhSuP0PeiZPQ007tq3ueHDC8Lgj3Bjy66AyROrGa7Y+ZnpBnhBL4iGoQPz0rb
         czLr8oHYl+XbcMZ0Ev9SZfdcGyTNHTiXSVjpGGLzocoNjDCfkuqm/4+pbkAN7uQMTNZd
         fRYBE3ecGvl8fDH7UTt5igWHXUIZEsppH91xTQfb9w/0kSc4UH3qenPLdz9w2R6QsDrQ
         7SntKIg+fLMn7qdP2hXA+B/Cem9oqis/EK0orN5T0+Dfcqc/RwGJ3Sn3AS/PhtHq1EEF
         W6JA==
X-Gm-Message-State: AOAM531OLJUEg4oUFyBYCSREzttDt76wGxob+XdLIpWsh5xF1quz89eg
        fw6YUaO55jWc7HVuGUfEH2kCnU1+Dgs9H8wuo9c=
X-Google-Smtp-Source: ABdhPJwOKN7OVz4thrN7WHmcmCQJ13ZwXS9E4wM0hRNogWES/6ZtFWrSYMPQPP9NGQmxG6CfkTCjBcAr9ls2y/e2XGc=
X-Received: by 2002:a92:dcc4:: with SMTP id b4mr73989237ilr.164.1609835035596;
 Tue, 05 Jan 2021 00:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net> <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
In-Reply-To: <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 5 Jan 2021 16:23:44 +0800
Message-ID: <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 10:41 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Mon, Jan 4, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > >
> > > wq_online_cpumask is the cached result of cpu_online_mask with the
> > > going-down cpu cleared.
> >
> > You can't use cpu_active_mask ?
>
>
> When a cpu is going out:
> (cpu_active_mask is not protected by workqueue mutexs.)
>
> create_worker() for unbound pool  |  cpu offlining
> check cpu_active_mask             |
check wq_online_cpumask
>                                   |  remove bit from cpu_active_mask
>                                   |  no cpu in pool->attrs->cpumask is active
> set pool->attrs->cpumask to worker|
> and hit the warning
                                    |  remove bit from wq_online_cpumask

Even with the help of wq_online_cpumask, the patchset can't silence
the warning in __set_cpus_allowed_ptr() in this case.  It is indeed
hard to suppress the warning for unbound pools.  Maybe we need something
like this (outmost callback of CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
so that workqueue can do preparation when offlining before AP_ACTIVE):

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0042ef362511..ac2103deb20b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -20,6 +20,9 @@
  *               |                               ^
  *               v                               |
  *              AP_ACTIVE                      AP_ACTIVE
+ *               |                               ^
+ *               v                               |
+ *              ONLINE                         ONLINE
  */

 enum cpuhp_state {
@@ -194,6 +197,7 @@ enum cpuhp_state {
        CPUHP_AP_X86_HPET_ONLINE,
        CPUHP_AP_X86_KVM_CLK_ONLINE,
        CPUHP_AP_ACTIVE,
+       CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
        CPUHP_ONLINE,
 };


The other way is to modify __set_cpus_allowed_ptr() to suppress the
warning for kworkers and believe/let the workqueue handle cpumask correctly.

And the third way is to use get_online_cpus() in worker_attach_to_pool()
which might delay work items to be processed during cpuhotplug and might
be dangerous when someone call flush_work() in cpuhotplug callbacks.

Any thoughts?

Thanks,
Lai

>
>
> And when a cpu is onlining, there may be some workers which were just created
> after the workqueue hotplug callback is finished but before cpu_active_mask
> was updated. workqueue has not call back after cpu_active_mask updated and
> these workers' cpumask is not updated.
>
> For percpu workers, these problems can be handled with the help of
> POOL_DISASSOCIATED which is protected by workqueue mutexs and the
> help of sched/core.c which doesn't warn when per-cpu-kthread.
>
> For unbound workers, the way to handle it without using wq_online_cpumask
> is much more complex when a cpu is going out.
