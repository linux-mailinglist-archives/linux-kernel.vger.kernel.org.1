Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E649D280EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgJBIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:20:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:31365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387641AbgJBIUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:20:34 -0400
IronPort-SDR: CKB7aAEntKlOVDqQrdfisi6P8NdmYyDdG9cvVzDA6F58bFGqVreTEhOG+h91hRu1jE730TmMZE
 JKa21F9+dQJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150740164"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="150740164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 01:20:27 -0700
IronPort-SDR: VAvwKm8yv/adFxa0i0UjSHBGLbVWNTAzS7bs1xbrD978obAwSQhcf/gpChaF2RmtJwKQFnO9gq
 IEbY9i7b84Mw==
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="458530120"
Received: from xzou3-mobl2.ccr.corp.intel.com (HELO [10.255.29.253]) ([10.255.29.253])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 01:20:23 -0700
Subject: Re: [perf report] 977f739b71:
 perf-test.skid_test.round2.MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_withou
 t_NMI_fixed_period.fail
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20200930091943.GB393@shao2-debian>
 <alpine.LRH.2.20.2009301439250.12057@Diego>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ecd17ed2-f041-7a80-b733-7a820e6da9f2@intel.com>
Date:   Fri, 2 Oct 2020 16:20:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.2009301439250.12057@Diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 8:41 PM, Michael Petlan wrote:
> Hello. To me, it looks rather a random failure. Is it actually reproducible
> and proven that the patch has caused it? The patch doesn't seem to cause
> the fails below.

Hi Michael,

It's not always reproducible, but we can reproduce it in most cases:

39c0a53b114d0317 977f739b7126bf98b5202e243f6
---------------- ---------------------------
        fail:runs  %reproduction    fail:runs
            |             |             |
            :8           75%           6:8 
perf-test.skid_test.round2.MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI.fail
            :8           88%           7:8 
perf-test.skid_test.round2.MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period.fail
            :8           25%           2:8 
perf-test.skid_test.round2.MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI.fail
            :8           62%           5:8 
perf-test.skid_test.round2.MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period.fail

Best Regards,
Rong Chen


> Cheers,
> Michael
> 
> On Wed, 30 Sep 2020, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 977f739b7126bf98b5202e243f60cbc0a1ec2c3b ("perf report: Disable ordered_events for raw dump")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: perf-test
>> version: perf-test-x86_64-git-1_20200717
>> with following parameters:
>>
>> 	type: lkp
>> 	ucode: 0xd6
>>
>> test-description: The internal Perf Test suite.
>>
>>
>> on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz with 32G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> 2020-09-28 17:02:40 ./skid_test/run.sh
>> Mon Sep 28 17:02:58 UTC 2020
>> 3 test cases pass for skid_test test. 3 test cases fail for skid_test test.
>> Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_with_NMI PASS!
>> Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI PASS!
>> Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI FAILED!
>> Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_without_NMI_fixed_period PASS!
>> Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period FAILED!
>> Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period FAILED!
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
>>
> 
