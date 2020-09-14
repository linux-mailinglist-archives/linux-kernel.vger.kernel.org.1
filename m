Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384D4269125
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgINQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgINQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:07:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899C720715;
        Mon, 14 Sep 2020 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099660;
        bh=X5qUsJMV6ViE0MaAC/O/nIMEKU5hu/C3oimsVa+PEiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlHOyv2XntNxUdfhJOLn2sIHES6gxl1dF9JBh7sDGqZRFMZnqvgYjSovbfJsQRyGk
         oQ81WP7/F6b5TbfIiGLPGxy3vzTp20xdZYH6Y5Ku4kl9pLbFXaHLsSRUoLHoG52OX+
         ohIz0DWNE8IbBWKj4tlEZZPDErxkcKTaZA/eBeh0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A023140D3D; Mon, 14 Sep 2020 13:07:38 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:07:38 -0300
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
Subject: Re: [PATCH 15/26] perf tools: Synthesize proc tasks with mmap3
Message-ID: <20200914160738.GJ160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-16-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-16-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:03:02PM +0200, Jiri Olsa escreveu:
> Synthesizing proc tasks with mmap3 events so we can
> get build id data for synthesized maps as well.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/mmap.c             |  2 +-
>  tools/perf/util/synthetic-events.c | 72 +++++++++++++++++-------------
>  2 files changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..51f6f86580a9 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -33,7 +33,7 @@ void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
>  
>  	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
>  	buf[len] = '\0';
> -	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
> +	pr_debug2("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
>  }

Can this be in a separate patch?
  
>  size_t mmap__mmap_len(struct mmap *map)
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 89b390623b63..bd6e7b84283d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -379,7 +379,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	}
>  	io__init(&io, io.fd, bf, sizeof(bf));
>  
> -	event->header.type = PERF_RECORD_MMAP2;
> +	event->header.type = PERF_RECORD_MMAP3;

This also needs to check if the user is interested in build-id records.
If it is disabled, then using this new tool with mmap3 support will
generate perf.data files that will bot be grokked by older tools,
introducing an annoyance for people not interested in build-ids.

- Arnaldo

>  	t = rdclock();
>  
>  	while (!io.eof) {
> @@ -387,20 +387,20 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		size_t size;
>  
>  		/* ensure null termination since stack will be reused. */
> -		event->mmap2.filename[0] = '\0';
> +		event->mmap3.filename[0] = '\0';
>  
>  		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
>  		if (!read_proc_maps_line(&io,
> -					&event->mmap2.start,
> -					&event->mmap2.len,
> -					&event->mmap2.prot,
> -					&event->mmap2.flags,
> -					&event->mmap2.pgoff,
> -					&event->mmap2.maj,
> -					&event->mmap2.min,
> -					&event->mmap2.ino,
> -					sizeof(event->mmap2.filename),
> -					event->mmap2.filename))
> +					&event->mmap3.start,
> +					&event->mmap3.len,
> +					&event->mmap3.prot,
> +					&event->mmap3.flags,
> +					&event->mmap3.pgoff,
> +					&event->mmap3.maj,
> +					&event->mmap3.min,
> +					&event->mmap3.ino,
> +					sizeof(event->mmap3.filename),
> +					event->mmap3.filename))
>  			continue;
>  
>  		if ((rdclock() - t) > timeout) {
> @@ -412,7 +412,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  			goto out;
>  		}
>  
> -		event->mmap2.ino_generation = 0;
> +		event->mmap3.ino_generation = 0;
>  
>  		/*
>  		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
> @@ -422,8 +422,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		else
>  			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
>  
> -		if ((event->mmap2.prot & PROT_EXEC) == 0) {
> -			if (!mmap_data || (event->mmap2.prot & PROT_READ) == 0)
> +		if ((event->mmap3.prot & PROT_EXEC) == 0) {
> +			if (!mmap_data || (event->mmap3.prot & PROT_READ) == 0)
>  				continue;
>  
>  			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
> @@ -433,25 +433,37 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		if (truncation)
>  			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
>  
> -		if (!strcmp(event->mmap2.filename, ""))
> -			strcpy(event->mmap2.filename, anonstr);
> +		if (!strcmp(event->mmap3.filename, ""))
> +			strcpy(event->mmap3.filename, anonstr);
>  
>  		if (hugetlbfs_mnt_len &&
> -		    !strncmp(event->mmap2.filename, hugetlbfs_mnt,
> +		    !strncmp(event->mmap3.filename, hugetlbfs_mnt,
>  			     hugetlbfs_mnt_len)) {
> -			strcpy(event->mmap2.filename, anonstr);
> -			event->mmap2.flags |= MAP_HUGETLB;
> +			strcpy(event->mmap3.filename, anonstr);
> +			event->mmap3.flags |= MAP_HUGETLB;
>  		}
>  
> -		size = strlen(event->mmap2.filename) + 1;
> +		size = strlen(event->mmap3.filename) + 1;
>  		size = PERF_ALIGN(size, sizeof(u64));
> -		event->mmap2.len -= event->mmap.start;
> -		event->mmap2.header.size = (sizeof(event->mmap2) -
> -					(sizeof(event->mmap2.filename) - size));
> -		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
> -		event->mmap2.header.size += machine->id_hdr_size;
> -		event->mmap2.pid = tgid;
> -		event->mmap2.tid = pid;
> +		event->mmap3.len -= event->mmap.start;
> +		event->mmap3.header.size = (sizeof(event->mmap3) -
> +					(sizeof(event->mmap3.filename) - size));
> +		memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
> +		event->mmap3.header.size += machine->id_hdr_size;
> +		event->mmap3.pid = tgid;
> +		event->mmap3.tid = pid;
> +
> +		rc = filename__read_build_id(event->mmap3.filename, event->mmap3.buildid,
> +					     BUILD_ID_SIZE);
> +		if (rc != BUILD_ID_SIZE) {
> +			if (event->mmap3.filename[0] == '/') {
> +				pr_debug2("Failed to read build ID for %s\n",
> +					  event->mmap3.filename);
> +			}
> +			memset(event->mmap3.buildid, 0x0, sizeof(event->mmap3.buildid));
> +		}
> +
> +		rc = 0;
>  
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
> @@ -744,7 +756,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  	if (comm_event == NULL)
>  		goto out;
>  
> -	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
> +	mmap_event = malloc(sizeof(mmap_event->mmap3) + machine->id_hdr_size);
>  	if (mmap_event == NULL)
>  		goto out_free_comm;
>  
> @@ -826,7 +838,7 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
>  	if (comm_event == NULL)
>  		goto out;
>  
> -	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
> +	mmap_event = malloc(sizeof(mmap_event->mmap3) + machine->id_hdr_size);
>  	if (mmap_event == NULL)
>  		goto out_free_comm;
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
