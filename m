Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B257B2B5F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKQMom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQMol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:44:41 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EC822203;
        Tue, 17 Nov 2020 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605617080;
        bh=6ZPOxKQN7EfoEKtx0si1zr5srH8ZGaPNaNtUAepHEEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csuMErfks4eN5jKlRXEV1mTFIQZ6/9ELdix9VvaxRl8HMlZ6Ypv1zxY2FsETVNZOP
         qWqlAwKTkm7lD83Wvc+z+7JUov6w/9tZpYy7bEpv+T59d6xVMtuQGy4NSf18QcorHr
         F/nY0YIc2AXQnWcYS5f+udKAxCuPmRH1ZOArcGrM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D5C9440E29; Tue, 17 Nov 2020 09:44:37 -0300 (-03)
Date:   Tue, 17 Nov 2020 09:44:37 -0300
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
Subject: Re: [PATCH 13/24] perf tools: Allow mmap2 event to synthesize kernel
 image
Message-ID: <20201117124437.GO614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-14-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-14-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 12:00:42PM +0100, Jiri Olsa escreveu:
> Allow mmap2 event to synthesize kernel image,
> so we can synthesize kernel build id data in
> following changes.
> 
> It's enabled by new symbol_conf.buildid_mmap2
> bool, which will be switched in following
> changes.

Why make this an option? MMAP2 goes back years:

13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  904)      * The MMAP2 records are an augmented version of MMAP, they add
13d7a2410fa637f45 (Stephane Eranian         2013-08-21 12:10:24 +0200  905)      * maj, min, ino numbers to be used to uniquely identify each mapping

Also we unconditionally generate MMAP2 events if the kernel supports it,
from evsel__config():

  attr->mmap  = track;
  attr->mmap2 = track && !perf_missing_features.mmap2;

So perhaps we should reuse that logic? I.e. use mmap2 if the kernel
supports it?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/symbol_conf.h      |  3 ++-
>  tools/perf/util/synthetic-events.c | 40 ++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index b916afb95ec5..b18f9c8dbb75 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -42,7 +42,8 @@ struct symbol_conf {
>  			report_block,
>  			report_individual_block,
>  			inline_name,
> -			disable_add2line_warn;
> +			disable_add2line_warn,
> +			buildid_mmap2;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 8a23391558cf..872df6d6dbef 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -988,11 +988,12 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  						perf_event__handler_t process,
>  						struct machine *machine)
>  {
> -	size_t size;
> +	union perf_event *event;
> +	size_t size = symbol_conf.buildid_mmap2 ?
> +			sizeof(event->mmap2) : sizeof(event->mmap);
>  	struct map *map = machine__kernel_map(machine);
>  	struct kmap *kmap;
>  	int err;
> -	union perf_event *event;
>  
>  	if (map == NULL)
>  		return -1;
> @@ -1006,7 +1007,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  	 * available use this, and after it is use this as a fallback for older
>  	 * kernels.
>  	 */
> -	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
> +	event = zalloc(size + machine->id_hdr_size);
>  	if (event == NULL) {
>  		pr_debug("Not enough memory synthesizing mmap event "
>  			 "for kernel modules\n");
> @@ -1023,16 +1024,29 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
>  	}
>  
> -	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
> -			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> -	size = PERF_ALIGN(size, sizeof(u64));
> -	event->mmap.header.type = PERF_RECORD_MMAP;
> -	event->mmap.header.size = (sizeof(event->mmap) -
> -			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
> -	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
> -	event->mmap.start = map->start;
> -	event->mmap.len   = map->end - event->mmap.start;
> -	event->mmap.pid   = machine->pid;
> +	if (symbol_conf.buildid_mmap2) {
> +		size = snprintf(event->mmap2.filename, sizeof(event->mmap2.filename),
> +				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> +		size = PERF_ALIGN(size, sizeof(u64));
> +		event->mmap2.header.type = PERF_RECORD_MMAP2;
> +		event->mmap2.header.size = (sizeof(event->mmap2) -
> +				(sizeof(event->mmap2.filename) - size) + machine->id_hdr_size);
> +		event->mmap2.pgoff = kmap->ref_reloc_sym->addr;
> +		event->mmap2.start = map->start;
> +		event->mmap2.len   = map->end - event->mmap.start;
> +		event->mmap2.pid   = machine->pid;
> +	} else {
> +		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
> +				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> +		size = PERF_ALIGN(size, sizeof(u64));
> +		event->mmap.header.type = PERF_RECORD_MMAP;
> +		event->mmap.header.size = (sizeof(event->mmap) -
> +				(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
> +		event->mmap.pgoff = kmap->ref_reloc_sym->addr;
> +		event->mmap.start = map->start;
> +		event->mmap.len   = map->end - event->mmap.start;
> +		event->mmap.pid   = machine->pid;
> +	}
>  
>  	err = perf_tool__process_synth_event(tool, event, machine, process);
>  	free(event);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
