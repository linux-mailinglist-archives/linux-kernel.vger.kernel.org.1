Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79C26E6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIQU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgIQU0N (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:26:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C247C2075B;
        Thu, 17 Sep 2020 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600374371;
        bh=Apet6Xy+GAEbCZkhykzJz6AAtIpO+b1s+wRIPXrGvQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjbFK/DYMK1wcvMHRHVkGd2fAwC021AfPk6LSd/N5uJDdvSZOfakxZxOcJW9oc/vr
         HlwZrm1om5bQ5zZUyr9xrE/6e5z/H6frm6DO2ceOXBhibgpdGOIQaIoj14yt8fXk2F
         L58q04YxtmEuKQ5WexcprO4F53N3imPRziURparU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA134400E9; Thu, 17 Sep 2020 17:26:08 -0300 (-03)
Date:   Thu, 17 Sep 2020 17:26:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 7/7] perf diff: Support hot streams comparison
Message-ID: <20200917202608.GF1431236@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-8-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080353.13359-8-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 04:03:53PM +0800, Jin Yao escreveu:
> This patch enables perf-diff with "--stream" option.
> 
> "--stream": Enable hot streams comparison
> 
> Now let's see examples.
> 
> perf record -b ...      Generate perf.data.old with branch data
> perf record -b ...      Generate perf.data with branch data
> perf diff --stream
> 
> [ Matched hot streams ]
> 
> hot chain pair 1:
>             cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
>         ---------------------------              --------------------------
>                       main div.c:39                           main div.c:39
>                       main div.c:44                           main div.c:44
> 
> hot chain pair 2:
>            cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
>         ---------------------------              --------------------------
>           __random_r random_r.c:360               __random_r random_r.c:360

Would it be interesting to get the associated source code and show right below
these file:number lines?

- Arnaldo

>           __random_r random_r.c:388               __random_r random_r.c:388
>           __random_r random_r.c:388               __random_r random_r.c:388
>           __random_r random_r.c:380               __random_r random_r.c:380
>           __random_r random_r.c:357               __random_r random_r.c:357
>               __random random.c:293                   __random random.c:293
>               __random random.c:293                   __random random.c:293
>               __random random.c:291                   __random random.c:291
>               __random random.c:291                   __random random.c:291
>               __random random.c:291                   __random random.c:291
>               __random random.c:288                   __random random.c:288
>                      rand rand.c:27                          rand rand.c:27
>                      rand rand.c:26                          rand rand.c:26
>                            rand@plt                                rand@plt
>                            rand@plt                                rand@plt
>               compute_flag div.c:25                   compute_flag div.c:25
>               compute_flag div.c:22                   compute_flag div.c:22
>                       main div.c:40                           main div.c:40
>                       main div.c:40                           main div.c:40
>                       main div.c:39                           main div.c:39
> 
> hot chain pair 3:
>              cycles: 9, hits: 4.48%                  cycles: 6, hits: 4.51%
>         ---------------------------              --------------------------
>           __random_r random_r.c:360               __random_r random_r.c:360
>           __random_r random_r.c:388               __random_r random_r.c:388
>           __random_r random_r.c:388               __random_r random_r.c:388
>           __random_r random_r.c:380               __random_r random_r.c:380
> 
> [ Hot streams in old perf data only ]
> 
> hot chain 1:
>             cycles: 18, hits: 6.75%
>          --------------------------
>           __random_r random_r.c:360
>           __random_r random_r.c:388
>           __random_r random_r.c:388
>           __random_r random_r.c:380
>           __random_r random_r.c:357
>               __random random.c:293
>               __random random.c:293
>               __random random.c:291
>               __random random.c:291
>               __random random.c:291
>               __random random.c:288
>                      rand rand.c:27
>                      rand rand.c:26
>                            rand@plt
>                            rand@plt
>               compute_flag div.c:25
>               compute_flag div.c:22
>                       main div.c:40
> 
> hot chain 2:
>             cycles: 29, hits: 2.78%
>          --------------------------
>               compute_flag div.c:22
>                       main div.c:40
>                       main div.c:40
>                       main div.c:39
> 
> [ Hot streams in new perf data only ]
> 
> hot chain 1:
>                                                      cycles: 4, hits: 4.54%
>                                                  --------------------------
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
> hot chain 2:
>                                                      cycles: 5, hits: 3.51%
>                                                  --------------------------
>                                                               main div.c:39
>                                                               main div.c:44
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v6:
>    - Rebase to perf/core
> 
>  v5:
>    - Remove enum stream_type
>    - Rebase to perf/core
> 
>  v4:
>    - Remove the "--before" and "--after" options since they are for
>      source line based comparison. In this patchset, we will not
>      support source line based comparison.
> 
>  tools/perf/Documentation/perf-diff.txt |   4 +
>  tools/perf/builtin-diff.c              | 133 ++++++++++++++++++++++---
>  2 files changed, 124 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
> index f50ca0fef0a4..be65bd55ab2a 100644
> --- a/tools/perf/Documentation/perf-diff.txt
> +++ b/tools/perf/Documentation/perf-diff.txt
> @@ -182,6 +182,10 @@ OPTIONS
>  --tid=::
>  	Only diff samples for given thread ID (comma separated list).
>  
> +--stream::
> +	Enable hot streams comparison. Stream can be a callchain which is
> +	aggregated by the branch records from samples.
> +
>  COMPARISON
>  ----------
>  The comparison is governed by the baseline file. The baseline perf.data
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index f8c9bdd8269a..d6db473cd010 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -25,6 +25,7 @@
>  #include "util/map.h"
>  #include "util/spark.h"
>  #include "util/block-info.h"
> +#include "util/stream.h"
>  #include <linux/err.h>
>  #include <linux/zalloc.h>
>  #include <subcmd/pager.h>
> @@ -42,6 +43,7 @@ struct perf_diff {
>  	int				 range_size;
>  	int				 range_num;
>  	bool				 has_br_stack;
> +	bool				 stream;
>  };
>  
>  /* Diff command specific HPP columns. */
> @@ -72,6 +74,8 @@ struct data__file {
>  	struct perf_data	 data;
>  	int			 idx;
>  	struct hists		*hists;
> +	struct evsel_streams	*evsel_streams;
> +	int			 nr_evsel_streams;
>  	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
>  };
>  
> @@ -106,6 +110,7 @@ enum {
>  	COMPUTE_DELTA_ABS,
>  	COMPUTE_CYCLES,
>  	COMPUTE_MAX,
> +	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
>  };
>  
>  const char *compute_names[COMPUTE_MAX] = {
> @@ -393,6 +398,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
>  	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
>  	struct addr_location al;
>  	struct hists *hists = evsel__hists(evsel);
> +	struct hist_entry_iter iter = {
> +		.evsel	= evsel,
> +		.sample	= sample,
> +		.ops	= &hist_iter_normal,
> +	};
>  	int ret = -1;
>  
>  	if (perf_time__ranges_skip_sample(pdiff->ptime_range, pdiff->range_num,
> @@ -411,14 +421,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
>  		goto out_put;
>  	}
>  
> -	if (compute != COMPUTE_CYCLES) {
> -		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
> -				      true)) {
> -			pr_warning("problem incrementing symbol period, "
> -				   "skipping event\n");
> -			goto out_put;
> -		}
> -	} else {
> +	switch (compute) {
> +	case COMPUTE_CYCLES:
>  		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
>  					  NULL, NULL, sample, true)) {
>  			pr_warning("problem incrementing symbol period, "
> @@ -428,6 +432,23 @@ static int diff__process_sample_event(struct perf_tool *tool,
>  
>  		hist__account_cycles(sample->branch_stack, &al, sample, false,
>  				     NULL);
> +		break;
> +
> +	case COMPUTE_STREAM:
> +		if (hist_entry_iter__add(&iter, &al, PERF_MAX_STACK_DEPTH,
> +					 NULL)) {
> +			pr_debug("problem adding hist entry, skipping event\n");
> +			goto out_put;
> +		}
> +		break;
> +
> +	default:
> +		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
> +				      true)) {
> +			pr_warning("problem incrementing symbol period, "
> +				   "skipping event\n");
> +			goto out_put;
> +		}
>  	}
>  
>  	/*
> @@ -996,6 +1017,50 @@ static void data_process(void)
>  	}
>  }
>  
> +static int process_base_stream(struct data__file *data_base,
> +			       struct data__file *data_pair,
> +			       const char *title __maybe_unused)
> +{
> +	struct evlist *evlist_base = data_base->session->evlist;
> +	struct evlist *evlist_pair = data_pair->session->evlist;
> +	struct evsel *evsel_base, *evsel_pair;
> +	struct evsel_streams *es_base, *es_pair;
> +
> +	evlist__for_each_entry(evlist_base, evsel_base) {
> +		evsel_pair = evsel_match(evsel_base, evlist_pair);
> +		if (!evsel_pair)
> +			continue;
> +
> +		es_base = evsel_streams_get(data_base->evsel_streams,
> +					    data_base->nr_evsel_streams,
> +					    evsel_base->idx);
> +		if (!es_base)
> +			return -1;
> +
> +		es_pair = evsel_streams_get(data_pair->evsel_streams,
> +					    data_pair->nr_evsel_streams,
> +					    evsel_pair->idx);
> +		if (!es_pair)
> +			return -1;
> +
> +		match_evsel_streams(es_base, es_pair);
> +		evsel_streams_report(es_base, es_pair);
> +	}
> +
> +	return 0;
> +}
> +
> +static void stream_process(void)
> +{
> +	/*
> +	 * Stream comparison only supports two data files.
> +	 * perf.data.old and perf.data. data__files[0] is perf.data.old,
> +	 * data__files[1] is perf.data.
> +	 */
> +	process_base_stream(&data__files[0], &data__files[1],
> +			    "# Output based on old perf data:\n#\n");
> +}
> +
>  static void data__free(struct data__file *d)
>  {
>  	int col;
> @@ -1109,6 +1174,18 @@ static int check_file_brstack(void)
>  	return 0;
>  }
>  
> +static struct evsel_streams *create_evsel_streams(struct evlist *evlist,
> +						  int nr_streams_max,
> +						  int *nr_evsel_streams)
> +{
> +	struct evsel_streams *es;
> +
> +	es = perf_evlist__create_streams(evlist, nr_streams_max);
> +	*nr_evsel_streams = evlist->core.nr_entries;
> +
> +	return es;
> +}
> +
>  static int __cmd_diff(void)
>  {
>  	struct data__file *d;
> @@ -1153,9 +1230,21 @@ static int __cmd_diff(void)
>  
>  		if (pdiff.ptime_range)
>  			zfree(&pdiff.ptime_range);
> +
> +		if (compute == COMPUTE_STREAM) {
> +			d->evsel_streams = create_evsel_streams(
> +						d->session->evlist,
> +						5,
> +						&d->nr_evsel_streams);
> +			if (!d->evsel_streams)
> +				goto out_delete;
> +		}
>  	}
>  
> -	data_process();
> +	if (compute == COMPUTE_STREAM)
> +		stream_process();
> +	else
> +		data_process();
>  
>   out_delete:
>  	data__for_each_file(i, d) {
> @@ -1228,6 +1317,8 @@ static const struct option options[] = {
>  		   "only consider symbols in these pids"),
>  	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
>  		   "only consider symbols in these tids"),
> +	OPT_BOOLEAN(0, "stream", &pdiff.stream,
> +		    "Enable hot streams comparison."),
>  	OPT_END()
>  };
>  
> @@ -1887,6 +1978,9 @@ int cmd_diff(int argc, const char **argv)
>  	if (cycles_hist && (compute != COMPUTE_CYCLES))
>  		usage_with_options(diff_usage, options);
>  
> +	if (pdiff.stream)
> +		compute = COMPUTE_STREAM;
> +
>  	symbol__annotation_init();
>  
>  	if (symbol__init(NULL) < 0)
> @@ -1898,13 +1992,26 @@ int cmd_diff(int argc, const char **argv)
>  	if (check_file_brstack() < 0)
>  		return -1;
>  
> -	if (compute == COMPUTE_CYCLES && !pdiff.has_br_stack)
> +	if ((compute == COMPUTE_CYCLES || compute == COMPUTE_STREAM)
> +	    && !pdiff.has_br_stack) {
>  		return -1;
> +	}
>  
> -	if (ui_init() < 0)
> -		return -1;
> +	if (compute == COMPUTE_STREAM) {
> +		symbol_conf.show_branchflag_count = true;
> +		symbol_conf.disable_add2line_warn = true;
> +		callchain_param.mode = CHAIN_FLAT;
> +		callchain_param.key = CCKEY_SRCLINE;
> +		callchain_param.branch_callstack = 1;
> +		symbol_conf.use_callchain = true;
> +		callchain_register_param(&callchain_param);
> +		sort_order = "srcline,symbol,dso";
> +	} else {
> +		if (ui_init() < 0)
> +			return -1;
>  
> -	sort__mode = SORT_MODE__DIFF;
> +		sort__mode = SORT_MODE__DIFF;
> +	}
>  
>  	if (setup_sorting(NULL) < 0)
>  		usage_with_options(diff_usage, options);
> -- 
> 2.17.1
> 

-- 

- Arnaldo
