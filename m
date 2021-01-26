Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9F304329
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbhAZP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391286AbhAZPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:55:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4CC0698C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WMBbAqRG8ImRubg0i2BL9P7B/0yRur7X7+FNKOvT0pI=; b=dxPPbq3NUJDTeD+mkdQmk4IhGA
        XJFXDfWlCDZ57woUY5tHbtgiwUpmMwMXKcZiqHNzu7F27kOytxhhOOED7KYjgDcaaRM3YW5TSwBcf
        gWU7oQaAYblm0PUz8uPoId82sZ8J9KxxPxGaD/tCGZJuniTefex6DSuz526R8NmphqnwRHYd1SgNR
        Dvs/XzlhDAHANt1jIMAygi3NxOjb03jv4W3MIhzbULRomTCjAJKh+hINe3lQB7RQ3swuxg2CKQGtA
        n/m96ZbLMrtSSvNBHYsGKBIYv44/gayRMdU4sUr4RhXLtECnqaUUP73v3f5F4itSIxiJuJIOxyzRY
        eX2bIphA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Qeb-005rVw-F9; Tue, 26 Jan 2021 15:53:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B99F6300DAE;
        Tue, 26 Jan 2021 16:53:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F64F200E46B7; Tue, 26 Jan 2021 16:53:15 +0100 (CET)
Date:   Tue, 26 Jan 2021 16:53:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 04/12] perf/x86/intel: Support CPUID 10.ECX to disable
 fixed counters
Message-ID: <YBA662724snCMudn@hirez.programming.kicks-ass.net>
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
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a54d4a9..21267dc 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5206,7 +5209,7 @@ __init int intel_pmu_init(void)
>  	union cpuid10_eax eax;
>  	union cpuid10_ebx ebx;
>  	struct event_constraint *c;
> -	unsigned int unused;
> +	unsigned int fixed_mask;
>  	struct extra_reg *er;
>  	bool pmem = false;
>  	int version, i;
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
> +			x86_pmu.num_counters_fixed = fls(fixed_mask);
> +		}
>  	}
>  
>  	if (version >= 4)
> @@ -5847,8 +5858,11 @@ __init int intel_pmu_init(void)
>  		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
>  	}
>  
> -	x86_pmu.intel_ctrl |=
> -		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
> +	if (!fixed_mask) {
> +		x86_pmu.intel_ctrl |=
> +			((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
> +	} else
> +		x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
>  
>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
>  	if (x86_pmu.intel_cap.anythread_deprecated)

Maybe like so.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe940082d49a..274d75d33c14 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4766,7 +4766,7 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	struct event_constraint *c;
-	unsigned int unused;
+	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
@@ -4788,7 +4788,7 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
 
@@ -4812,11 +4812,18 @@ __init int intel_pmu_init(void)
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
 	 */
-	if (version > 1) {
+	if (version > 1 && version < 5) {
 		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
 
 		x86_pmu.num_counters_fixed =
 			max((int)edx.split.num_counters_fixed, assume);
+
+		fixed_mask = (1L << x86_pmu.num_counters_fixed) - 1;
+
+	} else if (version >= 5 ) {
+
+		x86_pmu.num_counters_fixed = fls(fixed_mask);
+
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
@@ -5366,8 +5373,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
 	}
 
-	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
