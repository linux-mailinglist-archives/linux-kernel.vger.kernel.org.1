Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74C2FDD94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbhAUAER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732265AbhATVnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611178940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COxpx4NsY7+uBOYfKBklDTrDOfUCle1rtfah8ncuYHw=;
        b=fl9rP7fIFShk/44CYZXi9DTbq0uV3JxC3lgauPje4MFSb5J9fHHxSLc+yqwUgUGUmwlQYj
        bOoYWZ5ZkqgfY0X1+xq03eL5UZ9Oxpf2Fauyy6jjJeUWFanv6HETJkW62Z5IMJwDcQJFhf
        de0xpixyYbQBmR2SbKPbWoh+Ou3cQig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-5TbaO_6tOemohvTa11_4NQ-1; Wed, 20 Jan 2021 16:42:19 -0500
X-MC-Unique: 5TbaO_6tOemohvTa11_4NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6F38066E5;
        Wed, 20 Jan 2021 21:42:17 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F02F6E512;
        Wed, 20 Jan 2021 21:42:14 +0000 (UTC)
Date:   Wed, 20 Jan 2021 22:42:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
Message-ID: <20210120214213.GC1798087@krava>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:04:15PM +0800, John Garry wrote:
> Joakim reports that getting "perf stat" for multiple system PMU metrics
> segfaults:
> ./perf stat -a -I 1000 -M imx8mm_ddr_write.all,imx8mm_ddr_write.all
> Segmentation fault
> 
> While the same works without issue for a single metric.
> 
> The logic in metricgroup__add_metric_sys_event_iter() is broken, in that
> add_metric() @m argument should be NULL for each new metric. Fix by not
> passing a holder for that, and rather make local in
> metricgroup__add_metric_sys_event_iter().
> 
> Fixes: be335ec28efa ("perf metricgroup: Support adding metrics for system PMUs")
> Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ee94d3e8dd65..2e60ee170abc 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -766,7 +766,6 @@ int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
>  struct metricgroup_add_iter_data {
>  	struct list_head *metric_list;
>  	const char *metric;
> -	struct metric **m;
>  	struct expr_ids *ids;
>  	int *ret;
>  	bool *has_match;
> @@ -1058,12 +1057,13 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
>  						  void *data)
>  {
>  	struct metricgroup_add_iter_data *d = data;
> +	struct metric *m = NULL;
>  	int ret;
>  
>  	if (!match_pe_metric(pe, d->metric))
>  		return 0;
>  
> -	ret = add_metric(d->metric_list, pe, d->metric_no_group, d->m, NULL, d->ids);
> +	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
>  	if (ret)
>  		return ret;
>  
> @@ -1114,7 +1114,6 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				.metric_list = &list,
>  				.metric = metric,
>  				.metric_no_group = metric_no_group,
> -				.m = &m,
>  				.ids = &ids,
>  				.has_match = &has_match,
>  				.ret = &ret,
> -- 
> 2.26.2
> 

