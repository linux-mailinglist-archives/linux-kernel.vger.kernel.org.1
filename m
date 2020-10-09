Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1128805C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgJIC33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:29:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:51340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731239AbgJIC32 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:29:28 -0400
IronPort-SDR: lt6i+laml9KnnytHTJuoUP0uNlvOq8THaGlQp9+drs5E11yu5CvYViGD+jNl57cX9Pwayk4Dm1
 0FG4O7GhLbsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="182869954"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="182869954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 19:29:28 -0700
IronPort-SDR: jbd5/sPYaR61PlPIz9Xj8i/2jmtsohze+IJscDKtDs7CdbwcWcDHVKwkGWp1Yf1nNxBMtwQoz6
 LDe0VShdZffA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="354699974"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2020 19:29:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v8 1/7] perf util: Create streams
Date:   Fri,  9 Oct 2020 10:28:39 +0800
Message-Id: <20201009022845.13141-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009022845.13141-1-yao.jin@linux.intel.com>
References: <20201009022845.13141-1-yao.jin@linux.intel.com>
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
 v8:
   - Rebase to perf/core

 v7:
   - Create a new struct evlist_streams.
   - Rename functions with appropriate prefix

 v6:
   - Rebase to perf/core

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
 tools/perf/util/stream.c | 164 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  30 +++++++
 3 files changed, 195 insertions(+)
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index eebbd5223cae..e2563d0154eb 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -102,6 +102,7 @@ perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
 perf-y += topdown.o
+perf-y += stream.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
new file mode 100644
index 000000000000..31efe4ae0f55
--- /dev/null
+++ b/tools/perf/util/stream.c
@@ -0,0 +1,164 @@
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
+static void evsel_streams__delete(struct evsel_streams *es, int nr_evsel)
+{
+	for (int i = 0; i < nr_evsel; i++)
+		zfree(&es[i].streams);
+
+	free(es);
+}
+
+void evlist_streams__delete(struct evlist_streams *els)
+{
+	evsel_streams__delete(els->ev_streams, els->nr_evsel);
+	free(els);
+}
+
+static struct evlist_streams *evlist_streams__new(int nr_evsel,
+						  int nr_streams_max)
+{
+	struct evlist_streams *els;
+	struct evsel_streams *es;
+
+	els = zalloc(sizeof(*els));
+	if (!els)
+		return NULL;
+
+	es = calloc(nr_evsel, sizeof(struct evsel_streams));
+	if (!es) {
+		free(els);
+		return NULL;
+	}
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
+	els->ev_streams = es;
+	els->nr_evsel = nr_evsel;
+	return els;
+
+err:
+	evsel_streams__delete(es, nr_evsel);
+	return NULL;
+}
+
+/*
+ * The cnodes with high hit number are hot callchains.
+ */
+static void evsel_streams__set_hot_cnode(struct evsel_streams *es,
+					 struct callchain_node *cnode)
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
+		evsel_streams__set_hot_cnode(es, cnode);
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
+static int evlist__init_callchain_streams(struct evlist *evlist,
+					  struct evlist_streams *els)
+{
+	struct evsel_streams *es = els->ev_streams;
+	struct evsel *pos;
+	int i = 0;
+
+	BUG_ON(els->nr_evsel < evlist->core.nr_entries);
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
+struct evlist_streams *evlist__create_streams(struct evlist *evlist,
+					      int nr_streams_max)
+{
+	int nr_evsel = evlist->core.nr_entries, ret = -1;
+	struct evlist_streams *els = evlist_streams__new(nr_evsel,
+							 nr_streams_max);
+
+	if (!els)
+		return NULL;
+
+	ret = evlist__init_callchain_streams(evlist, els);
+	if (ret) {
+		evlist_streams__delete(els);
+		return NULL;
+	}
+
+	return els;
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
new file mode 100644
index 000000000000..35bc64df554c
--- /dev/null
+++ b/tools/perf/util/stream.h
@@ -0,0 +1,30 @@
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
+struct evlist_streams {
+	struct evsel_streams	*ev_streams;
+	int			nr_evsel;
+};
+
+struct evlist;
+
+void evlist_streams__delete(struct evlist_streams *els);
+
+struct evlist_streams *evlist__create_streams(struct evlist *evlist,
+					      int nr_streams_max);
+
+#endif /* __PERF_STREAM_H */
-- 
2.17.1

