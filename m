Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8FA2FA29F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392695AbhAROMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392623AbhAROLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:11:54 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A72C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:11:12 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w3so16297496otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTfhLTeONPL73/4VsK/L5S1/wO9PGRB6hEc7qRvlGaU=;
        b=tgcy/L3H/Qw7bHHyLmey5F+KqM83VfkcQx7AsVH3k+511OrzZYbnp6uoRjbsQUgVoZ
         uYFJnhcKFFvimpHV+b5EMZ/OaiuWtVFV+/zH9IXwYphxU5/h1eRLSu1TYQnLqbsMrzaZ
         CTIKaxNLPsoEXEKUg9hFgJ/QMsQlmF7EZKp1xPIPBmQ6ogBhLtDquPS2rp4KD8nAROUW
         drgwqIX8hELlxTfE94k6es3kfiBjVSQ0t3l+9U/hOSi0b3zftPHdEqy3ZsOP2rs9BRw6
         RfxzO2KHbWFHwCvZSJGnLYP35RGmzgNAeAHnDdkrYrMfOz0B7ciTu62AIggE1rE5Zh8l
         m0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTfhLTeONPL73/4VsK/L5S1/wO9PGRB6hEc7qRvlGaU=;
        b=ZBwW4I01X/5Bfpdy6nmCwp0mulD2TFzVm/2wprEv9T5Lv1MJvFYnzlPxJYtr4AwhLW
         f1i1Sji9G1AE40Jfl9qN1s9vnMJM4YRvLLcyqp6HGSJiuvaG/AO5l8Pz4uN4nWNiwf71
         ugVj428et/dHEoTVcQoKL2QnT4H4QbF3OsD1BB4Lqs3oJuhUxR6IePQ6zaBJzX7vOmvn
         7nt0lS1lchb5iLkPNPn0vnVxIMxhMPO0XAkKOqfN19H6gOBnSBF5c0DkuWNJa9VQLVCZ
         +B4gltFNs0rc7f1XWgUUgqQQ9gn6XRl64Kka9eC796Y9bhZYtNJJKGSxH/x1ynoFBs2r
         d+lg==
X-Gm-Message-State: AOAM531RjCEms755Dh+RsERulrPnJlV1a7rYcws1gi7+frfdXbV92lgA
        ojenmPeAPhT/waFTwb+XrYgmapSP4X4RvkYjeLh9Tul34KGBIw==
X-Google-Smtp-Source: ABdhPJz69ks0tL9qgtuiPnA+eRQcufcCFOJtt2fjlCfcPtDhD/C4ZpH69TUkTWFYbHx8Hd2XWW1uFpbbDSdYFmjKIio=
X-Received: by 2002:a9d:e91:: with SMTP id 17mr17287891otj.237.1610979072263;
 Mon, 18 Jan 2021 06:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20210117123104.27589-1-benbjiang@tencent.com> <CAKfTPtCPUnhiNF0SxK-=RTaq+h1D0tK-OfRsubb38V23KFEB_w@mail.gmail.com>
In-Reply-To: <CAKfTPtCPUnhiNF0SxK-=RTaq+h1D0tK-OfRsubb38V23KFEB_w@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Mon, 18 Jan 2021 22:11:01 +0800
Message-ID: <CAPJCdBnHHk40uBtrOisp=hY=5K3OLeUwpkPmgUURVf2DvDmY_Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add protection for delta of wait time
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

Hi, Vincent

On Mon, 18 Jan 2021 at 15:56, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 17 Jan 2021 at 13:31, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > delta in update_stats_wait_end() might be negative, which would
> > make following statistics go wrong.
>
> Could you describe the use case that generates a negative delta ?
>
> rq_clock is always increasing so this should not lead to a negative
> value even if update_stats_wait_end/start are not called in the right
> order,
Yes, indeed.

> This situation could happen after a migration if we forgot to call
> update_stats_wait_start
The migration case was what I worried about, but no regular use case
comes into my mind. :)
As an extreme case, would it be a problem if we disable/re-enable
sched_schedstats during migration?

static inline void
update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
{
        u64 wait_start, prev_wait_start;

        if (!schedstat_enabled()) // disable during migration
                return; // return here, and skip updating wait_start
...
}

static inline void
update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
{
        struct task_struct *p;
        u64 delta;

        if (!schedstat_enabled())  // re-enable again
                return;

        /*
         * When the sched_schedstat changes from 0 to 1, some sched se
         * maybe already in the runqueue, the se->statistics.wait_start
         * will be 0.So it will let the delta wrong. We need to avoid this
         * scenario.
         */
        if (unlikely(!schedstat_val(se->statistics.wait_start)))
                return;
         //stale wait_start which might be bigger than rq_clock would
be used. -)
        delta = rq_clock(rq_of(cfs_rq)) -
schedstat_val(se->statistics.wait_start);
...

Thanks a lot.
Regards,
Jiang

}
>
> >
> > Add protection for delta of wait time, like what have been done in
> > update_stats_enqueue_sleeper() for deltas of sleep/block time.
> >
> > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> > ---
> >  kernel/sched/fair.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c0374c1152e0..ac950ac950bc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -917,6 +917,9 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >
> >         delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
> >
> > +       if ((s64)delta < 0)
> > +               delta = 0;
> > +
> >         if (entity_is_task(se)) {
> >                 p = task_of(se);
> >                 if (task_on_rq_migrating(p)) {
> > --
> > 2.21.0
> >
