Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C07278985
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgIYN0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728171AbgIYN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:26:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601040406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaVnHYsDmisf0bqkKvlUV1x00eXwat3z5IqNZVOlGIs=;
        b=jF0ktyicJEB3YQtzB7XqSGPUhp420tJbnEMwGoGl0e4e0KVYTrR0LGRtBCFO1Rzw3jR9a2
        EOAew2FrtJts7YFkSTbkUOQTjFgB4vosFDCvh3grByRQnID5CSotoGmDyggWXwzvlM6m8K
        rwNg3mRM3kpXp1cqkT00HNsK/+NVKrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-WosOhRk2MbW1X-_OkIiHLQ-1; Fri, 25 Sep 2020 09:26:42 -0400
X-MC-Unique: WosOhRk2MbW1X-_OkIiHLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FDF6805EEE;
        Fri, 25 Sep 2020 13:26:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77AEB7882B;
        Fri, 25 Sep 2020 13:26:37 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:26:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand
 cgroups
Message-ID: <20200925132636.GB3273770@krava>
References: <20200924124455.336326-1-namhyung@kernel.org>
 <20200924124455.336326-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124455.336326-4-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:44:53PM +0900, Namhyung Kim wrote:

SNIP

>  
> +	if (metric_events) {
> +		orig_metric_events = *metric_events;
> +		rblist__init(metric_events);
> +	} else {
> +		rblist__init(&orig_metric_events);
> +	}
> +
>  	for (;;) {
>  		p = strchr(str, ',');
>  		e = p ? p : eos;
> @@ -255,6 +267,14 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  		cgroup__put(cgrp);
>  		nr_cgroups++;
>  
> +		if (metric_events) {
> +			perf_stat__collect_metric_expr(tmp_list);
> +			if (metricgroup__copy_metric_events(tmp_list, cgrp,
> +							    metric_events,
> +							    &orig_metric_events) < 0)
> +				break;
> +		}

looks good, do you plan to actualy add support for record?
my ack from last version stays

thanks,
jirka

