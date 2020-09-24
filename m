Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5492277153
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgIXMp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgIXMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so1813963pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHx91HNbfxPQXmY6ZrC1XdC105j8P9u6yOmyP0j9/hI=;
        b=VLxnwtY69hsTKyrrayocZTzxjddzNKdnklmCWZQnrWBiCUhzKIl3IJZZPaPIznCNfv
         ypyGNi4J+BeevFshYGxiT1rj851R9h3X5DxKtGYnwiJIq6jKMJ6bfZYt2bAivZy2xIkK
         3Jqij9JAVNovtt8rb06lj8QbmK6YzJb0N11jItFlIXik0BSGpwVOa1yERx0Cn6JnZ10I
         Oa/LSRPW8uWiw+EcQ7nO1pyHMpF9ovngqenFabYxm8SloAvabGQyYFihtMH6EHMVfrab
         rbinadXj48oYMUjImUBjZ7NHpo9MZF4wBWLLrjCn+K3NIM2q5P1UQWM2mGe+r5gpq+fS
         1qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zHx91HNbfxPQXmY6ZrC1XdC105j8P9u6yOmyP0j9/hI=;
        b=sFaAwIeJmE0l4axeJl6kOiGhKci/DBOxNOTKxnYGBx3wKyDpCclxhOzC5W9oH9X83N
         qWy2WtGtjx924cOYLIiNw02wRGfyFnfar/4xUjF2nqCahLsb47x4xoGZ0AgNlgKbEdpO
         Rw6pXb9I+e1D1Sm8CuTyNLqLb/0n97UAbMb8oncupeSKyA0hpNL3ij5Tp9dbmiRFAD+7
         mQCe+/dipJqomf3ovbhikszrv+p0/eyNKcPKQUipUlano7LSJdtyabQfxJqhK9wH1Ryc
         AiPNUJDUkNB3WtdDkvAWEaS5du9IyCcCe09fnuA3PEaV0P5EV+FhrjyRI8Sld1VZb23O
         HwAQ==
X-Gm-Message-State: AOAM531V6zVjksXyhHwx4d7JsAxIy3dN36Jvr+u60+lwsWmTOKrqtj10
        ccnCuL7D7NXGF80z3lBecBg=
X-Google-Smtp-Source: ABdhPJz+Ba8EoNdQCXQIfGAhKPV6tko2gLARMtUbg+6QnxOY+MkRhLtbqNjzXqlcbU3LjJ7lJ+zFuw==
X-Received: by 2002:aa7:9f04:0:b029:13e:d13d:a08c with SMTP id g4-20020aa79f040000b029013ed13da08cmr4438270pfr.35.1600951512362;
        Thu, 24 Sep 2020 05:45:12 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 194sm2690310pfy.44.2020.09.24.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:11 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/5] perf stat: Add --for-each-cgroup option
Date:   Thu, 24 Sep 2020 21:44:52 +0900
Message-Id: <20200924124455.336326-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924124455.336326-1-namhyung@kernel.org>
References: <20200924124455.336326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --for-each-cgroup option is a syntax sugar to monitor large number
of cgroups easily.  Current command line requires to list all the
events and cgroups even if users want to monitor same events for each
cgroup.  This patch addresses that usage by copying given events for
each cgroup on user's behalf.

For instance, if they want to monitor 6 events for 200 cgroups each
they should write 1200 event names (with -e) AND 1200 cgroup names
(with -G) on the command line.  But with this change, they can just
specify 6 events and 200 cgroups with a new option.

A simpler example below: It wants to measure 3 events for 2 cgroups
('A' and 'B').  The result is that total 6 events are counted like
below.

  $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup A,B sleep 1

   Performance counter stats for 'system wide':

              988.18 msec cpu-clock                 A #    0.987 CPUs utilized
       3,153,761,702      cycles                    A #    3.200 GHz                      (100.00%)
       8,067,769,847      instructions              A #    2.57  insn per cycle           (100.00%)
              982.71 msec cpu-clock                 B #    0.982 CPUs utilized
       3,136,093,298      cycles                    B #    3.182 GHz                      (99.99%)
       8,109,619,327      instructions              B #    2.58  insn per cycle           (99.99%)

         1.001228054 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  5 ++
 tools/perf/builtin-stat.c              | 27 ++++++++-
 tools/perf/util/cgroup.c               | 79 ++++++++++++++++++++++++++
 tools/perf/util/cgroup.h               |  1 +
 tools/perf/util/stat.h                 |  1 +
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5bf3d7ae4660..9f9f29025e49 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -166,6 +166,11 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
 If wanting to monitor, say, 'cycles' for a cgroup and also for system wide, this
 command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
 
+--for-each-cgroup name::
+Expand event list for each cgroup in "name" (allow multiple cgroups separated
+by comma).  This has same effect that repeating -e option and -G option for
+each event x name.  This option cannot be used with -G/--cgroup option.
+
 -o file::
 --output file::
 Print the output into the designated file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cbb2d977eec7..0c9e21a29795 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1060,6 +1060,17 @@ static int parse_control_option(const struct option *opt,
 	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack, &config->ctl_fd_close);
 }
 
+static int parse_stat_cgroups(const struct option *opt,
+			      const char *str, int unset)
+{
+	if (stat_config.cgroup_list) {
+		pr_err("--cgroup and --for-each-cgroup cannot be used together\n");
+		return -1;
+	}
+
+	return parse_cgroups(opt, str, unset);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1103,7 +1114,9 @@ static struct option stat_options[] = {
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
-		     "monitor event in cgroup name only", parse_cgroups),
+		     "monitor event in cgroup name only", parse_stat_cgroups),
+	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
+		    "expand events for each cgroup"),
 	OPT_STRING('o', "output", &output_name, "file", "output file name"),
 	OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
 	OPT_INTEGER(0, "log-fd", &output_fd,
@@ -2213,6 +2226,18 @@ int cmd_stat(int argc, const char **argv)
 	if (add_default_attributes())
 		goto out;
 
+	if (stat_config.cgroup_list) {
+		if (nr_cgroups > 0) {
+			pr_err("--cgroup and --for-each-cgroup cannot be used together\n");
+			parse_options_usage(stat_usage, stat_options, "G", 1);
+			parse_options_usage(NULL, stat_options, "for-each-cgroup", 0);
+			goto out;
+		}
+
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list) < 0)
+			goto out;
+	}
+
 	target__validate(&target);
 
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 050dea9f1e88..8b6a4fa49082 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -193,6 +193,85 @@ int parse_cgroups(const struct option *opt, const char *str,
 	return 0;
 }
 
+int evlist__expand_cgroup(struct evlist *evlist, const char *str)
+{
+	struct evlist *orig_list, *tmp_list;
+	struct evsel *pos, *evsel, *leader;
+	struct cgroup *cgrp = NULL;
+	const char *p, *e, *eos = str + strlen(str);
+	int ret = -1;
+
+	if (evlist->core.nr_entries == 0) {
+		fprintf(stderr, "must define events before cgroups\n");
+		return -EINVAL;
+	}
+
+	orig_list = evlist__new();
+	tmp_list = evlist__new();
+	if (orig_list == NULL || tmp_list == NULL) {
+		fprintf(stderr, "memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	/* save original events and init evlist */
+	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
+	evlist->core.nr_entries = 0;
+
+	for (;;) {
+		p = strchr(str, ',');
+		e = p ? p : eos;
+
+		/* allow empty cgroups, i.e., skip */
+		if (e - str) {
+			/* termination added */
+			char *name = strndup(str, e - str);
+			if (!name)
+				goto out_err;
+
+			cgrp = cgroup__new(name);
+			free(name);
+			if (cgrp == NULL)
+				goto out_err;
+		} else {
+			cgrp = NULL;
+		}
+
+		leader = NULL;
+		evlist__for_each_entry(orig_list, pos) {
+			evsel = evsel__clone(pos);
+			if (evsel == NULL)
+				goto out_err;
+
+			cgroup__put(evsel->cgrp);
+			evsel->cgrp = cgroup__get(cgrp);
+
+			if (evsel__is_group_leader(pos))
+				leader = evsel;
+			evsel->leader = leader;
+
+			evlist__add(tmp_list, evsel);
+		}
+		/* cgroup__new() has a refcount, release it here */
+		cgroup__put(cgrp);
+		nr_cgroups++;
+
+		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
+		tmp_list->core.nr_entries = 0;
+
+		if (!p) {
+			ret = 0;
+			break;
+		}
+		str = p+1;
+	}
+
+out_err:
+	evlist__delete(orig_list);
+	evlist__delete(tmp_list);
+
+	return ret;
+}
+
 static struct cgroup *__cgroup__findnew(struct rb_root *root, uint64_t id,
 					bool create, const char *path)
 {
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index e98d5975fe55..32893018296f 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -24,6 +24,7 @@ void cgroup__put(struct cgroup *cgroup);
 struct evlist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
+int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f36c8c92efa0..487010c624be 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -145,6 +145,7 @@ struct perf_stat_config {
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
+	const char		*cgroup_list;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.28.0.681.g6f77f65b4e-goog

