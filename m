Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4262FA59D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406287AbhARQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406420AbhARQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:06:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1813C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:05:51 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id p5so18139841oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYV6v28PmbLgIKD3dOyIEV8BYNhkb29qTPJqNvBC4G0=;
        b=f9jaiCBSfMJKmnGKpqI597WW8A97ptieAH0VHgP5oRMfCKMawFDUUCERdK99KkeoTU
         ntyT88ojQn0/AMsi+Ye3qur+Bz7FFg728JyOkiuVcQnwi+PaNm/iqYitqPPeuVhW5xED
         dEwPczSHiBgw2YFb7voPk9oSHWB2kTes9niMJFqtADS+8VSJnMRf0yKjp46NYBSePlf0
         Uae2ICsqxpe42/D33TAJaJJZFekbBQP2OwM/zoKTHl9cLeIUWV4y9EvaoFH229MfRVj1
         yn4WSPbZNhcmzNMMctCqaPUmTx4kkJ7YT4pXhGuAwes+Y4BbQlmL0LxpmRNiZKqklGPK
         95qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYV6v28PmbLgIKD3dOyIEV8BYNhkb29qTPJqNvBC4G0=;
        b=db7sgw8+3CIgtJUz95sPbKi+sZBQ+zWUGXgwwtE7mLr0xHjyO1J+gKDJ7U+FGWex9K
         51wpgVTHVNmZsKZkJ2Alv7BTZYaY5uGWP1aNHAmz6jOmum1n80J2Uz8Bf1uLB9juZ99z
         ptMalmjrLUeVX0heysXr2yHac/DCu8o40xy+e0Le009Id/bk1FzI3kz+tNxXzRk6pRgk
         3P0Ovd+JeTvBTdjJFJYis2lrcot/HNknOGinv8DoNRH8YdLap5RvVVnutfddW98Ird+w
         FyVP34z1aOO58lvsoWjIE05+YntthTeBUFpYDtK3sCxK/WBwDGbV58hh1rIwu3eNtgwk
         A1Jw==
X-Gm-Message-State: AOAM532xYu5n6/dC/npYXUyQdRS0VN9tXhzXq6oXoGwPTX2Y5OEm2HoW
        kM8nRa8Pe4u0yk4vKHD06CuaWufznpuYlrHM7gQ=
X-Google-Smtp-Source: ABdhPJzX8qvIYmuMWprM6f1xsibnLbeZdX6sAA0wHWRo2AhVGb5fXWaoGBx3iqMcjAqCUH2p5NDb4q3tvzVJWAv/+JM=
X-Received: by 2002:a05:6808:651:: with SMTP id z17mr39609oih.150.1610985951282;
 Mon, 18 Jan 2021 08:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20210117123104.27589-1-benbjiang@tencent.com> <CAKfTPtCPUnhiNF0SxK-=RTaq+h1D0tK-OfRsubb38V23KFEB_w@mail.gmail.com>
 <CAPJCdBnHHk40uBtrOisp=hY=5K3OLeUwpkPmgUURVf2DvDmY_Q@mail.gmail.com> <CAKfTPtDSKtavC=PtJKkY7g=VY-t=1aO-a_7NCjN=NiYei7SseA@mail.gmail.com>
In-Reply-To: <CAKfTPtDSKtavC=PtJKkY7g=VY-t=1aO-a_7NCjN=NiYei7SseA@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 19 Jan 2021 00:05:40 +0800
Message-ID: <CAPJCdBmRrOcx6pSGoGWqrq5p-vzBhrYccOCPAkjue9S8YD-zNg@mail.gmail.com>
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

On Mon, 18 Jan 2021 at 23:32, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 18 Jan 2021 at 15:11, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Vincent
> >
> > On Mon, 18 Jan 2021 at 15:56, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Sun, 17 Jan 2021 at 13:31, Jiang Biao <benbjiang@gmail.com> wrote:
> > > >
> > > > From: Jiang Biao <benbjiang@tencent.com>
> > > >
> > > > delta in update_stats_wait_end() might be negative, which would
> > > > make following statistics go wrong.
> > >
> > > Could you describe the use case that generates a negative delta ?
> > >
> > > rq_clock is always increasing so this should not lead to a negative
> > > value even if update_stats_wait_end/start are not called in the right
> > > order,
> > Yes, indeed.
> >
> > > This situation could happen after a migration if we forgot to call
> > > update_stats_wait_start
> > The migration case was what I worried about, but no regular use case
> > comes into my mind. :)
>
> IIUC, you haven't faced the problem and it's only based on studying the code.
Not yet. :).  Just found there are protections for
sleep_time/block_time, but no protection
for wait_time.

Think more later, the sleep_time/block_time do need to be protected
for the migration case,
because update_stats_enqueue_sleeper could be called right after
migration with src cpu's
sleep_start/block_start. But wait_time is not the case.

The following case might be too extreme to happen. :)

Thanks a lot for your patience.

Regards,
Jiang

>
> > As an extreme case, would it be a problem if we disable/re-enable
> > sched_schedstats during migration?
> >
> > static inline void
> > update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > {
> >         u64 wait_start, prev_wait_start;
> >
> >         if (!schedstat_enabled()) // disable during migration
> >                 return; // return here, and skip updating wait_start
> > ...
> > }
> >
> > static inline void
> > update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > {
> >         struct task_struct *p;
> >         u64 delta;
> >
> >         if (!schedstat_enabled())  // re-enable again
> >                 return;
> >
> >         /*
> >          * When the sched_schedstat changes from 0 to 1, some sched se
> >          * maybe already in the runqueue, the se->statistics.wait_start
> >          * will be 0.So it will let the delta wrong. We need to avoid this
> >          * scenario.
> >          */
> >         if (unlikely(!schedstat_val(se->statistics.wait_start)))
> >                 return;
> >          //stale wait_start which might be bigger than rq_clock would
> > be used. -)
> >         delta = rq_clock(rq_of(cfs_rq)) -
> > schedstat_val(se->statistics.wait_start);
> > ...
> >
> > Thanks a lot.
> > Regards,
> > Jiang
