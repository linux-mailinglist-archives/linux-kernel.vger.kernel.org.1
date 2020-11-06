Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1262A9A55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKFRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:02:34 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:42762 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:02:32 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 1FF2ACAAA1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 17:02:30 +0000 (GMT)
Received: (qmail 10694 invoked from network); 6 Nov 2020 17:02:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Nov 2020 17:02:29 -0000
Date:   Fri, 6 Nov 2020 17:02:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20201106170227.GG3371@techsingularity.net>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
 <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net>
 <CAKfTPtCzN934zZ5LzP0pv9iMocwjqoH17a=J5RS0OjT9GMFRMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCzN934zZ5LzP0pv9iMocwjqoH17a=J5RS0OjT9GMFRMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:06:59PM +0100, Vincent Guittot wrote:
> > > > While it was clear-cut for 5.9, it's less clear-cut for 5.10-rc2 although
> > > > the gitsource shows some severe differences depending on the machine that
> > > > is worth being extremely cautious about. I would still prefer a revert
> > > > but I'm also extremely biased and I know there are other patches in the
> > >
> > > This one from Julia can also impact
> > >
> >
> > Which one? I'm guessing "[PATCH v2] sched/fair: check for idle core"
> 
> Yes, Sorry I sent my answer before adding the link
> 

Grand, that's added to the mix on top to see how both patches measure up
versus a revert. No guarantee I'll have full results by Monday. As usual,
the test grid is loaded up to the eyeballs.

-- 
Mel Gorman
SUSE Labs
