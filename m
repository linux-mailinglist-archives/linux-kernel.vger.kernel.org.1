Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A3426FF25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIRNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIRNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyLeNICZKUOdxW6O8Crk1E2+QvWRpR1oTA6iWPg+TXo=;
        b=IMAa/SKPwMKajQMg//krE45noLlRGv/mJVZTxEH0dQVw+MOrMuG2gKVIJQNKlZ67Rvqn5D
        /R8TukIazn0khW5yCXId9VR132gwo887B5MDqTJ+Ks1k7Qe3qY8UdQ/l/G1opLUUpzzzwr
        rZQhAXY6o4rJsrRBZoMyT5M6BgbpaJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-9DB6R4cSNcmtFXZFanCpYQ-1; Fri, 18 Sep 2020 09:51:58 -0400
X-MC-Unique: 9DB6R4cSNcmtFXZFanCpYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C698B7842;
        Fri, 18 Sep 2020 13:51:25 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED6633782;
        Fri, 18 Sep 2020 13:51:21 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:51:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 4/4] perf test: Add expand cgroup event test
Message-ID: <20200918135120.GD2626435@krava>
References: <20200916063129.1061487-1-namhyung@kernel.org>
 <20200916063129.1061487-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916063129.1061487-5-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:31:29PM +0900, Namhyung Kim wrote:

SNIP

> +++ b/tools/perf/tests/tests.h
> @@ -123,6 +123,7 @@ const char *test__pfm_subtest_get_desc(int subtest);
>  int test__pfm_subtest_get_nr(void);
>  int test__parse_metric(struct test *test, int subtest);
>  int test__pe_file_parsing(struct test *test, int subtest);
> +int test__expand_cgroup_events(struct test *test, int subtest);
>  
>  bool test__bp_signal_is_supported(void);
>  bool test__bp_account_is_supported(void);
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index a1bf345a770b..eeffa08251b5 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -52,7 +52,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
>  	return NULL;
>  }


could you please put the do_open change below into separate patch?

thanks,
jirka

>  
> -static struct cgroup *cgroup__new(const char *name)
> +static struct cgroup *cgroup__new(const char *name, bool do_open)
>  {
>  	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
>  
> @@ -62,9 +62,14 @@ static struct cgroup *cgroup__new(const char *name)
>  		cgroup->name = strdup(name);
>  		if (!cgroup->name)
>  			goto out_err;
> -		cgroup->fd = open_cgroup(name);
> -		if (cgroup->fd == -1)
> -			goto out_free_name;
> +
> +		if (do_open) {
> +			cgroup->fd = open_cgroup(name);
> +			if (cgroup->fd == -1)
> +				goto out_free_name;
> +		} else {
> +			cgroup->fd = -1;
> +		}
>  	}
>  
>  	return cgroup;
> @@ -80,7 +85,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
>  {
>  	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
>  
> -	return cgroup ?: cgroup__new(name);
> +	return cgroup ?: cgroup__new(name, true);
>  }
>  
>  static int add_cgroup(struct evlist *evlist, const char *str)
> @@ -202,7 +207,7 @@ int parse_cgroups(const struct option *opt, const char *str,
>  }
>  
>  int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> -			  struct rblist *metric_events)
> +			  struct rblist *metric_events, bool open_cgroup)
>  {
>  	struct evlist *orig_list, *tmp_list;
>  	struct evsel *pos, *evsel, *leader;
> @@ -240,7 +245,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
>  			if (!name)
>  				break;
>  
> -			cgrp = cgroup__new(name);
> +			cgrp = cgroup__new(name, open_cgroup);
>  			free(name);
>  			if (cgrp == NULL)
>  				break;
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index eea6df8ee373..162906f3412a 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -26,7 +26,7 @@ struct rblist;
>  
>  struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
>  int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
> -			  struct rblist *metric_events);
> +			  struct rblist *metric_events, bool open_cgroup);
>  
>  void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

