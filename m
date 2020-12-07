Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67A2D177D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLGRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgLGRX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:23:57 -0500
Date:   Mon, 7 Dec 2020 14:23:19 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607361792;
        bh=YrqZt2cDoscNlEkZs4KxklqlELsS6ZtXkd5YDE69okg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=eliy9dGroa3le3PI/eDyWHKT6OBCSNVvMYpNcKkkgMihQiuaCIwVmiofvI+LJBqBv
         mniHhRirQuBUXbhWEQSI07KCafa3zW6NcT/PrzJyoydKfmboogdFeUeqqwdwMAwQNt
         rKT2LK4BushosHMZZywwQIfmrpvHRal5ET330n0Tq7aimXi66xztmM7UqogVvqCmvc
         wdh1u4CSPFvhbfr77718F/SAtvVV67sTOaH1av9dhCGJpClUooFG149W2occxgkaXY
         isr6yptLUiUGBzkkUO7ZoFb4KjNeTDCLPiNcBNeamlS7LbQ5mFPVzBC/KJjlRB1FeZ
         kGdwVwZfa/eQA==
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
Subject: Re: [PATCH v6 08/10] perf metricgroup: Support printing metric
 groups for system PMUs
Message-ID: <20201207172319.GD129853@kernel.org>
References: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
 <1607080216-36968-9-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607080216-36968-9-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 04, 2020 at 07:10:14PM +0800, John Garry escreveu:
> Currently printing metricgroups for core- or uncore-based events matched
> by CPUID is supported.
> 
> Extend this for system events.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/metricgroup.c | 64 ++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4c6a686b08eb..abc5d0e28d0f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -559,6 +559,49 @@ static int metricgroup__print_pmu_event(struct pmu_event *pe,
>  	return 0;
>  }
>  
> +struct metricgroup_print_sys_idata {
> +	struct strlist *metriclist;
> +	bool metricgroups;
> +	char *filter;
> +	bool raw;
> +	bool details;
> +	struct rblist *groups;
> +};

I'm doing some reorg to avoid these holes:

[acme@five perf]$ pahole -C metricgroup_print_sys_idata ~/bin/perf
struct metricgroup_print_sys_idata {
	struct strlist *           metriclist;           /*     0     8 */
	_Bool                      metricgroups;         /*     8     1 */

	/* XXX 7 bytes hole, try to pack */

	char *                     filter;               /*    16     8 */
	_Bool                      raw;                  /*    24     1 */
	_Bool                      details;              /*    25     1 */

	/* XXX 6 bytes hole, try to pack */

	struct rblist *            groups;               /*    32     8 */

	/* size: 40, cachelines: 1, members: 6 */
	/* sum members: 27, holes: 2, sum holes: 13 */
	/* last cacheline: 40 bytes */
};
[acme@five perf]$

It ended up as:

[acme@five perf]$ pahole -C metricgroup_print_sys_idata ~/bin/perf
struct metricgroup_print_sys_idata {
	struct strlist *           metriclist;           /*     0     8 */
	char *                     filter;               /*     8     8 */
	struct rblist *            groups;               /*    16     8 */
	_Bool                      metricgroups;         /*    24     1 */
	_Bool                      raw;                  /*    25     1 */
	_Bool                      details;              /*    26     1 */

	/* size: 32, cachelines: 1, members: 6 */
	/* padding: 5 */
	/* last cacheline: 32 bytes */
};
[acme@five perf]$o

- Arnaldo

> +typedef int (*metricgroup_sys_event_iter_fn)(struct pmu_event *pe, void *);
> +
> +struct metricgroup_iter_data {
> +	metricgroup_sys_event_iter_fn fn;
> +	void *data;
> +};
> +
> +static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
> +{
> +	struct metricgroup_iter_data *d = data;
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (!pe->metric_expr || !pe->compat)
> +		return 0;
> +
> +	while ((pmu = perf_pmu__scan(pmu))) {
> +
> +		if (!pmu->id || strcmp(pmu->id, pe->compat))
> +			continue;
> +
> +		return d->fn(pe, d->data);
> +	}
> +
> +	return 0;
> +}
> +
> +static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
> +{
> +	struct metricgroup_print_sys_idata *d = data;
> +
> +	return metricgroup__print_pmu_event(pe, d->metricgroups, d->filter, d->raw,
> +				     d->details, d->groups, d->metriclist);
> +}
> +
>  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			bool raw, bool details)
>  {
> @@ -569,9 +612,6 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  	struct rb_node *node, *next;
>  	struct strlist *metriclist = NULL;
>  
> -	if (!map)
> -		return;
> -
>  	if (!metricgroups) {
>  		metriclist = strlist__new(NULL, NULL);
>  		if (!metriclist)
> @@ -582,7 +622,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  	groups.node_new = mep_new;
>  	groups.node_cmp = mep_cmp;
>  	groups.node_delete = mep_delete;
> -	for (i = 0; ; i++) {
> +	for (i = 0; map; i++) {
>  		pe = &map->table[i];
>  
>  		if (!pe->name && !pe->metric_group && !pe->metric_name)
> @@ -595,6 +635,22 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			return;
>  	}
>  
> +	{
> +		struct metricgroup_iter_data data = {
> +			.fn = metricgroup__print_sys_event_iter,
> +			.data = (void *) &(struct metricgroup_print_sys_idata){
> +				.metriclist = metriclist,
> +				.metricgroups = metricgroups,
> +				.filter = filter,
> +				.raw = raw,
> +				.details = details,
> +				.groups = &groups,
> +			},
> +		};
> +
> +		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
> +	}
> +
>  	if (!filter || !rblist__empty(&groups)) {
>  		if (metricgroups && !raw)
>  			printf("\nMetric Groups:\n\n");
> -- 
> 2.26.2
> 

-- 

- Arnaldo
