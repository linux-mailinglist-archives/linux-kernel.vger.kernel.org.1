Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E432F74C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbhAOI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbhAOI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610701080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FyvW6QZm1SrTRJBMFAc+EGck0O0WnY8XaJY2PxCig28=;
        b=AXn4C2caGmNsTfZ7kycM7y36gM0x9FkaUMdSUfM5vLobBFY5ugBNTWNtGi/C79j+057dcR
        Ho++sYhJf1zLwSGxAY+STZhV00JjhQQ/MGmK7fOos3VBHir0sz/vmEV+ra1yEWmSZtwWEp
        Nk2k925cRodd3tymNoA4W461ZnJ7BMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-aoY8hiUvPdmrxFMkfYnWbg-1; Fri, 15 Jan 2021 03:57:56 -0500
X-MC-Unique: aoY8hiUvPdmrxFMkfYnWbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C770107ACF8;
        Fri, 15 Jan 2021 08:57:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 59B8410013C0;
        Fri, 15 Jan 2021 08:57:53 +0000 (UTC)
Date:   Fri, 15 Jan 2021 09:57:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] libperf tests: If a test fails return non-zero
Message-ID: <20210115085752.GA1476178@krava>
References: <20210114180250.3853825-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180250.3853825-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:02:49AM -0800, Ian Rogers wrote:
> If a test fails return -1 rather than 0. This is consistent with the
> return value in test-cpumap.c
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

for the patchset 

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/tests/test-cpumap.c    | 2 +-
>  tools/lib/perf/tests/test-evlist.c    | 2 +-
>  tools/lib/perf/tests/test-evsel.c     | 2 +-
>  tools/lib/perf/tests/test-threadmap.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
> index c8d45091e7c2..c70e9e03af3e 100644
> --- a/tools/lib/perf/tests/test-cpumap.c
> +++ b/tools/lib/perf/tests/test-cpumap.c
> @@ -27,5 +27,5 @@ int main(int argc, char **argv)
>  	perf_cpu_map__put(cpus);
>  
>  	__T_END;
> -	return 0;
> +	return tests_failed == 0 ? 0 : -1;
>  }
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 6d8ebe0c2504..d913241d4135 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -409,5 +409,5 @@ int main(int argc, char **argv)
>  	test_mmap_cpus();
>  
>  	__T_END;
> -	return 0;
> +	return tests_failed == 0 ? 0 : -1;
>  }
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 135722ac965b..0ad82d7a2a51 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -131,5 +131,5 @@ int main(int argc, char **argv)
>  	test_stat_thread_enable();
>  
>  	__T_END;
> -	return 0;
> +	return tests_failed == 0 ? 0 : -1;
>  }
> diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> index 7dc4d6fbedde..384471441b48 100644
> --- a/tools/lib/perf/tests/test-threadmap.c
> +++ b/tools/lib/perf/tests/test-threadmap.c
> @@ -27,5 +27,5 @@ int main(int argc, char **argv)
>  	perf_thread_map__put(threads);
>  
>  	__T_END;
> -	return 0;
> +	return tests_failed == 0 ? 0 : -1;
>  }
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

