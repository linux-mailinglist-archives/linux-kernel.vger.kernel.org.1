Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F528625B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgJGPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:40:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:44159 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJGPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:40:49 -0400
IronPort-SDR: OGcxL5JG2WsT6BHEb0wfw7i85YfK58DJ173zdVOmmzv6OxYqlidj4bYOEM0HgqA5Rf3uqZGJHZ
 PcmedOUf+O3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152754785"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="152754785"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 08:40:48 -0700
IronPort-SDR: FpXTz5k0XYL2/qm/0fjEbRN+GxW9oAIYEvj+G57/O2KjGPa96TWJTcAgW3kSJJB23P0EIR5FoS
 gK/asx7FcL2g==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="528012192"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.145.6]) ([10.249.145.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 08:40:46 -0700
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <20201006194745.GM3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <172043a7-d180-292e-249b-7aea16c2209a@intel.com>
Date:   Wed, 7 Oct 2020 17:40:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006194745.GM3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2020 9:47 PM, Mel Gorman wrote:
> On Tue, Oct 06, 2020 at 08:03:22PM +0100, Mel Gorman wrote:
>> On Tue, Oct 06, 2020 at 06:00:18PM +0200, Rafael J. Wysocki wrote:
>>>> server systems") and enable-cst is the commit. It was not fixed by 5.6 or
>>>> 5.9-rc8. A lot of bisections ended up here including kernel compilation,
>>>> tbench, syscall entry/exit microbenchmark, hackbench, Java workloads etc.
>>>>
>>>> What I don't understand is why. The latencies for c-state exit states
>>>> before and after the patch are both as follows
>>>>
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:10
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:33
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state4/latency:133
>>>>
>>>> Perf profiles did not show up anything interesting. A diff of
>>>> /sys/devices/system/cpu/cpu0/cpuidle/state0/ before and after the patch
>>>> showed up nothing interesting. Any idea why exactly this patch shows up
>>>> as being hazardous on Haswell in particular?
>>>>
>>> Presumably, some of the idle states are disabled by default on the affected
>>> machines.
>>>
>>> Can you check the disable and default_status attributes of each state before
>>> and after the commit in question?
>>>
>> # grep . pre-cst/cpuidle/state*/disable
> Sorry, second attempt after thinking the results made no sense at all.
> Turns out I fat fingered setting up the enable-cst kernel the second time
> to collect what you asked for and the patch was not applied at all.
>
> # grep . pre-cst/cpuidle/state*/disable
> pre-cst/cpuidle/state0/disable:0
> pre-cst/cpuidle/state1/disable:0
> pre-cst/cpuidle/state2/disable:0
> pre-cst/cpuidle/state3/disable:0
> pre-cst/cpuidle/state4/disable:0
> # grep . pre-cst/cpuidle/state*/default_status
> pre-cst/cpuidle/state0/default_status:enabled
> pre-cst/cpuidle/state1/default_status:enabled
> pre-cst/cpuidle/state2/default_status:enabled
> pre-cst/cpuidle/state3/default_status:enabled
> pre-cst/cpuidle/state4/default_status:enabled
> # grep . enable-cst/cpuidle/state*/disable
> enable-cst/cpuidle/state0/disable:0
> enable-cst/cpuidle/state1/disable:0
> enable-cst/cpuidle/state2/disable:0
> enable-cst/cpuidle/state3/disable:1
> enable-cst/cpuidle/state4/disable:1
> # grep . enable-cst/cpuidle/state*/default_status
> enable-cst/cpuidle/state0/default_status:enabled
> enable-cst/cpuidle/state1/default_status:enabled
> enable-cst/cpuidle/state2/default_status:enabled
> enable-cst/cpuidle/state3/default_status:disabled
> enable-cst/cpuidle/state4/default_status:disabled
>
> That looks like C3 and C6 are disabled after the patch.
>
> # grep . enable-cst/cpuidle/state*/name
> enable-cst/cpuidle/state0/name:POLL
> enable-cst/cpuidle/state1/name:C1
> enable-cst/cpuidle/state2/name:C1E
> enable-cst/cpuidle/state3/name:C3
> enable-cst/cpuidle/state4/name:C6
>
That's kind of unexpected and there may be two reasons for that.

First off, the MWAIT hints in the ACPI tables for C3 and C6 may be 
different from the ones in the intel_idle internal table.

Second, the ACPI tables may only be listing C1.

Can you send me the acpidump output from the affected machine, please?


