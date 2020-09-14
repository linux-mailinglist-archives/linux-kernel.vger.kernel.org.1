Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B3269129
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgINQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgINQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:08:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223E620715;
        Mon, 14 Sep 2020 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099696;
        bh=CWHXWAocNcGLO4AHayYtfc64U7QGTbBoqSWHR+p5jB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmrRg1zeMNMnekbolZ6hxaaSargI6yZx0PJTlBTkIh2SqNOfQfgAAxJWRhjlwk/qN
         P04YfphTBlp4QdgVI9Kho6bdka3aD4P9V3mu6oS9VVBl9mfhKkvriDs7Rum9i0UFrl
         iIDEC0afwNiP81A10Eet43mIt/gmc3XQOqODkt7Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33B1D40D3D; Mon, 14 Sep 2020 13:08:14 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:08:14 -0300
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
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 17/26] perf tools: Synthesize kernel with mmap3
Message-ID: <20200914160814.GL160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-18-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-18-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:03:04PM +0200, Jiri Olsa escreveu:
> Synthesizing kernel with mmap3 events so we can
> get build id data for kernel map as well.

Ditto as for 15/26
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 6bd2423ce2f3..844ca87b6e97 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1029,7 +1029,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  	 * available use this, and after it is use this as a fallback for older
>  	 * kernels.
>  	 */
> -	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
> +	event = zalloc((sizeof(event->mmap3) + machine->id_hdr_size));
>  	if (event == NULL) {
>  		pr_debug("Not enough memory synthesizing mmap event "
>  			 "for kernel modules\n");
> @@ -1046,16 +1046,21 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
>  	}
>  
> -	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
> +	size = snprintf(event->mmap3.filename, sizeof(event->mmap3.filename),
>  			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
>  	size = PERF_ALIGN(size, sizeof(u64));
> -	event->mmap.header.type = PERF_RECORD_MMAP;
> -	event->mmap.header.size = (sizeof(event->mmap) -
> -			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
> -	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
> -	event->mmap.start = map->start;
> -	event->mmap.len   = map->end - event->mmap.start;
> -	event->mmap.pid   = machine->pid;
> +	event->mmap3.header.type = PERF_RECORD_MMAP3;
> +	event->mmap3.header.size = (sizeof(event->mmap3) -
> +			(sizeof(event->mmap3.filename) - size) + machine->id_hdr_size);
> +	event->mmap3.pgoff = kmap->ref_reloc_sym->addr;
> +	event->mmap3.start = map->start;
> +	event->mmap3.len   = map->end - event->mmap3.start;
> +	event->mmap3.pid   = machine->pid;
> +
> +	err = sysfs__read_build_id("/sys/kernel/notes", event->mmap3.buildid,
> +				   BUILD_ID_SIZE);
> +	if (err)
> +		pr_err("Failed to read kernel build ID\n");
>  
>  	err = perf_tool__process_synth_event(tool, event, machine, process);
>  	free(event);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
