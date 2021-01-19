Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52DA2FAF00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbhASDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:02:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:2881 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbhASDCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:02:18 -0500
IronPort-SDR: Mc5RZhIQqFrCchRaQ4qd3uo+EpP7JPX7YYn9NfyglCwzvLCjm+51KvsF3mImAfs4gqRLqqIlwT
 574Us1actG8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="165961067"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="165961067"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 19:01:37 -0800
IronPort-SDR: mfCuK8AldyifUVtmxH7ERnY4Lw6Dbm3+p1YlnOmSpMDneA36I2SHelltehP26Xh9Be/YfflLfe
 jEVFH4YxqXvA==
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="383767685"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 19:01:35 -0800
Subject: Re: [LKP] Re: [percpu_ref] 2b0d3d3e4f: reaim.jobs_per_min -18.4%
 regression
To:     Ming Lei <ming.lei@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210110143247.GA6259@xsang-OptiPlex-9020>
 <20210111095854.GA4155851@T590>
From:   "Xing, Zhengjun" <zhengjun.xing@intel.com>
Message-ID: <0a3f09f3-6712-a66f-8a9a-fb31b9d1a564@intel.com>
Date:   Tue, 19 Jan 2021 11:01:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210111095854.GA4155851@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2021 5:58 PM, Ming Lei wrote:
> On Sun, Jan 10, 2021 at 10:32:47PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -18.4% regression of reaim.jobs_per_min due to commit:
>>
>>
>> commit: 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: reaim
>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	nr_task: 100%
>> 	test: short
>> 	cpufreq_governor: performance
>> 	ucode: 0x5002f01
>>
>> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
>> test-url: https://sourceforge.net/projects/re-aim-7/
>>
>> In addition to that, the commit also has significant impact on the following tests:
>>
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput -2.8% regression                |
>> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=performance                                              |
>> |                  | runtime=300s                                                              |
>> |                  | test=lru-file-mmap-read-rand                                              |
>> |                  | ucode=0x5003003                                                           |
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops 14.5% improvement            |
>> | test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory    |
>> | test parameters  | cpufreq_governor=performance                                              |
>> |                  | mode=process                                                              |
>> |                  | nr_task=50%                                                               |
>> |                  | test=page_fault2                                                          |
>> |                  | ucode=0x16                                                                |
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops -13.0% regression            |
>> | test machine     | 104 threads Skylake with 192G memory                                      |
>> | test parameters  | cpufreq_governor=performance                                              |
>> |                  | mode=process                                                              |
>> |                  | nr_task=50%                                                               |
>> |                  | test=malloc1                                                              |
>> |                  | ucode=0x2006906                                                           |
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput -2.3% regression                |
>> | test machine     | 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory                |
>> | test parameters  | cpufreq_governor=performance                                              |
>> |                  | runtime=300s                                                              |
>> |                  | test=lru-file-mmap-read-rand                                              |
>> |                  | ucode=0x5002f01                                                           |
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | fio-basic: fio.read_iops -4.8% regression                                 |
>> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | bs=4k                                                                     |
>> |                  | cpufreq_governor=performance                                              |
>> |                  | disk=2pmem                                                                |
>> |                  | fs=xfs                                                                    |
>> |                  | ioengine=libaio                                                           |
>> |                  | nr_task=50%                                                               |
>> |                  | runtime=200s                                                              |
>> |                  | rw=randread                                                               |
>> |                  | test_size=200G                                                            |
>> |                  | time_based=tb                                                             |
>> |                  | ucode=0x5002f01                                                           |
>> +------------------+---------------------------------------------------------------------------+
>> | testcase: change | stress-ng: stress-ng.stackmmap.ops_per_sec -45.4% regression              |
>> | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory      |
>> | test parameters  | class=memory                                                              |
>> |                  | cpufreq_governor=performance                                              |
>> |                  | disk=1HDD                                                                 |
>> |                  | nr_threads=100%                                                           |
>> |                  | testtime=10s                                                              |
>> |                  | ucode=0x5002f01                                                           |
>> +------------------+---------------------------------------------------------------------------+
> Just run a quick test of the last two on 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of
> percpu_ref in fast path) and cf785af19319 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()").
>
> Not see difference in the two kernel(fio on null_blk with 224 hw queues,
> and 'stress-ng --stackmmap-ops') on one 224 cores, dual sockets system.
>
> BTW this patch itself doesn't touch fast path code, so it is supposed to
> not affect performance.
>
> Can you double check if the test itself is good?
I re-test the "fio-basic: fio.read_iops -4.8% regression"  for more than 
5 times, the average regression is -2.3%.
For "stress_ng", normally, it tests a lot of cases one by one. Command  
'stress-ng --stackmmap-ops' only test  "stackmmap" case.
I also tried only test "stackmmap" case, the regression is -7.8%.

But for here, it mainly reports "reaim.jobs_per_min -18.4% regression", 
I re-test  "reaim" case, the result is almost the same.
>
> Note: cf785af19319 is 2b0d3d3e4fcf^
>
>
>
> Thanks,
> Ming
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

-- 
Zhengjun Xing

