Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51A26A515
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIOMXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:23:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C032078E;
        Tue, 15 Sep 2020 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600172598;
        bh=vy90yMz9Sf3885UaPcDrJO12q12CgKKGk5zz8hawBTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOJcHOFP0D8sHs0bIiPmcQkpRioXKQ04eu5V5T34IpyHrrVqQI3H6p9A1iH/Pcrqt
         pSExonah5/yNW80VbB7QiTqbyey+mPIgL2S8IneAEeDdZUyLFaOH4jz6tp4Z2QgKsf
         igsMEMy5cZdAgJWho2uNKIOjxmpwJKrqbnKV2zG4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D80A540D3D; Tue, 15 Sep 2020 09:23:16 -0300 (-03)
Date:   Tue, 15 Sep 2020 09:23:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 06/11] perf test: Fix memory leaks in parse-metric test
Message-ID: <20200915122316.GG720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-7-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:14PM +0900, Namhyung Kim escreveu:
> It didn't release resources when there's an error so the
> test_recursion_fail() will leak some memory.

Thanks, applied.

- Arnaldo
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: 0a507af9c681a ("perf tests: Add parse metric test for ipc metric")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/parse-metric.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 23db8acc492d..cd7331aac3bd 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -153,8 +153,10 @@ static int __compute_metric(const char *name, struct value *vals,
>  		return -ENOMEM;
>  
>  	cpus = perf_cpu_map__new("0");
> -	if (!cpus)
> +	if (!cpus) {
> +		evlist__delete(evlist);
>  		return -ENOMEM;
> +	}
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, NULL);
>  
> @@ -163,10 +165,11 @@ static int __compute_metric(const char *name, struct value *vals,
>  					     false, false,
>  					     &metric_events);
>  	if (err)
> -		return err;
> +		goto out;
>  
> -	if (perf_evlist__alloc_stats(evlist, false))
> -		return -1;
> +	err = perf_evlist__alloc_stats(evlist, false);
> +	if (err)
> +		goto out;
>  
>  	/* Load the runtime stats with given numbers for events. */
>  	runtime_stat__init(&st);
> @@ -178,13 +181,14 @@ static int __compute_metric(const char *name, struct value *vals,
>  	if (name2 && ratio2)
>  		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
>  
> +out:
>  	/* ... clenup. */
>  	metricgroup__rblist_exit(&metric_events);
>  	runtime_stat__exit(&st);
>  	perf_evlist__free_stats(evlist);
>  	perf_cpu_map__put(cpus);
>  	evlist__delete(evlist);
> -	return 0;
> +	return err;
>  }
>  
>  static int compute_metric(const char *name, struct value *vals, double *ratio)
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
