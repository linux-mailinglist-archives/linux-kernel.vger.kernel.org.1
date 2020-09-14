Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B13269193
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgINQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgINQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:13:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D13217BA;
        Mon, 14 Sep 2020 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600100014;
        bh=LLsNtKG6f/12f6ktLZfNEa60v8YG85vBkY/r67WhjyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t72TagTSNpLIF89aV4wh8SjvZcu/FAV4xkDbEvcN8/nDmKYiSwAfQeouwMbKv9FDh
         enKS04cEXrtUEcMzaPF6/4fzrXnh/WF6BlIdNNcjQyuSRT55V7/BGro8NWFg1flEMS
         l7EaTK1rpznc3mLt/gtHN/66vw9KFscK6IAxN8Yk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC7D640D3D; Mon, 14 Sep 2020 13:13:31 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:13:31 -0300
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
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 20/26] perf tools: Add build_id_cache__add function
Message-ID: <20200914161331.GM160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-21-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-21-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:03:07PM +0200, Jiri Olsa escreveu:
> Adding build_id_cache__add function as core function
> that adds file into build id database. It will be
> sed from another callers in following changes.

More prep work generally useful, applying now.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 42 ++++++++++++++++++++++++--------------
>  tools/perf/util/build-id.h |  2 ++
>  2 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index b281c97894e0..bf044e52ad1f 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -668,24 +668,15 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
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
> @@ -786,8 +777,6 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>  		pr_debug4("Failed to update/scan SDT cache for %s\n", realname);
>  
>  out_free:
> -	if (!is_kallsyms)
> -		free(realname);
>  	free(filename);
>  	free(debugfile);
>  	free(dir_name);
> @@ -795,6 +784,29 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
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
>  static int build_id_cache__add_b(const u8 *build_id, size_t build_id_size,
>  				 const char *name, struct nsinfo *nsi,
>  				 bool is_kallsyms, bool is_vdso)
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index 2cf87b7304e2..6d1c7180047b 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -50,6 +50,8 @@ char *build_id_cache__complement(const char *incomplete_sbuild_id);
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
