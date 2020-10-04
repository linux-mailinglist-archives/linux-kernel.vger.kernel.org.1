Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56517282BCD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJDQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 12:21:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgJDQVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 12:21:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEAF3AC3C;
        Sun,  4 Oct 2020 16:21:12 +0000 (UTC)
Date:   Sun, 4 Oct 2020 17:21:08 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair] fcf0553db6: netperf.Throughput_Mbps -30.8%
 regression
Message-ID: <20201004162108.GC3165@suse.de>
References: <20201004132716.GS393@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201004132716.GS393@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 09:27:16PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:
> 
> 
> commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

This commit was the start of a series that made large changes to load
balancing.  The series was not bisect-safe and has since been reconciled
with the NUMA balancing. Any workload with a potential load balancing
problem has to be checked against the latest kernel to see if the problem
persists there. If it does, then tip/sched/core should be checked or
5.10-rc1 when it comes out as tip has a few more LB changes pending.

-- 
Mel Gorman
SUSE Labs
