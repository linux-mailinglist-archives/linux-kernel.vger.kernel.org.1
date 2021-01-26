Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AD3042E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392070AbhAZPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391240AbhAZPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:46:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E25C061D7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HVe9UPpqqBkRScaiKRMY/5f0PlRXJM532tU8G+GF/PA=; b=CjlLafdXfrfvnWCck6qvJAMAwq
        zW1rsI4xZ9ZkViG4uxf/CcUseDRIsxcwE24D8CM1NV3eQumhvhuSndOGkPBNHk3/aRqcCZ6baMijE
        E+9Bkz0VbuH3T1mPWE4IU+K3IyQGYd2V81KjMhjGTBMuPF3rN6lJq8MBPS389DtZV8ujPf9SlxjiE
        6KMrspF4WNCEh4ocKPD9KgY+eAepNhvEkzE3g2sLXU44WMS9zDaIznwgiZmJnlR3DDtICnqicOzuO
        0dDmCrYtzEzHdbK8GgRzd59ZEcYwhHaWWyEuZ5xDBJCAzyZ04/nMOV+u5RcqMxU4XK3l533miC5C5
        xm1mLpiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4QW2-005qlo-Pa; Tue, 26 Jan 2021 15:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38550300DAE;
        Tue, 26 Jan 2021 16:44:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C695200E4647; Tue, 26 Jan 2021 16:44:24 +0100 (CET)
Date:   Tue, 26 Jan 2021 16:44:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 04/12] perf/x86/intel: Support CPUID 10.ECX to disable
 fixed counters
Message-ID: <YBA417xr4BxLfYvL@hirez.programming.kicks-ass.net>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611088711-17177-5-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:38:23PM -0800, kan.liang@linux.intel.com wrote:
> @@ -5228,7 +5231,7 @@ __init int intel_pmu_init(void)
>  	 * Check whether the Architectural PerfMon supports
>  	 * Branch Misses Retired hw_event or not.
>  	 */
> -	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
> +	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
>  	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
>  		return -ENODEV;
>  
> @@ -5255,8 +5258,16 @@ __init int intel_pmu_init(void)
>  	if (version > 1) {
>  		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
>  
> -		x86_pmu.num_counters_fixed =
> -			max((int)edx.split.num_counters_fixed, assume);
> +		if (!fixed_mask) {
> +			x86_pmu.num_counters_fixed =
> +				max((int)edx.split.num_counters_fixed, assume);
> +		} else {
> +			/*
> +			 * The fixed-purpose counters are enumerated in the ECX
> +			 * since V5 perfmon.
> +			 */

But that's not what the code implements.

> +			x86_pmu.num_counters_fixed = fls(fixed_mask);
> +		}
>  	}

What you were looking for is something like this:

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe940082d49a..9ad42cb59606 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4817,6 +4817,13 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.num_counters_fixed =
 			max((int)edx.split.num_counters_fixed, assume);
+
+		if (version >= 5) {
+			/*
+			 * V5 and later provide a fixed counter mask.
+			 */
+			x86_pmu.num_counters_fixed = fls(fixed_mask);
+		}
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
