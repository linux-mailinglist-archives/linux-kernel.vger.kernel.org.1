Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A163040F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbhAZOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391472AbhAZOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:52:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72491C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wr4Jb/2j9Hh/srQm4PSUOUpfBh73vdFGEsVL3upDmec=; b=UlT8zE06CfiawZhEqwBE+p3Jkv
        23Ngvp4ipjjorGyR2T1RtMzt+IKEDDWbh0JV8TVAamFTbR+Hzo341fDo2Nl1tjNQQRh/ZqGzJc8D8
        BNkBcni6c0fn2meAvkljbxMHQrOvIrVn4sPOa+FaicO4vJ1I33XsYnbkDJkXsMwsNAswrqyqfD2n0
        nvMZIQdZtanVYfNvj+p/ttFTyAjyLFbRX69yDI3GjgeN9XeaRMvgQUY+42NbnPE4fYVFZiW8tD4O6
        SJtGgwlRAhsD0mR2GInW/31D9YYYdfAjnXgrA0678QoRplpxvqxdQ8+4uS4HFd0R6W9O7p30ABLcf
        tH8SLUqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pf9-005lbK-1b; Tue, 26 Jan 2021 14:50:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04793300DB4;
        Tue, 26 Jan 2021 15:49:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBD9B2029059B; Tue, 26 Jan 2021 15:49:44 +0100 (CET)
Date:   Tue, 26 Jan 2021 15:49:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
Message-ID: <YBAsCE1dz7Xq/kFg@hirez.programming.kicks-ass.net>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:38:22PM -0800, kan.liang@linux.intel.com wrote:

>  Add pebs_no_block to
>   explicitly indicate the previous platforms which don't support the new
>   block fields. Accessing the new block fields are ignored on those
>   platforms.

> @@ -5475,6 +5749,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu.extra_regs = intel_icl_extra_regs;
>  		x86_pmu.pebs_aliases = NULL;
>  		x86_pmu.pebs_prec_dist = true;
> +		x86_pmu.pebs_no_block = true;
>  		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
>  

> @@ -198,6 +206,63 @@ static u64 load_latency_data(u64 status)
>  	if (dse.ld_locked)
>  		val |= P(LOCK, LOCKED);
>  
> +	/*
> +	 * Ice Lake and earlier models do not support block infos.
> +	 */
> +	if (x86_pmu.pebs_no_block) {
> +		val |= P(BLK, NA);
> +		return val;
> +	}

> @@ -2026,8 +2128,10 @@ void __init intel_ds_init(void)
>  	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
>  	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
> -	if (x86_pmu.version <= 4)
> +	if (x86_pmu.version <= 4) {
>  		x86_pmu.pebs_no_isolation = 1;
> +		x86_pmu.pebs_no_block = 1;
> +	}
>  
>  	if (x86_pmu.pebs) {
>  		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';

> @@ -724,7 +729,8 @@ struct x86_pmu {
>  			pebs_broken		:1,
>  			pebs_prec_dist		:1,
>  			pebs_no_tlb		:1,
> -			pebs_no_isolation	:1;
> +			pebs_no_isolation	:1,
> +			pebs_no_block		:1;
>  	int		pebs_record_size;
>  	int		pebs_buffer_size;
>  	int		max_pebs_events;

I suppose the existing pebs_no_isolation set the bad precedent, but this
is ofcourse a bit backwards. Since we're 0 initialized, new features
should be 1, and not the other way around.
