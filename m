Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B092DB098
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgLOPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbgLOPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:54:17 -0500
Date:   Tue, 15 Dec 2020 12:53:50 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047616;
        bh=IfkzvFyQ6gi7gVjWCwwrP2gFrlMuEuJNzOElKsi6Tew=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeyeXs1z2qtaYj29yEeUamuGa0f1cAQxn5YVJfelluV+TB8Jd23Wif63H80lGjVMQ
         eyrSvm58p9K7/iRVCnjv7856/KVeWqrI7WAv2xAzn6v+tD+HsZG+/rWhRnfewpaSiw
         M02+1zxpYEwrrZsXfu0YVIdBbcgmQVFgjaKb9/7lGipMraixooB7oh9bY9/immENVV
         aeN7GPCVaasHTSZvX7R/bonnryZtmTf/oWfy4to+w00e2u5lYsXHWPfny4XLZMzPKg
         BZcJQywvf41bGjyevp5HO9OXJTSnH7auQvcCHi2QMHkFx/3DZNS+o2fhcKpx4jFqwS
         VwMGa5lCWeaRg==
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
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 13/15] perf buildid-cache: Add --debuginfod option
Message-ID: <20201215155350.GL258566@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-14-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214105457.543111-14-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 11:54:55AM +0100, Jiri Olsa escreveu:
> Adding --debuginfod option to specify debuginfod url and
> support to do that through config file as well.
> 
> Use following in ~/.perfconfig file:
> 
>   [buildid-cache]
>   debuginfod=http://192.168.122.174:8002

I was going to try and cherry-pick this one, but it is after other
changes that are dependent on other bits to be merged :-\

- Arnaldo
 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../perf/Documentation/perf-buildid-cache.txt |  6 ++++
>  tools/perf/Documentation/perf-config.txt      |  7 +++++
>  tools/perf/builtin-buildid-cache.c            | 28 +++++++++++++++++--
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
> index b77da5138bca..b9987d1399ca 100644
> --- a/tools/perf/Documentation/perf-buildid-cache.txt
> +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> @@ -84,6 +84,12 @@ OPTIONS
>  	used when creating a uprobe for a process that resides in a
>  	different mount namespace from the perf(1) utility.
>  
> +--debuginfod=URLs::
> +	Specify debuginfod URL to be used when retrieving perf.data binaries,
> +	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
> +
> +	  buildid-cache.debuginfod=http://192.168.122.174:8002
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 31069d8a5304..e3672c5d801b 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -238,6 +238,13 @@ buildid.*::
>  		cache location, or to disable it altogether. If you want to disable it,
>  		set buildid.dir to /dev/null. The default is $HOME/.debug
>  
> +buildid-cache.*::
> +	buildid-cache.debuginfod=URLs
> +		Specify debuginfod URLs to be used when retrieving perf.data binaries,
> +		it follows the same syntax as the DEBUGINFOD_URLS variable, like:
> +
> +		  buildid-cache.debuginfod=http://192.168.122.174:8002
> +
>  annotate.*::
>  	These are in control of addresses, jump function, source code
>  	in lines of assembly code from a specific program.
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index f0afb2c89e03..864597fd9cf6 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -27,6 +27,7 @@
>  #include "util/time-utils.h"
>  #include "util/util.h"
>  #include "util/probe-file.h"
> +#include "util/config.h"
>  #include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/zalloc.h>
> @@ -550,12 +551,21 @@ build_id_cache__add_perf_data(const char *path, bool all)
>  	return err;
>  }
>  
> +static int perf_buildid_cache_config(const char *var, const char *value, void *cb)
> +{
> +	const char **debuginfod = cb;
> +
> +	if (!strcmp(var, "buildid-cache.debuginfod"))
> +		*debuginfod = strdup(value);
> +
> +	return 0;
> +}
> +
>  int cmd_buildid_cache(int argc, const char **argv)
>  {
>  	struct strlist *list;
>  	struct str_node *pos;
> -	int ret = 0;
> -	int ns_id = -1;
> +	int ret, ns_id = -1;
>  	bool force = false;
>  	bool list_files = false;
>  	bool opts_flag = false;
> @@ -565,7 +575,8 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		   *purge_name_list_str = NULL,
>  		   *missing_filename = NULL,
>  		   *update_name_list_str = NULL,
> -		   *kcore_filename = NULL;
> +		   *kcore_filename = NULL,
> +		   *debuginfod = NULL;
>  	char sbuf[STRERR_BUFSIZE];
>  
>  	struct perf_data data = {
> @@ -590,6 +601,8 @@ int cmd_buildid_cache(int argc, const char **argv)
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
>  	OPT_STRING('u', "update", &update_name_list_str, "file list",
>  		    "file(s) to update"),
> +	OPT_STRING(0, "debuginfod", &debuginfod, "debuginfod url",
> +		    "set debuginfod url"),
>  	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
>  	OPT_END()
> @@ -599,6 +612,10 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		NULL
>  	};
>  
> +	ret = perf_config(perf_buildid_cache_config, &debuginfod);
> +	if (ret)
> +		return ret;
> +
>  	argc = parse_options(argc, argv, buildid_cache_options,
>  			     buildid_cache_usage, 0);
>  
> @@ -610,6 +627,11 @@ int cmd_buildid_cache(int argc, const char **argv)
>  	if (argc || !(list_files || opts_flag))
>  		usage_with_options(buildid_cache_usage, buildid_cache_options);
>  
> +	if (debuginfod) {
> +		pr_debug("DEBUGINFOD_URLS=%s\n", debuginfod);
> +		setenv("DEBUGINFOD_URLS", debuginfod, 1);
> +	}
> +
>  	/* -l is exclusive. It can not be used with other options. */
>  	if (list_files && opts_flag) {
>  		usage_with_options_msg(buildid_cache_usage,
> -- 
> 2.26.2
> 

-- 

- Arnaldo
