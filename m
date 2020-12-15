Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA172DAD95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgLOM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgLOM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:57:26 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5FC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:56:45 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m12so39068811lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4MBZ1dI60iKUYe9TfjZRtvwSRBCnJWDAUyuJLUplMqM=;
        b=AlS1onk/BwAmxnUnWX4MAejqbkJOSDNpsbvJRnaezazm6u75FIVAjGUeKFwFlZAj0J
         0nFq9NHEiFRMkD+XCfdwfK2ZP+HSy/x2Drtun0RzA69St3sEsxvaeFgfULTKrwBmkC4O
         au9+iClu54o2Ne/Zlcl09sd4Cxpbtnn6bPpsy5F+6Hd1uJpMMcZQcRked/xPeExuX90V
         nunFI0QqiWqSGg7kSDsGKhw/9Zn4WpomQGS65cUXJn30ANAgvM3RahYIsawrtkWrJDqi
         8KQxAAZ/ton+o8sx49WpdudRRSnIWSiYoBGVVE/od2zif497uMAP2KjRVSZZRgJvV/ah
         vi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4MBZ1dI60iKUYe9TfjZRtvwSRBCnJWDAUyuJLUplMqM=;
        b=umn95a0SRnVwPYB3bjwi73U9V3mwn9N8z1l8NNLMp3qX+1Di8nGb7jt8hgITpJsftM
         or8WmnpaMANfLQUotr+FK01xUMMEmu7Is8UVei5pDUfOdD2zUTvYpfJ8WUypA5yEFMAm
         +vhQCu0DApvN+ayzyhCD2bKICShlBU8mJTiqCt6imig9GvBUyjrHKHhcllBLKCLd1Qn2
         PQj0nUrQuG5zv+9X0MbPr/dmZdNdB7EJFCzT+vR90Pjq23ncqYHRAJQhPKX6xI8Gjbju
         GbtSFLCp4fo0+8FdCkIsP0PcDC7Xstab/BRcd8vQKwY0l4Fkpgab08mGx6W/ojof+VPI
         6Mxg==
X-Gm-Message-State: AOAM530HLW4zxJlysgV+G/6ywL8IlKRxt+P6FoMoGam7btsSffr/C+wG
        0ith2a22q2ptPUBeGRaQlAy0onF5kyty949rATU=
X-Google-Smtp-Source: ABdhPJwk+TOzr0GvsEDUjB5jR0mCHAsvJ81r00UnMfO2JwSLDLoDiDsw61tf0GuJp1TKWzpYyi7XpmSUrox7wgCjhyw=
X-Received: by 2002:ac2:4576:: with SMTP id k22mr11977528lfm.110.1608037004087;
 Tue, 15 Dec 2020 04:56:44 -0800 (PST)
MIME-Version: 1.0
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
 <2edefcc7-ccea-5665-728e-5b86ac413629@arm.com> <CAB8ipk-z0e5XnkR__vW9+NAz_rFDpC3odLnPEthWZoHKVRSYWg@mail.gmail.com>
 <f7eb8636-2c15-58ef-d328-f879f16f498b@arm.com> <CAKfTPtBRid+d1bkd4eEXmB_zuF3OgWODD-HipuvpJk9jg6UqMg@mail.gmail.com>
In-Reply-To: <CAKfTPtBRid+d1bkd4eEXmB_zuF3OgWODD-HipuvpJk9jg6UqMg@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 15 Dec 2020 20:56:33 +0800
Message-ID: <CAB8ipk9O8E3q3cFwbKfcEnkOPXW-aT452yn1gie+yLBiDCcCrg@mail.gmail.com>
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for cfs_rq_util_change
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuewen Yan <Xuewen.Yan@unisoc.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 5:39 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 14 Dec 2020 at 19:46, Dietmar Eggemann <dietmar.eggemann@arm.com>=
 wrote:
> >
> > On 11/12/2020 13:03, Ryan Y wrote:
> > > Hi Dietmar,
> > >
> > > Yes! That's exactly what I meant.
> > >
> > >> The issue is that sugov_update_[shared\|single] -> sugov_get_util() =
->
> > >> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued val=
ue?
> > >
> > > well, because of this, when the p dequeued, _task_util_est(p) should =
be
> > > subtracted before cfs_rq_util_change().
> > > however, the original util_est_dequeue() dequeue the util_est and upd=
ate
> > > the
> > > p->se.avg.util_est together.
> > > so I separate the original util_est_dequeue() to deal with the issue.
> >
> > OK, I see.
> >
> > I ran a testcase '50% periodic task 'task0-0' (8ms/16ms)' with
> > PELT + proprietary trace events within dequeue_task_fair() call:
> >
> > task0-0-1710 [002] 218.215535: sched_pelt_se:      cpu=3D2 path=3D(null=
) comm=3Dtask0-0 pid=3D1710 load=3D596 runnable=3D597 util=3D597 update_tim=
e=3D218123022336
> > task0-0-1710 [002] 218.215536: sched_pelt_cfs:     cpu=3D2 path=3D/ loa=
d=3D597 runnable=3D597 util=3D597 update_time=3D218123022336
> > task0-0-1710 [002] 218.215538: bprint:             sugov_get_util: CPU2=
 rq->cfs.avg.util_avg=3D597 rq->cfs.avg.util_est.enqueued=3D601
> > task0-0-1710 [002] 218.215540: sched_util_est_cfs: cpu=3D2 path=3D/ enq=
ueued=3D0 ewma=3D0 util=3D597
> > task0-0-1710 [002] 218.215542: bprint:             dequeue_task_fair: C=
PU2 [task0-0 1710] rq->cfs.avg.util_avg=3D[576->597] rq->cfs.avg.util_est.e=
nqueued=3D[601->0]
> >
> > It's true that 'sugov_get_util() -> cpu_util_cfs()' can use
> > rq->cfs.avg.util_est.enqueued before _task_util_est(p) is subtracted
> > from it.
> >
> > But isn't rq->cfs.avg.util_est.enqueued (in this case 601) always close
> > to rq->cfs.avg.util_avg (597) since the task was just running?
> > The cfs_rq utilization contains a blocked (sleeping) task.
>
> There will be a difference if the task alternates long and short runs
> in which case util_avg is lower than util_est. But even in this case,
> the freq will be update at next enqueue/dequeue/tick.
> The only real case could be when cpu goes idle in shallow state (WFI)
> which is impacted by the freq/voltage. But even in this case, the
> situation should not be long
>
> That being said, I agree that the value used by schedutil is not
> correct at dequeue
>

Hi Dietmar,

as Vincent said, like the following scenario:
               running                              sleep
running        sleep
|---------------------------------------|
  |--------|

                  ^^
at the ^^ time, the util_avg is lower than util_est.
we hope that the CPU frequency would be reduced as soon as possible after
the task is dequeued. But the issue affects the sensitivity of cpu
frequency reduce.
worse, since the time, if there is no task enqueue or other scenarios where=
 the
load is updated, the cpu may always maintain a high frequency.

if keep the util_est_dequeue as it is, are there other concerns,
or this patch would affect other places of system?


> >
> > If I would run with your patch cpu_util_cfs() would chose between 597 a=
nd 0
> > whereas without it does between 597 and 601.
> >
> > Do you have a specific use case in mind? Or even test results showing a=
 benefit
> > of your patch?
> >
> > > Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:30=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > >> Hi Yan,
> > >>
> > >> On 09/12/2020 11:44, Xuewen Yan wrote:
> > >>> when a task dequeued, it will update it's util, and cfs_rq_util_cha=
nge
> > >>> would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigg=
er
> > >>> than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.en=
queued
> > >>> didn't be decreased, this would cause bigger cfs_rq_util by mistake=
,
> > >>> as a result, cfs_rq_util_change may change freq unreasonablely.
> > >>>
> > >>> separate the util_est_dequeue() into util_est_dequeue() and
> > >>> util_est_update(), and dequeue the _task_util_est(p) before update =
util.
> > >>
> > >> The issue is that sugov_update_[shared\|single] -> sugov_get_util() =
->
> > >> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued val=
ue?
> > >>
> > >> cpu_util_cfs()
> > >>
> > >>     if (sched_feat(UTIL_EST))
> > >>         util =3D max_t(util, READ_ONCE(rq->cfs.avg.util_est.enqueued=
))
> > >>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >>
> > >> dequeue_task_fair() (w/ your patch, moving (1) before (2))
> > >>
> > >>     /* (1) update cfs_rq->avg.util_est.enqueued */
> > >>     util_est_dequeue()
> > >>
> > >>     /* (2) potential p->se.avg.util_avg update */
> > >>     /* 2 for loops */
> > >>     for_each_sched_entity()
> > >>
> > >>         /* this can only lead to a freq change for a root cfs_rq */
> > >>         (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_chang=
e()
> > >>          -> cpufreq_update_util() ->...-> sugov_update_[shared\|sing=
le]
> > >>
> > >>     /* (3) potential update p->se.avg.util_est */
> > >>     util_est_update()
> > >>
> > >>
> > >> We do need (3) after (2) because of:
> > >>
> > >> util_est_update()
> > >>     ...
> > >>     ue.enqueued =3D (task_util(p) | UTIL_AVG_UNCHANGED); task_util
> > >>     ...           ^^^^^^^^^^^^^
> > >>                   p->se.avg.util_avg
> > >>
> > >>
> > >> Did I get this right?
> > >>
> > >> [...]
