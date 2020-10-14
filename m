Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3E28E32D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgJNPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgJNPWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:22:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A851221582;
        Wed, 14 Oct 2020 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602688935;
        bh=0CQoVzLVG8TWvLAgp5VYz2n9MqBBEV38H3lJ7gPA4Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7//f+Cp3741Hy5nqd/ek211jTTtxAh5DdT7M1N3f6VxY4HAYwUaDs/gN2lIYCQaG
         xX7XfFgibtnuWfdCvWtwn4PJbkW4Fez2tQ/g9WECjYCq7SzOG8GgiCQpAqy7iEeaWI
         r5KmH4OdHB5hQwHLJvJqb1h0gK2xgIGHmrBpM0TA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E63E4047F; Wed, 14 Oct 2020 12:22:12 -0300 (-03)
Date:   Wed, 14 Oct 2020 12:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf: Add support for exclusive groups/events
Message-ID: <20201014152212.GJ3100363@kernel.org>
References: <20201014144255.22699-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014144255.22699-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 14, 2020 at 07:42:55AM -0700, Andi Kleen escreveu:
> Peter suggested that using the exclusive mode in perf could
> avoid some problems with bad scheduling of groups. Exclusive
> is implemented in the kernel, but wasn't exposed by the perf tool,
> so hard to use without custom low level API users.
> 
> Add support for marking groups or events with :e for exclusive
> in the perf tool.  The implementation is basically the same as the
> existing pinned attribute.
> 
> Cc: peterz@infradead.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Jiri, I'm taking you "I'm ok" with this as an Acked-by, thanks

- Arnaldo

 
> --
> 
> v2: Update check_modifier too (Jiri)
> ---
>  tools/perf/Documentation/perf-list.txt |  1 +
>  tools/perf/tests/parse-events.c        | 58 +++++++++++++++++++++++++-
>  tools/perf/util/parse-events.c         | 11 ++++-
>  tools/perf/util/parse-events.l         |  2 +-
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 10ed539a8859..4c7db1da8fcc 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -58,6 +58,7 @@ counted. The following modifiers exist:
>   S - read sample value (PERF_SAMPLE_READ)
>   D - pin the event to the PMU
>   W - group is weak and will fallback to non-group if not schedulable,
> + e - group or event are exclusive and do not share the PMU
>  
>  The 'p' modifier can be used for specifying how precise the instruction
>  address should be. The 'p' modifier can be specified multiple times:
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 7f9f87a470c3..7411dd4d76cf 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -557,6 +557,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
> +	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
>  
>  	return 0;
>  }
> @@ -575,6 +576,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
> +	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
>  
>  	/* cpu/pmu-event/u*/
>  	evsel = evsel__next(evsel);
> @@ -587,6 +589,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
> +	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.pinned);
>  
>  	return 0;
>  }
> @@ -1277,6 +1280,49 @@ static int test__pinned_group(struct evlist *evlist)
>  	return 0;
>  }
>  
> +static int test__checkevent_exclusive_modifier(struct evlist *evlist)
> +{
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
> +
> +	return test__checkevent_symbolic_name(evlist);
> +}
> +
> +static int test__exclusive_group(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *leader;
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
> +
> +	/* cycles - group leader */
> +	evsel = leader = evlist__first(evlist);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
> +	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
> +
> +	/* cache-misses - can not be pinned, but will go on with the leader */
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
> +
> +	/* branch-misses - ditto */
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong config",
> +			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
> +
> +	return 0;
> +}
>  static int test__checkevent_breakpoint_len(struct evlist *evlist)
>  {
>  	struct evsel *evsel = evlist__first(evlist);
> @@ -1765,7 +1811,17 @@ static struct evlist_test test__events[] = {
>  		.name  = "cycles:k",
>  		.check = test__sym_event_dc,
>  		.id    = 55,
> -	}
> +	},
> +	{
> +		.name  = "instructions:uep",
> +		.check = test__checkevent_exclusive_modifier,
> +		.id    = 56,
> +	},
> +	{
> +		.name  = "{cycles,cache-misses,branch-misses}:e",
> +		.check = test__exclusive_group,
> +		.id    = 57,
> +	},
>  };
>  
>  static struct evlist_test test__events_pmu[] = {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9f7260e69113..c4da6bf6ff6a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1768,6 +1768,7 @@ struct event_modifier {
>  	int sample_read;
>  	int pinned;
>  	int weak;
> +	int exclusive;
>  };
>  
>  static int get_event_modifier(struct event_modifier *mod, char *str,
> @@ -1783,6 +1784,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>  	int precise_max = 0;
>  	int sample_read = 0;
>  	int pinned = evsel ? evsel->core.attr.pinned : 0;
> +	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
>  
>  	int exclude = eu | ek | eh;
>  	int exclude_GH = evsel ? evsel->exclude_GH : 0;
> @@ -1824,6 +1826,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>  			sample_read = 1;
>  		} else if (*str == 'D') {
>  			pinned = 1;
> +		} else if (*str == 'e') {
> +			exclusive = 1;
>  		} else if (*str == 'W') {
>  			weak = 1;
>  		} else
> @@ -1857,6 +1861,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>  	mod->sample_read = sample_read;
>  	mod->pinned = pinned;
>  	mod->weak = weak;
> +	mod->exclusive = exclusive;
>  
>  	return 0;
>  }
> @@ -1870,7 +1875,7 @@ static int check_modifier(char *str)
>  	char *p = str;
>  
>  	/* The sizeof includes 0 byte as well. */
> -	if (strlen(str) > (sizeof("ukhGHpppPSDIW") - 1))
> +	if (strlen(str) > (sizeof("ukhGHpppPSDIWe") - 1))
>  		return -1;
>  
>  	while (*p) {
> @@ -1912,8 +1917,10 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
>  		evsel->precise_max         = mod.precise_max;
>  		evsel->weak_group	   = mod.weak;
>  
> -		if (evsel__is_group_leader(evsel))
> +		if (evsel__is_group_leader(evsel)) {
>  			evsel->core.attr.pinned = mod.pinned;
> +			evsel->core.attr.exclusive = mod.exclusive;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 3ca5fd2829ca..9db5097317f4 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
>  /* If you add a modifier you need to update check_modifier() */
> -modifier_event	[ukhpPGHSDIW]+
> +modifier_event	[ukhpPGHSDIWe]+
>  modifier_bp	[rwx]{1,3}
>  
>  %%
> -- 
> 2.28.0
> 

-- 

- Arnaldo
