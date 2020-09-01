Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49434258BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIAJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:38:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:45308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgIAJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:38:40 -0400
IronPort-SDR: X4hwKWoyrCJ7OMd9wm83xzqaw70DuPUBi5sS2f+Uhma7382sntX6qLYOs6BNqPExgqD7k7OIqB
 lJq2Nbnzvm6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175181494"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175181494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 02:38:39 -0700
IronPort-SDR: rT/ax/9H3YWluGUOj0S43mZSNPT7OlsmvhKATqFD63h40c2jY3z33FSEBDfyLXdpvQ7Lr2hIt1
 Sn7S66PK7sYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="502181170"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2020 02:38:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] perf tools: Consolidate --control option parsing into one function
Date:   Tue,  1 Sep 2020 12:37:53 +0300
Message-Id: <20200901093758.32293-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901093758.32293-1-adrian.hunter@intel.com>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate --control option parsing into one function, in preparation for
adding FIFO file name options.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 22 ++--------------------
 tools/perf/builtin-stat.c   | 22 ++--------------------
 tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f91352f847c0..f2ab5bd7e2ba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2234,27 +2234,9 @@ static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
 {
-	char *comma = NULL, *endptr = NULL;
-	struct record_opts *config = (struct record_opts *)opt->value;
-
-	if (strncmp(str, "fd:", 3))
-		return -EINVAL;
-
-	config->ctl_fd = strtoul(&str[3], &endptr, 0);
-	if (endptr == &str[3])
-		return -EINVAL;
-
-	comma = strchr(str, ',');
-	if (comma) {
-		if (endptr != comma)
-			return -EINVAL;
-
-		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
-		if (endptr == comma + 1 || *endptr != '\0')
-			return -EINVAL;
-	}
+	struct record_opts *opts = opt->value;
 
-	return 0;
+	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack);
 }
 
 static void switch_output_size_warn(struct record *rec)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..12ce5cf2b10e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1045,27 +1045,9 @@ static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
 {
-	char *comma = NULL, *endptr = NULL;
-	struct perf_stat_config *config = (struct perf_stat_config *)opt->value;
+	struct perf_stat_config *config = opt->value;
 
-	if (strncmp(str, "fd:", 3))
-		return -EINVAL;
-
-	config->ctl_fd = strtoul(&str[3], &endptr, 0);
-	if (endptr == &str[3])
-		return -EINVAL;
-
-	comma = strchr(str, ',');
-	if (comma) {
-		if (endptr != comma)
-			return -EINVAL;
-
-		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
-		if (endptr == comma + 1 || *endptr != '\0')
-			return -EINVAL;
-	}
-
-	return 0;
+	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack);
 }
 
 static struct option stat_options[] = {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e3fa3bf7498a..62e3f87547ce 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1727,6 +1727,30 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	return leader;
 }
 
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack)
+{
+	char *comma = NULL, *endptr = NULL;
+
+	if (strncmp(str, "fd:", 3))
+		return -EINVAL;
+
+	*ctl_fd = strtoul(&str[3], &endptr, 0);
+	if (endptr == &str[3])
+		return -EINVAL;
+
+	comma = strchr(str, ',');
+	if (comma) {
+		if (endptr != comma)
+			return -EINVAL;
+
+		*ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
+		if (endptr == comma + 1 || *endptr != '\0')
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
 {
 	if (fd == -1) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c73f7f7f120b..a5a5a07d5c55 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -373,6 +373,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_ACK
 };
 
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
-- 
2.17.1

