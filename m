Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8442287136
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgJHJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:09:14 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:48267 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbgJHJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:09:14 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 901BCFAE68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:09:11 +0100 (IST)
Received: (qmail 10878 invoked from network); 8 Oct 2020 09:09:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Oct 2020 09:09:11 -0000
Date:   Thu, 8 Oct 2020 10:09:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201008090909.GP3227@techsingularity.net>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 05:45:30PM +0200, Rafael J. Wysocki wrote:
> > pre-cst is just before your patch
> > enable-cst is your patch that was bisected
> > enable-cst-no-hsx-acpi is your patch with use_acpi disabled
> > 5.9-rc8-vanilla is what it sounds like
> > 5.9-rc8-no-hsx-acpi disables use_acpi
> > 
> > The enable-cst-no-hsx-acpi result indicates that use_acpi was the issue for
> > Haswell (at least these machines). Looking just at 5.9-rc8-vanillaa might
> > have been misleading because its performance is not far off the baseline
> > due to unrelated changes that mostly offset the performance penalty.
> > 
> > The key question is -- how appropriate would it be to disable acpi for
> > Haswell? Would that be generally safe or could it hide other surprises?
> > 
> It should be safe, but let's try to do something more fine-grained.
> 
> There is the CPUIDLE_FLAG_ALWAYS_ENABLE flag that is set for C1E.  Can you
> please try to set it for C6 in hsw_cstates instead of clearing use_acpi in
> idle_cpu_hsx and retest?
> 

Performance-wise, always enabling C6 helps but it may be specific to
this workload. Looking across all tested kernels I get;

netperf-udp
                                      5.5.0              5.5.0-rc2              5.5.0-rc2              5.9.0-rc8              5.9.0-rc8              5.9.0-rc8
                                    vanilla                pre-cst             enable-cst                vanilla           disable-acpi              enable-c6
Hmean     send-64         196.31 (   0.00%)      208.56 *   6.24%*      181.15 *  -7.72%*      199.84 *   1.80%*      235.09 *  19.76%*      234.79 *  19.60%*
Hmean     send-128        391.75 (   0.00%)      408.13 *   4.18%*      359.92 *  -8.12%*      396.81 (   1.29%)      469.44 *  19.83%*      465.55 *  18.84%*
Hmean     send-256        776.38 (   0.00%)      798.39 *   2.84%*      707.31 *  -8.90%*      781.63 (   0.68%)      917.19 *  18.14%*      905.06 *  16.57%*
Hmean     send-1024      3019.64 (   0.00%)     3099.00 *   2.63%*     2756.32 *  -8.72%*     3017.06 (  -0.09%)     3509.84 *  16.23%*     3532.85 *  17.00%*
Hmean     send-2048      5790.31 (   0.00%)     6209.53 *   7.24%*     5394.42 *  -6.84%*     5846.11 (   0.96%)     6861.93 *  18.51%*     6852.08 *  18.34%*
Hmean     send-3312      8909.98 (   0.00%)     9483.92 *   6.44%*     8332.35 *  -6.48%*     9047.52 *   1.54%*    10677.93 *  19.84%*    10509.41 *  17.95%*
Hmean     send-4096     10517.63 (   0.00%)    11044.19 *   5.01%*     9851.70 *  -6.33%*    10914.24 *   3.77%*    12719.58 *  20.94%*    12731.06 *  21.04%*
Hmean     send-8192     17355.48 (   0.00%)    18344.50 *   5.70%*    15844.38 *  -8.71%*    17690.46 (   1.93%)    20777.97 *  19.72%*    20220.24 *  16.51%*
Hmean     send-16384    28585.78 (   0.00%)    28950.90 (   1.28%)    25946.88 *  -9.23%*    26643.69 *  -6.79%*    30891.89 *   8.07%*    30701.46 *   7.40%*

The difference between always using ACPI and force enabling C6 is
negligible in this case but more on that later

netperf-udp
                                  5.9.0-rc8              5.9.0-rc8
                               disable-acpi              enable-c6
Hmean     send-64         235.09 (   0.00%)      234.79 (  -0.13%)
Hmean     send-128        469.44 (   0.00%)      465.55 (  -0.83%)
Hmean     send-256        917.19 (   0.00%)      905.06 (  -1.32%)
Hmean     send-1024      3509.84 (   0.00%)     3532.85 (   0.66%)
Hmean     send-2048      6861.93 (   0.00%)     6852.08 (  -0.14%)
Hmean     send-3312     10677.93 (   0.00%)    10509.41 *  -1.58%*
Hmean     send-4096     12719.58 (   0.00%)    12731.06 (   0.09%)
Hmean     send-8192     20777.97 (   0.00%)    20220.24 *  -2.68%*
Hmean     send-16384    30891.89 (   0.00%)    30701.46 (  -0.62%)

The default status and enabled states differ.

For 5.9-rc8 vanilla, the default and disabled status for cstates are

./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:1
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status:enabled
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:disabled
./5.9.0-rc8-vanilla/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/default_status:disabled

For use_acpi == false, all c-states are enabled

./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:0
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status:enabled
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:enabled
./5.9.0-rc8-disable-acpi/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/default_status:enabled

Force enabling C6

./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:0
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status:enabled
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:disabled
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/default_status:enabled

Note that as expected, C3 remains disabled when only C6 is forced (state3
== c3, state4 == c6). While this particular workload does not appear to
care as it does not remain idle for long, the exit latency difference
between c3 and c6 is large so potentially a workload that idles for short
durations that are somewhere between c1e and c3 exit latency might take
a larger penalty exiting from c6 state if the deeper c-state is selected
for idling.

./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/residency:100
./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/residency:400

-- 
Mel Gorman
SUSE Labs
