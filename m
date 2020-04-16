Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8E1AB4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 02:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbgDPArb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 20:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404980AbgDPArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:47:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822AAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:47:17 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 189so1675934pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3iLPFWDwfHpQyIY5ddsVnQshlx7XFvcsLeTqTSfkz/8=;
        b=DOxWjyuCdatNOyA10KQsP9rVDkAeHg4yRlxw1JHHdd8LlS3MjoPjW4KlPiV5HBveEW
         XDXX2XIMRD1f4180KGWvIgtih5lCdBs7e6QpaT3vfTlrUGRiB9zDQ7iZTDQSmxCBcUeg
         t9o1nh7YOm+/2W5KKxYVGFbqqGbVSquaOqmdeEIU/D08lvXM/c3wKlpPU09tFMu24kpn
         93lz6sICS6dHBuF6+hfLvHjqSuNAuo+GVJKvXEUpFSzKpwdjBtcQxum2WjAahJtUYEkY
         hdwpVIFzodssxMpS8kqaVxWI2le2nHUtbGgOMKDv+zcBY+YZpAL1pYXGgQIAMlv1l1SY
         6iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3iLPFWDwfHpQyIY5ddsVnQshlx7XFvcsLeTqTSfkz/8=;
        b=TbWeSossclJe2Hgu/5/qNkYy0c8A9ctapJaaG/s2AKYR2r62xIqikaUyvOO2uKFELN
         cnp9alcB8b7kHJfeXGKFqyHfnkItQbepKDvmnvheVTZr9Qe3wHT2pTBadboxLXrsaSyn
         HHLSZZdUMOR2wExYuwRogJHdYrVxiFYCxmrugxYXD/IzcNJaKfA4MGZlCjMvOYU1qx6g
         aOpg6s1P31nOuymsNPzcez+vMueh/Iabjsmyx15DNnfR4YrChJgHg1l5ti9FCfZLedf+
         j4AYBPPArU8cWSlSD4ezKz4qlZQFZE7jCgzaAk3CMnhs+kez9dCCaHnchDzHCurBy+5l
         ipcQ==
X-Gm-Message-State: AGi0PuY5r1Hi8qWJmX2MIWrO2Ty7gObpRFkwnzxsxCzQ4sFBGHGe6icD
        BqF9CuHTDELvVEn7Tt2oY+5zTOlm1Dk7
X-Google-Smtp-Source: APiQypIXRwA2bUW5DAH76iANV6m2IGO0UtkMue6ylbcL7SvlwEz9QDTQZW3DJRyoZEPCYsxae41t1VPWRCer
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr2141264pjp.130.1586998037062;
 Wed, 15 Apr 2020 17:47:17 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:47:13 -0700
Message-Id: <20200416004713.192740-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] perf record: add dummy event during system wide synthesis
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the processing of /proc during event synthesis new processes may
start. Add a dummy event if /proc is to be processed, to capture mmaps
for starting processes. This reuses the existing logic for
initial-delay.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe904..bab4fc8568d1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -805,16 +805,18 @@ static int record__open(struct record *rec)
 	int rc = 0;
 
 	/*
-	 * For initial_delay we need to add a dummy event so that we can track
-	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
-	 * real events, the ones asked by the user.
+	 * For initial_delay or system wide, we need to add a dummy event so
+	 * that we can track PERF_RECORD_MMAP to cover the delay (of waiting or
+	 * synthesis) prior to the real user events being enabled.
 	 */
-	if (opts->initial_delay) {
+	if (opts->initial_delay || target__has_cpu(&opts->target)) {
 		if (perf_evlist__add_dummy(evlist))
 			return -ENOMEM;
 
+		/* Disable tracking of mmaps on lead event. */
 		pos = evlist__first(evlist);
 		pos->tracking = 0;
+		/* Activate dummy event immediately. */
 		pos = evlist__last(evlist);
 		pos->tracking = 1;
 		pos->core.attr.enable_on_exec = 1;
-- 
2.26.0.110.g2183baf09c-goog

