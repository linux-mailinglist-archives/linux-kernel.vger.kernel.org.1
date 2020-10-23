Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC2296A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375762AbgJWHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374510AbgJWHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:42:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A914DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:42:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so518180pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnTlgTGQOBWDFz3JgBcHIU+xNf8Nl884zoAHdXf3D6Q=;
        b=UkYIC54WzDPOHhDRc637UwX58Hz+FVl13MSLCU7naxTgverctDiRVat0O23ZJAjOkK
         UxLmhRXWZbMmIYD1yZzSe+ogCQlJfPH1+Ythf5rDwbLqmTNsXjFSC4DBnd/oixMnq/H6
         EEyoCOmC6ij8YwOr/kdpp2OYWlrwfSuYCjGA4ckOG+7uE9oGtSlQ2X9nvSiJRUVmTiMT
         YkHyIpk+T7FxiPtGfoGjnSChc5l//pvppMwW1bhr6odKmdT/iyPHGwu7tVQ54enm+Kdr
         huD0eQM3KzzpqIqcC0c0m9Mqm2uFj8FXbamK0Mb65/kaAy9rPITBvSrDoJoQusujLXqp
         hUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QnTlgTGQOBWDFz3JgBcHIU+xNf8Nl884zoAHdXf3D6Q=;
        b=G0Ijli7aYVA/DodjltgEXiJGiUR2Z9QHfVm4JgaJLrKKb3SdyIaIHfaNt1yYtsPndN
         4j4OYM1q8AQJvRq0Dgqj8zr2O876ZJd2zp2aBIDokQsoGS0JTejcl+klOtDhKgqzncdc
         1m9dp//3a7zMlL0AwfSwWlv/ilXAlDp86+DuEFuvWbaSkjRAu0/pZlVeMqpROhm00dWw
         tBJi2FjdoptKENu1EYrTklKxojM4SnBKwYxpfWDWAXpiyctZDql54fIbhWk86wUjb9/A
         OLoO6zHBLgIiwLEoXmxIJtAwmB/B8FcwhF+uyUwA/lM4m+ssGnzjvickweBUFdtd9oN3
         8oCQ==
X-Gm-Message-State: AOAM5336MLh8HxO6DHF66mAyOzv7hn0tLBcqGQ080jSRry6ORf7/zgnr
        6unfA+bMN1emaqaNYyip4HE=
X-Google-Smtp-Source: ABdhPJxLzwQuemUa02cfRN8eZg4hCe4mGG+P/GMpqxnbKXH1tH2dryJL/WFomcAVAJGh0m5NVo5kQA==
X-Received: by 2002:a17:90a:7188:: with SMTP id i8mr1129110pjk.76.1603438961135;
        Fri, 23 Oct 2020 00:42:41 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id k3sm962896pff.71.2020.10.23.00.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:42:40 -0700 (PDT)
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
Subject: [PATCH] perf stat: Support regex pattern in --for-each-cgroup
Date:   Fri, 23 Oct 2020 16:42:34 +0900
Message-Id: <20201023074234.395002-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the command line even more compact with cgroups, support regex
pattern matching in cgroup names.

  $ perf stat -a -e cpu-clock,cycles --for-each-cgroup '^.$' sleep 1

   Performance counter stats for 'system wide':

            992.90 msec cpu-clock                 A #    0.992 CPUs utilized
     4,155,444,322      cycles                    A #    4.204 GHz                      (100.00%)
            988.53 msec cpu-clock                 B #    0.988 CPUs utilized
     4,137,114,788      cycles                    B #    4.185 GHz                      (100.00%)
            983.94 msec cpu-clock                 C #    0.983 CPUs utilized
     4,117,862,551      cycles                    C #    4.166 GHz                      (99.99%)

       1.000975519 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 192 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 168 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b81324a13a2b..127c2411fb9f 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -13,9 +13,19 @@
 #include <stdlib.h>
 #include <string.h>
 #include <api/fs/fs.h>
+#include <ftw.h>
+#include <regex.h>
 
 int nr_cgroups;
 
+/* used to match cgroup name with patterns */
+struct cgroup_name {
+	struct list_head list;
+	bool used;
+	char name[];
+};
+static LIST_HEAD(cgroup_list);
+
 static int open_cgroup(const char *name)
 {
 	char path[PATH_MAX + 1];
@@ -149,6 +159,137 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup)
 		evsel__set_default_cgroup(evsel, cgroup);
 }
 
+/* helper function for ftw() in match_cgroups and list_cgroups */
+static int add_cgroup_name(const char *fpath, const struct stat *sb __maybe_unused,
+			   int typeflag)
+{
+	struct cgroup_name *cn;
+
+	if (typeflag != FTW_D)
+		return 0;
+
+	cn = malloc(sizeof(*cn) + strlen(fpath) + 1);
+	if (cn == NULL)
+		return -1;
+
+	cn->used = false;
+	strcpy(cn->name, fpath);
+
+	list_add_tail(&cn->list, &cgroup_list);
+	return 0;
+}
+
+static void release_cgroup_list(void)
+{
+	struct cgroup_name *cn;
+
+	while (!list_empty(&cgroup_list)) {
+		cn = list_first_entry(&cgroup_list, struct cgroup_name, list);
+		list_del(&cn->list);
+		free(cn);
+	}
+}
+
+/* collect given cgroups only */
+static int list_cgroups(const char *str)
+{
+	const char *p, *e, *eos = str + strlen(str);
+	struct cgroup_name *cn;
+	char *s;
+
+	/* use given name as is - for testing purpose */
+	for (;;) {
+		p = strchr(str, ',');
+		e = p ? p : eos;
+
+		if (e - str) {
+			int ret;
+
+			s = strndup(str, e - str);
+			if (!s)
+				return -1;
+			/* pretend if it's added by ftw() */
+			ret = add_cgroup_name(s, NULL, FTW_D);
+			free(s);
+			if (ret)
+				return -1;
+		} else {
+			if (add_cgroup_name("", NULL, FTW_D) < 0)
+				return -1;
+		}
+
+		if (!p)
+			break;
+		str = p+1;
+	}
+
+	/* these groups will be used */
+	list_for_each_entry(cn, &cgroup_list, list)
+		cn->used = true;
+
+	return 0;
+}
+
+/* collect all cgroups first and then match with the pattern */
+static int match_cgroups(const char *str)
+{
+	char mnt[PATH_MAX];
+	const char *p, *e, *eos = str + strlen(str);
+	struct cgroup_name *cn;
+	regex_t reg;
+	int prefix_len;
+	char *s;
+
+	if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event"))
+		return -1;
+
+	/* cgroup_name will have a full path, skip the root directory */
+	prefix_len = strlen(mnt);
+
+	/* collect all cgroups in the cgroup_list */
+	if (ftw(mnt, add_cgroup_name, 20) < 0)
+		return -1;
+
+	for (;;) {
+		p = strchr(str, ',');
+		e = p ? p : eos;
+
+		/* allow empty cgroups, i.e., skip */
+		if (e - str) {
+			/* termination added */
+			s = strndup(str, e - str);
+			if (!s)
+				return -1;
+			if (regcomp(&reg, s, REG_NOSUB)) {
+				free(s);
+				return -1;
+			}
+
+			/* check cgroup name with the pattern */
+			list_for_each_entry(cn, &cgroup_list, list) {
+				char *name = cn->name + prefix_len;
+
+				if (name[0] == '/' && name[1])
+					name++;
+				if (!regexec(&reg, name, 0, NULL, 0))
+					cn->used = true;
+			}
+			regfree(&reg);
+			free(s);
+		} else {
+			/* first entry to root cgroup */
+			cn = list_first_entry(&cgroup_list, struct cgroup_name,
+					      list);
+			cn->used = true;
+		}
+
+		if (!p)
+			break;
+		str = p+1;
+	}
+	return prefix_len;
+}
+
 int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
@@ -201,6 +342,11 @@ int parse_cgroups(const struct option *opt, const char *str,
 	return 0;
 }
 
+static bool has_pattern_string(const char *str)
+{
+	return !!strpbrk(str, "{}[]()|*+?^$");
+}
+
 int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			  struct rblist *metric_events, bool open_cgroup)
 {
@@ -208,8 +354,9 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 	struct evsel *pos, *evsel, *leader;
 	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
-	const char *p, *e, *eos = str + strlen(str);
+	struct cgroup_name *cn;
 	int ret = -1;
+	int prefix_len;
 
 	if (evlist->core.nr_entries == 0) {
 		fprintf(stderr, "must define events before cgroups\n");
@@ -234,24 +381,25 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		rblist__init(&orig_metric_events);
 	}
 
-	for (;;) {
-		p = strchr(str, ',');
-		e = p ? p : eos;
+	if (has_pattern_string(str))
+		prefix_len = match_cgroups(str);
+	else
+		prefix_len = list_cgroups(str);
 
-		/* allow empty cgroups, i.e., skip */
-		if (e - str) {
-			/* termination added */
-			char *name = strndup(str, e - str);
-			if (!name)
-				goto out_err;
+	if (prefix_len < 0)
+		goto out_err;
 
-			cgrp = cgroup__new(name, open_cgroup);
-			free(name);
-			if (cgrp == NULL)
-				goto out_err;
-		} else {
-			cgrp = NULL;
-		}
+	list_for_each_entry(cn, &cgroup_list, list) {
+		char *name;
+
+		if (!cn->used)
+			continue;
+
+		/* cgroup_name might have a full path, skip the prefix */
+		name = cn->name + prefix_len;
+		if (name[0] == '/' && name[1])
+			name++;
+		cgrp = cgroup__new(name, open_cgroup);
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
@@ -277,23 +425,19 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			if (metricgroup__copy_metric_events(tmp_list, cgrp,
 							    metric_events,
 							    &orig_metric_events) < 0)
-				break;
+				goto out_err;
 		}
 
 		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
-
-		if (!p) {
-			ret = 0;
-			break;
-		}
-		str = p+1;
 	}
+	ret = 0;
 
 out_err:
 	evlist__delete(orig_list);
 	evlist__delete(tmp_list);
 	rblist__exit(&orig_metric_events);
+	release_cgroup_list();
 
 	return ret;
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog

