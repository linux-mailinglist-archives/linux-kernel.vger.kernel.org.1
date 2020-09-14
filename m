Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D37269123
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgINQIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:08:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984A12074B;
        Mon, 14 Sep 2020 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099680;
        bh=9DjOq0KtDBR+vlWjDmQydd3einrzIMs1/vQH7vVaniA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgeOskVN3uAiZa/YHfZ73FG7p7jb/kYEfLcUR8/xJSxUYIZUbFvkzbjL6vYJ7Uo0t
         CBxEf9o4IIun6YY+81n+VEvEosERW+Pb10Ie9wcYXEIcYsRXS/aw+n5JDN7y0lrq5B
         9e18J45y+RYzQnHDXMC33EOVzc28a4gNmhHXiOhk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACF3440D3D; Mon, 14 Sep 2020 13:07:58 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:07:58 -0300
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
Subject: Re: [PATCH 16/26] perf tools: Synthesize modules with mmap3
Message-ID: <20200914160758.GK160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-17-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:03:03PM +0200, Jiri Olsa escreveu:
> Synthesizing modules with mmap3 events so we can
> get build id data for module's maps as well.

Ditto as for 15/26
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 37 +++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index bd6e7b84283d..6bd2423ce2f3 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -605,7 +605,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  	int rc = 0;
>  	struct map *pos;
>  	struct maps *maps = machine__kernel_maps(machine);
> -	union perf_event *event = zalloc((sizeof(event->mmap) +
> +	union perf_event *event = zalloc((sizeof(event->mmap3) +
>  					  machine->id_hdr_size));
>  	if (event == NULL) {
>  		pr_debug("Not enough memory synthesizing mmap event "
> @@ -613,8 +613,6 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  		return -1;
>  	}
>  
> -	event->header.type = PERF_RECORD_MMAP;
> -
>  	/*
>  	 * kernel uses 0 for user space maps, see kernel/perf_event.c
>  	 * __perf_event_mmap
> @@ -631,17 +629,30 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  			continue;
>  
>  		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> -		event->mmap.header.type = PERF_RECORD_MMAP;
> -		event->mmap.header.size = (sizeof(event->mmap) -
> -				        (sizeof(event->mmap.filename) - size));
> -		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
> -		event->mmap.header.size += machine->id_hdr_size;
> -		event->mmap.start = pos->start;
> -		event->mmap.len   = pos->end - pos->start;
> -		event->mmap.pid   = machine->pid;
> -
> -		memcpy(event->mmap.filename, pos->dso->long_name,
> +		event->mmap3.header.type = PERF_RECORD_MMAP3;
> +		event->mmap3.header.size = (sizeof(event->mmap3) -
> +					   (sizeof(event->mmap3.filename) - size));
> +		memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
> +		event->mmap3.header.size += machine->id_hdr_size;
> +		event->mmap3.start = pos->start;
> +		event->mmap3.len   = pos->end - pos->start;
> +		event->mmap3.pid   = machine->pid;
> +
> +		memcpy(event->mmap3.filename, pos->dso->long_name,
>  		       pos->dso->long_name_len + 1);
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
> +
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
>  			break;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
