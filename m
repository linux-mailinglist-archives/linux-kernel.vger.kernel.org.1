Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12B2B04FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgKLMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:35:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:58314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgKLMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:35:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 314A0AC6F;
        Thu, 12 Nov 2020 12:35:02 +0000 (UTC)
Date:   Thu, 12 Nov 2020 12:34:58 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, riel@surriel.com, clm@fb.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH] sched/fair: ensure tasks spreading in LLC during LB
Message-ID: <20201112123458.GY3306@suse.de>
References: <20201102102457.28808-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201102102457.28808-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:24:57AM +0100, Vincent Guittot wrote:
> schbench shows latency increase for 95 percentile above since:
>   commit 0b0695f2b34a ("sched/fair: Rework load_balance()")
> 
> Align the behavior of the load balancer with the wake up path, which tries
> to select an idle CPU which belongs to the LLC for a waking task.
> 
> calculate_imbalance() will use nr_running instead of the spare
> capacity when CPUs share resources (ie cache) at the domain level. This
> will ensure a better spread of tasks on idle CPUs.
> 
> Running schbench on a hikey (8cores arm64) shows the problem:
> 
> tip/sched/core :
> schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
> Latency percentiles (usec)
> 	50.0th: 33
> 	75.0th: 45
> 	90.0th: 51
> 	95.0th: 4152
> 	*99.0th: 14288
> 	99.5th: 14288
> 	99.9th: 14288
> 	min=0, max=14276
> 
> tip/sched/core + patch :
> schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
> Latency percentiles (usec)
> 	50.0th: 34
> 	75.0th: 47
> 	90.0th: 52
> 	95.0th: 78
> 	*99.0th: 94
> 	99.5th: 94
> 	99.9th: 94
> 	min=0, max=94
> 
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reported-by: Chris Mason <clm@fb.com>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
