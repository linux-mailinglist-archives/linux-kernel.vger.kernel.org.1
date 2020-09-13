Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8C268145
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIMVEu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23534 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgIMVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-1h84JKj6PWa4UViSTMNObg-1; Sun, 13 Sep 2020 17:04:26 -0400
X-MC-Unique: 1h84JKj6PWa4UViSTMNObg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648FA1074651;
        Sun, 13 Sep 2020 21:04:24 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 844711002388;
        Sun, 13 Sep 2020 21:04:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/26] perf tools: Add mmap3 events to --show-mmap-events option
Date:   Sun, 13 Sep 2020 23:03:01 +0200
Message-Id: <20200913210313.1985612-15-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying mmap3 events for --show-mmap-events option,
the build id is displayed within <> braces:

  $ perf script --show-mmap-events
  kill 12148 13893.519014: PERF_RECORD_MMAP3 12148/12148: <43938d0803c5e3130ea679cd569aaf44b98d9ae8> [0x560e7d7f..
  kill 12148 13893.519420: PERF_RECORD_MMAP3 12148/12148: <1805c738c8f3ec0f47b7ea09080c28f34d18a82b> [0x7f9e7dfc..

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d839983cfb88..9c09581d5cb0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2342,6 +2342,38 @@ static int process_mmap2_event(struct perf_tool *tool,
 			   event->mmap2.tid);
 }
 
+static int process_mmap3_event(struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+
+	if (perf_event__process_mmap3(tool, event, sample, machine) < 0)
+		return -1;
+
+	thread = machine__findnew_thread(machine, event->mmap3.pid, event->mmap3.tid);
+	if (thread == NULL) {
+		pr_debug("problem processing MMAP2 event, skipping it.\n");
+		return -1;
+	}
+
+	if (!evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = 0;
+		sample->tid = event->mmap3.tid;
+		sample->pid = event->mmap3.pid;
+	}
+	perf_sample__fprintf_start(script, sample, thread, evsel,
+				   PERF_RECORD_MMAP3, stdout);
+	perf_event__fprintf(event, machine, stdout);
+	thread__put(thread);
+	return 0;
+}
+
 static int process_switch_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -2498,6 +2530,7 @@ static int __cmd_script(struct perf_script *script)
 	if (script->show_mmap_events) {
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
+		script->tool.mmap3 = process_mmap3_event;
 	}
 	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
-- 
2.26.2

