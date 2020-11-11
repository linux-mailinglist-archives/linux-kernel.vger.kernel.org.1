Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D92AEC37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgKKIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:44:02 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:53453 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgKKIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:43:44 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 2C20E1C4FDA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:43:41 +0000 (GMT)
Received: (qmail 3821 invoked from network); 11 Nov 2020 08:43:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Nov 2020 08:43:40 -0000
Date:   Wed, 11 Nov 2020 08:43:31 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] sched/topology: Warn when NUMA diameter > 2
Message-ID: <20201111084331.GJ3371@techsingularity.net>
References: <20201110184300.15673-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201110184300.15673-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:43:00PM +0000, Valentin Schneider wrote:
> NUMA topologies where the shortest path between some two nodes requires
> three or more hops (i.e. diameter > 2) end up being misrepresented in the
> scheduler topology structures.
> 
> This is currently detected when booting a kernel with CONFIG_SCHED_DEBUG=y
> + sched_debug on the cmdline, although this will only yield a warning about
> sched_group spans not matching sched_domain spans:
> 
>   ERROR: groups don't span domain->span
> 
> Add an explicit warning for that case, triggered regardless of
> CONFIG_SCHED_DEBUG, and decorate it with an appropriate comment.
> 
> The topology described in the comment can be booted up on QEMU by appending
> the following to your usual QEMU incantation:
> 
>     -smp cores=4 \
>     -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
>     -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
>     -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
>     -numa dist,src=0,dst=3,val=40, -numa dist,src=1,dst=2,val=20, \
>     -numa dist,src=1,dst=3,val=30, -numa dist,src=2,dst=3,val=20
> 
> A somewhat more realistic topology (6-node mesh) with the same affliction
> can be conjured with:
> 
>     -smp cores=6 \
>     -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
>     -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
>     -numa node,cpus=4,nodeid=4, -numa node,cpus=5,nodeid=5, \
>     -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
>     -numa dist,src=0,dst=3,val=40, -numa dist,src=0,dst=4,val=30, \
>     -numa dist,src=0,dst=5,val=20, \
>     -numa dist,src=1,dst=2,val=20, -numa dist,src=1,dst=3,val=30, \
>     -numa dist,src=1,dst=4,val=20, -numa dist,src=1,dst=5,val=30, \
>     -numa dist,src=2,dst=3,val=20, -numa dist,src=2,dst=4,val=30, \
>     -numa dist,src=2,dst=5,val=40, \
>     -numa dist,src=3,dst=4,val=20, -numa dist,src=3,dst=5,val=30, \
>     -numa dist,src=4,dst=5,val=20
> 
> Link: https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
