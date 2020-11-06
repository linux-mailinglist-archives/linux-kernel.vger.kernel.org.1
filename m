Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA82A9911
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKFQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:07:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E29BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:07:13 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so2637984lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcmj1ukv7K42dhp/oVEaqtNUwjrAJVWvGdsiH5MZxzQ=;
        b=LBWs1kSgkTH7BzcDw1dW36l1s5vt8FR4tN72pUg8QJKbCkDNA/U/+7ZCyc6yUecXBf
         24eRuxkMu/ESPXvkbHhh73LJ+nswsF1YZDm9I42OVx/c9lq/PDjftC8Dp7PrQzKzx9j0
         c3D+g2oXC6bARlObQTKDAOXSkDbTD1Kbf8Y0xQ+R8slXE3q9EZis9XOp/uwk6yPq9s1f
         DMsD7YKWG3WXGVRH3RhO9gSSS0FhghdPOpUqCtLbZeDgben+Kh2RY1BPm0DeaMiBfy+P
         HL/gyLx3NVDrG9vWMp3J475mfzXK0dFZnspoHcKL8PGAix3gFYivbujsoxkFuTAHveTc
         aslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcmj1ukv7K42dhp/oVEaqtNUwjrAJVWvGdsiH5MZxzQ=;
        b=EBoBTjEgJ5tUGZTfuaHKNHWqjf6Ox/YZZlqKYCvSsI/P4Ur8P6cLHAFJthoGBpB+X9
         gpIfq4igViu22dYGLmFpBzjaU+rTcnW5mWwWWLVGI6mfwoEH1ejuCLQz1FfDf4LAXyNJ
         pUV48jBXTFKr7zfVQzTxDL70qaCImSGDpd7NZRmo2hb6y/9ywFkhGAnu5/JHtO+Wtgwk
         4JyNUwxn70CMNBqDlETRlZ3dkAVXNK98zPPMLSej5jBW6mfse/Q/v0KVE7nBB9KZNd2C
         ZCOYsOdAMjWoxnTrUyujj86E5TJ2dOvJQQwMNVmdIlU+IVeIxQq/Go2GK1OAZTJvbPsL
         DDiQ==
X-Gm-Message-State: AOAM530nw5tNeqoz4VCcXDBuDTmyxGAxa+hGEE6aT5Zzb/rt61q5bec0
        unZTEixXK+sU6MFga9HLqhGvf7WZeAV/BhbnZKmtSA==
X-Google-Smtp-Source: ABdhPJzPV+96s9Sgi3pkLF1/g9jUHJXBhTnJjRhYfsaPk2Dy6Z08ahROTttBY3Mr+FzWzNh89Q3mVzYYm4XkGJ9Xd6E=
X-Received: by 2002:ac2:5f4b:: with SMTP id 11mr1086333lfz.385.1604678831402;
 Fri, 06 Nov 2020 08:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20200714125941.4174-1-peter.puhov@linaro.org> <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com> <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net> <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net>
In-Reply-To: <20201106160010.GF3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Nov 2020 17:06:59 +0100
Message-ID: <CAKfTPtCzN934zZ5LzP0pv9iMocwjqoH17a=J5RS0OjT9GMFRMw@mail.gmail.com>
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

On Fri, 6 Nov 2020 at 17:00, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Nov 06, 2020 at 02:33:56PM +0100, Vincent Guittot wrote:
> > On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > > > While it's possible that some other factor masked the impact of the patch,
> > > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > > likely not have been merged. I've queued the tests on the remaining
> > > > machines to see if something more conclusive falls out.
> > > >
> > >
> > > It's not as conclusive as I would like. fork_test generally benefits
> > > across the board but I do not put much weight in that.
> > >
> > > Otherwise, it's workload and machine-specific.
> > >
> > > schbench: (wakeup latency sensitive), all machines benefitted from the
> > >         revert at the low utilisation except one 2-socket haswell machine
> > >         which showed higher variability when the machine was fully
> > >         utilised.
> >
> > There is a pending patch to should improve this bench:
> > https://lore.kernel.org/patchwork/patch/1330614/
> >
>
> Ok, I've slotted this one in with a bunch of other stuff I wanted to run
> over the weekend. That particular patch was on my radar anyway. It just
> got bumped up the schedule a little bit.
>
> > > hackbench: Neutral except for the same 2-socket Haswell machine which
> > >         took an 8% performance penalty of 8% for smaller number of groups
> > >         and 4% for higher number of groups.
> > >
> > > pipetest: Mostly neutral except for the *same* machine showing an 18%
> > >         performance gain by reverting.
> > >
> > > kernbench: Shows small gains at low job counts across the board -- 0.84%
> > >         lowest gain up to 5.93% depending on the machine
> > >
> > > gitsource: low utilisation execution of the git test suite. This was
> > >         mostly a win for the revert. For the list of machines tested it was
> > >
> > >          14.48% gain (2 socket but SNC enabled to 4 NUMA nodes)
> > >         neutral      (2 socket broadwell)
> > >         36.37% gain  (1 socket skylake machine)
> > >          3.18% gain  (2 socket broadwell)
> > >          4.4%        (2 socket EPYC 2)
> > >          1.85% gain  (2 socket EPYC 1)
> > >
> > > While it was clear-cut for 5.9, it's less clear-cut for 5.10-rc2 although
> > > the gitsource shows some severe differences depending on the machine that
> > > is worth being extremely cautious about. I would still prefer a revert
> > > but I'm also extremely biased and I know there are other patches in the
> >
> > This one from Julia can also impact
> >
>
> Which one? I'm guessing "[PATCH v2] sched/fair: check for idle core"

Yes, Sorry I sent my answer before adding the link

>
> --
> Mel Gorman
> SUSE Labs
