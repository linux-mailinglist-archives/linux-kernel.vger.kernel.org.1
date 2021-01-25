Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDD30211C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbhAYEbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:31:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:5598 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbhAYEbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:31:36 -0500
IronPort-SDR: /HGISSmFB8vnJipe5DsRSnI2GMaNtwTB5ZvdLznzzWSDH5jpvI13y36manBuVBE8inEQGRBvMP
 nbcuoo2IH/nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="241197293"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="241197293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 20:29:49 -0800
IronPort-SDR: ln98dYyhXuKwlB1UdlKIgphQByFjt4Ad0CQzM7bmr2s2OqFB7bBwQbYgiKAkkcpVcdLek3//EU
 3dYjBUvRX6aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="402088737"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2021 20:29:48 -0800
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net>
 <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
 <20210122101451.GV3592@techsingularity.net>
 <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <eb8ac8de-e6e8-3273-5368-efa6ec0cae9b@linux.intel.com>
Date:   Mon, 25 Jan 2021 12:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/22 21:22, Vincent Guittot wrote:
> On Fri, 22 Jan 2021 at 11:14, Mel Gorman <mgorman@techsingularity.net> wrote:
>>
>> On Fri, Jan 22, 2021 at 10:30:52AM +0100, Vincent Guittot wrote:
>>> Hi Mel,
>>>
>>> On Tue, 19 Jan 2021 at 13:02, Mel Gorman <mgorman@techsingularity.net> wrote:
>>>>
>>>> On Tue, Jan 19, 2021 at 12:33:04PM +0100, Vincent Guittot wrote:
>>>>> On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
>>>>>>
>>>>>> Changelog since v2
>>>>>> o Remove unnecessary parameters
>>>>>> o Update nr during scan only when scanning for cpus
>>>>>
>>>>> Hi Mel,
>>>>>
>>>>> I haven't looked at your previous version mainly because I'm chasing a
>>>>> performance regression on v5.11-rcx which prevents me from testing the
>>>>> impact of your patchset on my !SMT2 system.
>>>>> Will do this as soon as this problem is fixed
>>>>>
>>>>
>>>> Thanks, that would be appreciated as I do not have access to a !SMT2
>>>> system to do my own evaluation.
>>>
>>> I have been able to run tests with your patchset on both large arm64
>>> SMT4 system and small arm64 !SMT system and patch 3 is still a source
>>> of regression on both. Decreasing min number of loops to 2 instead of
>>> 4 and scaling it with smt weight doesn't seem to be a good option as
>>> regressions disappear when I remove them as I tested with the patch
>>> below
>>>
>>> hackbench -l 2560 -g 1 on 8 cores arm64
>>> v5.11-rc4 : 1.355 (+/- 7.96)
>>> + sis improvement : 1.923 (+/- 25%)
>>> + the patch below : 1.332 (+/- 4.95)
>>>
>>> hackbench -l 2560 -g 256 on 8 cores arm64
>>> v5.11-rc4 : 2.116 (+/- 4.62%)
>>> + sis improvement : 2.216 (+/- 3.84%)
>>> + the patch below : 2.113 (+/- 3.01%)
>>>

4 benchmarks reported out during weekend, with patch 3 on a x86 4s system
with 24 cores per socket and 2 HT per core, total 192 CPUs.

It looks like mid-load has notable changes on my side:
- netperf 50% num of threads in TCP mode has 27.25% improved
- tbench 50% num of threads has 9.52% regression

Details below:

hackbench: 10 iterations, 10000 loops, 40 fds per group
======================================================

- pipe process

	group	base	%std	patch	%std
  	6	1	5.27	1.0469	8.53
  	12	1	1.03	1.0398	1.44
	24	1	2.36	1.0275	3.34

- pipe thread

	group	base	%std	patch	%std
	6       1	7.48	1.0747	5.25
	12	1	0.97	1.0432	1.95
	24	1	7.01	1.0299	6.81

- socket process

	group	base	%std	patch	%std
	6       1       1.01	0.9656	1.09
	12      1       0.35	0.9853	0.49
	24      1       1.33	0.9877	1.20

- socket thread

	group	base	%std	patch	%std
	6       1       2.52	0.9346	2.75
	12      1       0.86	0.9830	0.66
	24      1       1.17	0.9791	1.23

netperf: 10 iterations x 100 seconds, transactions rate / sec
=============================================================

- tcp request/response performance

	thread	base	%std	patch	%std
	50%     1       3.98    1.2725   7.52
	100%    1       2.73    0.9446   2.86
	200%    1       39.36   0.9955  29.45

- udp request/response performance

	thread	base	%std	patch	%std
	50%     1       6.18    1.0704  11.99
	100%    1       47.85   0.9637  45.83
	200%    1       45.74   1.0162  36.99

tbench: 10 iterations x 100 seconds, throughput / sec
=====================================================

	thread	base	%std	patch	%std
	50%	1	1.38 	0.9048 	2.46 
	100%	1	1.05 	0.9640 	0.68 
	200%	1	6.76 	0.9886 	2.86 

schbench: 10 iterations x 100 seconds, 99th percentile latency
==============================================================

	mthread	base	%std	patch	%std
	6	1	29.07	0.8714	25.73
	12	1	15.32	1.0000	12.39
	24	1	 0.08	0.9996	 0.01

>>> So starting with a min of 2 loops instead of 4 currently and scaling
>>> nr loop with smt weight doesn't seem to be a good option and we should
>>> remove it for now
>>>
>> Note that this is essentially reverting the patch. As you remove "nr *=
>> sched_smt_weight", the scan is no longer proportional to cores, it's
> 
> Yes. My goal above was to narrow the changes only to lines that
> generate the regressions but i agree that removing patch 3 is the
> right solution> 
>> proportial to logical CPUs and the rest of the patch and changelog becomes
>> meaningless. On that basis, I'll queue tests over the weekend that remove
>> this patch entirely and keep the CPU scan as a single pass.
>>
>> --
>> Mel Gorman
>> SUSE Labs

