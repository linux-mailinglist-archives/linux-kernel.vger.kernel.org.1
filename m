Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5012B2A9708
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgKFNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKFNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:34:09 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26101C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 05:34:09 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a25so1398043ljn.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 05:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZyB7NIHwsVHRj+ZJxRic2IdeHhMc2SsKwtA6zsAtpw=;
        b=Dir4kt+15DzVgGQ/R3jWHc2LHCx/K1Q9oMK8dhBzKRJQcY5PkTe2jMcFRVVZVP7wM+
         QdNQBtDM+D+I1bgwQDTC7LyCjRcOZ8WGeyBeRy39Sai1t64xsPE/NB1yD+JJaj6FSJZW
         0REsc9wzTyfq+QPT4FB/+Jyr2+FSDfnA5y04GVb2HYWCqaAzJVchd3vTjK17HOLXZApf
         jtl8zj+dcjzGiBqXF/Nzch/xqcuev+q8buG2qEQLfMHBw7jAoP6cCA9wQ+fO02SCJzn2
         stP8Tr1LS77t8gIBI8L6xLb62mUC/BOzUDAQVvaJ/yBH0YQ+VvJ6vUC+KxIjlumU7rVP
         HqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZyB7NIHwsVHRj+ZJxRic2IdeHhMc2SsKwtA6zsAtpw=;
        b=inHuRCNQkZ61cjR53M1Gp66c48eZKtkgUCVu4TYHQTUt4P0nRzKsHA8MDWa6fu24Qr
         P0UZibioqSe+yb3elh6/pvJFVvC3odlO0cbEpyzB49NXei8g4s/K9al+p8Xx2LwZExzH
         WLkk+/VXYhvJyZEo/ZstRC+dkIGPusvclzeum1Q40AFWX1jMKL2k8ricJewURtlVmngT
         VZ1KHocQUl/tTfR+IMmpgwnNyxDnlmzujG9GaDJA3onhjbndrRop/xorD7uahyKnlocC
         KYpWYdVH5a1hMn9MN9KkUm/VQ9qClz5bMbnomQJCH0tPJ5t/qVJWR5Bo7bGYUEqKDcIn
         F7aQ==
X-Gm-Message-State: AOAM532RkUstKXnKSa9Z/J0s0eaxgN/0eYALOWi0it2vAyJz6AMz5/sE
        w2w0gIgfAlvcxjru2V+24JwCiSZqvvAQUVmLCmYuqw==
X-Google-Smtp-Source: ABdhPJy2BKDyzv0fq10X+2FzmYFUWLG/qRZJTZRNCXQ06RhXrnoH/UZXY04RSOr2s5pUsBPe/drGvSXL++oXKJuhpno=
X-Received: by 2002:a2e:9583:: with SMTP id w3mr802014ljh.25.1604669647550;
 Fri, 06 Nov 2020 05:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20200714125941.4174-1-peter.puhov@linaro.org> <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com> <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
In-Reply-To: <20201106120303.GE3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Nov 2020 14:33:56 +0100
Message-ID: <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > While it's possible that some other factor masked the impact of the patch,
> > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > indicates that if the patch was implemented against 5.10-rc2, it would
> > likely not have been merged. I've queued the tests on the remaining
> > machines to see if something more conclusive falls out.
> >
>
> It's not as conclusive as I would like. fork_test generally benefits
> across the board but I do not put much weight in that.
>
> Otherwise, it's workload and machine-specific.
>
> schbench: (wakeup latency sensitive), all machines benefitted from the
>         revert at the low utilisation except one 2-socket haswell machine
>         which showed higher variability when the machine was fully
>         utilised.

There is a pending patch to should improve this bench:
https://lore.kernel.org/patchwork/patch/1330614/

>
> hackbench: Neutral except for the same 2-socket Haswell machine which
>         took an 8% performance penalty of 8% for smaller number of groups
>         and 4% for higher number of groups.
>
> pipetest: Mostly neutral except for the *same* machine showing an 18%
>         performance gain by reverting.
>
> kernbench: Shows small gains at low job counts across the board -- 0.84%
>         lowest gain up to 5.93% depending on the machine
>
> gitsource: low utilisation execution of the git test suite. This was
>         mostly a win for the revert. For the list of machines tested it was
>
>          14.48% gain (2 socket but SNC enabled to 4 NUMA nodes)
>         neutral      (2 socket broadwell)
>         36.37% gain  (1 socket skylake machine)
>          3.18% gain  (2 socket broadwell)
>          4.4%        (2 socket EPYC 2)
>          1.85% gain  (2 socket EPYC 1)
>
> While it was clear-cut for 5.9, it's less clear-cut for 5.10-rc2 although
> the gitsource shows some severe differences depending on the machine that
> is worth being extremely cautious about. I would still prefer a revert
> but I'm also extremely biased and I know there are other patches in the

This one from Julia can also impact

> pipeline that may change the picture. A wider battery of tests might
> paint a clearer picture but may not be worth the time investment.

hackbench and pipetest are those that i usually run and where not
facing regression it was either neutral or small gain which seems
aligned with the fact that there is no much fork/exec involved in
these bench
My machine has faced some connections issues the last couple of days
so I don't have all results; And especially the git source and
kernbench one

>
> So maybe lets just keep an eye on this one. When the scheduler pipeline
> dies down a bit (does that happen?), we should at least revisit it.
>
> --
> Mel Gorman
> SUSE Labs
