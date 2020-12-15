Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFEF2DAFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgLOPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgLOPR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:17:28 -0500
Date:   Tue, 15 Dec 2020 12:17:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608045407;
        bh=vjAkZoPCLgdnug0Tj64jgJdbPsrYvR3AK7ldotdTSgA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHkDecmXpvExZ6zfejK2wAXERmgeUaO01KEAbmqyGrC2YIlMQ1zTbDijUs9fWircu
         NJsX7uMgN/vC3ueR6dDuUQMcMLFSESZwe7GxOrN6a3iDWzSG+91o5IYCngMeRVUXkN
         Q4DBItLv5x3krrh6FAEy4UbN+u1xoMBfXnw2VqGUf/0ohyOzIqLI48WtrM6+S6HCz3
         GMZN4VCAzPi8w85V/Arg/k90mKOm/NUhrmIpgQQWS33YJvfRO6VHn8Q9OVLr/cDGfu
         cWVVcy5oCGrAqPAZHudHz8dyB0tpOnCxxDV86SFXMvXvpO3T2wfJyL9CN8xuM0HKrL
         l7nPrQXczm65A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf tools: Add
 evlist__disable_evsel/evlist__enable_evsel
Message-ID: <20201215151700.GF252952@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210204330.233864-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 09:43:28PM +0100, Jiri Olsa escreveu:
> Adding interface to enable/disable single event in the
> evlist based on its name. It will be used later in new
> control enable/disable interface.
> 
> Keeping the evlist::enabled true when one or more events
> are enabled so the toggle can work properly and toggle
> evlist to disabled state.


Thanks, applied.

- Arnaldo

 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Alexei Budankov <abudankov@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evlist.c | 69 ++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evlist.h |  2 ++
>  2 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 493819173a8e..70aff26612a9 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -370,7 +370,30 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
>  	return true;
>  }
>  
> -void evlist__disable(struct evlist *evlist)
> +static int evsel__strcmp(struct evsel *pos, char *evsel_name)
> +{
> +	if (!evsel_name)
> +		return 0;
> +	if (evsel__is_dummy_event(pos))
> +		return 1;
> +	return strcmp(pos->name, evsel_name);
> +}
> +
> +static int evlist__is_enabled(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (!evsel__is_group_leader(pos) || !pos->core.fd)
> +			continue;
> +		/* If at least one event is enabled, evlist is enabled. */
> +		if (!pos->disabled)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  {
>  	struct evsel *pos;
>  	struct affinity affinity;
> @@ -386,6 +409,8 @@ void evlist__disable(struct evlist *evlist)
>  			affinity__set(&affinity, cpu);
>  
>  			evlist__for_each_entry(evlist, pos) {
> +				if (evsel__strcmp(pos, evsel_name))
> +					continue;
>  				if (evsel__cpu_iter_skip(pos, cpu))
>  					continue;
>  				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> @@ -403,15 +428,34 @@ void evlist__disable(struct evlist *evlist)
>  
>  	affinity__cleanup(&affinity);
>  	evlist__for_each_entry(evlist, pos) {
> +		if (evsel__strcmp(pos, evsel_name))
> +			continue;
>  		if (!evsel__is_group_leader(pos) || !pos->core.fd)
>  			continue;
>  		pos->disabled = true;
>  	}
>  
> -	evlist->enabled = false;
> +	/*
> +	 * If we disabled only single event, we need to check
> +	 * the enabled state of the evlist manually.
> +	 */
> +	if (evsel_name)
> +		evlist->enabled = evlist__is_enabled(evlist);
> +	else
> +		evlist->enabled = false;
> +}
> +
> +void evlist__disable(struct evlist *evlist)
> +{
> +	__evlist__disable(evlist, NULL);
> +}
> +
> +void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
> +{
> +	__evlist__disable(evlist, evsel_name);
>  }
>  
> -void evlist__enable(struct evlist *evlist)
> +static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>  {
>  	struct evsel *pos;
>  	struct affinity affinity;
> @@ -424,6 +468,8 @@ void evlist__enable(struct evlist *evlist)
>  		affinity__set(&affinity, cpu);
>  
>  		evlist__for_each_entry(evlist, pos) {
> +			if (evsel__strcmp(pos, evsel_name))
> +				continue;
>  			if (evsel__cpu_iter_skip(pos, cpu))
>  				continue;
>  			if (!evsel__is_group_leader(pos) || !pos->core.fd)
> @@ -433,14 +479,31 @@ void evlist__enable(struct evlist *evlist)
>  	}
>  	affinity__cleanup(&affinity);
>  	evlist__for_each_entry(evlist, pos) {
> +		if (evsel__strcmp(pos, evsel_name))
> +			continue;
>  		if (!evsel__is_group_leader(pos) || !pos->core.fd)
>  			continue;
>  		pos->disabled = false;
>  	}
>  
> +	/*
> +	 * Even single event sets the 'enabled' for evlist,
> +	 * so the toggle can work properly and toggle to
> +	 * 'disabled' state.
> +	 */
>  	evlist->enabled = true;
>  }
>  
> +void evlist__enable(struct evlist *evlist)
> +{
> +	__evlist__enable(evlist, NULL);
> +}
> +
> +void evlist__enable_evsel(struct evlist *evlist, char *evsel_name)
> +{
> +	__evlist__enable(evlist, evsel_name);
> +}
> +
>  void evlist__toggle_enable(struct evlist *evlist)
>  {
>  	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 9b0c795736bb..1aae75895dea 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -186,6 +186,8 @@ size_t evlist__mmap_size(unsigned long pages);
>  void evlist__disable(struct evlist *evlist);
>  void evlist__enable(struct evlist *evlist);
>  void evlist__toggle_enable(struct evlist *evlist);
> +void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
> +void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
>  
>  int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx);
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
