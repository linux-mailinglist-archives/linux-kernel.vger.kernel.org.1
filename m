Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1B1BDD34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD2NLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgD2NL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:11:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880DA2222A;
        Wed, 29 Apr 2020 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165888;
        bh=T+QBw3fWFulSDwnGmQld3vmXaCHwlmIIuIWPC01I/BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+CjaUlY79tpVTx/PIef/03GhwQAu5X+y/J5420l9yW5HxQejEs/VVm0qcylbrpFC
         lkE57c7CtLo6YYlPLsdHcftE9KKIJccbSVQ6wLB/vECbYWqCequO82OgH2VT8k11fU
         pMY1WVkCmh4zx72myGkDo0le4W1Ap2Ky8vOVrck0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5/8] perf evlist: Allow reusing the side band thread for more purposes
Date:   Wed, 29 Apr 2020 10:11:03 -0300
Message-Id: <20200429131106.27974-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. so far we had just one event in that side band thread, a dummy one
with attr.bpf_event set, so that 'perf record' can go ahead and ask the
kernel for further information about BPF programs being loaded.

Allow for more than one event to be there, so that we can use it as
well for the upcoming --switch-output-event feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200427211935.25789-7-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 22 ++++++++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1d0d36da223b..849058766757 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_id_all	  = 1;
+		evsel->core.attr.watermark	  = 1;
+		evsel->core.attr.wakeup_watermark = 1;
+		evsel->side_band.cb   = cb;
+		evsel->side_band.data = data;
+	}
+}
+
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target)
 {
@@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 	if (perf_evlist__create_maps(evlist, target))
 		goto out_delete_evlist;
 
+	if (evlist->core.nr_entries > 1) {
+		bool can_sample_identifier = perf_can_sample_identifier();
+
+		evlist__for_each_entry(evlist, counter)
+			perf_evsel__set_sample_id(counter, can_sample_identifier);
+
+		perf_evlist__set_id_pos(evlist);
+	}
+
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.cpus,
 				     evlist->core.threads) < 0)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0f02408fff3e..1a8a979ae137 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,7 @@ int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
-- 
2.21.1

