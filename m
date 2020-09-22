Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F8274B28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVV3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIVV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600810180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaWmfPeTbSi5Xi2IJBVYjUfMBBPnX2Y5Cvqqoyho9Yk=;
        b=CFBPPm3H0R0nBiXvnaAxOAm20PY/Ggjo8I/l7RbLnwefnGsN4fKxpVIVKOsGZ02MqM3D0K
        P1VWO6PCphsPO58OkbCSQP4ZFm5xZRnvYL8L1IZLb7VjCc+Z65ywtXIb9gpBslIPv5OmvN
        T4VCxbclOxDczBQ3TeZN42OdIqDTDns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Yoa8UgupMt2KHhiLXlQEnw-1; Tue, 22 Sep 2020 17:29:38 -0400
X-MC-Unique: Yoa8UgupMt2KHhiLXlQEnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04A0E1006704;
        Tue, 22 Sep 2020 21:29:35 +0000 (UTC)
Received: from krava (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4DE9C1A923;
        Tue, 22 Sep 2020 21:29:32 +0000 (UTC)
Date:   Tue, 22 Sep 2020 23:29:31 +0200
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
Message-ID: <20200922212931.GC2893484@krava>
References: <20200921094610.83736-1-namhyung@kernel.org>
 <20200921094610.83736-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921094610.83736-4-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:46:08PM +0900, Namhyung Kim wrote:

SNIP

> @@ -260,6 +267,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  		cgroup__put(cgrp);
>  		nr_cgroups++;
>  
> +		perf_stat__collect_metric_expr(tmp_list);
> +		if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
> +						    &orig_metric_events) < 0)
> +			break;
> +
>  		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
>  		tmp_list->core.nr_entries = 0;
>  
> @@ -273,6 +285,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
>  out_err:
>  	evlist__delete(orig_list);
>  	evlist__delete(tmp_list);
> +	rblist__exit(&orig_metric_events);
>  
>  	return ret;
>  }
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index 32893018296f..eea6df8ee373 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -22,9 +22,11 @@ struct cgroup *cgroup__get(struct cgroup *cgroup);
>  void cgroup__put(struct cgroup *cgroup);
>  
>  struct evlist;
> +struct rblist;
>  
>  struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
> -int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups);
> +int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
> +			  struct rblist *metric_events);
>  
>  void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index ee7b576d3b12..424209c4bcd2 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1964,3 +1964,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  
>  	return err;
>  }
> +
> +struct evsel *evlist__get_evsel(struct evlist *evlist, int idx)

perhaps evlist__find_evsel is better name?
we have get/put names for functions changing refcount 

jirka

> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel->idx == idx)
> +			return evsel;
> +	}
> +	return NULL;
> +}

SNIP

