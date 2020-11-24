Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56762C226A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgKXKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731377AbgKXKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:00:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so21615935wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf3v5L48kPBtIf3sogENGFn657pA/N996xR3c0/T9E4=;
        b=iCkj4sRHcmUFtUWtKeC4Kcqsw7GbEvHF/ZtJVu9sVq7GgY3/UQkIj9zZc00wv6PnLD
         rjTbr7Xt4XuTGA0Rheyhg56eaYI/rheYwrhbmlbFF9/GlhTFbJmBp1FvseHweBWEHXFs
         m7VmETpyAaipicGNk43FwR17dxbYNgIX8rqHq9iZkxGBzIAps3hwcVIsf8E5RoDimCxN
         pIIeSA6PqZzMDOHGk3kqIcQDoguEa2BSTY9buP56NXLFaklMRKE/QTAEmGZiV2Hd0bsn
         4LUT3KYuGdSSbLMHEIe5vX5hkWhZh12Vpf6I1GFohlMnm0TVPuKTIN8o4fYuQFJCQnyk
         iUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf3v5L48kPBtIf3sogENGFn657pA/N996xR3c0/T9E4=;
        b=J5ZYurMtIsbA1HEWH4upjVjBgjR3jJfurWUXDYW0W1tq0O9TA0UOxNg/NroCyYQ1Eq
         USRyxvrxfa8POEqUY+qZDGQZdRZzNW9H4qi9Re2ALVK6b+WN688qlZ7Pgumq6849AEJw
         yyPL8VAhOerMbTWL33kI6Eq1FvhdpPzjx8ulyGSFPlmCt/8bfyCzsGaIrmdEHsSNKncm
         NAM2ZBua1LuR9RhATV1DDLGHEvU8zNHYBYHkrTe3BDm+haHdenavUIt2sHVTN53o0w3m
         V9jhBI5mv15IOfF7EW0FVfx5csszidZrM7mhBYkOWlmpesES7BBZSINGCNyITLKEch6W
         YrHg==
X-Gm-Message-State: AOAM530mc/DOd+9XxGytdCHrOndz5G5qO2YGYh+Slg7jt/P0VXCJrR53
        FuwoeAnKGM535jLplTolmCxFGT0cAQqVvthz
X-Google-Smtp-Source: ABdhPJzd1d/Mc2hsUmjWxI36el2ZY4J5brluAysGieSUktIlpFY3gr6keiaF1fFx/8zBaSsu8NvZEw==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr4260803wrr.353.1606211999451;
        Tue, 24 Nov 2020 01:59:59 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id g186sm5565168wma.1.2020.11.24.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:59:58 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Malat <oss@malat.biz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 1/3] Revert "perf session: Fix decompression of PERF_RECORD_COMPRESSED records"
Date:   Tue, 24 Nov 2020 10:59:19 +0100
Message-Id: <20201124095923.3683-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both mmapped and compressed events can be split by the buffer boundary,
it doesn't make sense to handle them differently.

Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 tools/perf/util/session.c | 44 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7a5f03764702..593d5a823eba 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2024,8 +2024,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 }
 
 static union perf_event *
-prefetch_event(char *buf, u64 head, size_t mmap_size,
-	       bool needs_swap, union perf_event *error)
+fetch_mmaped_event(struct perf_session *session,
+		   u64 head, size_t mmap_size, char *buf)
 {
 	union perf_event *event;
 
@@ -2037,32 +2037,20 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
 		return NULL;
 
 	event = (union perf_event *)(buf + head);
-	if (needs_swap)
-		perf_event_header__bswap(&event->header);
-
-	if (head + event->header.size <= mmap_size)
-		return event;
 
-	/* We're not fetching the event so swap back again */
-	if (needs_swap)
+	if (session->header.needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
-		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
-
-	return error;
-}
-
-static union perf_event *
-fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
-{
-	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
-}
+	if (head + event->header.size > mmap_size) {
+		/* We're not fetching the event so swap back again */
+		if (session->header.needs_swap)
+			perf_event_header__bswap(&event->header);
+		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
+			 __func__, head, event->header.size, mmap_size);
+		return ERR_PTR(-EINVAL);
+	}
 
-static union perf_event *
-fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
-{
-	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
+	return event;
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -2075,8 +2063,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
-							     session->header.needs_swap);
+		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
+
+		if (IS_ERR(event))
+			return PTR_ERR(event);
 
 		if (!event)
 			break;
@@ -2176,7 +2166,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	}
 
 more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
+	event = fetch_mmaped_event(session, head, mmap_size, buf);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-- 
2.20.1

