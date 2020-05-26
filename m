Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7941D19A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgEMPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:39:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF4C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:39:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f189so12102306qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MK5LRngF6BQgSj4JKvxT09SFckiTyyiP8svKTcR3CW8=;
        b=USMcQeG/kipibP+2wX9TIzVTLoGSK2J6Y+BlynCOQJWtchL9nAp2Vrx0S6LQppyHNa
         AT97Grv1Nr7EIrpT3GUp4rfeDs24rcnnOiY0Q69o7MjoGRm6Gw2Da4s+B/xn1+Qsyqui
         b7oa18YcGTfpxgmJ0+onqNqQ0ozhrk4gla6R5M9dPgwgb7MWUkz/ZmhZ4FwCl7MCopnp
         0zT1SfRA7sBs2zj/5CY4VVLzr1skl4zk6rGdF+cUBu8p5l9T1SZ9DGE+CGyGXtARXDQ8
         XVbuTecW3wXZusd//aao7jO1bNBl6Zb7ghtj3PewoNqo3+euBjmhPlM7FSXm9DYnZDMy
         S6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MK5LRngF6BQgSj4JKvxT09SFckiTyyiP8svKTcR3CW8=;
        b=TRdSJ91XPMxrbOEonqRkTIHwGEW9Nex7KXs+wRt03TdaVnbY2DZkzdpm6T2Ngize9i
         QJjZt899Tw0YsSDd+c/O9k0SlAiHNILqoVpVfLDZD/OOITpgIgcPst41ZTkVmX8ZsHNy
         XlWi2eG45e1x1dHnfW15Gw9iWx57wQILE4Wrhn3atXOxvU5Djw42KbVtLaroWyOjvG/P
         e4PTwXf2rAqkSpA55sP1FC/7W+sS/R4TGAMdlV14GK0H0EQwwmog//ebKmzHEEvE9bEQ
         fkfY8il5YexMRoTNQM8yVvzJAl/AGA7MmAxCFZGkU7ciuvGG5ClGOFEbO6/KNanhLGPn
         0/nw==
X-Gm-Message-State: AOAM533PuZlOqcwC+4cyLZd67/gHAVQcj9n2zCjrrpzGnrSuPRNzK8NG
        RljmJWEkvHPfpYMCQy4TukM=
X-Google-Smtp-Source: ABdhPJwE3OEN2hFBPOcKhsM7z9KfKryVzI1ZfNmZ3PtaphiQraIbzQVQ6sPJccbFyBQw7MiZiEq1cw==
X-Received: by 2002:a05:620a:62c:: with SMTP id 12mr291990qkv.234.1589384372863;
        Wed, 13 May 2020 08:39:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d196sm136686qkg.16.2020.05.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:39:32 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED82040AFD; Wed, 13 May 2020 12:39:29 -0300 (-03)
Date:   Wed, 13 May 2020 12:39:29 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/2] perf test: Improve pmu event metric testing
Message-ID: <20200513153929.GH5583@kernel.org>
References: <20200513062752.3681-1-irogers@google.com>
 <20200513062752.3681-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513062752.3681-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 11:27:52PM -0700, Ian Rogers escreveu:
> Break pmu-events test into 2 and add a test to verify that all pmu metric
> expressions simply parse. Try to parse all metric ids/events, warning if
> metrics for the current architecture fail to parse.
> 
> Tested on power9, skylakex, haswell, broadwell, westmere, sandybridge and
> ivybridge with the patch set in place.
> May fail on other architectures if metrics are invalid. In particular s390
> is untested, but its expressions are trivial. The event encodings could
> be wrong but are only warned about. The untested architectures with
> expressions are power8, cascadelakex, tremontx, skylake, jaketown, ivytown
> and variants of haswell and broadwell.
> 
> v2. changes the commit message as event parsing errors no longer cause
> the test to fail.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c |   5 +
>  tools/perf/tests/pmu-events.c   | 158 ++++++++++++++++++++++++++++++--
>  tools/perf/tests/tests.h        |   2 +
>  3 files changed, 159 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 3471ec52ea11..8147c17c71ab 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -75,6 +75,11 @@ static struct test generic_tests[] = {
>  	{
>  		.desc = "PMU events",
>  		.func = test__pmu_events,
> +		.subtest = {
> +			.get_nr		= test__pmu_events_subtest_get_nr,
> +			.get_desc	= test__pmu_events_subtest_get_desc,
> +		},
> +
>  	},
>  	{
>  		.desc = "DSO data read",
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d64261da8bf7..c18b9ce8cace 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -8,6 +8,10 @@
>  #include <linux/zalloc.h>
>  #include "debug.h"
>  #include "../pmu-events/pmu-events.h"
> +#include "util/evlist.h"
> +#include "util/expr.h"
> +#include "util/parse-events.h"
> +#include <ctype.h>

historically we have been using a ctype.h we got from the git tool
repository, its in:

  tools/include/linux/ctype.h

[acme@five perf]$ find tools/perf/ -name "*.[ch]" | xargs grep '<linux/ctype.h>' | wc -l
39
[acme@five perf]$ find tools/perf/ -name "*.[ch]" | xargs grep '<ctype.h>' | wc -l
2
[acme@five perf]$

[acme@five perf]$ find tools/perf/ -name "*.[ch]" | xargs grep '<ctype.h>'
tools/perf/pmu-events/jevents.c:#include <ctype.h>
tools/perf/util/scripting-engines/trace-event-perl.c:#include <ctype.h>
[acme@five perf]$
  
>  struct perf_pmu_test_event {
>  	struct pmu_event event;
> @@ -144,7 +148,7 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
>  }
>  
>  /* Verify generated events from pmu-events.c is as expected */
> -static int __test_pmu_event_table(void)
> +static int test_pmu_event_table(void)
>  {
>  	struct pmu_events_map *map = __test_pmu_get_events_map();
>  	struct pmu_event *table;
> @@ -347,14 +351,11 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>  	return res;
>  }
>  
> -int test__pmu_events(struct test *test __maybe_unused,
> -		     int subtest __maybe_unused)
> +
> +static int test_aliases(void)
>  {
>  	struct perf_pmu *pmu = NULL;
>  
> -	if (__test_pmu_event_table())
> -		return -1;
> -
>  	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  		int count = 0;
>  
> @@ -377,3 +378,148 @@ int test__pmu_events(struct test *test __maybe_unused,
>  
>  	return 0;
>  }
> +
> +static bool is_number(const char *str)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < strlen(str); i++) {
> +		if (!isdigit(str[i]) && str[i] != '.')
> +			return false;
> +	}
> +	return true;
> +}

The above can still get some wrong numbers, can't we instead use
strtold() and check its return value?

> +static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
> +{
> +	struct parse_events_error error;
> +	struct evlist *evlist;
> +	int ret;
> +
> +	/* Numbers are always valid. */
> +	if (is_number(id))
> +		return 0;
> +
> +	evlist = evlist__new();
> +	memset(&error, 0, sizeof(error));
> +	ret = parse_events(evlist, id, &error);
> +	if (ret && same_cpu) {
> +		fprintf(stderr,
> +			"\nWARNING: Parse event failed metric '%s' id '%s' expr '%s'\n",
> +			pe->metric_name, id, pe->metric_expr);
> +		fprintf(stderr, "Error string '%s' help '%s'\n",
> +			error.str, error.help);

Can we pr_warning() above to be consistent with using pr_debug3(), right
in the else branch?

> +	} else if (ret) {
> +		pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
> +			id, pe->metric_name, pe->metric_expr);
> +	}
> +	evlist__delete(evlist);
> +	free(error.str);
> +	free(error.help);
> +	free(error.first_str);
> +	free(error.first_help);
> +	/* TODO: too many metrics are broken to fail on this test currently. */
> +	return 0;

I was thinking if we could handle the failure of this specific
check_parse_id() in its caller differently and then, at the end, use
some marking like with:

58: builtin clang support                                 : Skip (not compiled in)

Perhaps: 

NN: Parsing of PMU event table metrics                    : Skip (Some metrics failed)

Or some other wording, perhaps a new return value in addition to skip,
fail, ok. That allows the test to continue but flags it as having issues
that should be checked with 'perf test -v'

> +}
> +
> +static int test_parsing(void)
> +{
> +	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	int i, j, k;
> +	const char **ids;
> +	int idnum;
> +	int ret = 0;
> +	struct expr_parse_ctx ctx;
> +	double result;
> +
> +	i = 0;
> +	for (;;) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			map = NULL;
> +			break;
> +		}
> +		j = 0;
> +		for (;;) {
> +			pe = &map->table[j++];
> +			if (!pe->name && !pe->metric_group && !pe->metric_name)
> +				break;
> +			if (!pe->metric_expr)
> +				continue;
> +			if (expr__find_other(pe->metric_expr, NULL,
> +						&ids, &idnum, 0) < 0) {
> +				pr_debug("Parse other failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);
> +				ret++;
> +				continue;
> +			}
> +			expr__ctx_init(&ctx);
> +
> +			/*
> +			 * Add all ids with a made up value. The value may
> +			 * trigger divide by zero when subtracted and so try to
> +			 * make them unique.
> +			 */
> +			for (k = 0; k < idnum; k++)
> +				expr__add_id(&ctx, ids[k], k + 1);
> +
> +			for (k = 0; k < idnum; k++) {
> +				if (check_parse_id(ids[k], map == cpus_map, pe))
> +					ret++;
> +			}
> +
> +			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> +				pr_debug("Parse failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);
> +				ret++;
> +			}
> +			for (k = 0; k < idnum; k++)
> +				zfree(&ids[k]);
> +			free(ids);
> +		}
> +	}
> +	return ret;
> +}
> +
> +static const struct {
> +	int (*func)(void);
> +	const char *desc;
> +} pmu_events_testcase_table[] = {
> +	{
> +		.func = test_pmu_event_table,
> +		.desc = "PMU event table sanity",
> +	},
> +	{
> +		.func = test_aliases,
> +		.desc = "PMU event map aliases",
> +	},
> +	{
> +		.func = test_parsing,
> +		.desc = "Parsing of PMU event table metrics",
> +	},
> +};
> +
> +const char *test__pmu_events_subtest_get_desc(int i)
> +{
> +	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +		return NULL;
> +	return pmu_events_testcase_table[i].desc;
> +}
> +
> +int test__pmu_events_subtest_get_nr(void)
> +{
> +	return (int)ARRAY_SIZE(pmu_events_testcase_table);
> +}
> +
> +int test__pmu_events(struct test *test __maybe_unused, int i)
> +{
> +	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +		return TEST_FAIL;
> +	return pmu_events_testcase_table[i].func();
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index d6d4ac34eeb7..8e316c30ed3c 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -50,6 +50,8 @@ int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
>  int test__syscall_openat_tp_fields(struct test *test, int subtest);
>  int test__pmu(struct test *test, int subtest);
>  int test__pmu_events(struct test *test, int subtest);
> +const char *test__pmu_events_subtest_get_desc(int subtest);
> +int test__pmu_events_subtest_get_nr(void);
>  int test__attr(struct test *test, int subtest);
>  int test__dso_data(struct test *test, int subtest);
>  int test__dso_data_cache(struct test *test, int subtest);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 

- Arnaldo
