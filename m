Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884F295063
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502780AbgJUQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:06:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:25455 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502773AbgJUQGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:06:30 -0400
IronPort-SDR: JwajuWQlKouG9fhEmcgokHkOEunDa4E3+q38CPvHzG5bYRzID9nL7qsPzJgfajSFw8zBrDbXon
 4/oO7Lub41/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="185050954"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="185050954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:06:29 -0700
IronPort-SDR: Nmb44Xq+jTtTQTPzf1Wyt9QbnGoKKiUgUTZfIUI0hEM4XfjYm5yCsRun9cqeGU8ilqPnNcVSRu
 pqUyfXkC5zxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="321058244"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2020 09:06:29 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 3F9F5580107;
        Wed, 21 Oct 2020 09:06:27 -0700 (PDT)
Subject: [PATCH v2 11/15] perf evlist: introduce evlist__ctlfd_update() to
 update ctl fd status
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0081ef74-c3cf-1387-76e1-73d8396b6748@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:06:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce evlist__ctlfd_update() to update ctl fd poll status
in evlist pollfd array using other pollfd object.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 16 ++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8bdf3d2c907c..758a4896fedd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1970,6 +1970,22 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 	return err;
 }
 
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
+{
+	int ctlfd_pos = evlist->ctl_fd.pos;
+	struct pollfd *entries = evlist->core.pollfd.entries;
+
+	if (!evlist__ctlfd_initialized(evlist))
+		return 0;
+
+	if (entries[ctlfd_pos].fd != update->fd ||
+	    entries[ctlfd_pos].events != update->events)
+		return -1;
+
+	entries[ctlfd_pos].revents = update->revents;
+	return 0;
+}
+
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e1a450322bc5..9b73d6ccf066 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -380,6 +380,7 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 int evlist__ctlfd_ack(struct evlist *evlist);
 
-- 
2.24.1


