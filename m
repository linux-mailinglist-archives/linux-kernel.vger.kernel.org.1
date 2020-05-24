Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C01E03BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgEXWmt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 18:42:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388289AbgEXWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-zWBnyYi6MyecgeZlY0V42g-1; Sun, 24 May 2020 18:42:41 -0400
X-MC-Unique: zWBnyYi6MyecgeZlY0V42g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9B7D460;
        Sun, 24 May 2020 22:42:39 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593AC5D788;
        Sun, 24 May 2020 22:42:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/14] perf tools: Add parse_events_fake interface
Date:   Mon, 25 May 2020 00:42:10 +0200
Message-Id: <20200524224219.234847-6-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 4
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding parse_events_fake interface to parse events
and use fake pmu event in case pmu event is parsed.

This way it's possible to parse events from PMUs
which are not present in the system. It's available
only for testing purposes coming in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 48 +++++++++++++++++++++++++---------
 tools/perf/util/parse-events.h |  2 ++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8304f9b6e6be..89239695a728 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2082,22 +2082,15 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
-int parse_events(struct evlist *evlist, const char *str,
-		 struct parse_events_error *err)
+static int parse_events_state(struct parse_events_state *parse_state,
+			      struct evlist *evlist, const char *str)
 {
-	struct parse_events_state parse_state = {
-		.list   = LIST_HEAD_INIT(parse_state.list),
-		.idx    = evlist->core.nr_entries,
-		.error  = err,
-		.evlist = evlist,
-		.stoken = PE_START_EVENTS,
-	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state);
+	ret = parse_events__scanner(str, parse_state);
 	perf_pmu__parse_cleanup();
 
-	if (!ret && list_empty(&parse_state.list)) {
+	if (!ret && list_empty(&parse_state->list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
 		return -1;
 	}
@@ -2105,12 +2098,12 @@ int parse_events(struct evlist *evlist, const char *str,
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
-	perf_evlist__splice_list_tail(evlist, &parse_state.list);
+	perf_evlist__splice_list_tail(evlist, &parse_state->list);
 
 	if (!ret) {
 		struct evsel *last;
 
-		evlist->nr_groups += parse_state.nr_groups;
+		evlist->nr_groups += parse_state->nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
 
@@ -2125,6 +2118,35 @@ int parse_events(struct evlist *evlist, const char *str,
 	return ret;
 }
 
+int parse_events(struct evlist *evlist, const char *str,
+		 struct parse_events_error *err)
+{
+	struct parse_events_state parse_state = {
+		.list   = LIST_HEAD_INIT(parse_state.list),
+		.idx    = evlist->core.nr_entries,
+		.error  = err,
+		.evlist = evlist,
+		.stoken = PE_START_EVENTS,
+	};
+
+	return parse_events_state(&parse_state, evlist, str);
+}
+
+int parse_events_fake(struct evlist *evlist, const char *str,
+		      struct parse_events_error *err)
+{
+	struct parse_events_state parse_state = {
+		.list     = LIST_HEAD_INIT(parse_state.list),
+		.idx      = evlist->core.nr_entries,
+		.error    = err,
+		.evlist   = evlist,
+		.stoken   = PE_START_EVENTS,
+		.fake_pmu = true,
+	};
+
+	return parse_events_state(&parse_state, evlist, str);
+}
+
 #define MAX_WIDTH 1000
 static int get_term_width(void)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 963b0ea6c448..4a23b6cd9924 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -34,6 +34,8 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 int parse_events(struct evlist *evlist, const char *str,
 		 struct parse_events_error *error);
+int parse_events_fake(struct evlist *evlist, const char *str,
+		      struct parse_events_error *error);
 int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
-- 
2.25.4

