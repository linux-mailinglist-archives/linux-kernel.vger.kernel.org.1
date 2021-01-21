Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B12FEB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbhAUNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbhAUNUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:20:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B817B239FD;
        Thu, 21 Jan 2021 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611235144;
        bh=qlsgW6MriineoglnlGwXZodZ3LqSP+Ls/AUzSM/FQwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lusvUkxjdudNJ+JxNF58XWQBraDQfdjQpm1l9fT3D1S+ZOPQQHuV5mujOIFSKxC4i
         gQW8SuxiwagubDOOoaUD2hVVFS4U5JeefehLLymbveyn4pB0/9ezfqEndIyEMAFAFp
         Xmf6/h3t/2/k0IrjYSr4v9y4tuKGmTK7IgAY4RysiEirRZsOFp4813046G8GxFocfS
         /jpYe6kKQs4F9tJBxm4BPbjVARS+79cZSLzoIDYO3H05AghCM9Lij4E98I9dAF/P1X
         +gMKDt8Te3hNINefEaMS8z06oZjuGRp88cL393SDA+Z+gnX+RpzKCRY88FK+fYB/ad
         L4+o49Sqd2Xjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D14240513; Thu, 21 Jan 2021 10:19:01 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:19:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Jin@vger.kernel.org, Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf evlist: Fix id index for heterogeneous systems
Message-ID: <20210121131901.GA345740@kernel.org>
References: <20210121125446.11287-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121125446.11287-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 21, 2021 at 02:54:46PM +0200, Adrian Hunter escreveu:
> perf_evlist__set_sid_idx() updates perf_sample_id with the evlist map
> index, cpu number and tid. It is passed indexes to the evsel's cpu and
> thread maps, but references the evlist's maps instead. That results in
> using incorrect cpu numbers on heterogeneous systems. Fix by using evsel
> maps.
> 
> The id index (PERF_RECORD_ID_INDEX) is used by AUX area tracing when in
> sampling mode. Having an incorrect cpu number causes the trace data to
> be attributed to the wrong cpu, and can result in decoder errors because
> the trace data is then associated with the wrong process.

Can you please provide a Fixes: tag so that the stable@kernel.org guys
can apply where appropriate?

Thanks,

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index cfcdbd7be066..37be8042889f 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -367,21 +367,13 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
>  	return map;
>  }
>  
> -static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
> -				     struct perf_evsel *evsel, int idx, int cpu,
> -				     int thread)
> +static void set_sid_idx(struct perf_evsel *evsel, int idx, int cpu, int thread)
>  {
>  	struct perf_sample_id *sid = SID(evsel, cpu, thread);
>  
>  	sid->idx = idx;
> -	if (evlist->cpus && cpu >= 0)
> -		sid->cpu = evlist->cpus->map[cpu];
> -	else
> -		sid->cpu = -1;
> -	if (!evsel->system_wide && evlist->threads && thread >= 0)
> -		sid->tid = perf_thread_map__pid(evlist->threads, thread);
> -	else
> -		sid->tid = -1;
> +	sid->cpu = perf_cpu_map__cpu(evsel->cpus, cpu);
> +	sid->tid = perf_thread_map__pid(evsel->threads, thread);
>  }
>  
>  static struct perf_mmap*
> @@ -500,8 +492,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
>  						   fd) < 0)
>  				return -1;
> -			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
> -						 thread);
> +			set_sid_idx(evsel, idx, cpu, thread);
>  		}
>  	}
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
