Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7325F24F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 06:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIGEQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 00:16:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:58703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgIGEQq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:46 -0400
IronPort-SDR: 8UKXYdmekOhISEZGrDFNkipkfJLTta6SxAgALR7RfjSsdW6cPXqjwpH4mkpKS8s4+AfDZKfKzb
 amNb1On2CH6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215547"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:45 -0700
IronPort-SDR: 0ZOoyYNToN4fOs3toF9BwT8bXIHRFkZ+/EzXhC9/j/wk95S/1ZWEAmeOMLLDvSTvqGKHF7aYAy
 LfchOOC0KgAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709917"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:43 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/7] perf util: Create streams
Date:   Mon,  7 Sep 2020 12:16:00 +0800
Message-Id: <20200907041606.14500-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define the stream is the branch history which is aggregated by
the branch records from perf samples. For example, the callchains
aggregated from the branch records are considered as streams.
By browsing the hot stream, we can understand the hot code path.

Now we only support the callchain for stream. For measuring the
hot level for a stream, we use the callchain_node->hit, higher
is hotter.

There may be many callchains sampled so we only focus on the top
N hottest callchains. N is a user defined parameter or predefined
default value (nr_streams_max).

This patch creates an evsel_streams array per event, and saves
the top N hottest streams in a stream array.

So now we can get the per-event top N hottest streams.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v5:
   - Remove enum stram_type
   - Rebase to perf/core

 v4:
   - Refactor the code
   - Rename patch name from 'perf util: Create streams for managing
     top N hottest callchains' to 'perf util: Create streams'

 v2:
   - Use zfree in free_evsel_streams().

 tools/perf/util/Build    |   1 +
 tools/perf/util/stream.c | 148 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  23 ++++++
 3 files changed, 172 insertions(+)
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1a882f..3c8059186b09 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -95,6 +95,7 @@ perf-y += cloexec.o
 perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
+perf-y += stream.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
new file mode 100644
index 000000000000..015c1d07ce3a
--- /dev/null
+++ b/tools/perf/util/stream.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Compare and figure out the top N hottest streams
+ * Copyright (c) 2020, Intel Corporation.
+ * Author: Jin Yao
+ */
+
+#include <inttypes.h>
+#include <stdlib.h>
+#include <linux/zalloc.h>
+#include "debug.h"
+#include "hist.h"
+#include "sort.h"
+#include "stream.h"
+#include "evlist.h"
+
+static void free_evsel_streams(struct evsel_streams *es, int nr_evsel)
+{
+	for (int i = 0; i < nr_evsel; i++)
+		zfree(&es[i].streams);
+
+	free(es);
+}
+
+static struct evsel_streams *create_evsel_streams(int nr_evsel,
+						  int nr_streams_max)
+{
+	struct evsel_streams *es;
+
+	es = calloc(nr_evsel, sizeof(struct evsel_streams));
+	if (!es)
+		return NULL;
+
+	for (int i = 0; i < nr_evsel; i++) {
+		struct evsel_streams *s = &es[i];
+
+		s->streams = calloc(nr_streams_max, sizeof(struct stream));
+		if (!s->streams)
+			goto err;
+
+		s->nr_streams_max = nr_streams_max;
+		s->evsel_idx = -1;
+	}
+
+	return es;
+
+err:
+	free_evsel_streams(es, nr_evsel);
+	return NULL;
+}
+
+/*
+ * The cnodes with high hit number are hot callchains.
+ */
+static void set_hot_cnode(struct evsel_streams *es,
+			  struct callchain_node *cnode)
+{
+	int i, idx = 0;
+	u64 hit;
+
+	if (es->nr_streams < es->nr_streams_max) {
+		i = es->nr_streams;
+		es->streams[i].cnode = cnode;
+		es->nr_streams++;
+		return;
+	}
+
+	/*
+	 * Considering a few number of hot streams, only use simple
+	 * way to find the cnode with smallest hit number and replace.
+	 */
+	hit = (es->streams[0].cnode)->hit;
+	for (i = 1; i < es->nr_streams; i++) {
+		if ((es->streams[i].cnode)->hit < hit) {
+			hit = (es->streams[i].cnode)->hit;
+			idx = i;
+		}
+	}
+
+	if (cnode->hit > hit)
+		es->streams[idx].cnode = cnode;
+}
+
+static void update_hot_callchain(struct hist_entry *he,
+				 struct evsel_streams *es)
+{
+	struct rb_root *root = &he->sorted_chain;
+	struct rb_node *rb_node = rb_first(root);
+	struct callchain_node *cnode;
+
+	while (rb_node) {
+		cnode = rb_entry(rb_node, struct callchain_node, rb_node);
+		set_hot_cnode(es, cnode);
+		rb_node = rb_next(rb_node);
+	}
+}
+
+static void init_hot_callchain(struct hists *hists, struct evsel_streams *es)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+
+	while (next) {
+		struct hist_entry *he;
+
+		he = rb_entry(next, struct hist_entry, rb_node);
+		update_hot_callchain(he, es);
+		next = rb_next(&he->rb_node);
+	}
+}
+
+static int evlist_init_callchain_streams(struct evlist *evlist,
+					 struct evsel_streams *es, int nr_es)
+{
+	struct evsel *pos;
+	int i = 0;
+
+	BUG_ON(nr_es < evlist->core.nr_entries);
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		hists__output_resort(hists, NULL);
+		init_hot_callchain(hists, &es[i]);
+		es[i].evsel_idx = pos->idx;
+		i++;
+	}
+
+	return 0;
+}
+
+struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
+						  int nr_streams_max)
+{
+	struct evsel_streams *es;
+	int nr_evsel = evlist->core.nr_entries, ret = -1;
+
+	es = create_evsel_streams(nr_evsel, nr_streams_max);
+	if (!es)
+		return NULL;
+
+	ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
+	if (ret) {
+		free_evsel_streams(es, nr_evsel);
+		return NULL;
+	}
+
+	return es;
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
new file mode 100644
index 000000000000..c6844c5787cb
--- /dev/null
+++ b/tools/perf/util/stream.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_STREAM_H
+#define __PERF_STREAM_H
+
+#include "callchain.h"
+
+struct stream {
+	struct callchain_node	*cnode;
+};
+
+struct evsel_streams {
+	struct stream		*streams;
+	int			nr_streams_max;
+	int			nr_streams;
+	int			evsel_idx;
+};
+
+struct evlist;
+
+struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
+						  int nr_streams_max);
+
+#endif /* __PERF_STREAM_H */
-- 
2.17.1

