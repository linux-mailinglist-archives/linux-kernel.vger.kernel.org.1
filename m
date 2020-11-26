Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394AB2C5B23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404498AbgKZRxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404262AbgKZRxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:53:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BF720665;
        Thu, 26 Nov 2020 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606413229;
        bh=7QGAk4QZEWRnKfTDBVWHoD4S6Vq06F+m5SKvJ3EDZ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nswZc2KWkg9MZUcrSeOGKyYax4HnjeTQZxov2s9NqZS6gs8kFoTOjidwSRK4EQlRV
         976s/PCx4y+Xc2xEKdU289iTvsaB+LAoA3zV+FlUCeec0qqHekGqz5/m+FtPSIiy8f
         dcEaJt9WPP0x4s4RIGwcSHfqEwDIK8bIXP5Slzq4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 183C340E29; Thu, 26 Nov 2020 14:53:47 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:53:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 21/25] perf tools: Add build_id_cache__add function
Message-ID: <20201126175347.GH70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-22-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-22-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:22PM +0100, Jiri Olsa escreveu:
> Adding build_id_cache__add function as core function
> that adds file into build id database. It will be
> set from another callers in following changes.

Thanks, applied.

- Arnaldo

 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 42 ++++++++++++++++++++++++--------------
>  tools/perf/util/build-id.h |  2 ++
>  2 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 6bf3cc79c5d5..02df36b30ac5 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -671,24 +671,15 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  	return realname;
>  }
>  
> -int build_id_cache__add_s(const char *sbuild_id, const char *name,
> -			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
> +int
> +build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
> +		    struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
>  {
>  	const size_t size = PATH_MAX;
> -	char *realname = NULL, *filename = NULL, *dir_name = NULL,
> -	     *linkname = zalloc(size), *tmp;
> +	char *filename = NULL, *dir_name = NULL, *linkname = zalloc(size), *tmp;
>  	char *debugfile = NULL;
>  	int err = -1;
>  
> -	if (!is_kallsyms) {
> -		if (!is_vdso)
> -			realname = nsinfo__realpath(name, nsi);
> -		else
> -			realname = realpath(name, NULL);
> -		if (!realname)
> -			goto out_free;
> -	}
> -
>  	dir_name = build_id_cache__cachedir(sbuild_id, name, nsi, is_kallsyms,
>  					    is_vdso);
>  	if (!dir_name)
> @@ -788,8 +779,6 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>  		pr_debug4("Failed to update/scan SDT cache for %s\n", realname);
>  
>  out_free:
> -	if (!is_kallsyms)
> -		free(realname);
>  	free(filename);
>  	free(debugfile);
>  	free(dir_name);
> @@ -797,6 +786,29 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>  	return err;
>  }
>  
> +int build_id_cache__add_s(const char *sbuild_id, const char *name,
> +			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
> +{
> +	char *realname = NULL;
> +	int err = -1;
> +
> +	if (!is_kallsyms) {
> +		if (!is_vdso)
> +			realname = nsinfo__realpath(name, nsi);
> +		else
> +			realname = realpath(name, NULL);
> +		if (!realname)
> +			goto out_free;
> +	}
> +
> +	err = build_id_cache__add(sbuild_id, name, realname, nsi, is_kallsyms, is_vdso);
> +
> +out_free:
> +	if (!is_kallsyms)
> +		free(realname);
> +	return err;
> +}
> +
>  static int build_id_cache__add_b(const struct build_id *bid,
>  				 const char *name, struct nsinfo *nsi,
>  				 bool is_kallsyms, bool is_vdso)
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index c6f10e3d2152..02613f4b2c29 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -63,6 +63,8 @@ char *build_id_cache__complement(const char *incomplete_sbuild_id);
>  int build_id_cache__list_build_ids(const char *pathname, struct nsinfo *nsi,
>  				   struct strlist **result);
>  bool build_id_cache__cached(const char *sbuild_id);
> +int build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
> +			struct nsinfo *nsi, bool is_kallsyms, bool is_vdso);
>  int build_id_cache__add_s(const char *sbuild_id,
>  			  const char *name, struct nsinfo *nsi,
>  			  bool is_kallsyms, bool is_vdso);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
