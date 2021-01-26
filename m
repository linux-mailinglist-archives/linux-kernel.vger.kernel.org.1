Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A043042D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbhAZPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391332AbhAZPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:38:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5761C061A31
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7DH/rPV2wbpZFTFBKKpX3xvfLsUFCflTm0uKcXCTFHE=; b=RphfTLAfuZzVmn1QU3lI116THA
        y2vDd7wJQH7VMwfmr7uO2tULC+0N/7+anjPg9oZURVIjo9YqR4e1HDkHAniYSqbWNsmOXtgC+ss4V
        xRAlzLVIcdR5dxOOWy4oPYHaL4iHfxZJuI0Velf47Cbw/ajKL2/waaqpmyuhCMEQEpAr+lkk13sXE
        Ids3tBw4ufXacJUwdjoauMkSf93Pqr9w9WAvuFtLGEru0beA9QZQPpmlDHP56PHy2JGox2jmHhyIt
        V2WxZ1UWBsPU6nR1ZIjvhZK7I6hOvVCaO6fafmkcwjgyKACMi1hvxizVinsO2fJi/Xb84MZMhdejQ
        8JMFNgTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4QPo-0004FV-Ro; Tue, 26 Jan 2021 15:38:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89CFD3003D8;
        Tue, 26 Jan 2021 16:37:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A4F120731992; Tue, 26 Jan 2021 16:37:59 +0100 (CET)
Date:   Tue, 26 Jan 2021 16:37:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
Message-ID: <YBA3V59bsOA9j/wj@hirez.programming.kicks-ass.net>
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
> @@ -1577,9 +1668,20 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  	}
>  
>  	if (format_size & PEBS_DATACFG_MEMINFO) {
> +		if (sample_type & PERF_SAMPLE_WEIGHT) {
> +			u64 weight = meminfo->latency;
> +
> +			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
> +				weight >>= PEBS_CACHE_LATENCY_OFFSET;
> +			data->weight = weight & PEBS_LATENCY_MASK ?:
>  				intel_get_tsx_weight(meminfo->tsx_tuning);
> +		}
> +
> +		if (sample_type & PERF_SAMPLE_WEIGHT_EXT) {
> +			data->weight_ext.val = 0;
> +			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
> +				data->weight_ext.instr_latency = meminfo->latency & PEBS_LATENCY_MASK;
> +		}
>  
>  		if (sample_type & PERF_SAMPLE_DATA_SRC)
>  			data->data_src.val = get_data_src(event, meminfo->aux);

Talk to me about that SAMPLE_WEIGHT stuff.... I'm not liking it.

Sure you want multiple dimensions, but urgh.

Also, afaict, as proposed you're wasting 80/128 bits. That is, all data
you want to export fits in a single u64 and yet you're using two, which
is mighty daft.

Sure, pebs::lat / pebs_meminfo::latency is defined as a u64, but you
can't tell me that that is ever actually more than 4G cycles. Even the
TSX block latency is u32.

So how about defining SAMPLE_WEIGHT_STRUCT which uses the exact same
data as SAMPLE_WEIGHT but unions it with a struct. I'm not sure if we
want:

union sample_weight {
	u64 weight;

	struct {
		u32	low_dword;
		u32	high_dword;
	};

	/* or */

	struct {
		u32	low_dword;
		u16	high_word;
		u16	higher_word;
	};
};

Then have the core code enforce SAMPLE_WEIGHT ^ SAMPLE_WEIGHT_STRUCT and
make the existing code never set the high dword.

Hmmm?
