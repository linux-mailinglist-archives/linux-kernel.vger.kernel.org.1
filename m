Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA04D2848B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJFIg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:36:27 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:39765 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgJFIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:36:27 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id A47981905
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:36:41 +0100 (IST)
Received: (qmail 6665 invoked from network); 6 Oct 2020 08:36:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Oct 2020 08:36:41 -0000
Date:   Tue, 6 Oct 2020 09:36:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201006083639.GJ3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Numerous workload regressions have bisected repeatedly to the commit
6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems") but only on
a set of haswell machines that all have the same CPU.

CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  2
Core(s) per socket:  12
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               63
Model name:          Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
Stepping:            2
CPU MHz:             1200.359
CPU max MHz:         3100.0000
CPU min MHz:         1200.0000

As well as being bisected in mainline, backporting the patch to a
distribution kernel also showed the same type of problem so the patch
is definitely suspicious. An example comparison showing the performance
before CST was enabled and recent mainline kernels is as follow

netperf UDP_STREAM
                                      5.5.0              5.5.0-rc2              5.5.0-rc2                  5.6.0              5.9.0-rc8
                                    vanilla      sle15-sp2-pre-cst   sle15-sp2-enable-cst                vanilla                vanilla
Hmean     send-64         203.21 (   0.00%)      206.43 *   1.58%*      176.89 * -12.95%*      181.18 * -10.84%*      194.45 *  -4.31%*
Hmean     send-128        401.40 (   0.00%)      414.19 *   3.19%*      355.84 * -11.35%*      364.13 *  -9.29%*      387.83 *  -3.38%*
Hmean     send-256        786.69 (   0.00%)      799.70 (   1.65%)      700.65 * -10.94%*      719.82 *  -8.50%*      756.40 *  -3.85%*
Hmean     send-1024      3059.57 (   0.00%)     3106.57 *   1.54%*     2659.62 * -13.07%*     2793.58 *  -8.69%*     3006.95 *  -1.72%*
Hmean     send-2048      5976.66 (   0.00%)     6102.64 (   2.11%)     5249.34 * -12.17%*     5392.04 *  -9.78%*     5805.02 *  -2.87%*
Hmean     send-3312      9145.09 (   0.00%)     9304.85 *   1.75%*     8197.25 * -10.36%*     8398.36 *  -8.17%*     9120.88 (  -0.26%)
Hmean     send-4096     10871.63 (   0.00%)    11129.76 *   2.37%*     9667.68 * -11.07%*     9929.70 *  -8.66%*    10863.41 (  -0.08%)
Hmean     send-8192     17747.35 (   0.00%)    17969.19 (   1.25%)    15652.91 * -11.80%*    16081.20 *  -9.39%*    17316.13 *  -2.43%*
Hmean     send-16384    29187.16 (   0.00%)    29418.75 *   0.79%*    26296.64 *  -9.90%*    27028.18 *  -7.40%*    26941.26 *  -7.69%*
Hmean     recv-64         203.21 (   0.00%)      206.43 *   1.58%*      176.89 * -12.95%*      181.18 * -10.84%*      194.45 *  -4.31%*
Hmean     recv-128        401.40 (   0.00%)      414.19 *   3.19%*      355.84 * -11.35%*      364.13 *  -9.29%*      387.83 *  -3.38%*
Hmean     recv-256        786.69 (   0.00%)      799.70 (   1.65%)      700.65 * -10.94%*      719.82 *  -8.50%*      756.40 *  -3.85%*
Hmean     recv-1024      3059.57 (   0.00%)     3106.57 *   1.54%*     2659.62 * -13.07%*     2793.58 *  -8.69%*     3006.95 *  -1.72%*
Hmean     recv-2048      5976.66 (   0.00%)     6102.64 (   2.11%)     5249.34 * -12.17%*     5392.00 *  -9.78%*     5805.02 *  -2.87%*
Hmean     recv-3312      9145.09 (   0.00%)     9304.85 *   1.75%*     8197.25 * -10.36%*     8398.36 *  -8.17%*     9120.88 (  -0.26%)
Hmean     recv-4096     10871.63 (   0.00%)    11129.76 *   2.37%*     9667.68 * -11.07%*     9929.70 *  -8.66%*    10863.38 (  -0.08%)
Hmean     recv-8192     17747.35 (   0.00%)    17969.19 (   1.25%)    15652.91 * -11.80%*    16081.20 *  -9.39%*    17315.96 *  -2.43%*
Hmean     recv-16384    29187.13 (   0.00%)    29418.72 *   0.79%*    26296.63 *  -9.90%*    27028.18 *  -7.40%*    26941.23 *  -7.69%*

pre-cst is just before commit 6d4f08a6776 ("intel_idle: Use ACPI _CST on
server systems") and enable-cst is the commit. It was not fixed by 5.6 or
5.9-rc8. A lot of bisections ended up here including kernel compilation,
tbench, syscall entry/exit microbenchmark, hackbench, Java workloads etc.

What I don't understand is why. The latencies for c-state exit states
before and after the patch are both as follows

/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency:10
/sys/devices/system/cpu/cpu0/cpuidle/state3/latency:33
/sys/devices/system/cpu/cpu0/cpuidle/state4/latency:133

Perf profiles did not show up anything interesting. A diff of
/sys/devices/system/cpu/cpu0/cpuidle/state0/ before and after the patch
showed up nothing interesting. Any idea why exactly this patch shows up
as being hazardous on Haswell in particular?

-- 
Mel Gorman
SUSE Labs
