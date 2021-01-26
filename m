Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744D03040CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391152AbhAZOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405900AbhAZOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:47:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC89C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=adZ203+8MFPFQIgjnyrUrS2BP+acV8HdCeaXkQj1IVg=; b=FwUktD/Gd6Wrd4FK76EBUDfCBk
        +sfsg6xMPOo6SeDRbsrPbeoahXl3YjCGaABlMPeoggDzpxFtOVLrRubVrYe7y9LFrPkZvxbq2WgUO
        4TRJbhmrztOVVBs4LGDyMvXtR5TDkSWu98KPD3VNUKosmMNwkAJeBwoFb4o75lz3qxQu899U9g2MB
        GiSETeRm88StHK7C3XmoKViMpb4lNnOHtJkreiURsbIpOYLRmq7R1YX/I9uKK+nCBU6kOgjCqszmY
        wJkhD9ZEUdEgQFONuPIlDTqdrv9o3/LefWZOlRmbEy/CjC+lqT3hQjDnVnrX8q75CGzFGYQ4+aU1O
        1zr/wCKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4PaB-005lBC-VB; Tue, 26 Jan 2021 14:45:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A94253010C8;
        Tue, 26 Jan 2021 15:44:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94FC12029059B; Tue, 26 Jan 2021 15:44:39 +0100 (CET)
Date:   Tue, 26 Jan 2021 15:44:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
Message-ID: <YBAq11TjpYj2rAot@hirez.programming.kicks-ass.net>
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
> @@ -3671,6 +3853,31 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		}
>  	}
>  
> +	/*
> +	 * To retrieve complete Memory Info of the load latency event, an
> +	 * auxiliary event has to be enabled simultaneously. Add a check for
> +	 * the load latency event.
> +	 *
> +	 * In a group, the auxiliary event must be in front of the load latency
> +	 * event. The rule is to simplify the implementation of the check.
> +	 * That's because perf cannot have a complete group at the moment.
> +	 */
> +	if (x86_pmu.flags & PMU_FL_MEM_LOADS_AUX &&
> +	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
> +	    is_mem_loads_event(event)) {
> +		struct perf_event *leader = event->group_leader;
> +		struct perf_event *sibling = NULL;
> +
> +		if (!is_mem_loads_aux_event(leader)) {
> +			for_each_sibling_event(sibling, leader) {
> +				if (is_mem_loads_aux_event(sibling))
> +					break;
> +			}
> +			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
> +				return -ENODATA;
> +		}
> +	}
> +
>  	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>  		return 0;
>  

I have vague memories of this getting mentioned in a call at some point.
Pretend I don't know anything and tell me more.
