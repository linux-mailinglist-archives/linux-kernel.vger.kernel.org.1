Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94726CD80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIPVAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgIPQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942F320732;
        Wed, 16 Sep 2020 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264286;
        bh=G+GcwpnPsaY9VBxDq6CagaUGsxvNTNFkE5Z7g7piEj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX1bBNolNcGTLhlA76xhfF69xNE2JC7pRILvydUv9XylBy4ztSY4IzfNjT7837REp
         iQkdpjGHnF73M4PmlqVtxlhYwQ5+gn0zGcjydaCf4SOgLbCJz2joXGzS/U4crBYQrz
         xl3kcm5k61V0LYjc29s35xcQehi96kCPUXX949d4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90083400E9; Wed, 16 Sep 2020 10:51:23 -0300 (-03)
Date:   Wed, 16 Sep 2020 10:51:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/4] perf stat: Add --for-each-cgroup option
Message-ID: <20200916135123.GO720847@kernel.org>
References: <20200916063129.1061487-1-namhyung@kernel.org>
 <20200916063129.1061487-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916063129.1061487-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 03:31:27PM +0900, Namhyung Kim escreveu:
> The --for-each-cgroup option is a syntax sugar to monitor large number

You forgot to add the man page entry for this new option.

- Arnaldo

> of cgroups easily.  Current command line requires to list all the
> events and cgroups even if users want to monitor same events for each
> cgroup.  This patch addresses that usage by copying given events for
> each cgroup on user's behalf.
> 
> For instance, if they want to monitor 6 events for 200 cgroups each
> they should write 1200 event names (with -e) AND 1200 cgroup names
> (with -G) on the command line.  But with this change, they can just
> specify 6 events and 200 cgroups with a new option.
> 
> A simpler example below: It wants to measure 3 events for 2 cgroups
> ('A' and 'B').  The result is that total 6 events are counted like
> below.
> 
>   $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup A,B sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>               988.18 msec cpu-clock                 A #    0.987 CPUs utilized
>        3,153,761,702      cycles                    A #    3.200 GHz                      (100.00%)
>        8,067,769,847      instructions              A #    2.57  insn per cycle           (100.00%)
>               982.71 msec cpu-clock                 B #    0.982 CPUs utilized
>        3,136,093,298      cycles                    B #    3.182 GHz                      (99.99%)
>        8,109,619,327      instructions              B #    2.58  insn per cycle           (99.99%)
> 
>          1.001228054 seconds time elapsed
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 20 +++++++++-
>  tools/perf/util/cgroup.c  | 79 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cgroup.h  |  1 +
>  tools/perf/util/stat.h    |  1 +
>  4 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7f8d756d9408..a43e58e0a088 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1051,6 +1051,17 @@ static int parse_control_option(const struct option *opt,
>  	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack, &config->ctl_fd_close);
>  }
>  
> +static int parse_stat_cgroups(const struct option *opt,
> +			      const char *str, int unset)
> +{
> +	if (stat_config.cgroup_list) {
> +		pr_err("--cgroup and --for-each-cgroup cannot be used together\n");
> +		return -1;
> +	}
> +
> +	return parse_cgroups(opt, str, unset);
> +}
> +
>  static struct option stat_options[] = {
>  	OPT_BOOLEAN('T', "transaction", &transaction_run,
>  		    "hardware transaction statistics"),
> @@ -1094,7 +1105,9 @@ static struct option stat_options[] = {
>  	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
>  		   "print counts with custom separator"),
>  	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
> -		     "monitor event in cgroup name only", parse_cgroups),
> +		     "monitor event in cgroup name only", parse_stat_cgroups),
> +	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
> +		    "expand events for each cgroup"),
>  	OPT_STRING('o', "output", &output_name, "file", "output file name"),
>  	OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
>  	OPT_INTEGER(0, "log-fd", &output_fd,
> @@ -2234,6 +2247,11 @@ int cmd_stat(int argc, const char **argv)
>  	if (add_default_attributes())
>  		goto out;
>  
> +	if (stat_config.cgroup_list) {
> +		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list) < 0)
> +			goto out;
> +	}
> +
>  	target__validate(&target);
>  
>  	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 050dea9f1e88..01e0a6207207 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -12,6 +12,7 @@
>  #include <api/fs/fs.h>
>  
>  int nr_cgroups;
> +bool multiply_cgroup;
>  
>  static int open_cgroup(const char *name)
>  {
> @@ -156,6 +157,10 @@ int parse_cgroups(const struct option *opt, const char *str,
>  		return -1;
>  	}
>  
> +	/* delay processing cgroups after it sees all events */
> +	if (multiply_cgroup)
> +		return 0;
> +
>  	for (;;) {
>  		p = strchr(str, ',');
>  		e = p ? p : eos;
> @@ -193,6 +198,80 @@ int parse_cgroups(const struct option *opt, const char *str,
>  	return 0;
>  }
>  
> +int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> +{
> +	struct evlist *orig_list, *tmp_list;
> +	struct evsel *pos, *evsel, *leader;
> +	struct cgroup *cgrp = NULL;
> +	const char *p, *e, *eos = str + strlen(str);
> +	int ret = -1;
> +
> +	if (evlist->core.nr_entries == 0) {
> +		fprintf(stderr, "must define events before cgroups\n");
> +		return -EINVAL;
> +	}
> +
> +	orig_list = evlist__new();
> +	tmp_list = evlist__new();
> +	if (orig_list == NULL || tmp_list == NULL) {
> +		fprintf(stderr, "memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* save original events and init evlist */
> +	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
> +	evlist->core.nr_entries = 0;
> +
> +	for (;;) {
> +		p = strchr(str, ',');
> +		e = p ? p : eos;
> +
> +		/* allow empty cgroups, i.e., skip */
> +		if (e - str) {
> +			/* termination added */
> +			char *name = strndup(str, e - str);
> +			if (!name)
> +				break;
> +
> +			cgrp = cgroup__new(name);
> +			free(name);
> +			if (cgrp == NULL)
> +				break;
> +		} else {
> +			cgrp = NULL;
> +		}
> +
> +		leader = NULL;
> +		evlist__for_each_entry(orig_list, pos) {
> +			evsel = evsel__clone(pos);
> +			cgroup__put(evsel->cgrp);
> +			evsel->cgrp = cgroup__get(cgrp);
> +
> +			if (evsel__is_group_leader(pos))
> +				leader = evsel;
> +			evsel->leader = leader;
> +
> +			evlist__add(tmp_list, evsel);
> +		}
> +		/* cgroup__new() has a refcount, release it here */
> +		cgroup__put(cgrp);
> +		nr_cgroups++;
> +
> +		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> +		tmp_list->core.nr_entries = 0;
> +
> +		if (!p) {
> +			ret = 0;
> +			break;
> +		}
> +		str = p+1;
> +	}
> +	evlist__delete(orig_list);
> +	evlist__delete(tmp_list);
> +
> +	return ret;
> +}
> +
>  static struct cgroup *__cgroup__findnew(struct rb_root *root, uint64_t id,
>  					bool create, const char *path)
>  {
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index e98d5975fe55..32893018296f 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -24,6 +24,7 @@ void cgroup__put(struct cgroup *cgroup);
>  struct evlist;
>  
>  struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
> +int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups);
>  
>  void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
>  
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 9911fc6adbfd..7325de5bf2a6 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -137,6 +137,7 @@ struct perf_stat_config {
>  	int			 ctl_fd;
>  	int			 ctl_fd_ack;
>  	bool			 ctl_fd_close;
> +	const char		*cgroup_list;
>  };
>  
>  void perf_stat__set_big_num(int set);
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
