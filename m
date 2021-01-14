Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36A12F5DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbhANJgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:36:38 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:36225 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbhANJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:36:36 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id AA25C1C4699
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:35:45 +0000 (GMT)
Received: (qmail 10366 invoked from network); 14 Jan 2021 09:35:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jan 2021 09:35:45 -0000
Date:   Thu, 14 Jan 2021 09:35:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210114093543.GM3592@techsingularity.net>
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-6-mgorman@techsingularity.net>
 <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:03:00PM +0100, Vincent Guittot wrote:
> > @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >         for_each_cpu_wrap(cpu, cpus, target) {
> >                 if (!--nr)
> >                         return -1;
> > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > -                       break;
> > +               if (smt) {
> 
> If we want to stay on something similar to the previous behavior, we
> want to check on all cores if test_idle_cores is true so nr should be
> set to number of cores
> 

I don't think we necessarily want to do that. has_idle_cores is an
effective throttling mechanism but it's not perfect. If the full domain
is always scanned for a core then there can be excessive scanning in
workloads like hackbench which tends to have has_idle_cores return false
positives. It becomes important once average busy CPUs is over half of
the domain for SMT2.

At least with the patch if that change was made, we still would not scan
twice going over the same runqueues so it would still be an improvement
but it would be nice to avoid excessive deep scanning when there are a
lot of busy CPUs but individual tasks are rapidly idling.

However, in the event regressions are found, changing to your suggested
behaviour would be an obvious starting point.

-- 
Mel Gorman
SUSE Labs
