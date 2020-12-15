Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6543A2DB046
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgLOPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbgLOPlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:41:46 -0500
Date:   Tue, 15 Dec 2020 12:41:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608046865;
        bh=3EvisKc98OBFF9zv6xZ4nmuhbaRRngq2LpQsymSenps=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQEnLIpwKjgTgBeCwCu1/RAH8YmESZpO4kz/4Ctm7DK1n0mXbr4QtcaTWg3MDXkrI
         2mIMpgcmcy4IR3+0yl6HwjkZn2yplgZP0bg2LXKeXIpeNKkYxb6KIHQGh8l5Xog9VM
         t3p2s6f97kfZ9028TOe40qWI4tsZlpGcFSvVSqeNvt7iOBkrMDF+FZtTEWWsVOb51r
         uHPClaxtd2mT+H8sN9iwXJCA+4/akAxu5Fe4G7EX86qQAD6Jo5l9TA9CostsGCFT57
         ECRS6299RiwxydY1KmsQlUuREYPq4eKrf1XawkS75SvUzNKmqpg+Ma5gBMPpddvYUz
         BXcP4yXzVcazw==
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
Subject: Re: [PATCH 3/8] perf tools: Add config set interface
Message-ID: <20201215154118.GD258566@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212104358.412065-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 12, 2020 at 11:43:53AM +0100, Jiri Olsa escreveu:
> Add interface to load config set from custom file
> by using perf_config_set__new_file function.
> 
> It will be used in perf daemon command to process
> custom config file.

The naming may be misleading, as this is not _setting_ the perf config
to be that one, but to apply a set of changes to whatever is the current
configuration, right?

Perhaps 'perf_config_set__load_file()'

There is value in _resetting_ the config to some configuration, i.e.
moving everything to the strict defaults and then loading a file that
sets the configuration to a state similar to what perf does when it
first starts.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/config.c | 28 +++++++++++++++++++++++-----
>  tools/perf/util/config.h |  3 +++
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 6969f82843ee..dc3f03f8bbf5 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -738,6 +738,18 @@ struct perf_config_set *perf_config_set__new(void)
>  	return set;
>  }
>  
> +struct perf_config_set *perf_config_set__new_file(const char *file)
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
> index 8c881e3a3ec3..f58b457e7e5f 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -30,6 +30,8 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
>  int perf_config_from_file(config_fn_t fn, const char *filename, void *data);
>  int perf_default_config(const char *, const char *, void *);
>  int perf_config(config_fn_t fn, void *);
> +int perf_config_set(struct perf_config_set *set,
> +		    config_fn_t fn, void *data);
>  int perf_config_int(int *dest, const char *, const char *);
>  int perf_config_u8(u8 *dest, const char *name, const char *value);
>  int perf_config_u64(u64 *dest, const char *, const char *);
> @@ -38,6 +40,7 @@ int config_error_nonbool(const char *);
>  const char *perf_etc_perfconfig(void);
>  
>  struct perf_config_set *perf_config_set__new(void);
> +struct perf_config_set *perf_config_set__new_file(const char *file);
>  void perf_config_set__delete(struct perf_config_set *set);
>  int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
>  			     const char *var, const char *value);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
