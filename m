Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62777304B10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 22:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbhAZEvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:51:45 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:34384 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbhAYJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:17:18 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 220D942087
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:06:31 +0000 (GMT)
Received: (qmail 14252 invoked from network); 25 Jan 2021 09:06:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Jan 2021 09:06:30 -0000
Date:   Mon, 25 Jan 2021 09:06:29 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
Message-ID: <20210125090628.GX3592@techsingularity.net>
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:02:58PM +0800, Aubrey Li wrote:
> A long-tail load balance cost is observed on the newly idle path,
> this is caused by a race window between the first nr_running check
> of the busiest runqueue and its nr_running recheck in detach_tasks.
> 
> Before the busiest runqueue is locked, the tasks on the busiest
> runqueue could be pulled by other CPUs and nr_running of the busiest
> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
> flag set, and triggers load_balance redo at the same sched_domain level.
> 
> In order to find the new busiest sched_group and CPU, load balance will
> recompute and update the various load statistics, which eventually leads
> to the long-tail load balance cost.
> 
> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
> redo times, combined with sysctl_sched_nr_migrate, the max load balance
> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
> 192 logical CPUs.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

If redo_max is a constant, why is it not a #define instead of increasing
the size of lb_env?

-- 
Mel Gorman
SUSE Labs
