Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DB2B5F58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKQMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQMrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:47:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6878E2222A;
        Tue, 17 Nov 2020 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605617265;
        bh=LDRjxIuvOrGemLa3ri/r8K8ShCCVuXGg/QrCt9a9g0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfcDGo+QZ6F42ngBAGRKF8Md9P8ZZHw5RBZ3D2/6Y7VX1np5EjazpZlslz57Ly6GB
         I54jtbFL/xTQidEv/QLF5lQprKnqRdG/lzG5VSLPExE4kK1RVhT0SMW1ioPaLtjewe
         1nHCVAB8HuciRxBLE6XevXM8pcUK5kjgiPhUhl7M=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4294640E29; Tue, 17 Nov 2020 09:47:43 -0300 (-03)
Date:   Tue, 17 Nov 2020 09:47:43 -0300
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
Subject: Re: [PATCH 15/24] perf tools: Synthesize build id for
 kernel/modules/tasks
Message-ID: <20201117124743.GQ614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-16-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-16-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 12:00:44PM +0100, Jiri Olsa escreveu:
> Adding build id to synthesized mmap2 events for
> everything - kernel/modules/tasks.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a18ae502d765..91b1962d399c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -347,6 +347,31 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  	}
>  }
>  
> +static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> +					     bool is_kernel)
> +{
> +	struct build_id bid;
> +	int rc;
> +
> +	if (is_kernel)
> +		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> +	else
> +		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> +
> +	if (rc == 0) {
> +		memcpy(event->build_id, bid.data, sizeof(bid.data));
> +		event->build_id_size = (u8) bid.size;
> +		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
> +		event->__reserved_1 = 0;
> +		event->__reserved_2 = 0;
> +	} else {
> +		if (event->filename[0] == '/') {
> +			pr_debug2("Failed to read build ID for %s\n",
> +				  event->filename);
> +		}
> +	}
> +}
> +
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       union perf_event *event,
>  				       pid_t pid, pid_t tgid,
> @@ -453,6 +478,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		event->mmap2.pid = tgid;
>  		event->mmap2.tid = pid;
>  
> +		if (symbol_conf.buildid_mmap2)
> +			perf_record_mmap2__read_build_id(&event->mmap2, false);

Ditto

>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
>  			break;
> @@ -630,6 +658,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  
>  			memcpy(event->mmap2.filename, pos->dso->long_name,
>  			       pos->dso->long_name_len + 1);
> +
> +			perf_record_mmap2__read_build_id(&event->mmap2, false);
>  		} else {
>  			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
>  			event->mmap.header.type = PERF_RECORD_MMAP;
> @@ -1050,6 +1080,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->mmap2.start = map->start;
>  		event->mmap2.len   = map->end - event->mmap.start;
>  		event->mmap2.pid   = machine->pid;
> +
> +		perf_record_mmap2__read_build_id(&event->mmap2, true);
>  	} else {
>  		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
>  				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
