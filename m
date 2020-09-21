Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81907271F32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIUJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:46:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0200C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so7170852pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq7vnVZtxuY6qci6Ve/X673X9t7/IhaBhlMmXhqOZWA=;
        b=eiASWKMzSMdlJyyFOXUrGJXdQP/rx+5HLao4/yUS22TQOTg+6SfnDwVHGg5+ccckSi
         mWzmcAP8x5ovtBl2bM1iCUPSOenudJRxuKOumdppTDxvWagL4csd9WrjImvuvNqchkxU
         M34L3mrC3XH3D+X+MEzRI8ZfdRXG1L105nGuWwQlMyhwpVV0yHm6fVFOes6t0FXJtHuZ
         NSjuRUesyE8pQoyaFN+voudH0VVQMLfEfzVP8fP+L4J5TjIfSDrgdND97M9pODnPVCnB
         Di5nbiHUeTEPk91VFWodgK0U/RBeo9Nc9AUWvIJIQlZdIQdsqumWoQe5y1rAHPeEjTnO
         6jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mq7vnVZtxuY6qci6Ve/X673X9t7/IhaBhlMmXhqOZWA=;
        b=jeuU9Ns5OXdf5EhR9VYI2cUp5/IQHbImXqs6I3Oo/IL9Zs9MYdikcbRhyHcCHMj3zF
         zpcIWRMKm5GGuLqPE2Criit5S8c9vj1k+YHiodPPLgJpDSiO384hIsHZSYImJpfKbnMF
         ZAecJs56snJJQqLZLLIHoOdSeOPPi1o3/xxk9k3G5pZrMpRizKwJpDtL5RERDK1pz9/t
         UU+jfK0LhkrYviqWR/WxH0agU2mL5FoddhelTK5qw0E55R2cacHnp5k1iFdtO+qpy4Bn
         qCqMRJtHOLRKmqx8CaCY5jjdXJqO1HgitRTUk9bax2ZbacBbOHBhhVfjR4UoNDKEBss5
         ESKw==
X-Gm-Message-State: AOAM530H2GNGEyx+87qp7xaK49FxZqFgJo2Ey3goHlq1Qzsc1kLL85vo
        xppiHHSK2SEWoy+jvXk0Dk6THE65oLE=
X-Google-Smtp-Source: ABdhPJwEeVRDrHTUJg3He4HIFQeh8q5Z+HMxINUq3C5gskCIbWabF+dkAsQ+ghJbZHBPw/uXw/LoZA==
X-Received: by 2002:a17:90b:c90:: with SMTP id o16mr24769788pjz.86.1600681591216;
        Mon, 21 Sep 2020 02:46:31 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id x192sm11199984pfc.142.2020.09.21.02.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 02:46:30 -0700 (PDT)
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
Subject: [PATCH 4/5] perf tools: Allow creation of cgroup without open
Date:   Mon, 21 Sep 2020 18:46:09 +0900
Message-Id: <20200921094610.83736-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921094610.83736-1-namhyung@kernel.org>
References: <20200921094610.83736-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for a test case of expanding events for multiple
cgroups.  Instead of using real system cgroup, the test will use fake
cgroups so it needs a way to have them without a open file descriptor.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  2 +-
 tools/perf/util/cgroup.c  | 19 ++++++++++++-------
 tools/perf/util/cgroup.h  |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8b81d62ab18b..f00600d9903e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2249,7 +2249,7 @@ int cmd_stat(int argc, const char **argv)
 
 	if (stat_config.cgroup_list) {
 		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events) < 0)
+					  &stat_config.metric_events, true) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index adf60597520b..ee0b50f59977 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -52,7 +52,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
 	return NULL;
 }
 
-static struct cgroup *cgroup__new(const char *name)
+static struct cgroup *cgroup__new(const char *name, bool do_open)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
@@ -62,9 +62,14 @@ static struct cgroup *cgroup__new(const char *name)
 		cgroup->name = strdup(name);
 		if (!cgroup->name)
 			goto out_err;
-		cgroup->fd = open_cgroup(name);
-		if (cgroup->fd == -1)
-			goto out_free_name;
+
+		if (do_open) {
+			cgroup->fd = open_cgroup(name);
+			if (cgroup->fd == -1)
+				goto out_free_name;
+		} else {
+			cgroup->fd = -1;
+		}
 	}
 
 	return cgroup;
@@ -80,7 +85,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
-	return cgroup ?: cgroup__new(name);
+	return cgroup ?: cgroup__new(name, true);
 }
 
 static int add_cgroup(struct evlist *evlist, const char *str)
@@ -202,7 +207,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 }
 
 int evlist__expand_cgroup(struct evlist *evlist, const char *str,
-			  struct rblist *metric_events)
+			  struct rblist *metric_events, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
@@ -240,7 +245,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			if (!name)
 				goto out_err;
 
-			cgrp = cgroup__new(name);
+			cgrp = cgroup__new(name, open_cgroup);
 			free(name);
 			if (cgrp == NULL)
 				goto out_err;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index eea6df8ee373..162906f3412a 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -26,7 +26,7 @@ struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
-			  struct rblist *metric_events);
+			  struct rblist *metric_events, bool open_cgroup);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
-- 
2.28.0.681.g6f77f65b4e-goog

