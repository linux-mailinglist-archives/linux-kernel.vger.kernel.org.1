Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA362E33E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgL1DTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:19:52 -0500
Received: from smtp2.axis.com ([195.60.68.18]:41023 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgL1DTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1609125590;
  x=1640661590;
  h=from:to:cc:subject:mime-version:
   content-transfer-encoding:message-id:date;
  bh=6J3/haCJ1S4udfL+2NKVZM/qxvY7zBWBBCGW8TDBFh0=;
  b=Cuz5xMXH05qFVAGPTAlN15bImnLNqRm05MiRhMWGMu+iciT7O2ktorJg
   a/Gca7Uty1zIGswI/JZqgeb0OVznhlfhydf8aPs8m67PqYeqCQhgS+RuX
   yLarXlhTkl1aN7S38IVyQ4FZo3/u+yKZZJ3sXpBEAY6UKDvg6pTPxuVFq
   d45bYrZn0NPBuuWkzJ/Y2SGZ3455oAnpxUU/NizNE+LXdSh8KQb0zSi+S
   M6wzUYgVqfqe1TOq2ULEIevvG6fDFkgPgOq9cisbkBBh8jdXK2mZCYP7w
   mcietoLbiVFFwKyCnHOhvcmVTqvbuY8bUyIZ6dtWhNccboaHWOUwWlytE
   Q==;
From:   Hans-Peter Nilsson <hp@axis.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf record: Tweak "Lowering..." warning in record_opts__config_freq
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <20201228031908.B049B203B5@pchp3.se.axis.com>
Date:   Mon, 28 Dec 2020 04:19:08 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is, instead of "Lowering default frequency rate to <F>" say
"Lowering default frequency rate from <f> to <F>", specifying
the overridden default frequency <f>, so you don't have to grep
through the source to "remember" that was e.g. 4000.

Signed-off-by: Hans-Peter Nilsson <hp@axis.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 07e4b96a6625..3b38e7be10da 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -202,10 +202,10 @@ static int record_opts__config_freq(struct record_opts *opts)
 	 * Default frequency is over current maximum.
 	 */
 	if (max_rate < opts->freq) {
-		pr_warning("Lowering default frequency rate to %u.\n"
+		pr_warning("Lowering default frequency rate from %u to %u.\n"
 			   "Please consider tweaking "
 			   "/proc/sys/kernel/perf_event_max_sample_rate.\n",
-			   max_rate);
+			   opts->freq, max_rate);
 		opts->freq = max_rate;
 	}
 
-- 
2.11.0

brgds, H-P
