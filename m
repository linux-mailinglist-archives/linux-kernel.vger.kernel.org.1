Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE285304B15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbhAZEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:51:12 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:42788 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbhAYJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:17:17 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id E0F5F42091
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:04:20 +0000 (GMT)
Received: (qmail 4005 invoked from network); 25 Jan 2021 09:04:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Jan 2021 09:04:20 -0000
Date:   Mon, 25 Jan 2021 09:04:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
Message-ID: <20210125090419.GW3592@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net>
 <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
 <20210122101451.GV3592@techsingularity.net>
 <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
 <eb8ac8de-e6e8-3273-5368-efa6ec0cae9b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <eb8ac8de-e6e8-3273-5368-efa6ec0cae9b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:29:47PM +0800, Li, Aubrey wrote:
> >>> hackbench -l 2560 -g 1 on 8 cores arm64
> >>> v5.11-rc4 : 1.355 (+/- 7.96)
> >>> + sis improvement : 1.923 (+/- 25%)
> >>> + the patch below : 1.332 (+/- 4.95)
> >>>
> >>> hackbench -l 2560 -g 256 on 8 cores arm64
> >>> v5.11-rc4 : 2.116 (+/- 4.62%)
> >>> + sis improvement : 2.216 (+/- 3.84%)
> >>> + the patch below : 2.113 (+/- 3.01%)
> >>>
> 
> 4 benchmarks reported out during weekend, with patch 3 on a x86 4s system
> with 24 cores per socket and 2 HT per core, total 192 CPUs.
> 
> It looks like mid-load has notable changes on my side:
> - netperf 50% num of threads in TCP mode has 27.25% improved
> - tbench 50% num of threads has 9.52% regression
> 

It's interesting that patch 3 would make any difference on x64 given that
it's SMT2. The scan depth should have been similar. It's somewhat expected
that it will not be a universal win, particularly once the utilisation
is high enough to spill over in sched domains (25%, 50%, 75% utilisation
being interesting on 4-socket systems). In such cases, double scanning can
still show improvements for workloads that idle rapidly like tbench and
hackbench even though it's expensive. The extra scanning gives more time
for a CPU to go idle enough to be selected which can improve throughput
but at the cost of wake-up latency,

Hopefully v4 can be tested as well which is now just a single scan.

-- 
Mel Gorman
SUSE Labs
