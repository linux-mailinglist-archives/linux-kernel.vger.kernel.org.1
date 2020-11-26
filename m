Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51B2C5B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbgKZRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404000AbgKZRxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:53:16 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B032120665;
        Thu, 26 Nov 2020 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606413195;
        bh=pmWP8XdvL+H+eUNiryBu/5IP1VujJbyRXUEk/AmVySk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc6sSdt4RLDHyuW7xHPKdk/5jqaK/U7tz2dRivIClLeEpAskCXNDefCP2icEBh43p
         AfEBis08tSWwINa7qXgqMEvaVHlovq1RxZ4CA4XXexdE925BtYVj7BMw/TQTlJ45RX
         mV9IWf/RoDRk9K9DZY+vU/Hgy7NGBFTQvGVr6ZPI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A29FA40E29; Thu, 26 Nov 2020 14:53:13 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:53:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 19/25] perf tools: Add __perf_session__cache_build_ids
 function
Message-ID: <20201126175313.GG70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-20-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-20-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:20PM +0100, Jiri Olsa escreveu:
> Adding __perf_session__cache_build_ids function as an
> interface for caching sessions build ids with callback
> function and its data pointer.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 10 ++++++++--
>  tools/perf/util/build-id.h |  3 +++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 948a7f48d668..6bf3cc79c5d5 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -892,7 +892,8 @@ machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
>  	return ret ? -1 : 0;
>  }
>  
> -int perf_session__cache_build_ids(struct perf_session *session)
> +int __perf_session__cache_build_ids(struct perf_session *session,
> +				    machine__dso_t fn, void *priv)
>  {
>  	if (no_buildid_cache)
>  		return 0;
> @@ -900,7 +901,12 @@ int perf_session__cache_build_ids(struct perf_session *session)
>  	if (mkdir(buildid_dir, 0755) != 0 && errno != EEXIST)
>  		return -1;
>  
> -	return machines__for_each_dso(&session->machines, dso__cache_build_id, NULL) ?  -1 : 0;
> +	return machines__for_each_dso(&session->machines, fn, priv) ?  -1 : 0;
> +}
> +
> +int perf_session__cache_build_ids(struct perf_session *session)
> +{
> +	return __perf_session__cache_build_ids(session, dso__cache_build_id, NULL);
>  }
>  
>  static bool machine__read_build_ids(struct machine *machine, bool with_hits)
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index f1a2f67df6e4..c6f10e3d2152 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -5,6 +5,7 @@
>  #define BUILD_ID_SIZE	20
>  #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
>  
> +#include "machine.h"
>  #include "tool.h"
>  #include <linux/types.h>
>  
> @@ -46,6 +47,8 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
>  int perf_session__write_buildid_table(struct perf_session *session,
>  				      struct feat_fd *fd);
>  int perf_session__cache_build_ids(struct perf_session *session);
> +int __perf_session__cache_build_ids(struct perf_session *session,
> +				    machine__dso_t fn, void *priv);
>  
>  char *build_id_cache__origname(const char *sbuild_id);
>  char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
