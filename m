Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF763036BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbhAZGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:42:07 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:53755 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729706AbhAYOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:41:51 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 8EF12FA933
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:40:37 +0000 (GMT)
Received: (qmail 11268 invoked from network); 25 Jan 2021 14:40:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Jan 2021 14:40:37 -0000
Date:   Mon, 25 Jan 2021 14:40:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
Message-ID: <20210125144035.GZ3592@techsingularity.net>
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <20210125090628.GX3592@techsingularity.net>
 <639ac591-75bd-8771-f262-73b7e5c9529d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <639ac591-75bd-8771-f262-73b7e5c9529d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:53:28PM +0800, Li, Aubrey wrote:
> On 2021/1/25 17:06, Mel Gorman wrote:
> > On Mon, Jan 25, 2021 at 02:02:58PM +0800, Aubrey Li wrote:
> >> A long-tail load balance cost is observed on the newly idle path,
> >> this is caused by a race window between the first nr_running check
> >> of the busiest runqueue and its nr_running recheck in detach_tasks.
> >>
> >> Before the busiest runqueue is locked, the tasks on the busiest
> >> runqueue could be pulled by other CPUs and nr_running of the busiest
> >> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
> >> flag set, and triggers load_balance redo at the same sched_domain level.
> >>
> >> In order to find the new busiest sched_group and CPU, load balance will
> >> recompute and update the various load statistics, which eventually leads
> >> to the long-tail load balance cost.
> >>
> >> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
> >> redo times, combined with sysctl_sched_nr_migrate, the max load balance
> >> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
> >> 192 logical CPUs.
> >>
> >> Cc: Andi Kleen <ak@linux.intel.com>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > 
> > If redo_max is a constant, why is it not a #define instead of increasing
> > the size of lb_env?
> > 
> 
> I followed the existing variable sched_nr_migrate_break, I think this might
> be a tunable as well.
> 

I don't think it is, the tunable is sched_nr_migrate and it's not clear
to me at all why sched_nr_migrate_break is not also a #define. It just
happens that sched_nr_migrate == sched_nr_migrate_break by default.

-- 
Mel Gorman
SUSE Labs
