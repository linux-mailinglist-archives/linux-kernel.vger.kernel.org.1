Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF122F61ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbhANN01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbhANN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:26:26 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:25:46 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f11so6392811ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QvPxLUvcuz9mIwsWDogqiDxgYvt4hmJGX2gM6/Ri3Q=;
        b=FCyzNbl+gPMGGRdmqdiNFuwgDG70y2pm+vb41ZZ2TFyabcQDD8mrLe/LSGvXbflI6b
         WZQT7RcwIsvtW9qN5jmlRivFADpY+sHvdofwVCK9QIHeG2ahX+TZJvwC2pZgg0fufiO1
         rBv0+gVx+HDg+A5bQM/jLHHGf4ZHf/NyqF11NF/zAzSq/WmKTkzHr+nxavXfvxUZJfpK
         3oy1etE3fPiT5YQ3DHSLUolF3ZhbdjOdotQasDW6unvx89IAJa2ohmRZnVBaQvntuPCN
         nfaw+wS/60sWQiR9b8C+U5tIy0yk+4H60d5qnIIj6T/pYR6HjY0dxlV5TZ6exkhiaCOt
         CFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QvPxLUvcuz9mIwsWDogqiDxgYvt4hmJGX2gM6/Ri3Q=;
        b=QxZPogcVq/jz/KW3mst80QOuwV+qfiKsPmolx9rOclA9p2OKPDMh3mi/1JjhrLk3Qk
         RqRAuSlUv/w1+LrgVydDQkIH/etW/nbWxz/akFvDQXJXXjvBA523MfInuIw5VrACTfpW
         cP7FJl/Xr3tucjetL36hRVH6stltng9e5nT6eCgm//bk4XxbJzfV/T1tfO4bc6hSciK+
         WYaxe2USQzT1qZGd1s8EZYZ+6U5eJbfUlQ2tsZYn/lK+sKY1rO1lSWfnaLkv9mRzvrNP
         jcFKiyzW07teGNfrFbRpnRQNW9TCazBt5hzriPFufQb8b8j9hA8ujcz3vDeUbLd+OnP/
         AHLA==
X-Gm-Message-State: AOAM531YVWVczDlWFOecDRhUhxMgD81J4fN82WwR4JBLZu1EkGYF0gxz
        yRBLvtp6t+w7mt54ExkdKVEQ9QjpkfWxCsHJ8SvgxRP8lEglHQ==
X-Google-Smtp-Source: ABdhPJzWfQbV2Fw3tFTo6x9HlTdKQsAt9BeKSPoQDfzxHD5Cu583Tz0FksoUaftY26st29+6GHTpsFhqLTpbCENcmTI=
X-Received: by 2002:a2e:7613:: with SMTP id r19mr3324889ljc.284.1610630744380;
 Thu, 14 Jan 2021 05:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-6-mgorman@techsingularity.net> <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
 <20210114093543.GM3592@techsingularity.net>
In-Reply-To: <20210114093543.GM3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Jan 2021 14:25:32 +0100
Message-ID: <CAKfTPtAbQLYgjRTqdpDPwA+1ff2cUtNqOVbd5cGz_cHpZO=9WA@mail.gmail.com>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 10:35, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 13, 2021 at 06:03:00PM +0100, Vincent Guittot wrote:
> > > @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >         for_each_cpu_wrap(cpu, cpus, target) {
> > >                 if (!--nr)
> > >                         return -1;
> > > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > -                       break;
> > > +               if (smt) {
> >
> > If we want to stay on something similar to the previous behavior, we
> > want to check on all cores if test_idle_cores is true so nr should be
> > set to number of cores
> >
>
> I don't think we necessarily want to do that. has_idle_cores is an
> effective throttling mechanism but it's not perfect. If the full domain
> is always scanned for a core then there can be excessive scanning in

But that's what the code is currently doing. Can this change be done
in another patch so we can check the impact of each change more
easily?
This patch 5 should focus on merging select_idle_core and
select_idle_cpu so we keep (almost) the same behavior but each CPU is
checked only once.

> workloads like hackbench which tends to have has_idle_cores return false
> positives. It becomes important once average busy CPUs is over half of
> the domain for SMT2.
>
> At least with the patch if that change was made, we still would not scan
> twice going over the same runqueues so it would still be an improvement

yeah, it's for me the main goal of this patchset with the calculation
of avg_can_cost being done only when SIS_PROP is true and the remove
of SIS_AVG

any changes in the number of cpu/core to loop on is sensitive to
regression and should be done in a separate patch IMHO

> but it would be nice to avoid excessive deep scanning when there are a
> lot of busy CPUs but individual tasks are rapidly idling.
>
> However, in the event regressions are found, changing to your suggested
> behaviour would be an obvious starting point.
>
> --
> Mel Gorman
> SUSE Labs
