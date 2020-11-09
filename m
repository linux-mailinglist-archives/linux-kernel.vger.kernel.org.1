Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483912AC039
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgKIPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKIPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:49:21 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 07:49:20 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so13017417lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klq6Q68jdvp7j/9q9ZW+6VMrDTX3CW4pCIIJf0sl9GQ=;
        b=XcIS5YTF30Eorn4Dftbl8kpSmUIcv4tJ2A/FvXDUWtuu66oe4GZU4SmuJaMfLJ6SPw
         4AS2MKCkZEaMhp/v9xqTHYqLgsqF3xHNufQQSZvpQnwGAcke/u7gMIAo6PzLFubODrvo
         kfiOUbpzwDHhtNtiT7W9rKTUKXi9sWFUoRGSUjdtM1n6TwOe5dcNKNQ1s4RsYz4sTgTX
         8LrlsPOiWCQduQEfs8gK95pDu3EmlktOk0p2fj5Vv8K6GoHuq7mMqqBi6zoz5xzFZiiQ
         1CnpjrxCd0GkIFC0CUqhT7I9O25nCHoZBYPeRlLrSK8uMLMXKKAVyGwZHO9IZq5D/K+z
         GvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klq6Q68jdvp7j/9q9ZW+6VMrDTX3CW4pCIIJf0sl9GQ=;
        b=fFjjaJErzsK7Nh2DjOkvyABE+wqDiSA4eViKHtxTu5Aum1dQeo2eXckO15dRHFnEcI
         xSFNChyqA14y8p9x3cx6BGxoc6/9J/y5U5DQdh4l3nSU+8/FAME/iJCwTuvNSkW3uLRP
         mwl+d0mhmNaL2qnByDOkufo0WB6M3kDj+5C8HsILdPyxbgLyGLTvuLV5NgVVbd2kS3oI
         KkrGAcXkUgw9Duu9YB0H/0qcMYtXrccETjJGplaWKFsEHFgYzAYrEdcMlpOalqr2mygb
         AHb4s5QwE9Jyww2c91U9Izfyrsr/NwB8cBlK8C7MdVYVBnIiQ5aSwLCI5LiTRAgmugzN
         TY/g==
X-Gm-Message-State: AOAM533axnhvnoW07pA1WhNSH9fF7xufQHgsrCK1ymizg7qIEsuvGby3
        2KbIJaidAm+Re6HjCd7JGlo8eZG4J7SHzl90SqHQNQ==
X-Google-Smtp-Source: ABdhPJwhROlrP+0rBPgDIgQrMOh8CBB6dbmTOBIRUv710tcoLjSe59a/I2bia+zugeWjdqzBTvCT0xeFqN6swqwTTso=
X-Received: by 2002:a19:c191:: with SMTP id r139mr467712lff.258.1604936959185;
 Mon, 09 Nov 2020 07:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20200714125941.4174-1-peter.puhov@linaro.org> <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com> <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net> <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net> <20201109152411.GA610888@lorien.usersys.redhat.com>
 <20201109153815.GH3371@techsingularity.net>
In-Reply-To: <20201109153815.GH3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 9 Nov 2020 16:49:07 +0100
Message-ID: <CAKfTPtAGXhmmuEV=fF1E1JiOG40RBOXcX35oTTbUXe+1nDRSOA@mail.gmail.com>
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

On Mon, 9 Nov 2020 at 16:38, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Nov 09, 2020 at 10:24:11AM -0500, Phil Auld wrote:
> > Hi,
> >
> > On Fri, Nov 06, 2020 at 04:00:10PM +0000 Mel Gorman wrote:
> > > On Fri, Nov 06, 2020 at 02:33:56PM +0100, Vincent Guittot wrote:
> > > > On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > > >
> > > > > On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > > > > > While it's possible that some other factor masked the impact of the patch,
> > > > > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > > > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > > > > likely not have been merged. I've queued the tests on the remaining
> > > > > > machines to see if something more conclusive falls out.
> > > > > >
> > > > >
> > > > > It's not as conclusive as I would like. fork_test generally benefits
> > > > > across the board but I do not put much weight in that.
> > > > >
> > > > > Otherwise, it's workload and machine-specific.
> > > > >
> > > > > schbench: (wakeup latency sensitive), all machines benefitted from the
> > > > >         revert at the low utilisation except one 2-socket haswell machine
> > > > >         which showed higher variability when the machine was fully
> > > > >         utilised.
> > > >
> > > > There is a pending patch to should improve this bench:
> > > > https://lore.kernel.org/patchwork/patch/1330614/
> > > >
> > >
> > > Ok, I've slotted this one in with a bunch of other stuff I wanted to run
> > > over the weekend. That particular patch was on my radar anyway. It just
> > > got bumped up the schedule a little bit.
> > >
> >
> >
> > We've run some of our perf tests against various kernels in this thread.
> > By default RHEL configs run with the performance governor.
> >
>
> This aspect is somewhat critical because the patches affect CPU
> selection. If a mostly idle CPU is used due to spreading load wider,
> it can take longer to ramp up to the highest frequency. It can be a
> dominating factor and may account for some of the differences.

I agree but that also highlights that the problem comes from frequency
selection more than task placement. In such a case, instead of trying
to bias task placement to compensate for wrong freq selection, we
should look at the freq selection itself. Not sure if it's the case
but it's worth identifying if perf regression comes from task
placement and data locality or from freq selection

>
> Generally my tests are not based on the performance governor because a)
> it's not a universal win and b) the powersave/ondemand govenors should
> be able to function reasonably well. For short-lived workloads it may
> not matter but ultimately schedutil should be good enough that it can

Yeah, schedutil should be able to manage this. But there is another
place which impacts benchmark which are based on a lot of fork/exec :
the initial value of task's PELT signal. Current implementation tries
to accommodate both perf and embedded system but might fail to satisfy
any of them at the end.

> keep track of task utilisation after migrations and select appropriate
> frequencies based on the tasks historical behaviour.
>
> --
> Mel Gorman
> SUSE Labs
