Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43552FA4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbhARPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405966AbhARPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:33:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315AC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:32:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x20so24619577lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u07UYgoAVjMxvHxgb1YR1v1Q7hBZbcqsqw16DHX66HU=;
        b=XTBueRi92z7UjdGoyL185/1MwLAbHB2KsvPRpvVfZufS8a3Nw54vRtsFpV1R+4g7Ya
         EzIqFvX2QhSiK4iItDrugEQcpTCQPOj0A35EIMkbfCVUB3tdiXOBOp/ucPrieIJZdNUA
         VqB17gucbzhn9MAfS0MfKcBpxu/dm5FYlADwecJaws0dde2mIB2SFLEil/1FyxMc+7oH
         oWQxNGR43PXzbXYocQcomLTAsQJOpsyseUQB279q2g7f0UvHM+852iRSlAbjueyJylCk
         vZQcoWoL/pb7FMs5C4tnLeHLKm3wEAxRMuIucoxPHGzMsvFsSftzCJog/f9WAmnhnayY
         KgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u07UYgoAVjMxvHxgb1YR1v1Q7hBZbcqsqw16DHX66HU=;
        b=Fz904/+Jt75lXnHWZ5gKNXqAL0hcQq3+v89RlJMp1PHc8MiVyXVcsseOhdY6PLxajm
         0BWIu+NLqJf/Ygh7CBO2cHkH7cYwzvE6f7xOx/VwTGyvblh8+clqtVKIuomaTSVoF419
         0aVtmqLEultRnBWD/NA48231w0wKuxFB3H7io1gOGz1M+jbV7RrOAYdPPb3D3/GuAzS7
         MJmd7iuodtsAeXNG9HZFSIBDf/BwcmPkLBcqtt3V/4XEcbdnh8eDxL9okzcsVlgx6hxz
         rn8nfxwe+5f3Ettll73pPWzc1R+j1vENFhU/Z26/RMWQf1vzxlwkbUCo90nmWF1z3bXh
         9CbQ==
X-Gm-Message-State: AOAM530FhPCODzItSlF31BppAzT6S5j8nXeMbA89cjlnLCGhqNM8ahJI
        IU1ll1dFX0QBUK7Q4c+YaG7faUouIOf9901iQyhuvQ==
X-Google-Smtp-Source: ABdhPJxFmDrCKdTYpy9t5SkG6dA6FTsr7Mzc1WO+JkLaQm+PfSCMQvsrUVlOgzwppyWsD00FP+170mYz5dQVrWoPEqw=
X-Received: by 2002:a19:7718:: with SMTP id s24mr11721742lfc.277.1610983973495;
 Mon, 18 Jan 2021 07:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20210117123104.27589-1-benbjiang@tencent.com> <CAKfTPtCPUnhiNF0SxK-=RTaq+h1D0tK-OfRsubb38V23KFEB_w@mail.gmail.com>
 <CAPJCdBnHHk40uBtrOisp=hY=5K3OLeUwpkPmgUURVf2DvDmY_Q@mail.gmail.com>
In-Reply-To: <CAPJCdBnHHk40uBtrOisp=hY=5K3OLeUwpkPmgUURVf2DvDmY_Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jan 2021 16:32:41 +0100
Message-ID: <CAKfTPtDSKtavC=PtJKkY7g=VY-t=1aO-a_7NCjN=NiYei7SseA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add protection for delta of wait time
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 at 15:11, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent
>
> On Mon, 18 Jan 2021 at 15:56, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Sun, 17 Jan 2021 at 13:31, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > From: Jiang Biao <benbjiang@tencent.com>
> > >
> > > delta in update_stats_wait_end() might be negative, which would
> > > make following statistics go wrong.
> >
> > Could you describe the use case that generates a negative delta ?
> >
> > rq_clock is always increasing so this should not lead to a negative
> > value even if update_stats_wait_end/start are not called in the right
> > order,
> Yes, indeed.
>
> > This situation could happen after a migration if we forgot to call
> > update_stats_wait_start
> The migration case was what I worried about, but no regular use case
> comes into my mind. :)

IIUC, you haven't faced the problem and it's only based on studying the code.

> As an extreme case, would it be a problem if we disable/re-enable
> sched_schedstats during migration?
>
> static inline void
> update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
>         u64 wait_start, prev_wait_start;
>
>         if (!schedstat_enabled()) // disable during migration
>                 return; // return here, and skip updating wait_start
> ...
> }
>
> static inline void
> update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
>         struct task_struct *p;
>         u64 delta;
>
>         if (!schedstat_enabled())  // re-enable again
>                 return;
>
>         /*
>          * When the sched_schedstat changes from 0 to 1, some sched se
>          * maybe already in the runqueue, the se->statistics.wait_start
>          * will be 0.So it will let the delta wrong. We need to avoid this
>          * scenario.
>          */
>         if (unlikely(!schedstat_val(se->statistics.wait_start)))
>                 return;
>          //stale wait_start which might be bigger than rq_clock would
> be used. -)
>         delta = rq_clock(rq_of(cfs_rq)) -
> schedstat_val(se->statistics.wait_start);
> ...
>
> Thanks a lot.
> Regards,
> Jiang
>
> }
> >
> > >
> > > Add protection for delta of wait time, like what have been done in
> > > update_stats_enqueue_sleeper() for deltas of sleep/block time.
> > >
> > > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> > > ---
> > >  kernel/sched/fair.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index c0374c1152e0..ac950ac950bc 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -917,6 +917,9 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >
> > >         delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
> > >
> > > +       if ((s64)delta < 0)
> > > +               delta = 0;
> > > +
> > >         if (entity_is_task(se)) {
> > >                 p = task_of(se);
> > >                 if (task_on_rq_migrating(p)) {
> > > --
> > > 2.21.0
> > >
