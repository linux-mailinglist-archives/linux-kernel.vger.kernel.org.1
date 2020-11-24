Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A42C22F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgKXKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731488AbgKXKaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:30:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C70C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:30:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e7so4220241wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8Vj2lsxh2dmXHOTW3zje9p8p0OR3F3uEvD1vS5q1vM=;
        b=NhzYZo1fXZIXcPfxAuDruar6Hyf8gg4ztUnirgYkvUuKKZPMW/sL/GeY+MQutAMiim
         ar97ATFnXxZgjQYuURIx9I4f/D5Qu9exw06YoNzO0zPlrceyJ2Tla5qObA6e2QARSnRA
         CwovYK9RcrNABdA16bSbHQjr1HTXVu081aDpH3bYoUokts0F0R8deGGGkHlBuYeEHHOw
         gEgr17juaAW8Ow5XBrHUs6tar09aW7uSv6E7EF9kGq/kPVuJh3t15J2WUe66Cz7gRQsn
         ApNIs+IcP+6ES1EgE+1YiFA7M4I5YCwdtp9g09En0aQc0PBbZrAODAVbosGvyuz2CJlK
         nuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8Vj2lsxh2dmXHOTW3zje9p8p0OR3F3uEvD1vS5q1vM=;
        b=JYJlvzEh2V7tWUIEOPIgZ6/vrL5b031Tk7W3W9Oz2SYRczeJRxxtRu16MJtZrThEPq
         noptZluRRLUuJqJWpqjDMxE8y2y8WyyfZI1QXSdy+CW4lMDYcnw5p9uDS8QoPdz+7a1s
         StsZuG7Ge04UfluXhG6AYcr+iwADlAjtW2T6OYxSIFoPtSa1jZaOILZ1TMNoEhXkAYJ5
         Xu0KsHNg4YFP0h9Qb7Euxdp70qaAdlG2qCZNfmtSoxT1fchQIJXoO8YwjuovBs9/q54v
         xxXyH3Pg0xGFXK19v9i4Zovn0CUyyo1KRfY5h89dXobQnvnVLAaMAVl71DdOflTkPZdL
         mYGA==
X-Gm-Message-State: AOAM533Gp/dBnqle+eEMxuMc4l8tsWg4L6ayMsswx0ouVh2yBN8LDaJ1
        IWhLsGL3A8WmJpYU11zL/rmmSy5nxnsT0WUt
X-Google-Smtp-Source: ABdhPJwdJItnLMIYTMAOPeOvhuKmmquTric78+br6JZ1u/L7sPigx3rYY0dcxcIuKhWtosqGa4zrQQ==
X-Received: by 2002:adf:9cc6:: with SMTP id h6mr4455089wre.341.1606213819269;
        Tue, 24 Nov 2020 02:30:19 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id n9sm4471864wmd.4.2020.11.24.02.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:30:18 -0800 (PST)
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
Subject: [PATCH v2 2/3] Revert "perf session: Avoid infinite loop when seeing invalid header.size"
Date:   Tue, 24 Nov 2020 11:29:17 +0100
Message-Id: <20201124102919.15312-2-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124102919.15312-1-oss@malat.biz>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An event may be split by a buffer boundary, we should not abort processing
if that happens.

Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 tools/perf/util/session.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0d7a59c1aeb6..5f7bc5ad620f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
-#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
@@ -2059,9 +2058,7 @@ fetch_mmaped_event(struct perf_session *session,
 		/* We're not fetching the event so swap back again */
 		if (session->header.needs_swap)
 			perf_event_header__bswap(&event->header);
-		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
-			 __func__, head, event->header.size, mmap_size);
-		return ERR_PTR(-EINVAL);
+		return NULL;
 	}
 
 	return event;
@@ -2079,9 +2076,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	while (decomp->head < decomp->size && !session_done()) {
 		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
 
-		if (IS_ERR(event))
-			return PTR_ERR(event);
-
 		if (!event)
 			break;
 
@@ -2181,9 +2175,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 more:
 	event = fetch_mmaped_event(session, head, mmap_size, buf);
-	if (IS_ERR(event))
-		return PTR_ERR(event);
-
 	if (!event) {
 		if (mmaps[map_idx]) {
 			munmap(mmaps[map_idx], mmap_size);
-- 
2.20.1

