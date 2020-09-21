Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F3271F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIUJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:46:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so7170594pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WaOSyW42WKt5VX+wz2NlJkyrwbmYzHwbUQJTeg1wEs=;
        b=YJl5pImuVog/NioCjuLBbLMgCFgU0s3Uvdx021mRWTOy4XkqCtUcPNP1+EUHtZMXQO
         rOu8fZt82fAmZHIVc2f+ksxQBxeFNm3c0AX77JgXuZPns+Wz5byaSt6PJ3oP3eBp6XZT
         kvwUpaWKL/V2AB+R/mEAZA553vL6RQrWr9/wrMo9GvpGV9m7POSVWFMqqXmtYFpVRxzP
         PrwQQaGQUfMqofjQ3QXrMAwjNKEcqP//PsPpMrNmwhmm1buD9RNuK9jQUk0cFOzdAuov
         Pm2wE4N2ZVRVC5IddTWRYFMjrWttjYSBGDnewBVqBIpldr8JmbbvVMruyE/biyrrAg9S
         jmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1WaOSyW42WKt5VX+wz2NlJkyrwbmYzHwbUQJTeg1wEs=;
        b=LbAC4MBQEY3zFVBCd4WOzg9ITZFtuGtxSj6Zwg7EwMg5yAqv3BntLdYpqsqGyo7CW7
         2y95osKHG/iWNTJPt4cbWmKARiaQed+ZwRiesDY50MRHUUv+KkvQZorUIjIQlrmaLT09
         jJzeOyD8TwWO+u2qUB+5xAHr+XrPdbmfa7PhgtxvvB5x+ICH0HsRcnBmp/QqyKPokuuy
         2zxZAAhV/hx/Tc68bhtE1k7EBwTQubwxlP2KPskIlQoEmyijinVHtN8KrT3OrrIbeJKU
         phoi36Rs8/5lI5PCU+fdEdyr5rDDfFuuPZSbKHU8c5z5qoQrdh0UBVWgBTs9Yuvw1v52
         z5vw==
X-Gm-Message-State: AOAM530eX9xDYiJ4+rLBtChPsyJmdS9QkP7vp+5Ex34H5mhQaMSLvHhu
        eH+0Tdm9Il8f5BqskRDD2bA=
X-Google-Smtp-Source: ABdhPJyTcZ9BjG+uQwm8+BkFbw0TwOVibx/mMgogmdv2YnQ6dsYpaXpZTcwktG50gtn2Xn4ASf5K8w==
X-Received: by 2002:a17:90a:d304:: with SMTP id p4mr25040137pju.138.1600681579727;
        Mon, 21 Sep 2020 02:46:19 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id x192sm11199984pfc.142.2020.09.21.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 02:46:19 -0700 (PDT)
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
Subject: [PATCH 1/5] perf evsel: Add evsel__clone() function
Date:   Mon, 21 Sep 2020 18:46:06 +0900
Message-Id: <20200921094610.83736-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921094610.83736-1-namhyung@kernel.org>
References: <20200921094610.83736-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__clone() is to create an exactly same evsel from same
attributes.  The function assumes the given evsel is not configured
yet so it cares fields set during event parsing.  Those fields are now
moved together as Jiri suggested.  Note that metric events will be
handled by later patch.

It will be used by perf stat to generate separate events for each
cgroup.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 104 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  93 ++++++++++++++++++++---------------
 2 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fd865002cbbd..c63dd9f7e9fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -331,6 +331,110 @@ struct evsel *evsel__new_cycles(bool precise)
 	goto out;
 }
 
+static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
+{
+	struct evsel_config_term *pos, *tmp;
+
+	list_for_each_entry(pos, &src->config_terms, list) {
+		tmp = malloc(sizeof(*tmp));
+		if (tmp == NULL)
+			return -ENOMEM;
+
+		*tmp = *pos;
+		if (tmp->free_str) {
+			tmp->val.str = strdup(pos->val.str);
+			if (tmp->val.str == NULL) {
+				free(tmp);
+				return -ENOMEM;
+			}
+		}
+		list_add_tail(&tmp->list, &dst->config_terms);
+	}
+	return 0;
+}
+
+/**
+ * evsel__clone - create a new evsel copied from @orig
+ * @orig: original evsel
+ *
+ * The assumption is that @orig is not configured nor opened yet.
+ * So we only care about the attributes that can be set while it's parsed.
+ */
+struct evsel *evsel__clone(struct evsel *orig)
+{
+	struct evsel *evsel;
+
+	BUG_ON(orig->core.fd);
+	BUG_ON(orig->counts);
+	BUG_ON(orig->priv);
+	BUG_ON(orig->per_pkg_mask);
+
+	/* cannot handle BPF objects for now */
+	if (orig->bpf_obj)
+		return NULL;
+
+	evsel = evsel__new(&orig->core.attr);
+	if (evsel == NULL)
+		return NULL;
+
+	evsel->core.cpus = perf_cpu_map__get(orig->core.cpus);
+	evsel->core.own_cpus = perf_cpu_map__get(orig->core.own_cpus);
+	evsel->core.threads = perf_thread_map__get(orig->core.threads);
+	evsel->core.nr_members = orig->core.nr_members;
+	evsel->core.system_wide = orig->core.system_wide;
+
+	if (orig->name) {
+		evsel->name = strdup(orig->name);
+		if (evsel->name == NULL)
+			goto out_err;
+	}
+	if (orig->group_name) {
+		evsel->group_name = strdup(orig->group_name);
+		if (evsel->group_name == NULL)
+			goto out_err;
+	}
+	if (orig->pmu_name) {
+		evsel->pmu_name = strdup(orig->pmu_name);
+		if (evsel->pmu_name == NULL)
+			goto out_err;
+	}
+	if (orig->filter) {
+		evsel->filter = strdup(orig->filter);
+		if (evsel->filter == NULL)
+			goto out_err;
+	}
+	evsel->cgrp = cgroup__get(orig->cgrp);
+	evsel->tp_format = orig->tp_format;
+	evsel->handler = orig->handler;
+	evsel->leader = orig->leader;
+
+	evsel->max_events = orig->max_events;
+	evsel->tool_event = orig->tool_event;
+	evsel->unit = orig->unit;
+	evsel->scale = orig->scale;
+	evsel->snapshot = orig->snapshot;
+	evsel->per_pkg = orig->per_pkg;
+	evsel->percore = orig->percore;
+	evsel->precise_max = orig->precise_max;
+	evsel->use_uncore_alias = orig->use_uncore_alias;
+	evsel->is_libpfm_event = orig->is_libpfm_event;
+
+	evsel->exclude_GH = orig->exclude_GH;
+	evsel->sample_read = orig->sample_read;
+	evsel->auto_merge_stats = orig->auto_merge_stats;
+	evsel->collect_stat = orig->collect_stat;
+	evsel->weak_group = orig->weak_group;
+
+	if (evsel__copy_config_terms(evsel, orig) < 0)
+		goto out_err;
+
+	return evsel;
+
+out_err:
+	evsel__delete(evsel);
+	return NULL;
+}
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35e3f6d66085..79a860d8e3ee 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -42,65 +42,79 @@ enum perf_tool_event {
  */
 struct evsel {
 	struct perf_evsel	core;
-	struct evlist	*evlist;
-	char			*filter;
+	struct evlist		*evlist;
+	off_t			id_offset;
+	int			idx;
+	int			id_pos;
+	int			is_pos;
+	unsigned int		sample_size;
+
+	/*
+	 * These fields can be set in the parse-events code or similar.
+	 * Please check evsel__clone() to copy them properly so that
+	 * they can be released properly.
+	 */
+	struct {
+		char			*name;
+		char			*group_name;
+		const char		*pmu_name;
+		struct tep_event	*tp_format;
+		char			*filter;
+		unsigned long		max_events;
+		double			scale;
+		const char		*unit;
+		struct cgroup		*cgrp;
+		enum perf_tool_event	tool_event;
+		/* parse modifier helper */
+		int			exclude_GH;
+		int			sample_read;
+		bool			snapshot;
+		bool			per_pkg;
+		bool			percore;
+		bool			precise_max;
+		bool			use_uncore_alias;
+		bool			is_libpfm_event;
+		bool			auto_merge_stats;
+		bool			collect_stat;
+		bool			weak_group;
+		int			bpf_fd;
+		struct bpf_object	*bpf_obj;
+	};
+
+	/*
+	 * metric fields are similar, but needs more care as they can have
+	 * references to other metric (evsel).
+	 */
+	const char *		metric_expr;
+	const char *		metric_name;
+	struct evsel		**metric_events;
+	struct evsel		*metric_leader;
+
+	void			*handler;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
-	int			idx;
-	unsigned long		max_events;
 	unsigned long		nr_events_printed;
-	char			*name;
-	double			scale;
-	const char		*unit;
-	struct tep_event	*tp_format;
-	off_t			id_offset;
 	struct perf_stat_evsel  *stats;
 	void			*priv;
 	u64			db_id;
-	struct cgroup		*cgrp;
-	void			*handler;
-	unsigned int		sample_size;
-	int			id_pos;
-	int			is_pos;
-	enum perf_tool_event	tool_event;
 	bool			uniquified_name;
-	bool			snapshot;
 	bool 			supported;
 	bool 			needs_swap;
 	bool 			disabled;
 	bool			no_aux_samples;
 	bool			immediate;
 	bool			tracking;
-	bool			per_pkg;
-	bool			precise_max;
 	bool			ignore_missing_thread;
 	bool			forced_leader;
-	bool			use_uncore_alias;
-	bool			is_libpfm_event;
-	/* parse modifier helper */
-	int			exclude_GH;
-	int			sample_read;
-	unsigned long		*per_pkg_mask;
-	struct evsel		*leader;
-	char			*group_name;
 	bool			cmdline_group_boundary;
-	struct list_head	config_terms;
-	struct bpf_object	*bpf_obj;
-	int			bpf_fd;
-	int			err;
-	bool			auto_merge_stats;
 	bool			merged_stat;
-	const char *		metric_expr;
-	const char *		metric_name;
-	struct evsel		**metric_events;
-	struct evsel		*metric_leader;
-	bool			collect_stat;
-	bool			weak_group;
 	bool			reset_group;
 	bool			errored;
-	bool			percore;
+	unsigned long		*per_pkg_mask;
+	struct evsel		*leader;
+	struct list_head	config_terms;
+	int			err;
 	int			cpu_iter;
-	const char		*pmu_name;
 	struct {
 		evsel__sb_cb_t	*cb;
 		void		*data;
@@ -169,6 +183,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
+struct evsel *evsel__clone(struct evsel *orig);
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
 
 /*
-- 
2.28.0.681.g6f77f65b4e-goog

