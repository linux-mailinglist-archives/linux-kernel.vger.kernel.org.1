Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760D627563B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIWKXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgIWKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600856588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnhZ1p8MPUWNhHhmu91uoAEGZXibovEmFTnT+gcwC+M=;
        b=QHVmYaTEgbsGHbTfbO/572LIARTPF2x68yzv6vx6dyl68L13QekEKBjWmFFGggjR9fByKX
        LMaQJWskpiTBhRJ7MY8fFYMvJNOBqfKhAJSOaCDhqAuOfjaeaGf2swCdwtJrdvohVBTdub
        AvUGVzt1UIqOZmNmsNF65F/aNgx7BfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-QPRawwAFMz-l4cPXkxpLTA-1; Wed, 23 Sep 2020 06:23:03 -0400
X-MC-Unique: QPRawwAFMz-l4cPXkxpLTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD8641084C8A;
        Wed, 23 Sep 2020 10:23:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD4EA55783;
        Wed, 23 Sep 2020 10:22:57 +0000 (UTC)
Date:   Wed, 23 Sep 2020 12:22:56 +0200
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
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand
 cgroups
Message-ID: <20200923102256.GI2893484@krava>
References: <20200923015945.47535-1-namhyung@kernel.org>
 <20200923015945.47535-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923015945.47535-4-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:59:43AM +0900, Namhyung Kim wrote:

SNIP

  
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 8b6a4fa49082..dcd18ef268a1 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -3,6 +3,9 @@
>  #include "evsel.h"
>  #include "cgroup.h"
>  #include "evlist.h"
> +#include "rblist.h"
> +#include "metricgroup.h"
> +#include "stat.h"
>  #include <linux/zalloc.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -193,10 +196,12 @@ int parse_cgroups(const struct option *opt, const char *str,
>  	return 0;
>  }
>  
> -int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> +int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> +			  struct rblist *metric_events)
>  {
>  	struct evlist *orig_list, *tmp_list;
>  	struct evsel *pos, *evsel, *leader;
> +	struct rblist orig_metric_events;
>  	struct cgroup *cgrp = NULL;
>  	const char *p, *e, *eos = str + strlen(str);
>  	int ret = -1;
> @@ -216,6 +221,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  	/* save original events and init evlist */
>  	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
>  	evlist->core.nr_entries = 0;
> +	orig_metric_events = *metric_events;
> +	rblist__init(metric_events);
>  
>  	for (;;) {
>  		p = strchr(str, ',');
> @@ -255,6 +262,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  		cgroup__put(cgrp);
>  		nr_cgroups++;
>  
> +		perf_stat__collect_metric_expr(tmp_list);

I know you added the option just for perf stat, not record,
but the code looks generic apart from using this function

I wonder if this would cause any issues if it was called in record
context.. maybe we could just skip it in that case, but that's for
future to worry about ;-)

jirka

> +		if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
> +						    &orig_metric_events) < 0)
> +			break;
> +
>  		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
>  		tmp_list->core.nr_entries = 0;
>  
> @@ -268,6 +280,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  out_err:
>  	evlist__delete(orig_list);
>  	evlist__delete(tmp_list);
> +	rblist__exit(&orig_metric_events);
>  
>  	return ret;
>  }

SNIP

