Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92B230B00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgG1NKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgG1NKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:10:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=14t2LZw1UTiiPAX8sGipxQY0aUeLjHyy39ozCun4WYY=; b=YIq9uTs4x/U9BlIAnDcN3x15Y/
        WH0XbvQQH47YT5xATaDtMPmbt143qg3aSD570uR06hZxULOMWUNjLvbqLiVMIB5KpWw3AG1He2oTg
        B0gUr10zMjJTCR6G4qkjOSyzyFLUVJnqoXNztKmYEod4hy5kE2G7GhFAplfNUpac61ZzyNMuPWQvr
        GHus5/UvxS4/UT66b6pblEoh4PzFKbikYaUBiN58e/LtGasrvjkfP9RjT/pXm1aqumSJ2OI8Dg9lU
        AWwNuMuxiZOoPoIVu2Rt1WOIBnK0NI/NJns9kE1YZQoOSFd99wXjPxbEgX/HaN2Ef/byhK5r8tzA2
        2GQtKZYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0PMj-00048r-2K; Tue, 28 Jul 2020 13:09:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60DC7304B6D;
        Tue, 28 Jul 2020 15:09:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2142029DE2958; Tue, 28 Jul 2020 15:09:56 +0200 (CEST)
Date:   Tue, 28 Jul 2020 15:09:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200728130956.GK10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
 <20200724131906.GW119549@hirez.programming.kicks-ass.net>
 <20200724152755.GK43129@hirez.programming.kicks-ass.net>
 <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
 <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:10:52PM -0400, Liang, Kan wrote:

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 6cb079e0c9d9..010ac74afc09 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2405,27 +2405,18 @@ static u64 icl_update_topdown_event(struct
> perf_event *event)
>  	return slots;
>  }
> 
> -static void intel_pmu_read_topdown_event(struct perf_event *event)
> +static void intel_pmu_read_event(struct perf_event *event)
>  {
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -
> -	/* Only need to call update_topdown_event() once for group read. */
> -	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
> -	    !is_slots_event(event))
>  		return;
> 
> -	perf_pmu_disable(event->pmu);
> -	x86_pmu.update_topdown_event(event);
> -	perf_pmu_enable(event->pmu);
> -}
> -
> -static void intel_pmu_read_event(struct perf_event *event)
> -{
>  	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>  		intel_pmu_auto_reload_read(event);
> -	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
> -		intel_pmu_read_topdown_event(event);
> -	else
> +	else if (is_slots_count(event) && x86_pmu.update_topdown_event) {
> +		perf_pmu_disable(event->pmu);
> +		x86_pmu.update_topdown_event(event);
> +		perf_pmu_enable(event->pmu);
> +	} else
>  		x86_perf_event_update(event);
>  }

I'm a little puzzled by this; what happens if you:

	fd = sys_perf_event_open(&attr_slots);
	fd1 = sys_perf_event_open(&attr_metric, .group_fd=fd);

	read(fd1);

?
