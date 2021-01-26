Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402DC3040C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405952AbhAZOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbhAZOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:46:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0187C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/AUG5W4u8skpDV8wzPZNMfda6WvD517BsKuQotKboX0=; b=L59A+SFd0TP2CfA5+3LBzV4VnH
        1rfGO7h0R8cEVDv5HnEKrqPqtGmj5ToTJcUOMZLP8qC5+V4CXOC84vHxvSdGHV9cuZ7FT87BrUllh
        ehpbHEFR8Pr13Ejfi1AhlLqHnUHXO0DK1AeozkdOPDPc4Y95Y1KNaDSO6UXXaXVLwnpb+H8CpW2Yl
        ZodG2sdtf3MYvrWUL0OlcNpxj/vjNc5INU2qaJYyHbwbTvA+VKIUhCQB3KXGQC2j2mbS8kwcxmSGj
        1gXWzMC/vgqBo04MsF5iBT/8znRSdQw4JoBkfQwKmWrGsdZvIsq6/NpVetBWNvh8ZsQxdl4YE/gvk
        Rn/TgJGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4PZG-005l6s-If; Tue, 26 Jan 2021 14:44:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0ABA3028C8;
        Tue, 26 Jan 2021 15:43:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE8F32029059B; Tue, 26 Jan 2021 15:43:41 +0100 (CET)
Date:   Tue, 26 Jan 2021 15:43:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
Message-ID: <YBAqnSlLUpBHOWRY@hirez.programming.kicks-ass.net>
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
> @@ -2319,6 +2474,17 @@ static void __icl_update_topdown_event(struct perf_event *event,
>  {
>  	u64 delta, last = 0;
>  
> +	/*
> +	 * Although the unsupported topdown events are not exposed to users,
> +	 * users may mistakenly use the unsupported events via RAW format.
> +	 * For example, using L2 topdown event, cpu/event=0x00,umask=0x84/,
> +	 * on Ice Lake. In this case, the scheduler follows the unknown
> +	 * event handling and assigns a GP counter to the event.
> +	 * Check the case, and avoid updating unsupported events.
> +	 */
> +	if (event->hw.idx < INTEL_PMC_IDX_FIXED)
> +		return;
> +
>  	delta = icl_get_topdown_value(event, slots, metrics);
>  	if (last_slots)
>  		last = icl_get_topdown_value(event, last_slots, last_metrics);

Is this a separate patch?
