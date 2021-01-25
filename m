Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722483035D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbhAZFyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:54:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:13465 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbhAYMZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:25:30 -0500
IronPort-SDR: zyA3LxLwAar/hMzorYlYg9jpS947JK4+e4cTx+y0F/r230M/fhp7NTTDki3Dx8evikoINVmR45
 0jgktxZm674Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="264533815"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="264533815"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 03:37:57 -0800
IronPort-SDR: bUi0UhEituNXVIKn22FdlQbCetj6F+yqu4xxdp5RBf7c4Og23VaE0khtEwf/LI5xtXYO2Ri4hE
 x5Y8pLWeD8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="402275159"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 03:37:56 -0800
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net>
 <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
 <20210122101451.GV3592@techsingularity.net>
 <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
 <eb8ac8de-e6e8-3273-5368-efa6ec0cae9b@linux.intel.com>
 <20210125090419.GW3592@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <31300317-89e0-ca5e-d095-920c6cfe8704@linux.intel.com>
Date:   Mon, 25 Jan 2021 19:37:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125090419.GW3592@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 17:04, Mel Gorman wrote:
> On Mon, Jan 25, 2021 at 12:29:47PM +0800, Li, Aubrey wrote:
>>>>> hackbench -l 2560 -g 1 on 8 cores arm64
>>>>> v5.11-rc4 : 1.355 (+/- 7.96)
>>>>> + sis improvement : 1.923 (+/- 25%)
>>>>> + the patch below : 1.332 (+/- 4.95)
>>>>>
>>>>> hackbench -l 2560 -g 256 on 8 cores arm64
>>>>> v5.11-rc4 : 2.116 (+/- 4.62%)
>>>>> + sis improvement : 2.216 (+/- 3.84%)
>>>>> + the patch below : 2.113 (+/- 3.01%)
>>>>>
>>
>> 4 benchmarks reported out during weekend, with patch 3 on a x86 4s system
>> with 24 cores per socket and 2 HT per core, total 192 CPUs.
>>
>> It looks like mid-load has notable changes on my side:
>> - netperf 50% num of threads in TCP mode has 27.25% improved
>> - tbench 50% num of threads has 9.52% regression
>>
> 
> It's interesting that patch 3 would make any difference on x64 given that
> it's SMT2. The scan depth should have been similar. It's somewhat expected
> that it will not be a universal win, particularly once the utilisation
> is high enough to spill over in sched domains (25%, 50%, 75% utilisation
> being interesting on 4-socket systems). In such cases, double scanning can
> still show improvements for workloads that idle rapidly like tbench and
> hackbench even though it's expensive. The extra scanning gives more time
> for a CPU to go idle enough to be selected which can improve throughput
> but at the cost of wake-up latency,

aha, sorry for the confusion. Since you and Vincent discussed to drop
patch3, I just mentioned I tested 5 patches with patch3, not patch3 alone.

> 
> Hopefully v4 can be tested as well which is now just a single scan.
> 

Sure, may I know the baseline of v4?

Thanks,
-Aubrey
