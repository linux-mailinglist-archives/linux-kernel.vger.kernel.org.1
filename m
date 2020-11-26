Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F122C5AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391695AbgKZRna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbgKZRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:43:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04AB207BC;
        Thu, 26 Nov 2020 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412609;
        bh=tOAB4T9doP4SScLqwOdgYF36eBQgrXWFrZe8pJOlJ9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiEry9VID9GyUnIpPj2n4xAjxcmLc6aZ2sRF2SbyPQiziVa8PbYMuBQDVCLUEgREN
         8rxDK69Yw+N6Od49uFHQTp0FYRPkcQ3q+6PFPKOwlOhp21OZaAyuvW1gJYcR9d7Ypi
         oZ0zgdBQSOGY4w8+vunvBD8/+LDLSDiOfBstWUG0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC5AD40E29; Thu, 26 Nov 2020 14:43:26 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:43:26 -0300
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
Subject: Re: [PATCH 07/25] perf tools: Add build_id__is_defined function
Message-ID: <20201126174326.GI53384@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:08PM +0100, Jiri Olsa escreveu:
> Adding build_id__is_defined helper to check build id
> is defined and is != zero build id.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 6 ++++++
>  tools/perf/util/build-id.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 6b410c3d52dc..2aacc8b29f7e 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -37,6 +37,7 @@
>  
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
> +#include <linux/string.h>
>  #include <asm/bug.h>
>  
>  static bool no_buildid_cache;
> @@ -912,3 +913,8 @@ void build_id__init(struct build_id *bid, const u8 *data, size_t size)
>  	memcpy(bid->data, data, size);
>  	bid->size = size;
>  }
> +
> +bool build_id__is_defined(const struct build_id *bid)
> +{
> +	return bid && bid->size ? !!memchr_inv(bid->data, 0, bid->size) : false;
> +}
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index f293f99d5dba..d53415feaf69 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -21,6 +21,7 @@ struct feat_fd;
>  
>  void build_id__init(struct build_id *bid, const u8 *data, size_t size);
>  int build_id__sprintf(const struct build_id *build_id, char *bf);
> +bool build_id__is_defined(const struct build_id *bid);
>  int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
>  char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
> -- 
> 2.26.2
> 

-- 

- Arnaldo
