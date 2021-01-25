Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E7303246
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbhAYN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:57:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:52915 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbhAYNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:55:28 -0500
IronPort-SDR: 6yQPvI5EudsjAzA7t2fX7Aqk/9r0WvJpElL0xlSE7L2AXNntHV//ftn3EJMRR5CxRM7E24uNRF
 ORcrpC5V/E1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="198506180"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="198506180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 05:53:32 -0800
IronPort-SDR: rUX3lyJg4Wzq8rAzqMA8xtEKTIfF5rnGmWNRn3y6cZskfOoSzB/r/3Yc1hKT4ZhOJRpPYf9l3/
 fmVUVc07tPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="402340150"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 05:53:28 -0800
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     Mel Gorman <mgorman@techsingularity.net>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <20210125090628.GX3592@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <639ac591-75bd-8771-f262-73b7e5c9529d@linux.intel.com>
Date:   Mon, 25 Jan 2021 21:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125090628.GX3592@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 17:06, Mel Gorman wrote:
> On Mon, Jan 25, 2021 at 02:02:58PM +0800, Aubrey Li wrote:
>> A long-tail load balance cost is observed on the newly idle path,
>> this is caused by a race window between the first nr_running check
>> of the busiest runqueue and its nr_running recheck in detach_tasks.
>>
>> Before the busiest runqueue is locked, the tasks on the busiest
>> runqueue could be pulled by other CPUs and nr_running of the busiest
>> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
>> flag set, and triggers load_balance redo at the same sched_domain level.
>>
>> In order to find the new busiest sched_group and CPU, load balance will
>> recompute and update the various load statistics, which eventually leads
>> to the long-tail load balance cost.
>>
>> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
>> redo times, combined with sysctl_sched_nr_migrate, the max load balance
>> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
>> 192 logical CPUs.
>>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> If redo_max is a constant, why is it not a #define instead of increasing
> the size of lb_env?
> 

I followed the existing variable sched_nr_migrate_break, I think this might
be a tunable as well.

Thanks,
-Aubrey
