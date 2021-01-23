Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADF3018B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 23:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAWWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 17:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbhAWWnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 17:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611441745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qupc3tQLbCS2NvC0uQtSj9ojSf/ORyYBsb/uXYHlqFM=;
        b=NMjPrS0m+on02YvOP3KpJ5i9dNlHVSovwWZj+0HmXm7gQpVFxVLiCq0Nz3+o9+t3uJc0o3
        +zLUMLnwDiL+0SJbme0A3r2dQQvtPNBz1mCTT8wsu6kWMhi5tEAta+1b3dkuEIehiuXdNw
        VXpcAKQuyVVgKGu8rOOSgdzEUoO+5HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-vE3e5NSJPhGv14_ZMK67hQ-1; Sat, 23 Jan 2021 17:42:20 -0500
X-MC-Unique: vE3e5NSJPhGv14_ZMK67hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F04A801817;
        Sat, 23 Jan 2021 22:42:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF7355D723;
        Sat, 23 Jan 2021 22:42:14 +0000 (UTC)
Date:   Sat, 23 Jan 2021 23:42:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v5 4/9] libperf: Add evsel mmap support
Message-ID: <20210123224213.GA138414@krava>
References: <20210114020605.3943992-1-robh@kernel.org>
 <20210114020605.3943992-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114020605.3943992-5-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:06:00PM -0600, Rob Herring wrote:
> In order to support usersapce access, an event must be mmapped. While
> there's already mmap support for evlist, the usecase is a bit different
> than the self monitoring with userspace access. So let's add a new
> perf_evsel__mmap() function to mmap an evsel. This allows implementing
> userspace access as a fastpath for perf_evsel__read().
> 
> The mmapped address is returned by perf_evsel__mmap_base() which
> primarily for users/tests to check if userspace access is enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v5:
>  - Create an mmap for every underlying event opened. Due to this, we
>    need a different way to get the mmap ptr, so perf_evsel__mmap_base()
>    is introduced.
> v4:
>  - Change perf_evsel__mmap size to pages instead of bytes
> v3:
>  - New patch split out from user access patch
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 +
>  tools/lib/perf/evsel.c                   | 47 +++++++++++++++++++++++-
>  tools/lib/perf/include/internal/evsel.h  |  2 +
>  tools/lib/perf/include/perf/evsel.h      |  2 +
>  tools/lib/perf/libperf.map               |  2 +
>  5 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 0c74c30ed23a..a2c73df191ca 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -136,6 +136,8 @@ SYNOPSIS
>                         struct perf_thread_map *threads);
>    void perf_evsel__close(struct perf_evsel *evsel);
>    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +  int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> +  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
>    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                         struct perf_counts_values *count);
>    int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 4dc06289f4c7..0b5bdf4badae 100644
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
> @@ -37,11 +39,17 @@ void perf_evsel__delete(struct perf_evsel *evsel)
>  	free(evsel);
>  }
>  
> -#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> +struct evsel_fd {
> +	int fd;
> +	struct perf_mmap mmap;
> +};

nice shortcut ;-) but 'struct perf_mmap' is too big for that

I think it's better to add new 'evsel::mmap' xyarray to hold it,
add perf_evsel__alloc_mmap to allocate it and call it from
perf_evsel__mmap the same way as we callperf_evsel__alloc_fd
from perf_evsel__open

thanks,
jirka

