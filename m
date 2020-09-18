Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1D26FEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIRNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIRNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600436091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YN8GaQ8TV4sFrBpi6XN0z9f0qTT9ES4Iedyq0dk3o+A=;
        b=NuY2o/w/2mHgQntSRn8IAU1FGi31arsI7v3tdVCJ89ohqUQ6n2nXu+Een3N8FkmO87boBu
        JrcJWTlWwrcaEEOdBgs1gxSNyNg2hW4aJEgwFR0ZypPToH2+DwkUtVX5zovK43lLkcBc1Z
        fCKe7QtdhOdCGPSIQqQL7BMz2Z/r6W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-KlS48hkNMc-Xii0KmdWJjA-1; Fri, 18 Sep 2020 09:34:47 -0400
X-MC-Unique: KlS48hkNMc-Xii0KmdWJjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 824C0AFD63;
        Fri, 18 Sep 2020 13:34:45 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0200C1002D46;
        Fri, 18 Sep 2020 13:34:40 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:34:39 +0200
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
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/4] perf stat: Add --for-each-cgroup option
Message-ID: <20200918133439.GB2626435@krava>
References: <20200916063129.1061487-1-namhyung@kernel.org>
 <20200916063129.1061487-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916063129.1061487-3-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:31:27PM +0900, Namhyung Kim wrote:

SNIP

> +int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> +{
> +	struct evlist *orig_list, *tmp_list;
> +	struct evsel *pos, *evsel, *leader;
> +	struct cgroup *cgrp = NULL;
> +	const char *p, *e, *eos = str + strlen(str);
> +	int ret = -1;
> +
> +	if (evlist->core.nr_entries == 0) {
> +		fprintf(stderr, "must define events before cgroups\n");
> +		return -EINVAL;
> +	}
> +
> +	orig_list = evlist__new();
> +	tmp_list = evlist__new();
> +	if (orig_list == NULL || tmp_list == NULL) {
> +		fprintf(stderr, "memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* save original events and init evlist */
> +	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
> +	evlist->core.nr_entries = 0;
> +
> +	for (;;) {
> +		p = strchr(str, ',');
> +		e = p ? p : eos;
> +
> +		/* allow empty cgroups, i.e., skip */
> +		if (e - str) {
> +			/* termination added */
> +			char *name = strndup(str, e - str);
> +			if (!name)
> +				break;
> +
> +			cgrp = cgroup__new(name);
> +			free(name);
> +			if (cgrp == NULL)
> +				break;
> +		} else {
> +			cgrp = NULL;
> +		}
> +
> +		leader = NULL;
> +		evlist__for_each_entry(orig_list, pos) {
> +			evsel = evsel__clone(pos);

missing check on evsel == NULL

jirka

> +			cgroup__put(evsel->cgrp);
> +			evsel->cgrp = cgroup__get(cgrp);
> +
> +			if (evsel__is_group_leader(pos))
> +				leader = evsel;
> +			evsel->leader = leader;
> +
> +			evlist__add(tmp_list, evsel);
> +		}
> +		/* cgroup__new() has a refcount, release it here */
> +		cgroup__put(cgrp);
> +		nr_cgroups++;
> +
> +		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> +		tmp_list->core.nr_entries = 0;
> +
> +		if (!p) {
> +			ret = 0;
> +			break;
> +		}
> +		str = p+1;
> +	}
> +	evlist__delete(orig_list);
> +	evlist__delete(tmp_list);
> +
> +	return ret;
> +}

SNIP

