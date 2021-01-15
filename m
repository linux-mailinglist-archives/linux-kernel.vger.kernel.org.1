Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76AE2F84F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbhAOS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388039AbhAOS7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:59:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ACE423A5E;
        Fri, 15 Jan 2021 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737127;
        bh=Zuv0mT3LPFnK+1vpfUW2e3lJvF9+EtIFqyJtpAHgcPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBW8av3ONYY/LRdohIvMMhSTUEnvb0Lyxe48QUDBQj1bDa9nsn3bc2v+E88r+zJUl
         85f1cOR85NHGEAFSHluV0tdETwmJygKPAzq5tLC0em2gWaEq8FrSJ3ykP2vGFla45U
         ww2D7VxMoMC8miXCCKCNCaYtD3WJRfsYFuq+fvcCSdjwGAObK7GLg1A1u3aJKsa4Mo
         +DDn4+IpTcHe7Xzy4m52CQwN3M1BDLjmu1qUooyZYA8RnN3TwG0F3Al91m0F+qb6jz
         sq37X2Zg+3Y5i7oYPZdk9PfjswfHzjpJqUo4HL7wm+uKAUWUmoRB84DJPtbk0St6N+
         MxRb0T3Zq7iKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63ACD40522; Fri, 15 Jan 2021 15:59:20 -0300 (-03)
Date:   Fri, 15 Jan 2021 15:59:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] libperf tests: If a test fails return non-zero
Message-ID: <20210115185920.GD457607@kernel.org>
References: <20210114180250.3853825-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180250.3853825-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 14, 2021 at 10:02:49AM -0800, Ian Rogers escreveu:
> If a test fails return -1 rather than 0. This is consistent with the
> return value in test-cpumap.c

Thanks, applied both patches.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
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

-- 

- Arnaldo
