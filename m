Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297C62DAA41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgLOJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLOJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:40:04 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E781C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:39:24 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so37575609lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+SCilci3dCIxKjH7jPO1c0vlSpfYaT9fnHHOpuAZKJQ=;
        b=aQtsOmNf4iKoiWCc0wWppim6NDu/vFyWd0+LKu81hRrq7rfhZHYttQUucbpqh7pRzo
         MEfw7oqHrUvKvJFAB1W6ZUVRHZ+pL+IdQcKeAieK0NhLai/wFTY342f2G3HtaHOsDvsz
         pB94i5T589PrW0wl9FfJ8kRB5w4XVJtjMdfwLFziVJ6VOoPqTF8WvBllBWik4KFIfBnw
         0i7vTnRaRgwQmo72ROBWE0lCFtPhVwcmCGe60LjvnCIqu9KmjRGbLefaQivIPkPUcslB
         YN52rHvRw+pKu6k94e1mkSDp+9BvbKg0wFqKDmuP2dIZipH39KXRhhH5Ja/vQdiNvckq
         58Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+SCilci3dCIxKjH7jPO1c0vlSpfYaT9fnHHOpuAZKJQ=;
        b=BVwNYTZIJDj1Pz1F61Rca4nVUHZXC5IH2uUUmwgWraUc/maOpDETKU21S4G3HV3TBk
         RIOrNH9+COt4oaNIBiKo7T+zIx3g82ZGQ+m5cENk+BHxG6vPdJLSp3ikPCO02X6bZaHB
         JZ6nn8i0FJ1UtW9fHdTuW4UwZBD2Cc6kLiCa4QkOOfAtnP94qBEg1xJ9xvIU8dQjRxYv
         vfv0ZOW2GnLEbsyh1GdcqnE5knkcT2qjtjUwNHEtY7klBQ0pFEKsMHr6x9XbOnb6fboC
         6PfN35LN8lZXMaZvcYHSsXB5JvJNxVnjl+IDnSyYeUPtlsccSWjqsiw/m9eIGr4yOIcT
         zyrw==
X-Gm-Message-State: AOAM533oCJEfmtsp9UNKaTDJp70WntMpF4VXiy5g5JjILU2F4xLom086
        255jST1YiowqjIbBWLAlSYpTKXXtFDHKPri6jG0IYg==
X-Google-Smtp-Source: ABdhPJxC+08IcqM1AHSr5IjAUFfyfiKUKwkdAAhljSwCdfkKJi91ITvjmU6IzY3qUtqsZep28oEr6emoXrEwhraA3Yk=
X-Received: by 2002:ac2:5442:: with SMTP id d2mr11106219lfn.154.1608025162659;
 Tue, 15 Dec 2020 01:39:22 -0800 (PST)
MIME-Version: 1.0
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
 <2edefcc7-ccea-5665-728e-5b86ac413629@arm.com> <CAB8ipk-z0e5XnkR__vW9+NAz_rFDpC3odLnPEthWZoHKVRSYWg@mail.gmail.com>
 <f7eb8636-2c15-58ef-d328-f879f16f498b@arm.com>
In-Reply-To: <f7eb8636-2c15-58ef-d328-f879f16f498b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Dec 2020 10:39:11 +0100
Message-ID: <CAKfTPtBRid+d1bkd4eEXmB_zuF3OgWODD-HipuvpJk9jg6UqMg@mail.gmail.com>
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for cfs_rq_util_change
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ryan Y <xuewen.yan94@gmail.com>,
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

On Mon, 14 Dec 2020 at 19:46, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 11/12/2020 13:03, Ryan Y wrote:
> > Hi Dietmar,
> >
> > Yes! That's exactly what I meant.
> >
> >> The issue is that sugov_update_[shared\|single] -> sugov_get_util() ->
> >> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued value=
?
> >
> > well, because of this, when the p dequeued, _task_util_est(p) should be
> > subtracted before cfs_rq_util_change().
> > however, the original util_est_dequeue() dequeue the util_est and updat=
e
> > the
> > p->se.avg.util_est together.
> > so I separate the original util_est_dequeue() to deal with the issue.
>
> OK, I see.
>
> I ran a testcase '50% periodic task 'task0-0' (8ms/16ms)' with
> PELT + proprietary trace events within dequeue_task_fair() call:
>
> task0-0-1710 [002] 218.215535: sched_pelt_se:      cpu=3D2 path=3D(null) =
comm=3Dtask0-0 pid=3D1710 load=3D596 runnable=3D597 util=3D597 update_time=
=3D218123022336
> task0-0-1710 [002] 218.215536: sched_pelt_cfs:     cpu=3D2 path=3D/ load=
=3D597 runnable=3D597 util=3D597 update_time=3D218123022336
> task0-0-1710 [002] 218.215538: bprint:             sugov_get_util: CPU2 r=
q->cfs.avg.util_avg=3D597 rq->cfs.avg.util_est.enqueued=3D601
> task0-0-1710 [002] 218.215540: sched_util_est_cfs: cpu=3D2 path=3D/ enque=
ued=3D0 ewma=3D0 util=3D597
> task0-0-1710 [002] 218.215542: bprint:             dequeue_task_fair: CPU=
2 [task0-0 1710] rq->cfs.avg.util_avg=3D[576->597] rq->cfs.avg.util_est.enq=
ueued=3D[601->0]
>
> It's true that 'sugov_get_util() -> cpu_util_cfs()' can use
> rq->cfs.avg.util_est.enqueued before _task_util_est(p) is subtracted
> from it.
>
> But isn't rq->cfs.avg.util_est.enqueued (in this case 601) always close
> to rq->cfs.avg.util_avg (597) since the task was just running?
> The cfs_rq utilization contains a blocked (sleeping) task.

There will be a difference if the task alternates long and short runs
in which case util_avg is lower than util_est. But even in this case,
the freq will be update at next enqueue/dequeue/tick.
The only real case could be when cpu goes idle in shallow state (WFI)
which is impacted by the freq/voltage. But even in this case, the
situation should not be long

That being said, I agree that the value used by schedutil is not
correct at dequeue

>
> If I would run with your patch cpu_util_cfs() would chose between 597 and=
 0
> whereas without it does between 597 and 601.
>
> Do you have a specific use case in mind? Or even test results showing a b=
enefit
> of your patch?
>
> > Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2020=E5=B9=B412=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:30=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> >> Hi Yan,
> >>
> >> On 09/12/2020 11:44, Xuewen Yan wrote:
> >>> when a task dequeued, it will update it's util, and cfs_rq_util_chang=
e
> >>> would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigger
> >>> than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.enqu=
eued
> >>> didn't be decreased, this would cause bigger cfs_rq_util by mistake,
> >>> as a result, cfs_rq_util_change may change freq unreasonablely.
> >>>
> >>> separate the util_est_dequeue() into util_est_dequeue() and
> >>> util_est_update(), and dequeue the _task_util_est(p) before update ut=
il.
> >>
> >> The issue is that sugov_update_[shared\|single] -> sugov_get_util() ->
> >> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued value=
?
> >>
> >> cpu_util_cfs()
> >>
> >>     if (sched_feat(UTIL_EST))
> >>         util =3D max_t(util, READ_ONCE(rq->cfs.avg.util_est.enqueued))
> >>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> dequeue_task_fair() (w/ your patch, moving (1) before (2))
> >>
> >>     /* (1) update cfs_rq->avg.util_est.enqueued */
> >>     util_est_dequeue()
> >>
> >>     /* (2) potential p->se.avg.util_avg update */
> >>     /* 2 for loops */
> >>     for_each_sched_entity()
> >>
> >>         /* this can only lead to a freq change for a root cfs_rq */
> >>         (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change(=
)
> >>          -> cpufreq_update_util() ->...-> sugov_update_[shared\|single=
]
> >>
> >>     /* (3) potential update p->se.avg.util_est */
> >>     util_est_update()
> >>
> >>
> >> We do need (3) after (2) because of:
> >>
> >> util_est_update()
> >>     ...
> >>     ue.enqueued =3D (task_util(p) | UTIL_AVG_UNCHANGED); task_util
> >>     ...           ^^^^^^^^^^^^^
> >>                   p->se.avg.util_avg
> >>
> >>
> >> Did I get this right?
> >>
> >> [...]
