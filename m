Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701B2DBCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgLPIk0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 03:40:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:26654 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgLPIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:40:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-HzGSyt7OMLiY5TyKVdxkKA-1; Wed, 16 Dec 2020 03:39:28 -0500
X-MC-Unique: HzGSyt7OMLiY5TyKVdxkKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0F9879500;
        Wed, 16 Dec 2020 08:39:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF50927C3D;
        Wed, 16 Dec 2020 08:39:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/4] perf tools: Add evlist__disable_evsel/evlist__enable_evsel
Date:   Wed, 16 Dec 2020 09:39:12 +0100
Message-Id: <20201216083914.47215-3-jolsa@kernel.org>
In-Reply-To: <20201216083914.47215-1-jolsa@kernel.org>
References: <20201216083914.47215-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding interface to enable/disable single event in the
evlist based on its name. It will be used later in new
control enable/disable interface.

Keeping the evlist::enabled true when one or more events
are enabled so the toggle can work properly and toggle
evlist to disabled state.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Alexei Budankov <abudankov@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 69 ++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 493819173a8e..70aff26612a9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -370,7 +370,30 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 	return true;
 }
 
-void evlist__disable(struct evlist *evlist)
+static int evsel__strcmp(struct evsel *pos, char *evsel_name)
+{
+	if (!evsel_name)
+		return 0;
+	if (evsel__is_dummy_event(pos))
+		return 1;
+	return strcmp(pos->name, evsel_name);
+}
+
+static int evlist__is_enabled(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		/* If at least one event is enabled, evlist is enabled. */
+		if (!pos->disabled)
+			return true;
+	}
+	return false;
+}
+
+static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
 	struct affinity affinity;
@@ -386,6 +409,8 @@ void evlist__disable(struct evlist *evlist)
 			affinity__set(&affinity, cpu);
 
 			evlist__for_each_entry(evlist, pos) {
+				if (evsel__strcmp(pos, evsel_name))
+					continue;
 				if (evsel__cpu_iter_skip(pos, cpu))
 					continue;
 				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
@@ -403,15 +428,34 @@ void evlist__disable(struct evlist *evlist)
 
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
+		if (evsel__strcmp(pos, evsel_name))
+			continue;
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		pos->disabled = true;
 	}
 
-	evlist->enabled = false;
+	/*
+	 * If we disabled only single event, we need to check
+	 * the enabled state of the evlist manually.
+	 */
+	if (evsel_name)
+		evlist->enabled = evlist__is_enabled(evlist);
+	else
+		evlist->enabled = false;
+}
+
+void evlist__disable(struct evlist *evlist)
+{
+	__evlist__disable(evlist, NULL);
+}
+
+void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
+{
+	__evlist__disable(evlist, evsel_name);
 }
 
-void evlist__enable(struct evlist *evlist)
+static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
 	struct affinity affinity;
@@ -424,6 +468,8 @@ void evlist__enable(struct evlist *evlist)
 		affinity__set(&affinity, cpu);
 
 		evlist__for_each_entry(evlist, pos) {
+			if (evsel__strcmp(pos, evsel_name))
+				continue;
 			if (evsel__cpu_iter_skip(pos, cpu))
 				continue;
 			if (!evsel__is_group_leader(pos) || !pos->core.fd)
@@ -433,14 +479,31 @@ void evlist__enable(struct evlist *evlist)
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
+		if (evsel__strcmp(pos, evsel_name))
+			continue;
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		pos->disabled = false;
 	}
 
+	/*
+	 * Even single event sets the 'enabled' for evlist,
+	 * so the toggle can work properly and toggle to
+	 * 'disabled' state.
+	 */
 	evlist->enabled = true;
 }
 
+void evlist__enable(struct evlist *evlist)
+{
+	__evlist__enable(evlist, NULL);
+}
+
+void evlist__enable_evsel(struct evlist *evlist, char *evsel_name)
+{
+	__evlist__enable(evlist, evsel_name);
+}
+
 void evlist__toggle_enable(struct evlist *evlist)
 {
 	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9b0c795736bb..1aae75895dea 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -186,6 +186,8 @@ size_t evlist__mmap_size(unsigned long pages);
 void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void evlist__toggle_enable(struct evlist *evlist);
+void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
+void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
 
 int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx);
 
-- 
2.26.2

