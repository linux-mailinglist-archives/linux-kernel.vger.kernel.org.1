Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FDA2D412F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgLILdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:33:54 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:33277 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbgLILdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:33:54 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 93DE71C3E97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 11:33:02 +0000 (GMT)
Received: (qmail 24101 invoked from network); 9 Dec 2020 11:33:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2020 11:33:02 -0000
Date:   Wed, 9 Dec 2020 11:33:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
Message-ID: <20201209113300.GN3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
 <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
 <3255625e-fa92-dc09-9fab-5621122f4af0@linux.intel.com>
 <20201209090507.GM3371@techsingularity.net>
 <14963d1e-02ea-c298-d6b4-2db637913ee3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <14963d1e-02ea-c298-d6b4-2db637913ee3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:07:11PM +0800, Li, Aubrey wrote:
> On 2020/12/9 17:05, Mel Gorman wrote:
> > On Wed, Dec 09, 2020 at 01:28:11PM +0800, Li, Aubrey wrote:
> >>>>                         nr = div_u64(span_avg, avg_cost);
> >>>>                 else
> >>>>                         nr = 4;
> >>>> -       }
> >>>> -
> >>>> -       time = cpu_clock(this);
> >>>>
> >>>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >>>> +               time = cpu_clock(this);
> >>>> +       }
> >>>>
> >>>>         for_each_cpu_wrap(cpu, cpus, target) {
> >>>>                 if (!--nr)
> >>
> >> nr is the key of this throttling mechanism, need to be placed under sched_feat(SIS_PROP) as well.
> >>
> > 
> > It isn't necessary as nr in initialised to INT_MAX if !SIS_PROP.
> >If !SIS_PROP, nr need to -1 then tested in the loop, instead of testing directly.
> But with SIS_PROP, need adding a test in the loop.
> Since SIS_PROP is default true, I think it's okay to keep the current way.
> 

It's because it's default true and the cost is negligible that I'm leaving
it alone. The branch cost and nr accounting cost is negligible and it
avoids peppering select_idle_cpu() with too many SIS_PROP checks.

-- 
Mel Gorman
SUSE Labs
