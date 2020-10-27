Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B088A29BF55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793683AbgJ0PHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789695AbgJ0PCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:02:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B5182071A;
        Tue, 27 Oct 2020 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603810952;
        bh=UPPTxSVZb7GIjOsYLuXonGX0qXcz5ULeSLysZUDilyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlJSCia1GZ/Rhbz+B03No+jpTjgOFSVdZ3e6v9hQIaYtqiQ0pPoNngUkbmqVAaniB
         G/LL85l2Bt3MXg02ltqHg1XK7Fv3fZv3GIHqkPB6ZUqKdfBSya6Nd8sZ5C9D7N+TOK
         w9qocebBzTJjhA3WiUKisejOaFXFq3lxvATaRZYQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FA9E403C2; Tue, 27 Oct 2020 12:02:29 -0300 (-03)
Date:   Tue, 27 Oct 2020 12:02:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 2/2] perf stat: Support regex pattern in
 --for-each-cgroup
Message-ID: <20201027150229.GD2479604@kernel.org>
References: <20201027072855.655449-1-namhyung@kernel.org>
 <20201027072855.655449-2-namhyung@kernel.org>
 <20201027134421.GI2900849@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027134421.GI2900849@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 27, 2020 at 02:44:21PM +0100, Jiri Olsa escreveu:
> On Tue, Oct 27, 2020 at 04:28:55PM +0900, Namhyung Kim wrote:
> > To make the command line even more compact with cgroups, support regex
> > pattern matching in cgroup names.
> > 
> >   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> > 
> >           3,000.73 msec cpu-clock                 foo #    2.998 CPUs utilized
> >     12,530,992,699      cycles                    foo #    7.517 GHz                      (100.00%)
> >           1,000.61 msec cpu-clock                 foo/bar #    1.000 CPUs utilized
> >      4,178,529,579      cycles                    foo/bar #    2.506 GHz                      (100.00%)
> >           1,000.03 msec cpu-clock                 foo/baz #    0.999 CPUs utilized
> >      4,176,104,315      cycles                    foo/baz #    2.505 GHz                      (100.00%)
> > 
> >        1.000892614 seconds time elapsed
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied both patches.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/Documentation/perf-stat.txt |   5 +-
> >  tools/perf/builtin-stat.c              |   5 +-
> >  tools/perf/util/cgroup.c               | 198 ++++++++++++++++++++++---
> >  3 files changed, 182 insertions(+), 26 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > index 9f9f29025e49..2b44c08b3b23 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -168,8 +168,9 @@ command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
> >  
> >  --for-each-cgroup name::
> >  Expand event list for each cgroup in "name" (allow multiple cgroups separated
> > -by comma).  This has same effect that repeating -e option and -G option for
> > -each event x name.  This option cannot be used with -G/--cgroup option.
> > +by comma).  It also support regex patterns to match multiple groups.  This has same
> > +effect that repeating -e option and -G option for each event x name.  This option
> > +cannot be used with -G/--cgroup option.
> >  
> >  -o file::
> >  --output file::
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index b01af171d94f..6709578128c9 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2235,8 +2235,11 @@ int cmd_stat(int argc, const char **argv)
> >  		}
> >  
> >  		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
> > -					  &stat_config.metric_events, true) < 0)
> > +					  &stat_config.metric_events, true) < 0) {
> > +			parse_options_usage(stat_usage, stat_options,
> > +					    "for-each-cgroup", 0);
> >  			goto out;
> > +		}
> >  	}
> >  
> >  	target__validate(&target);
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index b81324a13a2b..704333748549 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -13,9 +13,19 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <api/fs/fs.h>
> > +#include <ftw.h>
> > +#include <regex.h>
> >  
> >  int nr_cgroups;
> >  
> > +/* used to match cgroup name with patterns */
> > +struct cgroup_name {
> > +	struct list_head list;
> > +	bool used;
> > +	char name[];
> > +};
> > +static LIST_HEAD(cgroup_list);
> > +
> >  static int open_cgroup(const char *name)
> >  {
> >  	char path[PATH_MAX + 1];
> > @@ -149,6 +159,137 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup)
> >  		evsel__set_default_cgroup(evsel, cgroup);
> >  }
> >  
> > +/* helper function for ftw() in match_cgroups and list_cgroups */
> > +static int add_cgroup_name(const char *fpath, const struct stat *sb __maybe_unused,
> > +			   int typeflag)
> > +{
> > +	struct cgroup_name *cn;
> > +
> > +	if (typeflag != FTW_D)
> > +		return 0;
> > +
> > +	cn = malloc(sizeof(*cn) + strlen(fpath) + 1);
> > +	if (cn == NULL)
> > +		return -1;
> > +
> > +	cn->used = false;
> > +	strcpy(cn->name, fpath);
> > +
> > +	list_add_tail(&cn->list, &cgroup_list);
> > +	return 0;
> > +}
> > +
> > +static void release_cgroup_list(void)
> > +{
> > +	struct cgroup_name *cn;
> > +
> > +	while (!list_empty(&cgroup_list)) {
> > +		cn = list_first_entry(&cgroup_list, struct cgroup_name, list);
> > +		list_del(&cn->list);
> > +		free(cn);
> > +	}
> > +}
> > +
> > +/* collect given cgroups only */
> > +static int list_cgroups(const char *str)
> > +{
> > +	const char *p, *e, *eos = str + strlen(str);
> > +	struct cgroup_name *cn;
> > +	char *s;
> > +
> > +	/* use given name as is - for testing purpose */
> > +	for (;;) {
> > +		p = strchr(str, ',');
> > +		e = p ? p : eos;
> > +
> > +		if (e - str) {
> > +			int ret;
> > +
> > +			s = strndup(str, e - str);
> > +			if (!s)
> > +				return -1;
> > +			/* pretend if it's added by ftw() */
> > +			ret = add_cgroup_name(s, NULL, FTW_D);
> > +			free(s);
> > +			if (ret)
> > +				return -1;
> > +		} else {
> > +			if (add_cgroup_name("", NULL, FTW_D) < 0)
> > +				return -1;
> > +		}
> > +
> > +		if (!p)
> > +			break;
> > +		str = p+1;
> > +	}
> > +
> > +	/* these groups will be used */
> > +	list_for_each_entry(cn, &cgroup_list, list)
> > +		cn->used = true;
> > +
> > +	return 0;
> > +}
> > +
> > +/* collect all cgroups first and then match with the pattern */
> > +static int match_cgroups(const char *str)
> > +{
> > +	char mnt[PATH_MAX];
> > +	const char *p, *e, *eos = str + strlen(str);
> > +	struct cgroup_name *cn;
> > +	regex_t reg;
> > +	int prefix_len;
> > +	char *s;
> > +
> > +	if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event"))
> > +		return -1;
> > +
> > +	/* cgroup_name will have a full path, skip the root directory */
> > +	prefix_len = strlen(mnt);
> > +
> > +	/* collect all cgroups in the cgroup_list */
> > +	if (ftw(mnt, add_cgroup_name, 20) < 0)
> > +		return -1;
> > +
> > +	for (;;) {
> > +		p = strchr(str, ',');
> > +		e = p ? p : eos;
> > +
> > +		/* allow empty cgroups, i.e., skip */
> > +		if (e - str) {
> > +			/* termination added */
> > +			s = strndup(str, e - str);
> > +			if (!s)
> > +				return -1;
> > +			if (regcomp(&reg, s, REG_NOSUB)) {
> > +				free(s);
> > +				return -1;
> > +			}
> > +
> > +			/* check cgroup name with the pattern */
> > +			list_for_each_entry(cn, &cgroup_list, list) {
> > +				char *name = cn->name + prefix_len;
> > +
> > +				if (name[0] == '/' && name[1])
> > +					name++;
> > +				if (!regexec(&reg, name, 0, NULL, 0))
> > +					cn->used = true;
> > +			}
> > +			regfree(&reg);
> > +			free(s);
> > +		} else {
> > +			/* first entry to root cgroup */
> > +			cn = list_first_entry(&cgroup_list, struct cgroup_name,
> > +					      list);
> > +			cn->used = true;
> > +		}
> > +
> > +		if (!p)
> > +			break;
> > +		str = p+1;
> > +	}
> > +	return prefix_len;
> > +}
> > +
> >  int parse_cgroups(const struct option *opt, const char *str,
> >  		  int unset __maybe_unused)
> >  {
> > @@ -201,6 +342,11 @@ int parse_cgroups(const struct option *opt, const char *str,
> >  	return 0;
> >  }
> >  
> > +static bool has_pattern_string(const char *str)
> > +{
> > +	return !!strpbrk(str, "{}[]()|*+?^$");
> > +}
> > +
> >  int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> >  			  struct rblist *metric_events, bool open_cgroup)
> >  {
> > @@ -208,8 +354,9 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> >  	struct evsel *pos, *evsel, *leader;
> >  	struct rblist orig_metric_events;
> >  	struct cgroup *cgrp = NULL;
> > -	const char *p, *e, *eos = str + strlen(str);
> > +	struct cgroup_name *cn;
> >  	int ret = -1;
> > +	int prefix_len;
> >  
> >  	if (evlist->core.nr_entries == 0) {
> >  		fprintf(stderr, "must define events before cgroups\n");
> > @@ -234,24 +381,27 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> >  		rblist__init(&orig_metric_events);
> >  	}
> >  
> > -	for (;;) {
> > -		p = strchr(str, ',');
> > -		e = p ? p : eos;
> > +	if (has_pattern_string(str))
> > +		prefix_len = match_cgroups(str);
> > +	else
> > +		prefix_len = list_cgroups(str);
> >  
> > -		/* allow empty cgroups, i.e., skip */
> > -		if (e - str) {
> > -			/* termination added */
> > -			char *name = strndup(str, e - str);
> > -			if (!name)
> > -				goto out_err;
> > +	if (prefix_len < 0)
> > +		goto out_err;
> >  
> > -			cgrp = cgroup__new(name, open_cgroup);
> > -			free(name);
> > -			if (cgrp == NULL)
> > -				goto out_err;
> > -		} else {
> > -			cgrp = NULL;
> > -		}
> > +	list_for_each_entry(cn, &cgroup_list, list) {
> > +		char *name;
> > +
> > +		if (!cn->used)
> > +			continue;
> > +
> > +		/* cgroup_name might have a full path, skip the prefix */
> > +		name = cn->name + prefix_len;
> > +		if (name[0] == '/' && name[1])
> > +			name++;
> > +		cgrp = cgroup__new(name, open_cgroup);
> > +		if (cgrp == NULL)
> > +			goto out_err;
> >  
> >  		leader = NULL;
> >  		evlist__for_each_entry(orig_list, pos) {
> > @@ -277,23 +427,25 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> >  			if (metricgroup__copy_metric_events(tmp_list, cgrp,
> >  							    metric_events,
> >  							    &orig_metric_events) < 0)
> > -				break;
> > +				goto out_err;
> >  		}
> >  
> >  		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> >  		tmp_list->core.nr_entries = 0;
> > +	}
> >  
> > -		if (!p) {
> > -			ret = 0;
> > -			break;
> > -		}
> > -		str = p+1;
> > +	if (list_empty(&evlist->core.entries)) {
> > +		fprintf(stderr, "no cgroup matched: %s\n", str);
> > +		goto out_err;
> >  	}
> >  
> > +	ret = 0;
> > +
> >  out_err:
> >  	evlist__delete(orig_list);
> >  	evlist__delete(tmp_list);
> >  	rblist__exit(&orig_metric_events);
> > +	release_cgroup_list();
> >  
> >  	return ret;
> >  }
> > -- 
> > 2.29.0.rc2.309.g374f81d7ae-goog
> > 
> 

-- 

- Arnaldo
