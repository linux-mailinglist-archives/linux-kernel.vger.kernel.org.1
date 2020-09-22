Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B8274B45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVVkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIVVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600810841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvKLK45f+pV+aZpx2RncLiRV10TEdFA1YgHDgtiks7E=;
        b=UOz4kyopzxWcuCgaGctR4lrf+6REmhAepLicHTdRpZC16iFQxninSLfJvrV5CS36XzuCNt
        pLFSdhf3YUTpzyyh0O/GakB34qdZzUthUG0MlAtL7iQUWYqnffg8KdWfwin33UAenPnktw
        AgBSm52n9MW9q+r4gghWH8uZDzCAZvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-jKa5IYJEOQqvVwTebOPlGQ-1; Tue, 22 Sep 2020 17:40:39 -0400
X-MC-Unique: jKa5IYJEOQqvVwTebOPlGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AFD186DD2C;
        Tue, 22 Sep 2020 21:40:37 +0000 (UTC)
Received: from krava (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 874C073689;
        Tue, 22 Sep 2020 21:40:34 +0000 (UTC)
Date:   Tue, 22 Sep 2020 23:40:33 +0200
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
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/5] perf stat: Add --for-each-cgroup option
Message-ID: <20200922214033.GD2893484@krava>
References: <20200921094610.83736-1-namhyung@kernel.org>
 <20200921094610.83736-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921094610.83736-3-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:46:07PM +0900, Namhyung Kim wrote:

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
> +				goto out_err;
> +
> +			cgrp = cgroup__new(name);
> +			free(name);
> +			if (cgrp == NULL)
> +				goto out_err;
> +		} else {
> +			cgrp = NULL;
> +		}
> +
> +		leader = NULL;
> +		evlist__for_each_entry(orig_list, pos) {
> +			evsel = evsel__clone(pos);
> +			if (evsel == NULL)
> +				goto out_err;
> +
> +			cgroup__put(evsel->cgrp);
> +			evsel->cgrp = cgroup__get(cgrp);
> +
> +			if (evsel__is_group_leader(pos))
> +				leader = evsel;
> +			evsel->leader = leader;

hum, will this work if there's standalone event after group? like:

  {cycles,instructions},cache-misses

cache-misses will get cycles as group leader no?

jirka

> +
> +			evlist__add(tmp_list, evsel);
> +		}
> +		/* cgroup__new() has a refcount, release it here */
> +		cgroup__put(cgrp);
> +		nr_cgroups++;

SNIP

