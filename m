Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260672B5F55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgKQMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:46:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD462222A;
        Tue, 17 Nov 2020 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605617214;
        bh=w2JRgA1Ne8LerPp1nVhszfic7yCVQyHfDY/SgatFze8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPXygCEQ7JuNIx+1R6rEVW2osfuZBDkuWBAsgBTkKvy62cviNGS1CnRur1YkeQYQ1
         LxQc9BUQHiqeM9HOVm1rCv4rsqqDTio6UhZz3ZtHF3PRErpLjRtClv21VUF0OytTyK
         d3e3H4ZP8QAmgMsN35GK+WLlWwVcHHXIQ7/iRmzg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AFB140E29; Tue, 17 Nov 2020 09:46:52 -0300 (-03)
Date:   Tue, 17 Nov 2020 09:46:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 14/24] perf tools: Allow mmap2 event to synthesize modules
Message-ID: <20201117124652.GP614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-15-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-15-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 12:00:43PM +0100, Jiri Olsa escreveu:
> Allow mmap2 event to synthesize kernel modules,
> so we can synthesize module's build id data in
> following changes.
> 
> It's enabled by new symbol_conf.buildid_mmap2
> bool, which will be switched in following
> changes.

Ditto as for the kernel mmap event, don't we do this probing before
generating the synthetic events? If not perhaps we should, to avoid
synthesizing things and then failing on creating the events? If we do it
that way, we can switch from symbol_conf.buildid_mmap2 to
!perf_missing_features.mmap2.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 872df6d6dbef..a18ae502d765 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -593,16 +593,17 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  	int rc = 0;
>  	struct map *pos;
>  	struct maps *maps = machine__kernel_maps(machine);
> -	union perf_event *event = zalloc((sizeof(event->mmap) +
> -					  machine->id_hdr_size));
> +	union perf_event *event;
> +	size_t size = symbol_conf.buildid_mmap2 ?
> +			sizeof(event->mmap2) : sizeof(event->mmap);
> +
> +	event = zalloc(size + machine->id_hdr_size);
>  	if (event == NULL) {
>  		pr_debug("Not enough memory synthesizing mmap event "
>  			 "for kernel modules\n");
>  		return -1;
>  	}
>  
> -	event->header.type = PERF_RECORD_MMAP;
> -
>  	/*
>  	 * kernel uses 0 for user space maps, see kernel/perf_event.c
>  	 * __perf_event_mmap
> @@ -613,23 +614,37 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
>  
>  	maps__for_each_entry(maps, pos) {
> -		size_t size;
> -
>  		if (!__map__is_kmodule(pos))
>  			continue;
>  
> -		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> -		event->mmap.header.type = PERF_RECORD_MMAP;
> -		event->mmap.header.size = (sizeof(event->mmap) -
> -				        (sizeof(event->mmap.filename) - size));
> -		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
> -		event->mmap.header.size += machine->id_hdr_size;
> -		event->mmap.start = pos->start;
> -		event->mmap.len   = pos->end - pos->start;
> -		event->mmap.pid   = machine->pid;
> +		if (symbol_conf.buildid_mmap2) {
> +			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> +			event->mmap2.header.type = PERF_RECORD_MMAP2;
> +			event->mmap2.header.size = (sizeof(event->mmap2) -
> +						(sizeof(event->mmap2.filename) - size));
> +			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
> +			event->mmap2.header.size += machine->id_hdr_size;
> +			event->mmap2.start = pos->start;
> +			event->mmap2.len   = pos->end - pos->start;
> +			event->mmap2.pid   = machine->pid;
> +
> +			memcpy(event->mmap2.filename, pos->dso->long_name,
> +			       pos->dso->long_name_len + 1);
> +		} else {
> +			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> +			event->mmap.header.type = PERF_RECORD_MMAP;
> +			event->mmap.header.size = (sizeof(event->mmap) -
> +						(sizeof(event->mmap.filename) - size));
> +			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
> +			event->mmap.header.size += machine->id_hdr_size;
> +			event->mmap.start = pos->start;
> +			event->mmap.len   = pos->end - pos->start;
> +			event->mmap.pid   = machine->pid;
> +
> +			memcpy(event->mmap.filename, pos->dso->long_name,
> +			       pos->dso->long_name_len + 1);
> +		}
>  
> -		memcpy(event->mmap.filename, pos->dso->long_name,
> -		       pos->dso->long_name_len + 1);
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
>  			break;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
