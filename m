Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2926C837
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIPSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgIPSXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01D57AC24;
        Wed, 16 Sep 2020 11:00:58 +0000 (UTC)
Date:   Wed, 16 Sep 2020 12:00:39 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
Message-ID: <20200916110039.GG3117@suse.de>
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200916043103.606132-1-aubrey.li@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:31:03PM +0800, Aubrey Li wrote:
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
> 
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
> 
> The following benchmarks were tested on a x86 4 socket system with
> 24 cores per socket and 2 hyperthreads per core, total 192 CPUs:
> 

This still appears to be tied to turning the tick off. An idle CPU
available for computation does not necessarily have the tick turned off
if it's for short periods of time. When nohz is disabled or a machine is
active enough that CPUs are not disabling the tick, select_idle_cpu may
fail to select an idle CPU and instead stack tasks on the old CPU.

The other subtlety is that select_idle_sibling() currently allows a
SCHED_IDLE cpu to be used as a wakeup target. The CPU is not really
idle as such, it's simply running a low priority task that is suitable
for preemption. I suspect this patch breaks that.

-- 
Mel Gorman
SUSE Labs
