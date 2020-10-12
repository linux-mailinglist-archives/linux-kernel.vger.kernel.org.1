Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2835428B214
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgJLKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgJLKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:16:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D47C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:16:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so13411534ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RNKSqGI3bPQWqRgZx9FOjSkPA02yTZhMdKykoyj7FA=;
        b=LjqIa0bZDg0RKgK7tWKAHgxk8JdFW89Gmby5DN70p17oqHlO2UZ9qyC+fIIPbYeaDo
         KcXYyiGO60Wb2n37Sdg4wTX9p4ufLEKaF7/aGDAxv1rDmP4QLmZx+R2KzU5HKxeu5M20
         0mD0slUS3PZ2jPAwZ6VnGNS3jXXmpEemmWqEcF+WWfKViak0kM/yhrVR+9Ag7dwJBsFa
         8qWXh8Kme3YlI90FKV5p6JqPGsJSxUFL2HMrb4CczelwrsR5dAoIuyA2PjsYFce2YjRK
         XUjKYvtY2NNqtFqPQZhH6DqUwlsaEcdma5WVmRDWEalOuaf6XdDS2MeXYvIFdyPjI4VC
         eEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RNKSqGI3bPQWqRgZx9FOjSkPA02yTZhMdKykoyj7FA=;
        b=XP5HPFSguTIwIvBtZcPdTj0hP493/+VZE2YfNdEdm83045294WQd5fZmZmSAZiyogl
         C8Uo0a0lqLiOEEJQhWBsqH2EVoeMsMLXzCiJC7JV3AczwSAZ76Oik6VEAULGqkk0LAtQ
         Vu6XQQt1ooG3pb0P+pniJ6SU35YfgLhbgoR3QoW6l4XxRI+OWrmUNb4tZmPWuaSNLYKn
         0qjRQ/DD+U1TmdtnWSImy1OzFlkCYPGtNZRWEV0vaBlTt1Kynx9qOKFA8vxKcsscwGgl
         1UC8Kr2GUMQ6pSD8PI7yXlakvF3RP5B5XFAEQEPha9DSlcp30LF2SqWJUNrv1zqsjBhr
         cwIQ==
X-Gm-Message-State: AOAM531PosMpM1yT1dC7VpHVbZzPO3hKNdLLXiPIy8X7tC5u6GWlesCy
        1AkpH2Pt/V/osJMk29norIkIK3oNs6rpUl8OptwWzA==
X-Google-Smtp-Source: ABdhPJx6ooRreht6rqqI3/+ilXoSfNDS9qlL9b87crTGC/WttuKdQOankrXRy3az4y+5/TYfe25XSpl3B3XGJ22Ubok=
X-Received: by 2002:a2e:7803:: with SMTP id t3mr814820ljc.156.1602497778191;
 Mon, 12 Oct 2020 03:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
 <jhj7dtaokxe.mognet@arm.com> <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 12 Oct 2020 12:16:06 +0200
Message-ID: <CAKfTPtCPapkwS7B5X3XQsQFx7GXa-RSzRWO1e6n5JzLT7nTvrA@mail.gmail.com>
Subject: Re: SD_LOAD_BALANCE
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gilles Muller <Gilles.Muller@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Sat, 10 Oct 2020 at 18:14, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Hello,
>
> Previously, I was wondering about why starting in Linux v5.8 my unblocking
> threads were moving to different sockets more frequently than in previous
> releases.  Now, I think that I have found the reason.
>
> The first issue is the change from runnable load average to load average
> in computing wake_affine_weight:
>
> ---
>
> commit 11f10e5420f6cecac7d4823638bff040c257aba9
> Author: Vincent Guittot <vincent.guittot@linaro.org>
> Date:   Fri Oct 18 15:26:36 2019 +0200
>
>     sched/fair: Use load instead of runnable load in wakeup path
>
>     Runnable load was originally introduced to take into account the case where
>     blocked load biases the wake up path which may end to select an overloaded
>     CPU with a large number of runnable tasks instead of an underutilized
>     CPU with a huge blocked load.
>
>     Tha wake up path now starts looking for idle CPUs before comparing
>     runnable load and it's worth aligning the wake up path with the
>     load_balance() logic.
>
> ---
>
> The unfortunate case is illustrated by the following trace (*** on the
> important lines):
>
>        trace-cmd-8006  [118]   451.444751: sched_migrate_task:   comm=containerd pid=2481 prio=120 orig_cpu=114 dest_cpu=118
>           ua.B.x-8007  [105]   451.444752: sched_switch:         ua.B.x:8007 [120] S ==> swapper/105:0 [120]
>        trace-cmd-8006  [118]   451.444769: sched_switch:         ua.B.x:8006 [120] S ==> containerd:2481 [120] ***
>       containerd-2481  [118]   451.444859: sched_switch:         containerd:2481 [120] S ==> swapper/118:0 [120] ***
>           ua.B.x-8148  [016]   451.444910: sched_switch:         ua.B.x:8148 [120] S ==> swapper/16:0 [120]
>           ua.B.x-8154  [127]   451.445186: sched_switch:         ua.B.x:8154 [120] S ==> swapper/127:0 [120]
>           ua.B.x-8145  [047]   451.445199: sched_switch:         ua.B.x:8145 [120] S ==> swapper/47:0 [120]
>           ua.B.x-8138  [147]   451.445200: sched_switch:         ua.B.x:8138 [120] S ==> swapper/147:0 [120]
>           ua.B.x-8152  [032]   451.445210: sched_switch:         ua.B.x:8152 [120] S ==> swapper/32:0 [120]
>           ua.B.x-8144  [067]   451.445215: sched_switch:         ua.B.x:8144 [120] S ==> swapper/67:0 [120]
>           ua.B.x-8137  [000]   451.445219: sched_switch:         ua.B.x:8137 [120] S ==> swapper/0:0 [120]
>           ua.B.x-8140  [075]   451.445225: sched_switch:         ua.B.x:8140 [120] S ==> swapper/75:0 [120]
>           ua.B.x-8155  [084]   451.445229: sched_switch:         ua.B.x:8155 [120] S ==> swapper/84:0 [120]
>           ua.B.x-8161  [155]   451.445232: sched_switch:         ua.B.x:8161 [120] S ==> swapper/155:0 [120]
>           ua.B.x-8156  [095]   451.445261: sched_switch:         ua.B.x:8156 [120] S ==> swapper/95:0 [120]
>           ua.B.x-8153  [134]   451.445268: sched_switch:         ua.B.x:8153 [120] S ==> swapper/134:0 [120]
>           ua.B.x-8151  [154]   451.445268: sched_switch:         ua.B.x:8151 [120] S ==> swapper/154:0 [120]
>           ua.B.x-8141  [107]   451.445273: sched_switch:         ua.B.x:8141 [120] S ==> swapper/107:0 [120]
>           ua.B.x-8146  [131]   451.445275: sched_switch:         ua.B.x:8146 [120] S ==> swapper/131:0 [120]
>           ua.B.x-8160  [035]   451.445286: sched_switch:         ua.B.x:8160 [120] S ==> swapper/35:0 [120]
>           ua.B.x-8136  [088]   451.445286: sched_switch:         ua.B.x:8136 [120] S ==> swapper/88:0 [120]
>           ua.B.x-8159  [056]   451.445290: sched_switch:         ua.B.x:8159 [120] S ==> swapper/56:0 [120]
>           ua.B.x-8147  [036]   451.445294: sched_switch:         ua.B.x:8147 [120] S ==> swapper/36:0 [120]
>           ua.B.x-8150  [150]   451.445298: sched_switch:         ua.B.x:8150 [120] S ==> swapper/150:0 [120]
>           ua.B.x-8142  [159]   451.445300: sched_switch:         ua.B.x:8142 [120] S ==> swapper/159:0 [120]
>           ua.B.x-8157  [058]   451.445309: sched_switch:         ua.B.x:8157 [120] S ==> swapper/58:0 [120]
>           ua.B.x-8149  [123]   451.445311: sched_switch:         ua.B.x:8149 [120] S ==> swapper/123:0 [120]
>           ua.B.x-8162  [156]   451.445313: sched_switch:         ua.B.x:8162 [120] S ==> swapper/156:0 [120]
>           ua.B.x-8164  [019]   451.445317: sched_switch:         ua.B.x:8164 [120] S ==> swapper/19:0 [120]
>           ua.B.x-8139  [068]   451.445319: sched_switch:         ua.B.x:8139 [120] S ==> swapper/68:0 [120]
>           ua.B.x-8143  [126]   451.445335: sched_switch:         ua.B.x:8143 [120] S ==> swapper/126:0 [120]
>           ua.B.x-8163  [062]   451.445361: sched_switch:         ua.B.x:8163 [120] S ==> swapper/62:0 [120]
>           ua.B.x-8158  [129]   451.445371: sched_switch:         ua.B.x:8158 [120] S ==> swapper/129:0 [120]
>           ua.B.x-8040  [043]   451.445413: sched_wake_idle_without_ipi: cpu=0
>           ua.B.x-8165  [098]   451.445451: sched_switch:         ua.B.x:8165 [120] S ==> swapper/98:0 [120]
>           ua.B.x-8069  [009]   451.445622: sched_waking:         comm=ua.B.x pid=8007 prio=120 target_cpu=105
>           ua.B.x-8069  [009]   451.445635: sched_wake_idle_without_ipi: cpu=105
>           ua.B.x-8069  [009]   451.445638: sched_wakeup:         ua.B.x:8007 [120] success=1 CPU:105
>           ua.B.x-8069  [009]   451.445639: sched_waking:         comm=ua.B.x pid=8006 prio=120 target_cpu=118
>           <idle>-0     [105]   451.445641: sched_switch:         swapper/105:0 [120] R ==> ua.B.x:8007 [120]
>           ua.B.x-8069  [009]   451.445645: bprint:               select_task_rq_fair: wake_affine_weight2 returning this_cpu: 614400 < 2981888
>           ua.B.x-8069  [009]   451.445650: sched_migrate_task:   comm=ua.B.x pid=8006 prio=120 orig_cpu=118 dest_cpu=129 ***
>
> Basically, core 118 has run both a thread of the NAS UA benchmark and a
> containerd, and so it seems to have a higher load average than this_cpu, ie
> 9, when it wakes up.  The commit says "The wake up path now starts looking
> for idle CPUs", but this is not always the case.  Here the target and prev

Yes, cross node use cases are not considered because it's not only
about load but also numa in such case

> are not on the same socket, and in that case cpus_share_cache(prev, target)
> fails and there is no check as to whether prev is idle.  The result is that
> an idle core is left idle and the thread is migrated to another socket,
> perhaps impacting locality.
>
> Prior to v5.8 on my machine this was a rare event, because there were not
> many of these background processes.  But in v5.8, the default governor for
> Intel machines without the HWP feature was changed from intel_pstate to
> intel_cpufreq.  The use of intel_cpufreq triggers very frequent kworkers on
> all cores, which makes it much more likely that cores that are currently
> idle, and are overall not at all overloaded, will have a higher load
> average even with the waking thread deducted, than the core managing the
> wakeup of the threads.
>
> Would it be useful to always check whether prev is idle, perhaps in
> wake_affine_idle or perhaps in select_idle_sibling?

Yes, that would make sense to add a condition in  wake_affine_idle to
return prev if this cpu is not idle (or about to become idle)

>
> Traces from various versions are available at
> https://pages.lip6.fr/Julia.Lawall/uas.pdf.  5.8 and 5.9-rc7 are toward the
> end of the file.  In these versions, all the threads systematically move
> around at synchronization points in the program.
>
> thanks,
> julia
