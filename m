Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246AF2B30E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 22:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKNVGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 16:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgKNVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 16:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605387979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDqPoFmTP4ds0d2GMoMz+XMW5r3umHX/Yp3qFx9m9x0=;
        b=e/Svq4/3xclFvazUGN62rZOaBsQ3kyXFswib5wHsvLbld9jS3EGGOMjDJtyVPi+vfJrC7s
        Dk742dm2x3zk1kaZEFrLlw5iELvyA60+0UseTnOXyZE+vos5tZQhpUZoHgtarJRlYnoouh
        jvf2UT2uSLhwjaw7vXp+p0EMN0YYeFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Yi7BwOQyMGafghng6LQrYA-1; Sat, 14 Nov 2020 16:06:15 -0500
X-MC-Unique: Yi7BwOQyMGafghng6LQrYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0A3804024;
        Sat, 14 Nov 2020 21:06:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id E1CAD6B8D4;
        Sat, 14 Nov 2020 21:06:10 +0000 (UTC)
Date:   Sat, 14 Nov 2020 22:06:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Fix dwarf unwind for optimized builds.
Message-ID: <20201114210609.GC903902@krava>
References: <20201114000803.909530-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114000803.909530-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:08:03PM -0800, Ian Rogers wrote:
> To ensure the stack frames are on the stack tail calls optimizations
> need to be inhibited. If your compiler supports an attribute use it,
> otherwise use an asm volatile barrier.
> 
> The barrier fix was suggested here:
> https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
> 
> Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
>        attribute")

missing SOB

LGTM and test is passing for me ;-)

Tested-by: Jiri Olsa <jolsa@redhat.com>

jirka

> ---
>  tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index 83638097c3bc..c8ce86bceea8 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -24,6 +24,23 @@
>  /* For bsearch. We try to unwind functions in shared object. */
>  #include <stdlib.h>
>  
> +/*
> + * The test will assert frames are on the stack but tail call optimizations lose
> + * the frame of the caller. Clang can disable this optimization on a called
> + * function but GCC currently (11/2020) lacks this attribute. The barrier is
> + * used to inhibit tail calls in these cases.
> + */
> +#ifdef __has_attribute
> +#if __has_attribute(disable_tail_calls)
> +#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
> +#define NO_TAIL_CALL_BARRIER
> +#endif
> +#endif
> +#ifndef NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
> +#endif
> +
>  static int mmap_handler(struct perf_tool *tool __maybe_unused,
>  			union perf_event *event,
>  			struct perf_sample *sample,
> @@ -95,7 +112,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	return strcmp((const char *) symbol, funcs[idx]);
>  }
>  
> -noinline int test_dwarf_unwind__thread(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
>  {
>  	struct perf_sample sample;
>  	unsigned long cnt = 0;
> @@ -126,7 +143,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
>  
>  static int global_unwind_retval = -INT_MAX;
>  
> -noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
>  {
>  	/* Any possible value should be 'thread' */
>  	struct thread *thread = *(struct thread **)p1;
> @@ -145,7 +162,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
>  	return p1 - p2;
>  }
>  
> -noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
>  {
>  	struct thread *array[2] = {thread, thread};
>  	void *fp = &bsearch;
> @@ -164,14 +181,22 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
>  	return global_unwind_retval;
>  }
>  
> -noinline int test_dwarf_unwind__krava_2(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
>  {
> -	return test_dwarf_unwind__krava_3(thread);
> +	int ret;
> +
> +	ret =  test_dwarf_unwind__krava_3(thread);
> +	NO_TAIL_CALL_BARRIER;
> +	return ret;
>  }
>  
> -noinline int test_dwarf_unwind__krava_1(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
>  {
> -	return test_dwarf_unwind__krava_2(thread);
> +	int ret;
> +
> +	ret =  test_dwarf_unwind__krava_2(thread);
> +	NO_TAIL_CALL_BARRIER;
> +	return ret;
>  }
>  
>  int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

