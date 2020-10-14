Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300028DF92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgJNLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgJNLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602673536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ingjVkHesWJGOLcfOeCRQ+XyVe9OrHcQ8bIZZXuyEHc=;
        b=EACMHFtlI95U5rLiF9xFAuSIcEaeDbXmzBCCC8zUQvBT1EWf/1cLLu04Qb7S7/7gVUNvVF
        GCeUrxBxb4ijvlHIRgxryYdGvi90gM/JHQCjVyN2178lob/po8MmqJDuKWlW8daLQ2EagY
        /AdSIQo61NPHXXyGfJt6+JsUlAcQR+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-B6guhdFVN-6dJ49MtygEJA-1; Wed, 14 Oct 2020 07:05:34 -0400
X-MC-Unique: B6guhdFVN-6dJ49MtygEJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17AE185C737;
        Wed, 14 Oct 2020 11:05:32 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 274D55D9CD;
        Wed, 14 Oct 2020 11:05:27 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:05:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v4 4/9] libperf: Add libperf_evsel__mmap()
Message-ID: <20201014110527.GA1349644@krava>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001140116.651970-5-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:

SNIP

>  
> +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> +{
> +	int ret;
> +	struct perf_mmap *map;
> +	struct perf_mmap_param mp = {
> +		.prot = PROT_READ | PROT_WRITE,
> +	};
> +
> +	if (FD(evsel, 0, 0) < 0)
> +		return NULL;
> +
> +	mp.mask = (pages * page_size) - 1;
> +
> +	map = zalloc(sizeof(*map));
> +	if (!map)
> +		return NULL;
> +
> +	perf_mmap__init(map, NULL, false, NULL);
> +
> +	ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);

hum, so you map event for FD(0,0) but later in perf_evsel__read
you allow to read any cpu/thread combination ending up reading
data from FD(0,0) map:

	int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
			     struct perf_counts_values *count)
	{
		size_t size = perf_evsel__read_size(evsel);

		memset(count, 0, sizeof(*count));

		if (FD(evsel, cpu, thread) < 0)
			return -EINVAL;

		if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
			return 0;


I think we should either check cpu == 0, thread == 0, or make it
general and store perf_evsel::mmap in xyarray as we do for fds

thanks,
jirka

