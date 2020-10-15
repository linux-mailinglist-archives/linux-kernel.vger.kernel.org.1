Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5B28ECEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgJOGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJOGHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:07:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF144C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:07:18 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l8so2832436ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbDBjzfoSjYWcdFm7/OVUlPfbPckb1RRkf5R/cahnAo=;
        b=c/REDy8Wy+AgNbzLGLeWhbXSFuiyp0skQ+WxDIeQLskE83dYzmMTZF2ezUVBE84/4N
         hG5G4m5OON7XmxIbl6jRGt/9mQ2mJXi7GtO2iCSORVNwUoU3MHWVo+QyBtTJAO7LwXC+
         Zn8Y5G8C094yR9GgvbjHL5ko12QDw0wuf7iWS9urkhVFapvgovTzwF94OeqoNnUY0iB6
         4lfUEHSXeC3+ax7YnWWI26/gRXh091UkFetTXcOHHsHo/SFtUF+gRDFFPSrIS1/1Ajfq
         p1jm3fJDDOXxsyz04zYuDE3h832ATs9jXj7SYHajcKhta0jLIaTKsdQbIyIiTrQ54J8U
         zBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbDBjzfoSjYWcdFm7/OVUlPfbPckb1RRkf5R/cahnAo=;
        b=AH+cCD3K/X9sSErnhOqzoGpKswbjC9XKiRyDLIbVpKYkUk3jpKpEmqfR9LN8dzMjWq
         Kg26ythJZazo7NQjeh2Uv6+CmPVFAV21dGaCSNeDyuIUAA42hI6EfTNsav4aOLGcfFqH
         lC6lHhHcuwYOONrRVqlKqPKZX0IU23xecsM+CyQOEsRoO3cVqwm0FO0mAZuiBrlh/9aP
         iExeZ6lCafa3w/fTZ1O+CIgmcvL/n47JcyMGTOXhEUY2yfrX4pzOcIfW6bV6Rg9IHrWt
         P/gUEawSTDmQZUgac9TCw3Eu/+T236b7rGbTcu9kpOC5OVMY/JJ+6PR/1bIYCcWjyihf
         B2kw==
X-Gm-Message-State: AOAM532uDaLk3VVPjj+vhMnLmH8k50pB1EGZEV4URIpgX4uuOjZK1UPk
        thCBK1tzUg/vD+bpxgWoAHtpJmA30dVmEQwPw1E=
X-Google-Smtp-Source: ABdhPJy9UlAIoHXd2nncLjwY3qAvV3ogTigQvb903Qwy6OPLA+FF/ndRaXdkq46BsqRDnv3F1JQ1Mje4WQcmzHsyexs=
X-Received: by 2002:a02:ccac:: with SMTP id t12mr2234843jap.109.1602742038156;
 Wed, 14 Oct 2020 23:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201009092530.223-1-qianjun.kernel@gmail.com> <20201014131910.GG2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201014131910.GG2628@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 15 Oct 2020 14:06:42 +0800
Message-ID: <CALOAHbCD+E9doVCZEvuuMdDJBbCkBwPNiUo786k19jb82q_8Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Sched/fair: Improve the accuracy of sched_stat_wait statistics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jun qian <qianjun.kernel@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 09, 2020 at 05:25:30PM +0800, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > When the sched_schedstat changes from 0 to 1, some sched se maybe
> > already in the runqueue, the se->statistics.wait_start will be 0.
> > So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> > wrong. We need to avoid this scenario.
> >
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> This SoB chain isn't valid. Did Yafang's tag need to a reviewed-by or
> something?
>

This patch improves the behavior when sched_schedstat is changed from
0 to 1, so it looks good to me.

Reviewed-by: Yafang Shao <laoar.shao@gmail.com>

> > ---
> >  kernel/sched/fair.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a68a05..6f8ca0c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -906,6 +906,15 @@ static void update_curr_fair(struct rq *rq)
> >       if (!schedstat_enabled())
> >               return;
> >
> > +     /*
> > +      * When the sched_schedstat changes from 0 to 1, some sched se
> > +      * maybe already in the runqueue, the se->statistics.wait_start
> > +      * will be 0.So it will let the delta wrong. We need to avoid this
> > +      * scenario.
> > +      */
> > +     if (unlikely(!schedstat_val(se->statistics.wait_start)))
> > +             return;
> > +
> >       delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
> >
> >       if (entity_is_task(se)) {
> > --
> > 1.8.3.1
> >



-- 
Thanks
Yafang
