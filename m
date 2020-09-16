Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36F26BD89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIPGyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:54:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C94C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:54:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so5739422lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QEey1hzy1bqX/OHJeS+2uzdMX9/rDhV5te+bMXMBMc=;
        b=sodhEh82Xf828BKu+sPED3WvhhHn2O4JICvcYCOAO2cOdyYEfrzehRZ1dKWsDwnNf8
         4S3JKT8GXNRYdHOQUNQ033SU7nohBIQHQwdvlY1/kF/dL2eTrUHzm5dBbWG1VcLrErBr
         XlV35oa9WlRMZoWMRx+7DETxdkFCljoyiluLb0XppgpLD91wWgo+nnIgo3RkbRi6CtP/
         cB8UcZxSN1azvs7qSQSrqEa9ae+xxq4w/eQwmpBDs0JBwYUMQs7OPzA3NObcTtVJfI5l
         JUJTTJ/Cq8Ttw38CYwVfAR7sQ9ZE4g7goIwQjWWoq4TLLnK9OE11359rVef2DOLlgn9w
         Y17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QEey1hzy1bqX/OHJeS+2uzdMX9/rDhV5te+bMXMBMc=;
        b=blvqe15Pp2f1daDpkwRvQaHnbZA7r6sfvhb0QRL+/EXKvzeDoEOkdNTAA1b9qvAJbF
         fg1+COTe+zXNoTerEcuzv9afpYUSQA/76LAp0i6ZIqUpo4OKGnMzUm79mB6iUQO1pakQ
         5brAriXKeMV2mF6cYNuVkdcvQucxOOmXpPS2FTTzulqU1l7ZFqTp+6FO2Ep8uD1JCcis
         bTyKZUbaU89QmgBKK8gR7fCIDBh6JeL7Nz2h9qbJdpkZIwmfXteh313ttnp65GqegQBP
         QEFxp30NRx+h34dSIIKMgUZjpap1GFWFRJrKm/f3Dv7KEdBXKyGN7a+jCWoliBdE1xTb
         WpKA==
X-Gm-Message-State: AOAM533NtUXuharqPcpANBGcJNE64GIBpEH1hHWWFMnvqDI2LpUGkdCQ
        bxPqZvj3gGbr3bA7RVQ4BWxwnSo8XmLJy2dd5IuZjg==
X-Google-Smtp-Source: ABdhPJyd39V2B1MuDUjlhP4vVvrE0KNJz/hEOfXAV9wJUT7eubq5haK07lWMitXXCFlv1LM9BCJrZmsStV+Dcva8Brw=
X-Received: by 2002:a19:4a57:: with SMTP id x84mr8104829lfa.258.1600239291658;
 Tue, 15 Sep 2020 23:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-4-vincent.guittot@linaro.org> <jhjh7ry6eup.mognet@arm.com>
In-Reply-To: <jhjh7ry6eup.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Sep 2020 08:54:40 +0200
Message-ID: <CAKfTPtA5PHN=9ykqHd5MYJvTxdR_pdtZOO=gjsJ7AWfLnLzMag@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/fair: minimize concurrent LBs between domain level
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 21:04, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 14/09/20 11:03, Vincent Guittot wrote:
> > sched domains tend to trigger simultaneously the load balance loop but
> > the larger domains often need more time to collect statistics. This
> > slowness makes the larger domain trying to detach tasks from a rq whereas
> > tasks already migrated somewhere else at a sub-domain level. This is not
> > a real problem for idle LB because the period of smaller domains will
> > increase with its CPUs being busy and this will let time for higher ones
> > to pulled tasks. But this becomes a problem when all CPUs are already busy
> > because all domains stay synced when they trigger their LB.
> >
> > A simple way to minimize simultaneous LB of all domains is to decrement the
> > the busy interval by 1 jiffies. Because of the busy_factor, the interval of
> > larger domain will not be a multiple of smaller ones anymore.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 765be8273292..7d7eefd8e2d4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9780,6 +9780,9 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
> >
> >       /* scale ms to jiffies */
> >       interval = msecs_to_jiffies(interval);
>
> A comment here would be nice, I think. What about:
>
> /*
>  * Reduce likelihood of (busy) balancing at higher domains racing with
>  * balancing at lower domains by preventing their balancing periods from being
>  * multiples of each other.
>  */

Yes a comment would be nice. Will add it

Thanks
>
> > +     if (cpu_busy)
> > +             interval -= 1;
> > +
> >       interval = clamp(interval, 1UL, max_load_balance_interval);
> >
> >       return interval;
