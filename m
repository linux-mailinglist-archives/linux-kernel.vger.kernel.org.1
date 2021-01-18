Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCC2FA54C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406111AbhARPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406043AbhARPxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8980C22B39;
        Mon, 18 Jan 2021 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985183;
        bh=hQwf45Vonv1kT5LPtkjifKKda8aZgMCuSyvZS1Y+COQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4pTXSJFGW5xeZsTPT6p3/S9kOb582w5jswwne8x/2ruA6TuLCGHo2RTrogyJEJ6O
         Sf4OTMmiVXr8pwVccP7JkP4o8/Kr1k/Pb/aV4mW9qwS2aHBotlc5kbZsmLETfvN93y
         9r/ZLCqRmVwK39Vn4XM3yEjTq+aRf3rdHjL3qxS7JiJXzwH7tJs5Z94axA6uUYI8L6
         g9lhDjWa5qo4YD0LR2DB0TwyLFSFSAdeWhpMDOfJoq9BM8JPp5PnNNRNkZNfiwxjY7
         XQiowExDOG8NME5bPD0NmbsxyPkqPzJG5OlnKNk8yGG9gERLAzE42vn42As7bf+/cQ
         TANr6IyKTB7xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9606E40CE2; Mon, 18 Jan 2021 12:53:01 -0300 (-03)
Date:   Mon, 18 Jan 2021 12:53:01 -0300
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
Subject: Re: [PATCH 02/22] perf tools: Add config set interface
Message-ID: <20210118155301.GB12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:21PM +0100, Jiri Olsa escreveu:
> Add interface to load config set from custom file
> by using perf_config_set__load_file function.
> 
> It will be used in perf daemon command to process
> custom config file.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/config.c | 28 +++++++++++++++++++++++-----
>  tools/perf/util/config.h |  3 +++
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 20be0504fb95..222cb2e2de25 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -738,6 +738,18 @@ struct perf_config_set *perf_config_set__new(void)
>  	return set;
>  }
>  
> +struct perf_config_set *perf_config_set__load_file(const char *file)
> +{
> +	struct perf_config_set *set = zalloc(sizeof(*set));
> +
> +	if (set) {
> +		INIT_LIST_HEAD(&set->sections);
> +		perf_config_from_file(collect_config, file, set);
> +	}
> +
> +	return set;
> +}
> +
>  static int perf_config__init(void)
>  {
>  	if (config_set == NULL)
> @@ -746,17 +758,15 @@ static int perf_config__init(void)
>  	return config_set == NULL;
>  }
>  
> -int perf_config(config_fn_t fn, void *data)
> +int perf_config_set(struct perf_config_set *set,
> +		    config_fn_t fn, void *data)
>  {
>  	int ret = 0;
>  	char key[BUFSIZ];
>  	struct perf_config_section *section;
>  	struct perf_config_item *item;
>  
> -	if (config_set == NULL && perf_config__init())
> -		return -1;
> -
> -	perf_config_set__for_each_entry(config_set, section, item) {
> +	perf_config_set__for_each_entry(set, section, item) {
>  		char *value = item->value;
>  
>  		if (value) {
> @@ -778,6 +788,14 @@ int perf_config(config_fn_t fn, void *data)
>  	return ret;
>  }
>  
> +int perf_config(config_fn_t fn, void *data)
> +{
> +	if (config_set == NULL && perf_config__init())
> +		return -1;
> +
> +	return perf_config_set(config_set, fn, data);
> +}
> +
>  void perf_config__exit(void)
>  {
>  	perf_config_set__delete(config_set);
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index 2f753b2a034b..ee5a242446e9 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -29,6 +29,8 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
>  
>  int perf_default_config(const char *, const char *, void *);
>  int perf_config(config_fn_t fn, void *);
> +int perf_config_set(struct perf_config_set *set,
> +		    config_fn_t fn, void *data);
>  int perf_config_int(int *dest, const char *, const char *);
>  int perf_config_u8(u8 *dest, const char *name, const char *value);
>  int perf_config_u64(u64 *dest, const char *, const char *);
> @@ -37,6 +39,7 @@ int config_error_nonbool(const char *);
>  const char *perf_etc_perfconfig(void);
>  
>  struct perf_config_set *perf_config_set__new(void);
> +struct perf_config_set *perf_config_set__load_file(const char *file);
>  void perf_config_set__delete(struct perf_config_set *set);
>  int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
>  			     const char *var, const char *value);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
