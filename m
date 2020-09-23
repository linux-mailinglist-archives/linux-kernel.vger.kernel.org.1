Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2842A274ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgIWB75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:59:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B41C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:59:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so6001791pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WaOSyW42WKt5VX+wz2NlJkyrwbmYzHwbUQJTeg1wEs=;
        b=WDPy9taiEFTzzwPyJpgMy7P5cNKK2GaVlNK3NBbBN9joc1u5finPO9KgSDee9Eh74L
         dSa1/gJnK0rkq3E+4jfQQ6JI+ldw2fkGO24jGbjkygXtpHZEjXGlITWJUtyVXwhZezbe
         K1iM1pEKYpOTcZCLDjzLiQq9zLkO1ACWtsABFBNZymFBPyqNBuj/UpDg+7AaA0Fv8s+E
         d8MDsXJ3jqYZ3q7973M5Nf1vgilZm6F7d7Y4hwV3fxCpFuYIJ3C0fQHMMFDITa8BaUt7
         XWVEu/roUvy45zc0KEcnepCpt1MUlkUkxFuiAldWmjjzyclwP2e1PuBqrH41axtX6qrF
         tj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1WaOSyW42WKt5VX+wz2NlJkyrwbmYzHwbUQJTeg1wEs=;
        b=qU7+TwULF72QVPHAooxQ5qL3O3gIXCr2Fd5UCwdzHBJeQZayqbtEKC428z5jZcUah+
         ewQ2xYAmWSEwMJpmF8Pdp9PdKZ92jYiSiKDrbgXL1DORQniBLg0IWPqPmCswB5ShHsv7
         Z2BUJr8o4+BpqoL+JySiqL6K9u8w51DdbpRlv54or0uS/jvlOxvI12TdDE6i9KeAoOh7
         ZYgkV3ppq4sTbYX93gbsz9FQd6CB31EhV8zWD8vVhiuIQ6GLPM0/+FhEzp0ZFimLfbN9
         nCoY5UvCBYWwNaQLkpUAm/NP5jgZL6tKQA9UXoWAUluFs9VB5q5jnpgHJYXtbaBpnlLB
         9jgA==
X-Gm-Message-State: AOAM531m//TRv8ZE4Q45cRlwdRD8yZrgnJhVKy/m7cGhcYqhFHBU0VD6
        enCtXFQoCagv0mlSEtVo1HyOQUxoxcU=
X-Google-Smtp-Source: ABdhPJxX0qWxye+CAgVrlpzbcFbH/woaxNh7jJsDng3AQwlKjDRDjY4emnN63zSLpKDHd5Q04BphQA==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr6024520pjy.3.1600826395843;
        Tue, 22 Sep 2020 18:59:55 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v13sm3367741pjr.12.2020.09.22.18.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:59:55 -0700 (PDT)
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
Date:   Wed, 23 Sep 2020 10:59:41 +0900
Message-Id: <20200923015945.47535-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923015945.47535-1-namhyung@kernel.org>
References: <20200923015945.47535-1-namhyung@kernel.org>
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

