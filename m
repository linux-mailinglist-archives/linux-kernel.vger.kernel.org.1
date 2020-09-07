Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B025F66E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgIGJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 05:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgIGJ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C485ADA8;
        Mon,  7 Sep 2020 09:27:21 +0000 (UTC)
Date:   Mon, 7 Sep 2020 10:27:17 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Message-ID: <20200907092717.GD3117@suse.de>
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 07:27:08PM +1200, Barry Song wrote:
> Something is wrong. In find_busiest_group(), we are checking if src has
> higher load, however, in task_numa_find_cpu(), we are checking if dst
> will have higher load after balancing. It seems it is not sensible to
> check src.
> It maybe cause wrong imbalance value, for example, if
> dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
> src_running = env->src_stats.nr_running - 1 results in 1;
> The current code is thinking imbalance as 0 since src_running is smaller
> than 2.
> This is inconsistent with load balancer.
> 

It checks the conditions if the move was to happen. Have you evaluated
this for a NUMA balancing load and confirmed it a) balances properly and
b) does not increase the scan rate trying to "fix" the problem?

-- 
Mel Gorman
SUSE Labs
