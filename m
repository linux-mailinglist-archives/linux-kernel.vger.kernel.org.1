Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299E326FFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIROdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIROdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600439623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lc1gdBcSlwW1Myg1j82ImIPmW/PKiG30x2XN4oGwKHM=;
        b=JMfksy8sawvjzuQ4O1vedj4n4U2ae+7m0dEvb/h813QvhmcDrE+zEXZAoyZvBnfjQV4yR2
        QFwq0NlU8SWLfB7/+j+xNJ0JFiY/be1Php0w0qrGsgQIqHmRUgXStXXk9u/SsfnMaK5ylV
        b2zoQTvs0nDE4ZeK6STDB0Mng2YeeBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-313U2Tk8MHy_GT9nKyn5qg-1; Fri, 18 Sep 2020 10:33:38 -0400
X-MC-Unique: 313U2Tk8MHy_GT9nKyn5qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBEC4802B69;
        Fri, 18 Sep 2020 14:33:35 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 42B0C5D9E4;
        Fri, 18 Sep 2020 14:33:32 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:33:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v3 05/10] libperf: Add libperf_evsel__mmap()
Message-ID: <20200918143331.GF2626435@krava>
References: <20200911215118.2887710-1-robh@kernel.org>
 <20200911215118.2887710-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215118.2887710-6-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:51:13PM -0600, Rob Herring wrote:
> In order to support usersapce access, an event must be mmapped. While
> there's already mmap support for evlist, the usecase is a bit different
> than the self monitoring with userspace access. So let's add a new
> perf_evsel__mmap() function to mmap an evsel. This allows implementing
> userspace access as a fastpath for perf_evsel__read().
> 
> The mmapped address is returned by perf_evsel__mmap() primarily for
> users/tests to check if userspace access is enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - New patch split out from user access patch
> ---
>  tools/lib/perf/Documentation/libperf.txt |  1 +
>  tools/lib/perf/evsel.c                   | 31 ++++++++++++++++++++++++
>  tools/lib/perf/include/internal/evsel.h  |  2 ++
>  tools/lib/perf/include/perf/evsel.h      |  2 ++
>  tools/lib/perf/libperf.map               |  1 +
>  5 files changed, 37 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 0c74c30ed23a..0b4694ce42b9 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -136,6 +136,7 @@ SYNOPSIS
>                         struct perf_thread_map *threads);
>    void perf_evsel__close(struct perf_evsel *evsel);
>    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +  void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length);
>    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                         struct perf_counts_values *count);
>    int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 4dc06289f4c7..99fa53dc0887 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -11,10 +11,12 @@
>  #include <stdlib.h>
>  #include <internal/xyarray.h>
>  #include <internal/cpumap.h>
> +#include <internal/mmap.h>
>  #include <internal/threadmap.h>
>  #include <internal/lib.h>
>  #include <linux/string.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
>  {
> @@ -156,6 +158,35 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
>  	perf_evsel__close_fd_cpu(evsel, cpu);
>  }
>  
> +void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length)
> +{

could you rather use 'int pages' insted of length as we
do in perf_evlist__mmap, so we keep the same interface

  len = (pages + 1) * page_size

thanks,
jirka

