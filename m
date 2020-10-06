Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741EB284F58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJFQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:00:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:38044 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:00:34 -0400
IronPort-SDR: inB826jZR5PWXBcvNyxYf6+kk3eP7EkE23yBvqPhbBRhUBgr3Xiqy0cSGODNEp/Q30kMMsH6Z3
 SFMFvmfMnSAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228687383"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="228687383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 09:00:25 -0700
IronPort-SDR: oGu8+r+CaTaKtN6r25+Nsb+N0//Y+n6XonjVKB8vo68v6ufkAOphNupRD9Qci6kOfNUs6XKSGt
 NByg9bT/BkMA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527416830"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.144.70]) ([10.249.144.70])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 09:00:22 -0700
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20201006083639.GJ3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
Date:   Tue, 6 Oct 2020 18:00:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006083639.GJ3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 10/6/2020 10:36 AM, Mel Gorman wrote:
> Hi Rafael,
>
> Numerous workload regressions have bisected repeatedly to the commit
> 6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems") but only on
> a set of haswell machines that all have the same CPU.
>
> CPU(s):              48
> On-line CPU(s) list: 0-47
> Thread(s) per core:  2
> Core(s) per socket:  12
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               63
> Model name:          Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> Stepping:            2
> CPU MHz:             1200.359
> CPU max MHz:         3100.0000
> CPU min MHz:         1200.0000
>
> As well as being bisected in mainline, backporting the patch to a
> distribution kernel also showed the same type of problem so the patch
> is definitely suspicious. An example comparison showing the performance
> before CST was enabled and recent mainline kernels is as follow
>
> netperf UDP_STREAM
>                                        5.5.0              5.5.0-rc2              5.5.0-rc2                  5.6.0              5.9.0-rc8
>                                      vanilla      sle15-sp2-pre-cst   sle15-sp2-enable-cst                vanilla                vanilla
> Hmean     send-64         203.21 (   0.00%)      206.43 *   1.58%*      176.89 * -12.95%*      181.18 * -10.84%*      194.45 *  -4.31%*
> Hmean     send-128        401.40 (   0.00%)      414.19 *   3.19%*      355.84 * -11.35%*      364.13 *  -9.29%*      387.83 *  -3.38%*
> Hmean     send-256        786.69 (   0.00%)      799.70 (   1.65%)      700.65 * -10.94%*      719.82 *  -8.50%*      756.40 *  -3.85%*
> Hmean     send-1024      3059.57 (   0.00%)     3106.57 *   1.54%*     2659.62 * -13.07%*     2793.58 *  -8.69%*     3006.95 *  -1.72%*
> Hmean     send-2048      5976.66 (   0.00%)     6102.64 (   2.11%)     5249.34 * -12.17%*     5392.04 *  -9.78%*     5805.02 *  -2.87%*
> Hmean     send-3312      9145.09 (   0.00%)     9304.85 *   1.75%*     8197.25 * -10.36%*     8398.36 *  -8.17%*     9120.88 (  -0.26%)
> Hmean     send-4096     10871.63 (   0.00%)    11129.76 *   2.37%*     9667.68 * -11.07%*     9929.70 *  -8.66%*    10863.41 (  -0.08%)
> Hmean     send-8192     17747.35 (   0.00%)    17969.19 (   1.25%)    15652.91 * -11.80%*    16081.20 *  -9.39%*    17316.13 *  -2.43%*
> Hmean     send-16384    29187.16 (   0.00%)    29418.75 *   0.79%*    26296.64 *  -9.90%*    27028.18 *  -7.40%*    26941.26 *  -7.69%*
> Hmean     recv-64         203.21 (   0.00%)      206.43 *   1.58%*      176.89 * -12.95%*      181.18 * -10.84%*      194.45 *  -4.31%*
> Hmean     recv-128        401.40 (   0.00%)      414.19 *   3.19%*      355.84 * -11.35%*      364.13 *  -9.29%*      387.83 *  -3.38%*
> Hmean     recv-256        786.69 (   0.00%)      799.70 (   1.65%)      700.65 * -10.94%*      719.82 *  -8.50%*      756.40 *  -3.85%*
> Hmean     recv-1024      3059.57 (   0.00%)     3106.57 *   1.54%*     2659.62 * -13.07%*     2793.58 *  -8.69%*     3006.95 *  -1.72%*
> Hmean     recv-2048      5976.66 (   0.00%)     6102.64 (   2.11%)     5249.34 * -12.17%*     5392.00 *  -9.78%*     5805.02 *  -2.87%*
> Hmean     recv-3312      9145.09 (   0.00%)     9304.85 *   1.75%*     8197.25 * -10.36%*     8398.36 *  -8.17%*     9120.88 (  -0.26%)
> Hmean     recv-4096     10871.63 (   0.00%)    11129.76 *   2.37%*     9667.68 * -11.07%*     9929.70 *  -8.66%*    10863.38 (  -0.08%)
> Hmean     recv-8192     17747.35 (   0.00%)    17969.19 (   1.25%)    15652.91 * -11.80%*    16081.20 *  -9.39%*    17315.96 *  -2.43%*
> Hmean     recv-16384    29187.13 (   0.00%)    29418.72 *   0.79%*    26296.63 *  -9.90%*    27028.18 *  -7.40%*    26941.23 *  -7.69%*
>
> pre-cst is just before commit 6d4f08a6776 ("intel_idle: Use ACPI _CST on
> server systems") and enable-cst is the commit. It was not fixed by 5.6 or
> 5.9-rc8. A lot of bisections ended up here including kernel compilation,
> tbench, syscall entry/exit microbenchmark, hackbench, Java workloads etc.
>
> What I don't understand is why. The latencies for c-state exit states
> before and after the patch are both as follows
>
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:10
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:33
> /sys/devices/system/cpu/cpu0/cpuidle/state4/latency:133
>
> Perf profiles did not show up anything interesting. A diff of
> /sys/devices/system/cpu/cpu0/cpuidle/state0/ before and after the patch
> showed up nothing interesting. Any idea why exactly this patch shows up
> as being hazardous on Haswell in particular?
>
Presumably, some of the idle states are disabled by default on the 
affected machines.

Can you check the disable and default_status attributes of each state 
before and after the commit in question?

Cheers!


