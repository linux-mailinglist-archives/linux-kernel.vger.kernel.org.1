Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE21BE5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2RyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2RyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:54:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D18C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:54:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l78so2927514qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V04cfTgPwsOaE9K2g2VsgPhrMgAixKyeveOTHytG5tM=;
        b=mVsd5ru3Yi5oyTnXf7KzEQgMl9EyOwUdEH2xlPdE77cScRsvmbWnk5204RqU8NsDBS
         i8Q/zKxil2PLn2fhPHrYVsX8M7pSYjJk5RPzMaueOzuHtPMJNlzZOWTW4ZcNmXQ0ni1B
         m14VUxbsgPlAFVeoR1Y/2kLt8I8F+B8kxJpr0lh+fgpKldeQ/m7PYjDN64+nEgELobEK
         BU02VGDAtX28TDQFi0LlXWrwjwDjJ4R5ldKdYIYgg8K9B5L02TQhcFRNSafjjQqgvNBT
         gPBKC1R1kVFHoq4GXAhJIHDD0/UZGg7WLjiZVL74j/kR7OEKfo+AxMZP7Cab94ztUbc+
         gLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V04cfTgPwsOaE9K2g2VsgPhrMgAixKyeveOTHytG5tM=;
        b=SOx+O8CZmAty7JKOK0dVf2DqLiW2tUXKgCdRSMStm/LuDtHZQ1qNasaNyGOIFVCYl9
         nluGEMB+ehIO3OrCXAi9ca5EVhu54+nF8YE8RsnYr3zK+RbNYXgzj5d7mkspoo5oyy5L
         5x++ENa5EVnW2b0sGdClC6ZplolPyuZkX7bUVx9USiC1fH3xJ3BRfPxnbkJ1X8MOKa58
         DscRGUDAx8HnSkNei1xJ1uFW677PDDMxFByMpfwX0RKEBuCc3Re51yhY3jcs7KLxliMY
         OfPSCK/FfE/CqVshitVYYfZAIkVkFgnte5M1MxYSE3BPgllvZsy1aggMvAo0KUlB1Y3W
         k2Pg==
X-Gm-Message-State: AGi0PuZWHL3RoclhlQ0ZuKRjTnix101X2zO9QNRZMsWjj9RNZzSYUYVP
        PnGwEiJCYZO9q19barcTnxw=
X-Google-Smtp-Source: APiQypJG6rUrtYBiB56IFcxYg21zWnKCs2XLU8o4djJgxlg9XirtoiU2mI65E44Emj+/Z3edCGm0pA==
X-Received: by 2002:a37:617:: with SMTP id 23mr35309683qkg.11.1588182863395;
        Wed, 29 Apr 2020 10:54:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d69sm16267115qke.111.2020.04.29.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:54:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9F66409A3; Wed, 29 Apr 2020 14:54:20 -0300 (-03)
Date:   Wed, 29 Apr 2020 14:54:20 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/2] perf parse-events: fix memory leaks found on
 parse_events
Message-ID: <20200429175420.GD30487@kernel.org>
References: <20200319023101.82458-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319023101.82458-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 07:31:00PM -0700, Ian Rogers escreveu:
> Memory leaks found by applying LLVM's libfuzzer on the parse_events
> function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 2 ++
>  tools/perf/util/parse-events.y | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 593b6b03785d..1e0bec5c0846 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
>  			list_del_init(&pos->list);
> +			if (pos->free_str)
> +				free(pos->val.str);

I'm applying it but only after changing it to zfree(&pos->free_str), to
make sure that any othe rcode that may still hold a pointer to pos will
see a NULL in ->free_str and crash sooner rather than later.

>  			free(pos);
>  		}
>  		return -EINVAL;

And the following should be in a different patch

> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 94f8bcd83582..8212cc771667 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
>  
>  	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
>  		list_del_init(&evsel->core.node);
> -		perf_evsel__delete(evsel);
> +		evsel__delete(evsel);
>  	}
>  	free(list_evsel);
>  }

And this one in another, I'll fix this up, but please try in the future
to provide different patches for different fixes, so that if we
eventually find out that one of the unrelated fixes is wrong, then we
can revert the patch more easily with 'git revert' instead of having to
do a patch that reverts just part of the bigger hodge-podge patch.

If you go and have a track record of doing this as piecemeal as
possible, I will in turn feel more confident of processing your patches
in a faster fashion ;-) :-)

Thanks,

- Arnaldo

> @@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
>  	}
>  	parse_events_terms__delete($2);
>  	parse_events_terms__delete(orig_terms);
> +	free(pattern);
>  	free($1);
>  	$$ = list;
>  #undef CLEANUP_YYABORT
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
