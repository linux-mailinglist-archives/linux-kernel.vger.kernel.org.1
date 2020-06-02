Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEA1EC488
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBVsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 17:48:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728272AbgFBVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:47:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-O5EWrYMkOCis49jRWf6ldQ-1; Tue, 02 Jun 2020 17:47:55 -0400
X-MC-Unique: O5EWrYMkOCis49jRWf6ldQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A16B1083E80;
        Tue,  2 Jun 2020 21:47:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E553178EF7;
        Tue,  2 Jun 2020 21:47:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/13] perf tests: Factor check_parse_id function
Date:   Tue,  2 Jun 2020 23:47:31 +0200
Message-Id: <20200602214741.1218986-4-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating the generic part of check_parse_id function,
so it can be used in following changes for the new test.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/pmu-events.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 894282be073f..8d852f6d2092 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -390,9 +390,8 @@ static bool is_number(const char *str)
 	return errno == 0 && end_ptr != str;
 }
 
-static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
+static int check_parse_id(const char *id, struct parse_events_error *error)
 {
-	struct parse_events_error error;
 	struct evlist *evlist;
 	int ret;
 
@@ -401,8 +400,18 @@ static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
 		return 0;
 
 	evlist = evlist__new();
-	memset(&error, 0, sizeof(error));
-	ret = parse_events(evlist, id, &error, false);
+	if (!evlist)
+		return -ENOMEM;
+	ret = parse_events(evlist, id, error, false);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
+{
+	struct parse_events_error error = { 0 };
+
+	int ret = check_parse_id(id, &error);
 	if (ret && same_cpu) {
 		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
 			pe->metric_name, id, pe->metric_expr);
@@ -413,7 +422,6 @@ static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
 			  id, pe->metric_name, pe->metric_expr);
 		ret = 0;
 	}
-	evlist__delete(evlist);
 	free(error.str);
 	free(error.help);
 	free(error.first_str);
@@ -474,7 +482,7 @@ static int test_parsing(void)
 				expr__add_id(&ctx, strdup(cur->key), k++);
 
 			hashmap__for_each_entry((&ctx.ids), cur, bkt) {
-				if (check_parse_id(cur->key, map == cpus_map,
+				if (check_parse_cpu(cur->key, map == cpus_map,
 						   pe))
 					ret++;
 			}
-- 
2.25.4

