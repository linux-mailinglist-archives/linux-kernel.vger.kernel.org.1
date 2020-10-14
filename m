Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0628E1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgJNNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgJNNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602683393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QEmxJLiT1wHeNPWeuMQam02BQ0ZmlXtwVvgC9s9VEA=;
        b=QFgNg8RwJkH/wQOxb3TsLjgJXiSAiFncgiC1OAiDKozO62D8LGOdcrub9GniTB57fwxSEB
        xpILR4lYLAJUwzl/VEMDWY4Rh/Y55O+6vl5P8b+fRoeRhbslWcdhS6eujSbPZidPofpwaS
        ibut65ZX6CYJLnQnBl79H4ogANXLFnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Tvzl8CbCObCq5viflTFpLQ-1; Wed, 14 Oct 2020 09:49:51 -0400
X-MC-Unique: Tvzl8CbCObCq5viflTFpLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCFC78797D3;
        Wed, 14 Oct 2020 13:49:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D44F60C0F;
        Wed, 14 Oct 2020 13:49:48 +0000 (UTC)
Date:   Wed, 14 Oct 2020 15:49:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf: Add support for exclusive groups/events
Message-ID: <20201014134947.GA1395746@krava>
References: <20201014035203.4354-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014035203.4354-1-andi@firstfloor.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 08:52:03PM -0700, Andi Kleen wrote:
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
> ---
>  tools/perf/Documentation/perf-list.txt |  1 +
>  tools/perf/tests/parse-events.c        | 58 +++++++++++++++++++++++++-
>  tools/perf/util/parse-events.c         |  9 +++-
>  tools/perf/util/parse-events.l         |  2 +-
>  4 files changed, 67 insertions(+), 3 deletions(-)
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
> index 9f7260e69113..760506f7a87a 100644
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

please update also check_modifier function as the comment
suggests, other than that it looks good to me

thanks,
jrka


> -modifier_event	[ukhpPGHSDIW]+
> +modifier_event	[ukhpPGHSDIWe]+
>  modifier_bp	[rwx]{1,3}
>  
>  %%
> -- 
> 2.28.0
> 

