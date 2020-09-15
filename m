Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767D26A516
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIOM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIOMYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:24:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F922078E;
        Tue, 15 Sep 2020 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600172685;
        bh=KeMkjvFdXhW96ouW5STtD1ivumL4a+JTdaMFckbG69w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTY7xsq0ig6H3TSH/7+tit2EbB5lDTv6Mf8Pj7+XySKh8iZAqZsF9oBH8lpGvg/kF
         a6dzmDd9+a5YauoriUVLyQTdiLRSI3jWyQnoirRGWUFYt0BIkYgRbUYJ6LVS3ryhzT
         EIxEyO2Ect7UFePUjx6YNzVNO7PYGO+5b8eo4hSI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0658440D3D; Tue, 15 Sep 2020 09:24:43 -0300 (-03)
Date:   Tue, 15 Sep 2020 09:24:42 -0300
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
Subject: Re: [PATCH 08/11] perf metric: Free metric when it failed to resolve
Message-ID: <20200915122442.GI720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-9-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-9-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:16PM +0900, Namhyung Kim escreveu:
> The metricgroup__add_metric() can find multiple match for a metric
> group and it's possible to fail.  Also it can fail in the middle like
> in resolve_metric() even for single metric.

Thanks, applied.

- Arnaldo

> 
> In those cases, the intermediate list and ids will be leaked like:
> 
>   Direct leak of 3 byte(s) in 1 object(s) allocated from:
>     #0 0x7f4c938f40b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
>     #1 0x55f7e71c1bef in __add_metric util/metricgroup.c:683
>     #2 0x55f7e71c31d0 in add_metric util/metricgroup.c:906
>     #3 0x55f7e71c3844 in metricgroup__add_metric util/metricgroup.c:940
>     #4 0x55f7e71c488d in metricgroup__add_metric_list util/metricgroup.c:993
>     #5 0x55f7e71c488d in parse_groups util/metricgroup.c:1045
>     #6 0x55f7e71c60a4 in metricgroup__parse_groups_test util/metricgroup.c:1087
>     #7 0x55f7e71235ae in __compute_metric tests/parse-metric.c:164
>     #8 0x55f7e7124650 in compute_metric tests/parse-metric.c:196
>     #9 0x55f7e7124650 in test_recursion_fail tests/parse-metric.c:318
>     #10 0x55f7e7124650 in test__parse_metric tests/parse-metric.c:356
>     #11 0x55f7e70be09b in run_test tests/builtin-test.c:410
>     #12 0x55f7e70be09b in test_and_print tests/builtin-test.c:440
>     #13 0x55f7e70c101a in __cmd_test tests/builtin-test.c:661
>     #14 0x55f7e70c101a in cmd_test tests/builtin-test.c:807
>     #15 0x55f7e7126214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
>     #16 0x55f7e6fc41a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
>     #17 0x55f7e6fc41a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
>     #18 0x55f7e6fc41a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
>     #19 0x7f4c93492cc9 in __libc_start_main ../csu/libc-start.c:308
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: 83de0b7d535de ("perf metric: Collect referenced metrics in struct metric_ref_node")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 53747df601fa..35bcaa8d11e9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -940,7 +940,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  
>  		ret = add_metric(&list, pe, metric_no_group, &m, NULL, &ids);
>  		if (ret)
> -			return ret;
> +			goto out;
>  
>  		/*
>  		 * Process any possible referenced metrics
> @@ -949,12 +949,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  		ret = resolve_metric(metric_no_group,
>  				     &list, map, &ids);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
>  
>  	/* End of pmu events. */
> -	if (!has_match)
> -		return -EINVAL;
> +	if (!has_match) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	list_for_each_entry(m, &list, nd) {
>  		if (events->len > 0)
> @@ -969,9 +971,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  		}
>  	}
>  
> +out:
> +	/*
> +	 * add to metric_list so that they can be released
> +	 * even if it's failed
> +	 */
>  	list_splice(&list, metric_list);
>  	expr_ids__exit(&ids);
> -	return 0;
> +	return ret;
>  }
>  
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
