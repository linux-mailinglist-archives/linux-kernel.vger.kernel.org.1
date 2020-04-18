Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAED1AEC36
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDRLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgDRLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:50:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:50:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b10so4335085qtt.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GAVD1JEWIlFB14otpvKYqgLY6hPmlPGgIfr02WPJ4ME=;
        b=vIeIPHXmzPVHnn/+MApbGMDxDcwB2HSyHgeuVG5C0r88Guw/yHAhZhLA3OrPY/897j
         WsV/cf1Kl50Ja738uAD+cf33mNMr2ovDT1YjLnvwl1eiYygcOtcoVU78lSzvFmTEU7WZ
         HsiuC727sozByygg6bweqiZIMWbHVBn/AZVa+gBkDGH/ld0ciLK7K4gsOLUlLfGr2poe
         OYKWy+J4MwmacD+McHUz7j1gcWMZqD+L+dmp62g7sRlaFnbMkTJglN7dIQfdo9eeeQkC
         K1C6kes8suARJi2zAMOIIgFU6VpkNnjQig7KVot9IyxpGsEnZHC6nzqYo7Z79slZUead
         9sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GAVD1JEWIlFB14otpvKYqgLY6hPmlPGgIfr02WPJ4ME=;
        b=ONOxGToBBmnVdSN5aKSaX/vcitIQLzmUfYxf94LaYy/Ru8gmNcW8UtagiV+mTUiAaI
         q07IbQ6UoqRnwY+8umAQJm1jXZ5ToxsbtWxNmv+iedrb0at9v8Ri03Mg7oNZa9GvY6Jy
         Fo/eP0uIXhU9hnjb9fjUl91L/Ax5F5YidX3WHqZKIqJpJrn9k5eHybWnZXx7VQ+Nl5ku
         FReTiPrs+qTaM4SDktbZgGQ05IwpdpNL5eNazDhNCt1qZR+sUz3CwXpO04Pg+NHDFaCn
         i6EpIDfEhQKVZTLZGCKuUWgn8nvRNqVDWi/y8E/U3udAqvTTp/GgZ9r4SSYPiWtK/PrP
         XTpw==
X-Gm-Message-State: AGi0Pua/NEvdqQox2ShhZv8rrHOHbRBZJrA9rbYN3yflyU0m3r8tRoFZ
        KomPbQg91725OM+losOZ3V3pT1ib6Ps=
X-Google-Smtp-Source: APiQypKM7T6iNHps1h5Z10ItLktBdg9OZQ2vQdwwcNBPPSFs+djesaOxDwNkG4lFCdi8FC0fTJ9fOg==
X-Received: by 2002:aed:3a86:: with SMTP id o6mr7572229qte.262.1587210620373;
        Sat, 18 Apr 2020 04:50:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x124sm18797687qkc.70.2020.04.18.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 04:50:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 97DE6409A3; Sat, 18 Apr 2020 08:50:17 -0300 (-03)
Date:   Sat, 18 Apr 2020 08:50:17 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] perf tools: Move and globalize
 perf_evsel__find_pmu() and perf_evsel__is_aux_event()
Message-ID: <20200418115017.GA6031@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-13-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401101613.6201-13-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 01, 2020 at 01:16:09PM +0300, Adrian Hunter escreveu:
> Move and globalize 2 functions so that they can be reused.

So this breaks this:

[acme@five perf]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
19: 'import perf' in python                               :
--- start ---
test child forked, pid 168414
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.so: undefined symbol: perf_pmu__scan
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[acme@five perf]$

I'm trying to fix...
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 19 -------------------
>  tools/perf/util/evsel.c    | 20 ++++++++++++++++++++
>  tools/perf/util/evsel.h    |  3 +++
>  3 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 809a09e75c55..33ad33378a90 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -58,25 +58,6 @@
>  #include "symbol/kallsyms.h"
>  #include <internal/lib.h>
>  
> -static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
> -{
> -	struct perf_pmu *pmu = NULL;
> -
> -	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> -		if (pmu->type == evsel->core.attr.type)
> -			break;
> -	}
> -
> -	return pmu;
> -}
> -
> -static bool perf_evsel__is_aux_event(struct evsel *evsel)
> -{
> -	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
> -
> -	return pmu && pmu->auxtrace;
> -}
> -
>  /*
>   * Make a group from 'leader' to 'last', requiring that the events were not
>   * already grouped to a different leader.
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 60e6cd49dee3..d4ab073c9fe7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -44,6 +44,7 @@
>  #include "stat.h"
>  #include "string2.h"
>  #include "memswap.h"
> +#include "pmu.h"
>  #include "util.h"
>  #include "../perf-sys.h"
>  #include "util/parse-branch-options.h"
> @@ -100,6 +101,25 @@ int perf_evsel__object_config(size_t object_size,
>  	return 0;
>  }
>  
> +struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (pmu->type == evsel->core.attr.type)
> +			break;
> +	}
> +
> +	return pmu;
> +}
> +
> +bool perf_evsel__is_aux_event(struct evsel *evsel)
> +{
> +	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
> +
> +	return pmu && pmu->auxtrace;
> +}
> +
>  #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
>  
>  int __perf_evsel__sample_size(u64 sample_type)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index e64ed4202cab..a463bc65b001 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -158,6 +158,9 @@ int perf_evsel__object_config(size_t object_size,
>  			      int (*init)(struct evsel *evsel),
>  			      void (*fini)(struct evsel *evsel));
>  
> +struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
> +bool perf_evsel__is_aux_event(struct evsel *evsel);
> +
>  struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
>  
>  static inline struct evsel *evsel__new(struct perf_event_attr *attr)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
