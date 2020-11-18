Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7B2B7D53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgKRMGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:06:46 -0500
Received: from foss.arm.com ([217.140.110.172]:53094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgKRMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:06:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E705011D4;
        Wed, 18 Nov 2020 04:06:44 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA0B3F70D;
        Wed, 18 Nov 2020 04:06:42 -0800 (PST)
References: <20201116200428.47359-1-aubrey.li@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup
In-reply-to: <20201116200428.47359-1-aubrey.li@linux.intel.com>
Date:   Wed, 18 Nov 2020 12:06:36 +0000
Message-ID: <jhjlfeyx41f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/11/20 20:04, Aubrey Li wrote:
> From: Aubrey Li <aubrey.li@intel.com>
>
> Add idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, if the idle driver indicates to stop tick, this CPU
> is set in the idle cpumask to be a wakeup target. And if the CPU
> is not in idle, the CPU is cleared in idle cpumask during scheduler
> tick to ratelimit idle cpumask update.
>
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
>
> Benchmarks were tested on a x86 4 socket system with 24 cores per
> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> schbench have no notable change, uperf has:
>
> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>
>   threads       baseline-avg    %std    patch-avg       %std
>   96            1               0.83    1.23            3.27
>   144           1               1.03    1.67            2.67
>   192           1               0.69    1.81            3.59
>   240           1               2.84    1.51            2.67
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jiang Biao <benbjiang@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

That's missing a v3 -> v4 change summary

