Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44926FF45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIRN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgIRN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3feYbRX5RF30aYeydKYF7mV0YVysGFrSM26kIF+cdg=;
        b=fRAnDMH4Ah6bRHVIVPGdavBFaK4KkvtBzu3A5QH7tC1fImca2e4SCMC4daItvvPXlV4W4h
        IJPiCLS+pY9/9/KYpzv8cDch2HyoXDO//kdYlFaUT8HZea5gjIrUZeloKh7xgBCbruVtdC
        kD5FlTnHAavmZ8E+OzjROvStpObtzIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-iIapkWVhP4aTLzlHnAiGCw-1; Fri, 18 Sep 2020 09:57:29 -0400
X-MC-Unique: iIapkWVhP4aTLzlHnAiGCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9EC1007B2B;
        Fri, 18 Sep 2020 13:57:27 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 787F41C4;
        Fri, 18 Sep 2020 13:57:22 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:57:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        guohanjun@huawei.com
Subject: Re: [PATCH v2] perf metric: Code cleanup with map_for_each_event()
Message-ID: <20200918135721.GE2626435@krava>
References: <20200918012948.2798-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918012948.2798-1-liwei391@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:29:48AM +0800, Wei Li wrote:
> Since we have introduced map_for_each_event() to walk the 'pmu_events_map',
> clean up metricgroup__print() and metricgroup__has_metric() with it.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> v1 -> v2:
>  - Move map_for_each_metric() after match_metric() to avoid potential
>    use-before-declare.
> ---
>  tools/perf/util/metricgroup.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..50ee36437b99 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -374,6 +374,17 @@ static bool match_metric(const char *n, const char *list)
>  	return false;
>  }
>  
> +#define map_for_each_event(__pe, __idx, __map)				\
> +	for (__idx = 0, __pe = &__map->table[__idx];			\
> +	     __pe->name || __pe->metric_group || __pe->metric_name;	\
> +	     __pe = &__map->table[++__idx])
> +
> +#define map_for_each_metric(__pe, __idx, __map, __metric)		\
> +	map_for_each_event(__pe, __idx, __map)				\
> +		if (__pe->metric_expr &&				\
> +		    (match_metric(__pe->metric_group, __metric) ||	\
> +		     match_metric(__pe->metric_name, __metric)))
> +
>  struct mep {
>  	struct rb_node nd;
>  	const char *name;
> @@ -475,12 +486,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  	groups.node_new = mep_new;
>  	groups.node_cmp = mep_cmp;
>  	groups.node_delete = mep_delete;
> -	for (i = 0; ; i++) {
> +	map_for_each_event(pe, i, map) {
>  		const char *g;
> -		pe = &map->table[i];
>  
> -		if (!pe->name && !pe->metric_group && !pe->metric_name)
> -			break;
>  		if (!pe->metric_expr)
>  			continue;
>  		g = pe->metric_group;
> @@ -745,17 +753,6 @@ static int __add_metric(struct list_head *metric_list,
>  	return 0;
>  }
>  
> -#define map_for_each_event(__pe, __idx, __map)				\
> -	for (__idx = 0, __pe = &__map->table[__idx];			\
> -	     __pe->name || __pe->metric_group || __pe->metric_name;	\
> -	     __pe = &__map->table[++__idx])
> -
> -#define map_for_each_metric(__pe, __idx, __map, __metric)		\
> -	map_for_each_event(__pe, __idx, __map)				\
> -		if (__pe->metric_expr &&				\
> -		    (match_metric(__pe->metric_group, __metric) ||	\
> -		     match_metric(__pe->metric_name, __metric)))
> -
>  static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>  {
>  	struct pmu_event *pe;
> @@ -1092,11 +1089,7 @@ bool metricgroup__has_metric(const char *metric)
>  	if (!map)
>  		return false;
>  
> -	for (i = 0; ; i++) {
> -		pe = &map->table[i];
> -
> -		if (!pe->name && !pe->metric_group && !pe->metric_name)
> -			break;
> +	map_for_each_event(pe, i, map) {
>  		if (!pe->metric_expr)
>  			continue;
>  		if (match_metric(pe->metric_name, metric))
> -- 
> 2.17.1
> 

