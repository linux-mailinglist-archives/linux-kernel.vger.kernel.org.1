Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46D826C65B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgIPRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbgIPRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2FE222B7;
        Wed, 16 Sep 2020 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264488;
        bh=qKQqnxzRQxd/vr0zAdpm6sfQKn89rWwS4k5j1IwIQC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOR6F/G35l7Y5nJcVzTX20iL9YlsKqqfeVkp9nv8rPr+WPovGSKYRo3JCk8JSbrNL
         mzRRzKQrEH2cjlBX08WNE4bLLtXtehAfXbXWpCfldRt0k8WNOvO1cbbRTgnkXOxs9Z
         A5mU5NlO5Pri734moqVGX3xpmlvNaq1TkUnO4Q6Y=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09EE7400E9; Wed, 16 Sep 2020 10:54:46 -0300 (-03)
Date:   Wed, 16 Sep 2020 10:54:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     ak@linux.intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 RESEND] perf stat: Fix the ratio comments of
 miss-events
Message-ID: <20200916135445.GP720847@kernel.org>
References: <1600253331-10535-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600253331-10535-1-git-send-email-liuqi115@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 06:48:51PM +0800, Qi Liu escreveu:
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
> iTLB cache and LL-cache. Take L1-dcache for example, miss ratio is
> caculated as "L1-dcache-load-misses/L1-dcache-loads". So
> "of all L1-dcache hits" is unsuitable to describe it, and
> "of all L1-dcache accesses" seems better.
> 
> The comments of L1-icache, dTLB cache, iTLB cache and LL-cache are
> fixed in the same way.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/stat-shadow.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index e1ba6c1..ee3c404 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -517,7 +517,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> 
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);
>  }
> 
>  static void print_l1_icache_misses(struct perf_stat_config *config,
> @@ -538,7 +538,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache accesses", ratio);
>  }
> 
>  static void print_dtlb_cache_misses(struct perf_stat_config *config,
> @@ -558,7 +558,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache accesses", ratio);
>  }
> 
>  static void print_itlb_cache_misses(struct perf_stat_config *config,
> @@ -578,7 +578,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache accesses", ratio);
>  }
> 
>  static void print_ll_cache_misses(struct perf_stat_config *config,
> @@ -598,7 +598,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
>  }
> 
>  /*
> @@ -918,7 +918,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
>  			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
> @@ -928,7 +928,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
>  			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
> @@ -938,7 +938,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
>  			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
> @@ -948,7 +948,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
>  			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
> @@ -958,7 +958,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
>  			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
>  	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
>  		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
> 
> --
> 2.8.1
> 

-- 

- Arnaldo
