Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2234304332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbhAZP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404144AbhAZP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:57:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD6C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SwwSz04nAiitxppm41x59LNVjdYgPkKG1Bk647+oE+s=; b=Islfy0bjDLGA2KUoXMGMGwM+q0
        ddqVVRNHC8PWeTXwKsKJGhcTNOI8oWxGXD76NFBEMLyPilgM2Q3EUWDYaakHBQiWBINuqOIY8ZZE6
        j9aKImwGQAno1yAsvwJGgeKiR5L6jC3yMNuPXTaenNCml6as2v7ZL4W/QSkqQs0dWKkaS3lPJtNFw
        JFAiiCVEJGrzCzNaBoYQ5CsvmdO8y/ssbjP3WxkXpch/z9GguEUNX8lqcH42quL09uNJqF2U8tgWn
        7q3w1ADsCwFfr8UYKAZgiPmvptUTF7d5RPFysn0PlnisFJjKu2LAR8Lo2QGmimUq3Sgc3AYZ0CRdD
        fNUbONrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4QgG-005reX-UB; Tue, 26 Jan 2021 15:55:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FE4B300DAE;
        Tue, 26 Jan 2021 16:55:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BA2E2029059B; Tue, 26 Jan 2021 16:55:00 +0100 (CET)
Date:   Tue, 26 Jan 2021 16:55:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 01/12] perf/core: Add PERF_SAMPLE_WEIGHT_EXT
Message-ID: <YBA7VMH4l6J8LlCZ@hirez.programming.kicks-ass.net>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-2-git-send-email-kan.liang@linux.intel.com>
 <YBAqYyTuqxsH8tqR@hirez.programming.kicks-ass.net>
 <d018282d-f47d-4382-2538-59c6930a74c3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d018282d-f47d-4382-2538-59c6930a74c3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:33:18AM -0500, Liang, Kan wrote:
> 
> 
> On 1/26/2021 9:42 AM, Peter Zijlstra wrote:
> > On Tue, Jan 19, 2021 at 12:38:20PM -0800, kan.liang@linux.intel.com wrote:
> > 
> > > @@ -900,6 +901,13 @@ enum perf_event_type {
> > >   	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> > >   	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
> > >   	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> > > +	 *	{ union {
> > > +	 *		u64		weight_ext;
> > > +	 *		struct {
> > > +	 *			u64	instr_latency:16,
> > > +	 *				reserved:48;
> > > +	 *		};
> > > +	 *	} && PERF_SAMPLE_WEIGHT_EXT
> > >   	 * };
> > >   	 */
> > >   	PERF_RECORD_SAMPLE			= 9,
> > > @@ -1248,4 +1256,12 @@ struct perf_branch_entry {
> > >   		reserved:40;
> > >   };
> > > +union perf_weight_ext {
> > > +	__u64		val;
> > > +	struct {
> > > +		__u64	instr_latency:16,
> > > +			reserved:48;
> > > +	};
> > > +};
> > > +
> > >   #endif /* _UAPI_LINUX_PERF_EVENT_H */
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 55d1879..9363d12 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -1903,6 +1903,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
> > >   	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
> > >   		size += sizeof(data->code_page_size);
> > > +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
> > > +		size += sizeof(data->weight_ext);
> > > +
> > >   	event->header_size = size;
> > >   }
> > > @@ -6952,6 +6955,9 @@ void perf_output_sample(struct perf_output_handle *handle,
> > >   			perf_aux_sample_output(event, handle, data);
> > >   	}
> > > +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
> > > +		perf_output_put(handle, data->weight_ext);
> > > +
> > >   	if (!event->attr.watermark) {
> > >   		int wakeup_events = event->attr.wakeup_events;
> > 
> > This patch is broken and will expose uninitialized kernel stack.
> > 
> 
> Could we initialize the 'weight_ext' in perf_sample_data_init()?

No. Also see my other mail for why I hate this thing.
