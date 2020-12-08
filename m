Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84232D2FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgLHQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:30:55 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:37330 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgLHQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:30:54 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id DF4F3C4A45
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 16:30:01 +0000 (GMT)
Received: (qmail 4339 invoked from network); 8 Dec 2020 16:30:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Dec 2020 16:30:01 -0000
Date:   Tue, 8 Dec 2020 16:30:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
Message-ID: <20201208163000.GL3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
 <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 05:03:21PM +0100, Vincent Guittot wrote:
> On Tue, 8 Dec 2020 at 16:35, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> > even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> > check and while we are at it, exclude the cost of initialising the CPU
> > mask from the average scan cost.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  kernel/sched/fair.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ac7b34e7372b..5c41875aec23 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >         if (!this_sd)
> >                 return -1;
> 
> Just noticed while reviewing the patch that the above related to
> this_sd can also go under sched_feat(SIS_PROP)
> 

Technically yes but I also decided against it. It's a functional difference
depending on whether SIS_PROP is set in the highly unlikely case that
this_sd == NULL. I was also thinking in terms of what happens if SIS_PROP
was disabled and enabled while a search is in progress even if it's very
unlikely. In that case, this_sd would be uninitialised. That might be
impossible in practice depending on how static branching is implemented
but I don't think we should rely on the internals of jump labels and play
it safe. I can move it in if you feel strongly about it but I think the
disable/enable race is enough of a concern to leave it alone.

-- 
Mel Gorman
SUSE Labs
