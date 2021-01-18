Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442562FA59B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbhARQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406314AbhARQFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:05:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 339B820E65;
        Mon, 18 Jan 2021 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985910;
        bh=RaFc/KU/UqPArIcxvNLD5/A8Ei7pqUtAnaVAu+7Z3pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsdIePPEC7Xzr8TIb+V9aZi3eNY1JaPPNf8M61pMNwO6qyIi9VT8TiKewTuMGRz7v
         VI+g1BW9W5uIhBrF0ikaWhw5xdKMfSHZYr+cgZb2nzLg53JqpCgBdNnVHnGMJXVNXe
         g9QYlmhTIZ+69p1BsB4VPKqx6rpMY1w9JZ4MTb+8/W17ig0OtymuTwi2cOfRwO3gO2
         C2smGToBbbWfeRCjPX1eWRTF4u6KleYS7yFlCfB+FZFnrFknKbb6zVnpGvaUI1PflR
         1ELFLTHLlBs7sK61Pw8u3yjwKIZ2qyfIoWNb/N7p0HscmNr9Hjej+xbxoB5uAihmc3
         nv+UgXhIHG9Aw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 433B040CE2; Mon, 18 Jan 2021 13:05:08 -0300 (-03)
Date:   Mon, 18 Jan 2021 13:05:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 04/22] perf tools: Add perf_home_perfconfig function
Message-ID: <20210118160508.GE12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:23PM +0100, Jiri Olsa escreveu:
> Factor out the perf_home_perfconfig, that looks for
> .perfconfig in home directory including check for
> PERF_CONFIG_NOGLOBAL and for proper permission.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/config.c | 89 ++++++++++++++++++++++++----------------
>  tools/perf/util/config.h |  1 +
>  2 files changed, 54 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 222cb2e2de25..34fe80ccdad1 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -531,6 +531,56 @@ static int perf_config_global(void)
>  	return !perf_env_bool("PERF_CONFIG_NOGLOBAL", 0);
>  }
>  
> +static char *home_perfconfig(void)
> +{
> +	const char *home = NULL;
> +	char *config;
> +	struct stat st;
> +
> +	home = getenv("HOME");
> +
> +	/*
> +	 * Skip reading user config if:
> +	 *   - there is no place to read it from (HOME)
> +	 *   - we are asked not to (PERF_CONFIG_NOGLOBAL=1)
> +	 */
> +	if (!home || !*home || !perf_config_global())
> +		return NULL;
> +
> +	config = strdup(mkpath("%s/.perfconfig", home));
> +	if (config == NULL) {
> +		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.", home);
> +		return NULL;
> +	}
> +
> +	if (stat(config, &st) < 0)
> +		goto out_free;
> +
> +	if (st.st_uid && (st.st_uid != geteuid())) {
> +		pr_warning("File %s not owned by current user or root, ignoring it.", config);
> +		goto out_free;
> +	}
> +
> +	if (st.st_size)
> +		return config;
> +
> +out_free:
> +	free(config);
> +	return NULL;
> +}
> +
> +const char *perf_home_perfconfig(void)
> +{
> +	static const char *config;
> +	static bool failed;
> +
> +	config = failed ? NULL : home_perfconfig();
> +	if (!config)
> +		failed = true;
> +
> +	return config;
> +}
> +
>  static struct perf_config_section *find_section(struct list_head *sections,
>  						const char *section_name)
>  {
> @@ -676,9 +726,6 @@ int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
>  static int perf_config_set__init(struct perf_config_set *set)
>  {
>  	int ret = -1;
> -	const char *home = NULL;
> -	char *user_config;
> -	struct stat st;
>  
>  	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
>  	if (config_exclusive_filename)
> @@ -687,41 +734,11 @@ static int perf_config_set__init(struct perf_config_set *set)
>  		if (perf_config_from_file(collect_config, perf_etc_perfconfig(), set) < 0)
>  			goto out;
>  	}
> -
> -	home = getenv("HOME");
> -
> -	/*
> -	 * Skip reading user config if:
> -	 *   - there is no place to read it from (HOME)
> -	 *   - we are asked not to (PERF_CONFIG_NOGLOBAL=1)
> -	 */
> -	if (!home || !*home || !perf_config_global())
> -		return 0;
> -
> -	user_config = strdup(mkpath("%s/.perfconfig", home));
> -	if (user_config == NULL) {
> -		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.", home);
> -		goto out;
> -	}
> -
> -	if (stat(user_config, &st) < 0) {
> -		if (errno == ENOENT)
> -			ret = 0;
> -		goto out_free;
> -	}
> -
> -	ret = 0;
> -
> -	if (st.st_uid && (st.st_uid != geteuid())) {
> -		pr_warning("File %s not owned by current user or root, ignoring it.", user_config);
> -		goto out_free;
> +	if (perf_config_global() && perf_home_perfconfig()) {
> +		if (perf_config_from_file(collect_config, perf_home_perfconfig(), set) < 0)
> +			goto out;
>  	}
>  
> -	if (st.st_size)
> -		ret = perf_config_from_file(collect_config, user_config, set);
> -
> -out_free:
> -	free(user_config);
>  out:
>  	return ret;
>  }
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index ee5a242446e9..d6c4f80f367c 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -37,6 +37,7 @@ int perf_config_u64(u64 *dest, const char *, const char *);
>  int perf_config_bool(const char *, const char *);
>  int config_error_nonbool(const char *);
>  const char *perf_etc_perfconfig(void);
> +const char *perf_home_perfconfig(void);
>  
>  struct perf_config_set *perf_config_set__new(void);
>  struct perf_config_set *perf_config_set__load_file(const char *file);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
