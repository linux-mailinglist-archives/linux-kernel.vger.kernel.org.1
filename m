Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647DB28526D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgJFT3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:29:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:34507 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgJFT3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:29:32 -0400
IronPort-SDR: HAVbOduw97hmwxpVbbpwWOGHVJNXAWiW8gqcCRn9E3sg9w5tl43UknEaHGqgMaLWSPxQQ3IA4B
 q36MroSpyqyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144558066"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="144558066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:29:28 -0700
IronPort-SDR: 9STah4YN+/SAOPpnOT7ONANbOSoP4V3o8cJ+unULqsQqDz8KGRsSizJ49TGiFYqkXKUmL4HSQz
 cVjbd5emwLoA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527530045"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.144.70]) ([10.249.144.70])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:29:26 -0700
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
Date:   Tue, 6 Oct 2020 21:29:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006190322.GL3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2020 9:03 PM, Mel Gorman wrote:
> On Tue, Oct 06, 2020 at 06:00:18PM +0200, Rafael J. Wysocki wrote:
>>> server systems") and enable-cst is the commit. It was not fixed by 5.6 or
>>> 5.9-rc8. A lot of bisections ended up here including kernel compilation,
>>> tbench, syscall entry/exit microbenchmark, hackbench, Java workloads etc.
>>>
>>> What I don't understand is why. The latencies for c-state exit states
>>> before and after the patch are both as follows
>>>
>>> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
>>> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
>>> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:10
>>> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:33
>>> /sys/devices/system/cpu/cpu0/cpuidle/state4/latency:133
>>>
>>> Perf profiles did not show up anything interesting. A diff of
>>> /sys/devices/system/cpu/cpu0/cpuidle/state0/ before and after the patch
>>> showed up nothing interesting. Any idea why exactly this patch shows up
>>> as being hazardous on Haswell in particular?
>>>
>> Presumably, some of the idle states are disabled by default on the affected
>> machines.
>>
>> Can you check the disable and default_status attributes of each state before
>> and after the commit in question?
>>
> # grep . pre-cst/cpuidle/state*/disable
> pre-cst/cpuidle/state0/disable:0
> pre-cst/cpuidle/state1/disable:0
> pre-cst/cpuidle/state2/disable:0
> pre-cst/cpuidle/state3/disable:0
> pre-cst/cpuidle/state4/disable:0
> # grep . enable-cst/cpuidle/state*/disable
> enable-cst/cpuidle/state0/disable:0
> enable-cst/cpuidle/state1/disable:0
> enable-cst/cpuidle/state2/disable:0
> enable-cst/cpuidle/state3/disable:0
> enable-cst/cpuidle/state4/disable:0
> # grep . pre-cst/cpuidle/state*/default_status
> pre-cst/cpuidle/state0/default_status:enabled
> pre-cst/cpuidle/state1/default_status:enabled
> pre-cst/cpuidle/state2/default_status:enabled
> pre-cst/cpuidle/state3/default_status:enabled
> pre-cst/cpuidle/state4/default_status:enabled
>
> After the commit, the default_status file does not appear in /sys
>
Something is amiss, then, because the commit doesn't affect the presence 
of this file.

The only thing it does is to set the use_acpi flag for several processor 
models in intel_idle.c.

It can be effectively reversed by removing all of the ".use_acpi = 
true," lines from intel_idle.c.

In particular, please check if changing the value of use_acpi in struct 
idle_cpu_hsx from 'true' to 'false' alone (without reverting the commit) 
makes the issue go away in 5.9-rc8 (the default_status file should be 
present regardless).

Cheers!


