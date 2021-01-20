Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C576B2FDC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbhATV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbhATVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611178543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jj+8p192ZV5ikw4sedPFVxEdRg+TWPKG/l+Q0ijiudo=;
        b=eonSsAwGG6hrpzecc3/6C7h85g5fW9RArsUHsaUyarI11wuuzeGWvyjWF+eFyu3Syx50Wn
        E7zEoLMavj7JSPpTOveFKhrBS7zE7JrisnPjS2h3+3hwI/YDxrfVzOzoIs+D5ukhWzKL9X
        OLcbGbDtYnDCG5D3c77C4Le/t6eqLSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-r0_bLIg7OUGIlvkJjc6Etw-1; Wed, 20 Jan 2021 16:35:41 -0500
X-MC-Unique: r0_bLIg7OUGIlvkJjc6Etw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1739010054FF;
        Wed, 20 Jan 2021 21:35:39 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 82D7B6E512;
        Wed, 20 Jan 2021 21:35:36 +0000 (UTC)
Date:   Wed, 20 Jan 2021 22:35:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH] perf metricgroup: Fix for metrics containing
 duration_time
Message-ID: <20210120213535.GB1798087@krava>
References: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:18:38AM +0800, John Garry wrote:
> Metrics containing duration_time cause a segfault:
> 
> $./perf stat -v -M L1D_Cache_Fill_BW sleep 1
> Using CPUID GenuineIntel-6-3D-4
> metric expr 64 * l1d.replacement / 1000000000 / duration_time for L1D_Cache_Fill_BW
> found event duration_time
> found event l1d.replacement
> adding {l1d.replacement}:W,duration_time
> l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
> Segmentation fault
> 
> In commit c2337d67199a ("perf metricgroup: Fix metrics using aliases
> covering multiple PMUs"), the logic in find_evsel_group() when iter'ing
> events was changed to not only select events in same group, but also for
> aliased PMUs.
> 
> Checking whether events were for aliased PMUs was done by comparing the
> event PMU name. This was not safe for duration_time event, which has no
> associated PMU (and no PMU name), so fix by checking if the event PMU name
> is set also.
> 
> Fixes: c2337d67199a ("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
> Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Tested/Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 2e60ee170abc..e6d3452031e5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -162,6 +162,14 @@ static bool contains_event(struct evsel **metric_events, int num_events,
>  	return false;
>  }
>  
> +static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
> +{
> +	if (!ev1->pmu_name || !ev2->pmu_name)
> +		return false;
> +
> +	return !strcmp(ev1->pmu_name, ev2->pmu_name);
> +}
> +
>  /**
>   * Find a group of events in perf_evlist that correspond to those from a parsed
>   * metric expression. Note, as find_evsel_group is called in the same order as
> @@ -280,8 +288,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  			 */
>  			if (!has_constraint &&
>  			    ev->leader != metric_events[i]->leader &&
> -			    !strcmp(ev->leader->pmu_name,
> -				    metric_events[i]->leader->pmu_name))
> +			    evsel_same_pmu(ev->leader, metric_events[i]->leader))
>  				break;
>  			if (!strcmp(metric_events[i]->name, ev->name)) {
>  				set_bit(ev->idx, evlist_used);
> -- 
> 2.26.2
> 

