Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78523040B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbhAZOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391470AbhAZOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:43:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F48C0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9gTsMMOQz39o3Kzc+ONyPjwXCQ2Mzuei9mghrZLPVk=; b=1WKy1gRNY1V2JS8HwV9fvPZlDU
        4zTOZlGJyeTu0on2qPqaY3LdtYPTcZt9sSrHuigiAJdzsQPJCNATOHTCogqqUpqtW9LcEUJYVSeUb
        FyYu85I0LfyOUMpWAEwFSYI+YfUlA6n0E8QIRKVU8e9HpsNgM7vjoe5q7hXLIgt1vY5t0vln83MSH
        /Mt7OGMRfmZJJ2QW5Bs07F1Ph+BLzEKcwvixDeFJaQwgWhj+ygUDJXsSvmJHN2obJDy+/yJ40Ihli
        3YWriWE/n+0DPz2S5rDjUmhlP5KduPZlYZLTdQSVNDvLZ9WyN6sskQwNZE7DWfguWtiL1cyzsQKcm
        4MDJ84Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4PYO-0005Qs-9c; Tue, 26 Jan 2021 14:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEB5C300DB4;
        Tue, 26 Jan 2021 15:42:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A500B2029059B; Tue, 26 Jan 2021 15:42:43 +0100 (CET)
Date:   Tue, 26 Jan 2021 15:42:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 01/12] perf/core: Add PERF_SAMPLE_WEIGHT_EXT
Message-ID: <YBAqYyTuqxsH8tqR@hirez.programming.kicks-ass.net>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611088711-17177-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:38:20PM -0800, kan.liang@linux.intel.com wrote:

> @@ -900,6 +901,13 @@ enum perf_event_type {
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX
>  	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>  	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> +	 *	{ union {
> +	 *		u64		weight_ext;
> +	 *		struct {
> +	 *			u64	instr_latency:16,
> +	 *				reserved:48;
> +	 *		};
> +	 *	} && PERF_SAMPLE_WEIGHT_EXT
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> @@ -1248,4 +1256,12 @@ struct perf_branch_entry {
>  		reserved:40;
>  };
>  
> +union perf_weight_ext {
> +	__u64		val;
> +	struct {
> +		__u64	instr_latency:16,
> +			reserved:48;
> +	};
> +};
> +
>  #endif /* _UAPI_LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 55d1879..9363d12 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1903,6 +1903,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
>  	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
>  		size += sizeof(data->code_page_size);
>  
> +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
> +		size += sizeof(data->weight_ext);
> +
>  	event->header_size = size;
>  }
>  
> @@ -6952,6 +6955,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>  			perf_aux_sample_output(event, handle, data);
>  	}
>  
> +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
> +		perf_output_put(handle, data->weight_ext);
> +
>  	if (!event->attr.watermark) {
>  		int wakeup_events = event->attr.wakeup_events;
>  

This patch is broken and will expose uninitialized kernel stack.
