Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB02D1766
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLGRTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLGRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:19:46 -0500
Date:   Mon, 7 Dec 2020 14:19:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607361545;
        bh=aRRSbhbaOPTitCqGejFML/VNFmqB7WcW2a9n25/6z0E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8uh5XOoX0uZc8G/SiyTBG3mITtKYfbkqBYC/Sq03Coc/Au7H9UM7f7BLZY9pSX+m
         /sfuClt0cJXCmpHG2JnxNAxlEojUotjUDUIC3m11DRS0R4IfakA/o4glkzyfHWDuxJ
         JzxfihB7GJeenY6EbVmyhAcdO1o7EKRS6dBbkjJNp0fHk8+tLfVH9D865cnzYt6off
         zVSC10TN9I1A2M0o1opXTyy5le3VTdhHT7IvVJvFeKpiDR1PGtHKjdAINtyL4DqZD+
         Jd5cu0O/AAtkDyvWf3GNQtU1+Zl3ItPxsf+ppaTgL8f6pEdZLuwvsfZjabfjtzPf6h
         13gMjyjZRKQwQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, irogers@google.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, kan.liang@linux.intel.com,
        kim.phillips@amd.com, ak@linux.intel.com
Subject: Re: [PATCH v6 06/10] perf metricgroup: Fix metrics using aliases
 covering multiple PMUs
Message-ID: <20201207171914.GC129853@kernel.org>
References: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
 <1607080216-36968-7-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607080216-36968-7-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 04, 2020 at 07:10:12PM +0800, John Garry escreveu:
> Support for metric expressions using aliases which cover multiple PMUs is
> broken. Consider the following test metric expression:
> 
> "MetricExpr": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE * UNC_CBO_XSNP_RESPONSE.MISS_EVICTION"
> 
> When used on my broadwell, "perf stat" gives:
> 
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_1/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_0/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_1/umask=0x41,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_0/umask=0x41,event=0x22/
> Control descriptor is not initialized
> unc_cbo_xsnp_response.miss_eviction: 3645925 1000850523 1000850523
> unc_cbo_xsnp_response.miss_xcore: 106850 1000850523 1000850523
> 
>  Performance counter stats for 'system wide':
> 
>          3,645,925      unc_cbo_xsnp_response.miss_eviction # 389567086250.00 test_metric_inc
>            106,850      unc_cbo_xsnp_response.miss_xcore
> 
>        1.000883096 seconds time elapsed
> 
> 
> Notice that only the results from one PMU are included. Fix the logic of
> find_evsel_group() to enable events which apply to multiple PMUs, by
> checking if the event pmu_name matches that of the metric event.
> 
> With that, "perf stat" now gives:
> 
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_1/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_0/umask=0x81,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_1/umask=0x41,event=0x22/
> unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_0/umask=0x41,event=0x22/
> Control descriptor is not initialized
> unc_cbo_xsnp_response.miss_eviction: 4237983 1000904100 1000904100
> unc_cbo_xsnp_response.miss_xcore: 218643 1000904100 1000904100
> unc_cbo_xsnp_response.miss_eviction: 4254148 1000902629 1000902629
> unc_cbo_xsnp_response.miss_xcore: 213352 1000902629 1000902629
> 
>  Performance counter stats for 'system wide':
> 
>          4,237,983      unc_cbo_xsnp_response.miss_eviction # 3668558131345.00 test_metric_inc
>            218,643      unc_cbo_xsnp_response.miss_xcore
>          4,254,148      unc_cbo_xsnp_response.miss_eviction
>            213,352      unc_cbo_xsnp_response.miss_xcore
> 
>        1.000938151 seconds time elapsed
> 

Next time please try to provides a Fixes: tag to help with
backporting/stable@kernel.org work.

- Arnaldo
 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/metricgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 81d201c8b833..b89160718c04 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -279,7 +279,9 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  			 * when then group is left.
>  			 */
>  			if (!has_constraint &&
> -			    ev->leader != metric_events[i]->leader)
> +			    ev->leader != metric_events[i]->leader &&
> +			    !strcmp(ev->leader->pmu_name,
> +				    metric_events[i]->leader->pmu_name))
>  				break;
>  			if (!strcmp(metric_events[i]->name, ev->name)) {
>  				set_bit(ev->idx, evlist_used);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
