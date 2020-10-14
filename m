Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5E28DBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgJNItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbgJNIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:49:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EDC045876
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:20:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d20so3625200iop.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yh5eV4hOumNRLJMSxFibYpvMiOE+ffsWbgYFUP6fpwc=;
        b=IZ6ICDPP+6J5OmKUUrFMB9f0+5pPtItLO6SbUgGJ8S06R0nD0AGgc9muHqhdfw6RHP
         2U9RORutbBUv47MM0JZs123HjWRMfxSCdllPBGAbB/ZYYdT1oBMTIcLKVNRVnkTzE9SY
         eP26qYuD7+uCKcJBKi15XdHn9jL7eK914J3YPSNxmKXh2YskJ0enUOsoWHtRkL0ZbtZC
         s0rQh/yLWHxf+mt/npDW0TeWeeCFEUGbBOJewCXBpSc2SV5LGUOd70Q/l/p2bftNOKHF
         53wOJ8iONmpJJktVtkFdk929PHzdoD8MuvtHi+A78hjSwMzRtO7a7cqxlKxJNucgqN5G
         VdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yh5eV4hOumNRLJMSxFibYpvMiOE+ffsWbgYFUP6fpwc=;
        b=NT6R/VYzz+dlZYYs27gFTwoETX7bpU9Z4A84S7hD9g9DCWkD1ANfSWPeVGhJdyy7WT
         vsoJp9GuXxFlsfDR5yYhYmW3909fccNY93cUS0GJZzl+RtpnPp2Uv4r9S+GY45jrPCPC
         uxdeS0000b2diAYY6j3DwhlHM9ETFQn/+6GtGs9MHzr+s8Va+B9cAiJJ6ixJbG8q7vTx
         DAkXQuwMJrj7/a82NuyyNq7h91/U4Pdn8UHlpHJ6elJlwXYE0xTz6sjASmP6RDeHGqG0
         oFpXqXBWLSvNnucKW1NaAWdxHDy1PDFScIksfw0VXrzfsUtILyK0D12+84UK8TEMTDo9
         dzzw==
X-Gm-Message-State: AOAM530tPe35CRK/CyL90TFHytjEnWRL6nTGvM6noKWPsaj6VBUXmb7X
        udy5EVejetoMRp+LwxHryjvgAgbJ8Afcd5AiZmk=
X-Google-Smtp-Source: ABdhPJyvY7U0YV3+7uIEBcresE6N4V1dn4C5D+dPgLDPrYwXvzx7ITRo1bTGhesS2/DrYXTxbXYsuBqT8kUEcCaLc1E=
X-Received: by 2002:a02:6952:: with SMTP id e79mr1967775jac.24.1602656455642;
 Tue, 13 Oct 2020 23:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201013143140.237750-1-arch0.zheng@gmail.com> <20201013154800.GV2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201013154800.GV2611@hirez.programming.kicks-ass.net>
From:   Qi Zheng <arch0.zheng@gmail.com>
Date:   Wed, 14 Oct 2020 14:20:44 +0800
Message-ID: <CA+zs-xGTnL-g=poPxeF3yLwyHD_usZw+GAP0CQmOagCdgkgkRQ@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Replace rq_of_dl_rq(dl_rq_of_se(dl_se))
 with ... ...task_rq(dl_task_of(dl_se))
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/13 =E4=B8=8B=E5=8D=8811:48, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 10:31:40PM +0800, Qi Zheng wrote:
>> The rq is already obtained in the dl_rq_of_se() function:
>> struct task_struct *p =3D dl_task_of(dl_se);
>> struct rq *rq =3D task_rq(p);
>> So there is no need to do extra conversion.
>>
>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>> ---
>> kernel/sched/deadline.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 6d93f4518734..f64e577f6aba 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -1152,7 +1152,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl=
_se)
>> static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se=
)
>> {
>> struct task_struct *p =3D dl_task_of(dl_se);
>> - struct rq *rq =3D rq_of_dl_rq(dl_rq_of_se(dl_se));
>> + struct rq *rq =3D task_rq(p);
>>
>> if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
>> dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
>> @@ -1498,7 +1498,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>> replenish_dl_entity(dl_se, pi_se);
>> } else if ((flags & ENQUEUE_RESTORE) &&
>> dl_time_before(dl_se->deadline,
>> - rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
>> + rq_clock(task_rq(dl_task_of(dl_se))))) {
>> setup_new_dl_entity(dl_se);
>> }
>
> Consider where we're going:
>
> https://lkml.kernel.org/r/20200807095051.385985-1-juri.lelli@redhat.com
>
> then a dl_entity is no longer immediately a task and the above is no
> longer true.
>

Thanks for your reply, I saw in the patch below that the dl_rq_of_se()
has been changed to the rq_of_dl_se(), so the above is no longer needed.

    [RFC PATCH v2 4/6] sched/deadline: Introduce deadline servers

In addition, when will the SCHED_DEADLINE server infrastructure is
expected to be integrated into the mainline? It looks great!

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B410=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:48=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Oct 13, 2020 at 10:31:40PM +0800, Qi Zheng wrote:
> > The rq is already obtained in the dl_rq_of_se() function:
> >       struct task_struct *p =3D dl_task_of(dl_se);
> >         struct rq *rq =3D task_rq(p);
> > So there is no need to do extra conversion.
> >
> > Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> > ---
> >  kernel/sched/deadline.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 6d93f4518734..f64e577f6aba 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1152,7 +1152,7 @@ void init_dl_task_timer(struct sched_dl_entity *d=
l_se)
> >  static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_=
se)
> >  {
> >       struct task_struct *p =3D dl_task_of(dl_se);
> > -     struct rq *rq =3D rq_of_dl_rq(dl_rq_of_se(dl_se));
> > +     struct rq *rq =3D task_rq(p);
> >
> >       if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
> >           dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
> > @@ -1498,7 +1498,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
> >               replenish_dl_entity(dl_se, pi_se);
> >       } else if ((flags & ENQUEUE_RESTORE) &&
> >                 dl_time_before(dl_se->deadline,
> > -                              rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))=
))) {
> > +                              rq_clock(task_rq(dl_task_of(dl_se))))) {
> >               setup_new_dl_entity(dl_se);
> >       }
>
> Consider where we're going:
>
>   https://lkml.kernel.org/r/20200807095051.385985-1-juri.lelli@redhat.com
>
> then a dl_entity is no longer immediately a task and the above is no
> longer true.
