Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC87F26A4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgIOL7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:59:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D808721D43;
        Tue, 15 Sep 2020 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600171111;
        bh=4AuBx4JHqQo3nAGsX8TsJEelIrU1veR457qm0hKhDJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5e7DoJjgpaHM5PtVykcXxtaCm66MkFlDUky/BUaZzr+JhjQBA2QzDzzuGqbpfXP4
         cPVddQb/zptnMTvKCQyMAVm3agS4wtXWxjEn2Hu5nczmkFlaMpBu+Wo2EISSEIbA03
         iMQh6gZCnY+DpAVGo8KB5TPNUxuDwt3ZVEtPZ6Qs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B96D40D3D; Tue, 15 Sep 2020 08:58:29 -0300 (-03)
Date:   Tue, 15 Sep 2020 08:58:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 01/11] perf metric: Fix some memory leaks
Message-ID: <20200915115828.GC720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:09PM +0900, Namhyung Kim escreveu:
> I found some memory leaks while reading the metric code.  Some are
> real and others only occur in the error path.  When it failed during
> metric or event parsing, it should release all resources properly.

Thanks, applied.

- Arnaldo
 
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index d03bac65a3c2..90d14c63babb 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -529,6 +529,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  						continue;
>  					strlist__add(me->metrics, s);
>  				}
> +
> +				if (!raw)
> +					free(s);
>  			}
>  			free(omg);
>  		}
> @@ -1041,7 +1044,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  	ret = metricgroup__add_metric_list(str, metric_no_group,
>  					   &extra_events, &metric_list, map);
>  	if (ret)
> -		return ret;
> +		goto out;
>  	pr_debug("adding %s\n", extra_events.buf);
>  	bzero(&parse_error, sizeof(parse_error));
>  	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
> @@ -1049,11 +1052,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  		parse_events_print_error(&parse_error, extra_events.buf);
>  		goto out;
>  	}
> -	strbuf_release(&extra_events);
>  	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
>  					perf_evlist, metric_events);
>  out:
>  	metricgroup__free_metrics(&metric_list);
> +	strbuf_release(&extra_events);
>  	return ret;
>  }
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
