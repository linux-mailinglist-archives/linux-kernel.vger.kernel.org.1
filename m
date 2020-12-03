Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D12CDB65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgLCQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgLCQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:38:57 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EAC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:38:16 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a1so1899089ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ltl78lXBp6dDmBs0fVAnPQcvErbEe3OvqJPVj/xbjGU=;
        b=WcZ349jzBAd4ARpLKEAfsqIlphpKxcnW9E0gmPYxvdz8HhlTyf6ySmzEd40J6XRAed
         BlWswIs6POszFdZ9lDw57mCQQyX8CfMaIHKjaWkOFNLpVZOoGCfI9kyC942fNIKxSBUs
         I23qXIu1TL9Rh+T5Fznypo7sl3DuvSZCerz2pNcqcCW51WUGwlPiH65DjzN5wPUCE+7m
         SDGBEdzDJSSMBCIL+/AFhL5PW5OUwMiWyS6+dQcft+dH6SCa2cilPcquznqvF2U6zy8S
         mHNE/Kkh833e1XrHpeTsXKmKIbtB/oPr3GKZ/cYkJR3Z9YDydxK6YSm2yW1Os51628fs
         2qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ltl78lXBp6dDmBs0fVAnPQcvErbEe3OvqJPVj/xbjGU=;
        b=OYDoaY4n4o+om0Kz7Xigowwvv3aiFoVBaTsYooDMl9fLkU+7v7cGbQMsnPukPRLWPA
         4GRkM3Ca5LYIKS+PqROkNCmxFlFEHgPfE6kbAYqlwXEAfXbPICQPZSZnA1yr8U5ecOYp
         L9v85xSCG1iYx02Fmcihe+dWzUDDwpE34/Lzk+pltKgVIjyn1b4XtXwThvNAm67PBCyY
         0wtI+lIhU+WbDoeA8Ng0PyyeiGv3M7foRiA2wsu/Cqluy9mbamCm+EhM/HmYfSzYwSK4
         y1jl3X+rvuj6oi1qMyxwSp2iZOX3W+sCYcHWj7IJVx42hHvGP61u9ep552wbQaZ7KFTc
         bAog==
X-Gm-Message-State: AOAM533gcnYj0C9oqeQwBAv+DZI+FydXSk3hB6kCdCcDJwEdZZ2p0YWT
        En+fJaItnpZ5vaf5U8PzxP8Fe1y6Ohue+zsJixWelg==
X-Google-Smtp-Source: ABdhPJz6xeCW3eZXb/cE5h5ryI1f+8RWgmTvi8K9X4Lh5I9xNOpUxTLJfWVEFjumvgdeWFet6gniqZGyC0IV4iF/6JM=
X-Received: by 2002:a2e:8050:: with SMTP id p16mr1589474ljg.69.1607013495295;
 Thu, 03 Dec 2020 08:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net> <20201203141124.7391-7-mgorman@techsingularity.net>
In-Reply-To: <20201203141124.7391-7-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Dec 2020 17:38:03 +0100
Message-ID: <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 at 15:11, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The target CPU is definitely not idle in both select_idle_core and
> select_idle_cpu. For select_idle_core(), the SMT is potentially
> checked unnecessarily as the core is definitely not idle if the
> target is busy. For select_idle_cpu(), the first CPU checked is
> simply a waste.

>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 68dd9cd62fbd..1d8f5c4b4936 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6077,6 +6077,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                 return -1;
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       __cpumask_clear_cpu(target, cpus);

should clear cpu_smt_mask(target) as we are sure that the core will not be idle

>
>         for_each_cpu_wrap(core, cpus, target) {
>                 bool idle = true;
> @@ -6181,6 +6182,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         time = cpu_clock(this);
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       __cpumask_clear_cpu(target, cpus);
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 schedstat_inc(this_rq()->sis_scanned);
> --
> 2.26.2
>
