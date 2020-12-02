Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7C2CB2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 03:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgLBCGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 21:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgLBCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:06:17 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DFC0613D4;
        Tue,  1 Dec 2020 18:05:31 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z136so345300iof.3;
        Tue, 01 Dec 2020 18:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xn/Qw79sid0CoEVHDkLbIFMzaVFtjxbXx36teEBnLoI=;
        b=paOIrkW0zg1FoI9vN2C7U4MdtX5+gTwqaIk/ATMhY18+RhWyEayz0NPodug3sfGHRj
         VFGcGrTVy+xJg8QZGmepTK9MTJfAQ5ONxy6UeoUb8ok8hfrri5riYCh+ojU6ztfLWlS+
         aacQj8ctDT52HNdoj6qQyWfGyKZd9XDFqDaKCBnLFFgf9OPsU0OZaYv0gOwKUIxwHOvG
         VAzuE9vveHnQGa08sjXdlLSQ1GOaM3tGzLwRdpzc+6BhYct1AD5nJ4E5F2rIswCG0zn6
         NvhfMEnzmHBBQ3P/tq5czN3JpRWVYnAek8xrt5x+PLc3Ou5zkoU+cZMPrkEXIAugl5ve
         nzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xn/Qw79sid0CoEVHDkLbIFMzaVFtjxbXx36teEBnLoI=;
        b=SCPsDOLyKaNwm+Ype+lVQp+dlJunS0B4MmY1isJc3UdomVhC97hRNBKD9Bfhmngv8+
         XhaArogxOlWXZezzCzD740ApM5edl+7E0rS0RdpGN+6Vke7VpdCrUtlH/hJn5ld6Tfhh
         dzwL/KimySpEyNd32dEIOWflxoaL+h+ixKBM3suf/JTu9PHrMc711ss5xtHlDkSQfVlA
         Z4p0dDuhU4kS/iUAIsfUxMjTYCWBYnpYRYvi5UZrievJG0SGg4u8kHjnTimVFFWlBPnY
         LfVVPC/Q6Y6WS3kyxf1lxcIeGM0RaZfEPGF4QK7R1N/jGKHHETJrca6asX2QCKFHOfBR
         lvxQ==
X-Gm-Message-State: AOAM5327VlNsL61KAErG18hDM0K5SO0dME/4KBiXlThFD5mBjswN6YJn
        m475gzTW25/doR99tMTmbV/8O231OIUmH3todx0=
X-Google-Smtp-Source: ABdhPJxZ32qfJO+y9gnoFEEKoXbNcSkk4dLviSHgqRNEq3YBPypBrkgA+TFyfP8+Yk0TtSZRj7XCRUuEkSeMS5V0STU=
X-Received: by 2002:a6b:c582:: with SMTP id v124mr175469iof.13.1606874729998;
 Tue, 01 Dec 2020 18:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20201201115416.26515-1-laoar.shao@gmail.com> <20201201115416.26515-5-laoar.shao@gmail.com>
 <20201201124614.GU3306@suse.de>
In-Reply-To: <20201201124614.GU3306@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 2 Dec 2020 10:04:54 +0800
Message-ID: <CALOAHbD0g=UPFcutNn3Decn4iRSgU4sfewtSKJqUXxBs203YAw@mail.gmail.com>
Subject: Re: [PATCH 4/6] sched: make schedstats helpers independent of fair
 sched class
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, bristot@redhat.com,
        jun qian <qianjun.kernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 8:46 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Dec 01, 2020 at 07:54:14PM +0800, Yafang Shao wrote:
> > The original prototype of the schedstats helpers are
> >
> > update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >
> > The cfs_rq in these helpers is used to get the rq_clock, and the se is
> > used to get the struct sched_statistics and the struct task_struct. In
> > order to make these helpers available by all sched classes, we can pass
> > the rq, sched_statistics and task_struct directly.
> >
> > Then the new helpers are
> >
> > update_stats_wait_*(struct rq *rq, struct task_struct *p,
> >                   struct sched_statistics *stats)
> >
> > which are independent of fair sched class.
> >
> > To avoid vmlinux growing too large or introducing ovehead when
> > !schedstat_enabled(), some new helpers after schedstat_enabled() are also
> > introduced, Suggested by Mel. These helpers are in sched/stats.c,
> >
> > __update_stats_wait_*(struct rq *rq, struct task_struct *p,
> >                     struct sched_statistics *stats)
> >
> > Cc: Mel Gorman <mgorman@suse.de>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Think it's ok, it's mostly code shuffling. I'd have been happier if
> there was evidence showing a before/after comparison of the sched stats
> for something simple like "perf bench sched pipe" and a clear statement
> of no functional change as well as a comparison of the vmlinux files but
> I think it's ok so;
>

Thanks for the review, I will do the comparison as you suggested.

> Acked-by: Mel Gorman <mgorman@suse.de>
>

Thanks!

> I didn't look at the rt.c parts
>
> --
> Mel Gorman
> SUSE Labs



-- 
Thanks
Yafang
