Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552EA26BD27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIPGb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPGbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:31:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8353AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so3317011pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkEURAg1znO3nxIgYme7h96cCaK9uK23QOQsawmTpdA=;
        b=G1BSX12fCImI9oBqRMjD5fw4lipEymkNuwwO4q74xpIuXloMoKNXgzO8KBG5VW3yDC
         uouT3xX8coEjeI2NzJxlU/mj9ji2C/VvyBF8XH5VkJ7eCpJ/TumE0/xlkJrB9aRlDGYT
         8xfp2jWmoGDkE+4QUYvPzGdhZRFeEXNTyrfUrZKlWBW9IfCd0+du3JZAumkIlaFlMV+O
         21k1dOg/mU58mK3F4U41ycnLaE/u/JGqxaWrBrbLubW/qd2+QugiXmSubMpp08BVwBS/
         S3UQEN/fGCHxlLUFXAcY5FyOFOg4z7x1j3TTN+d+NPxh8G56IvxAXWQdWYcJ3p7s2HuU
         Lhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fkEURAg1znO3nxIgYme7h96cCaK9uK23QOQsawmTpdA=;
        b=igjUZqvFABZXFVr7ymIF9rirydX2UVJfqsKGtDNmzDJT2VPJJbjpFTkWD/Q8nNZQmJ
         N3kfz3wCKRikm/a6VsIN75pNg8BAdUVZM8/zyZ2ZzB598EMGj/CAJvYO9e9Nefi0m2I6
         qPkQjZR/r3Cubunoy6oNNCVA7TFaTs7LKhKgMoOyqJo21s1qNQbqYVOnvLZLmWhtCZEB
         XIK1PrLxFhm+TUsC4Tqqvvt2ufbWr6ZpnCVcNu87ulK67gf5iqUqAnaxrpPTVuFy5uIo
         ppDwKffsb890BjV5B04BRyzP1pNG/YgBSmGkZTCh9epo9l2rJWoIq7IFEL+1QJh/ufwZ
         z7Lg==
X-Gm-Message-State: AOAM533NhhFCtacWuwlxZ/5gVyKr8ErXsfqq/3e10K3JrGkHs6xYzyGv
        NVTGRHjnTDx5drVkl6NanNc=
X-Google-Smtp-Source: ABdhPJwI+PBtpGfZbFPe5xvhnrWBJKgbh3erIIKGXOQkpB8reHUgq+prZ0BnW+GNgt9athi/9Etl/A==
X-Received: by 2002:a63:1342:: with SMTP id 2mr16786688pgt.214.1600237899001;
        Tue, 15 Sep 2020 23:31:39 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 203sm15401388pfz.131.2020.09.15.23.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:31:38 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/4] perf evsel: Add evsel__clone() function
Date:   Wed, 16 Sep 2020 15:31:26 +0900
Message-Id: <20200916063129.1061487-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200916063129.1061487-1-namhyung@kernel.org>
References: <20200916063129.1061487-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__clone() is to create an exactly same evsel from same
attributes.  Note that metric events will be handled by later patch.

It will be used by perf stat to generate separate events for each
cgroup.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 85 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fd865002cbbd..29edef353036 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -331,6 +331,91 @@ struct evsel *evsel__new_cycles(bool precise)
 	goto out;
 }
 
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
+	struct evsel_config_term *pos, *tmp;
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
+	if (orig->name)
+		evsel->name = strdup(orig->name);
+	if (orig->group_name)
+		evsel->group_name = strdup(orig->group_name);
+	if (orig->pmu_name)
+		evsel->pmu_name = strdup(orig->pmu_name);
+	if (orig->filter)
+		evsel->filter = strdup(orig->filter);
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
+	list_for_each_entry(pos, &orig->config_terms, list) {
+		tmp = malloc(sizeof(*tmp));
+		if (tmp == NULL) {
+			evsel__delete(evsel);
+			evsel = NULL;
+			break;
+		}
+
+		*tmp = *pos;
+		if (tmp->free_str) {
+			tmp->val.str = strdup(pos->val.str);
+			if (tmp->val.str == NULL) {
+				evsel__delete(evsel);
+				evsel = NULL;
+				free(tmp);
+				break;
+			}
+		}
+		list_add_tail(&tmp->list, &evsel->config_terms);
+	}
+
+	return evsel;
+}
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35e3f6d66085..507c31d6a389 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -169,6 +169,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
+struct evsel *evsel__clone(struct evsel *orig);
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
 
 /*
-- 
2.28.0.618.gf4bc123cb7-goog

