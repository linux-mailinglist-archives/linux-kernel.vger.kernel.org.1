Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05E62A289C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgKBLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:00:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:37448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgKBLAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:00:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9817AB2EC;
        Mon,  2 Nov 2020 11:00:10 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:00:08 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched/fair] d8fcb81f1a: netperf.Throughput_tps -16.9% regression
Message-ID: <20201102110008.GA3306@suse.de>
References: <20201101082452.GC31092@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201101082452.GC31092@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 04:24:52PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -16.9% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: d8fcb81f1acf651a0e50eacecca43d0524984f87 ("sched/fair: Check for idle core in wake_affine")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> 
> in testcase: netperf
> on test machine: 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 25%
> 	cluster: cs-localhost
> 	test: SCTP_RR
> 	cpufreq_governor: performance
> 	ucode: 0x700001c
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+------------------------------------------------------------------------+
> | testcase: change | aim7: aim7.jobs-per-min 8.7% improvement                               |
> | test machine     | 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                           |
> |                  | disk=1BRD_48G                                                          |
> |                  | fs=xfs                                                                 |
> |                  | load=600                                                               |
> |                  | test=sync_disk_rw                                                      |
> |                  | ucode=0x700001c                                                        |
> +------------------+------------------------------------------------------------------------+
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 

I know I ran tests against this patch in general and gave an Ack but
these cases were not covered by me. For netperf, I neither vary the number
of threads nor did I cover SCTP_RR so this could be an example of where
the patch is a loss. I also had run reaim but not specifically for one
sub-test like this does and the generation of machines used was much
older than Gold 5318H. Grid or no grid, complete coverage is a challenge

-- 
Mel Gorman
SUSE Labs
