Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3D297A66
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759204AbgJXC7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759197AbgJXC7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:59:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3652C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:59:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o3so2720506pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XheX/kFTP+JtS/kBZQvEhFBFwVqWKBUyTf5LHTAAZSQ=;
        b=EljGXAKr5mk4lj5yygHIB2dm1IWm2mcBb7b8nQx6VO2iJOTNwQD/gN3ssj3/f9w+Ph
         wFRSc0ZaCVuoaH+y6GfKqMMagE66WTo8efZFfImSRFI5zKSlNqvwSJYKG9HkHutTOg0f
         bruyFDObYQsyV4+E2c1NuvPrUIr2HAfXbAZ+HtsZVAM7lAy3ios5YyPpbmD+L3A6N4xa
         L55uLBYgDnQE8eCUKGuDNRrW6PkSnKcb4JaeBi4c8vd/jcFcqIP3B8hHVgi5YL0rKM3s
         CC8QbnLwlc//kjMv6AhLDorOrWmeNR68UCSo8X3dkbuhfOGMh2RGe2Nmyd0pzb0Nm+nq
         s5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XheX/kFTP+JtS/kBZQvEhFBFwVqWKBUyTf5LHTAAZSQ=;
        b=oBUFZvBO1zJlEML+T28I0dHQsmdK5OgcRBefrqmrfzG9WCoPjZLyAFyeh0iOQ20gUL
         6GO+iNL/mrcesi2BS9lvmfka8+idumv6623FFn+9HyvFCsleR/eeDQ1vTOSJvV1aJseQ
         fZgIA7RV2/Sx7MdODom55ExxNcwvzJ0ab0Q+E3/RI0Wa6n0ZucjtlMRGofn3u256RSwl
         Tdln4FusqeaJOGrdLGXlMmORQLa11JOfeN9rCMnOz+016GC9+DrdmKXxGBfdfTz3D/65
         ieYQmoOcH4tZBtcm+DMTAOQMnaOdC5et5r8IIK7+NGMYG/rTpo4By+yjmFssP1MPrGOd
         CvVw==
X-Gm-Message-State: AOAM532SVmyeMyafRhxKSQROnJCE9EcKYKF/IiGrOdgoGRhcqMN16taF
        wd+gLPtSXlHxt4/wjm5yMYU=
X-Google-Smtp-Source: ABdhPJwbef3n2M/PRM++wKLausRyIHu1Kczl3FiQINPRfGzgUIJsNg7OcoO/+jyHGFEY4gcWMS259w==
X-Received: by 2002:aa7:96ce:0:b029:155:8c02:e74a with SMTP id h14-20020aa796ce0000b02901558c02e74amr1941161pfq.32.1603508368306;
        Fri, 23 Oct 2020 19:59:28 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id s10sm4038235pji.7.2020.10.23.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 19:59:27 -0700 (PDT)
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
Subject: [PATCH v2 2/2] perf stat: Support regex pattern in --for-each-cgroup
Date:   Sat, 24 Oct 2020 11:59:18 +0900
Message-Id: <20201024025918.453431-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201024025918.453431-1-namhyung@kernel.org>
References: <20201024025918.453431-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the command line even more compact with cgroups, support regex
pattern matching in cgroup names.

  $ perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1

          3,000.73 msec cpu-clock                 foo #    2.998 CPUs utilized
    12,530,992,699      cycles                    foo #    7.517 GHz                      (100.00%)
          1,000.61 msec cpu-clock                 foo/bar #    1.000 CPUs utilized
     4,178,529,579      cycles                    foo/bar #    2.506 GHz                      (100.00%)
          1,000.03 msec cpu-clock                 foo/baz #    0.999 CPUs utilized
     4,176,104,315      cycles                    foo/baz #    2.505 GHz                      (100.00%)

       1.000892614 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |   5 +-
 tools/perf/util/cgroup.c               | 192 +++++++++++++++++++++----
 2 files changed, 171 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9f9f29025e49..2b44c08b3b23 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -168,8 +168,9 @@ command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
 
 --for-each-cgroup name::
 Expand event list for each cgroup in "name" (allow multiple cgroups separated
-by comma).  This has same effect that repeating -e option and -G option for
-each event x name.  This option cannot be used with -G/--cgroup option.
+by comma).  It also support regex patterns to match multiple groups.  This has same
+effect that repeating -e option and -G option for each event x name.  This option
+cannot be used with -G/--cgroup option.
 
 -o file::
 --output file::
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

