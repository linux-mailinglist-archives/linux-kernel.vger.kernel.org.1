Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF12C226B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgKXKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731821AbgKXKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:00:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19027C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w24so2239179wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EB90JQ/0XqcsTAPslbzBeq29zVRoJjnJP4/4/VfFxeE=;
        b=iWLh3WbpBgL0ha2v/yASF63Z6iBdPC6zlLda7ow+ZjEVYbnR3w7m549X81OOjhS07G
         k8h0qs7eH+JKum0/yDyQSKPt9zhHMMObAgu0LhvUQG/0fguYeGncgNP6f9QCrRpmZcL3
         g5g0W3dKC/VgEB4JQxvbyl0WHhh/fIs/0pg08+tgDKbzeoIkJxoZ6G7cp4C3hGw0vAy0
         ngdw7nW1lPoUzn3MqY3U91IGiuHvHzcSJnlot+wsWqKGr4z0NUGfmx1ozN8uExm2ETeK
         ffGa79qZ1EWFnYBGFGcGC5pukuw/4tnfOC9w2unQ2D28hSxF6VIIXm3dbpj6p856kcCV
         eQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EB90JQ/0XqcsTAPslbzBeq29zVRoJjnJP4/4/VfFxeE=;
        b=mPlqtaD9uQ1pGk3jqsDyAlGEB+fm68R5KM2S2TBHmX902PJuGWotrw2I2ho4M/sJHd
         JRwBISgNWZjuUKMK6BTi1LAyGWTGX+yutnz02YIXJCX7jF2ScWR0xlTQhcVMECzkTDzt
         R61m6tRdT1WyMslWMPipTrgbTSkLlQIpZDYmQMHyCM3Ygj2HCT51+YMLIGODvudkcCe6
         SGZdJwz+5zXCwJUjzT0fLE+0xZIdEaw8qPfk2hbD4Y4wptyQ0Qp1Rhf9mqpsSMIDLCr1
         c/PTGSMc6sHUAJTt7SVLNCnyMQ4Hf1YMPcQ+x98e3VDHMRV+WtF07uQSeo1qM4X807Fl
         1RIQ==
X-Gm-Message-State: AOAM532No8GX7pgrwj6N7hEp5OX8MAleam7kCwvSBKnGQtcrh4f+R58l
        h2ybguYghqYvpdLIzM+EY9yVhwe986ow8hXH
X-Google-Smtp-Source: ABdhPJySASir2Lvrw+zV17ORnOk5njq1cjXvPqNITvpanul8SnSOEW85fpv2OoUiS0GOk2SlwlgO2A==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr3639203wmk.4.1606212002609;
        Tue, 24 Nov 2020 02:00:02 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id g186sm5565168wma.1.2020.11.24.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:00:02 -0800 (PST)
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
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 2/3] Revert "perf session: Avoid infinite loop when seeing invalid header.size"
Date:   Tue, 24 Nov 2020 10:59:20 +0100
Message-Id: <20201124095923.3683-2-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124095923.3683-1-oss@malat.biz>
References: <20201124095923.3683-1-oss@malat.biz>
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
index 593d5a823eba..e57b0d09d196 100644
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
@@ -2045,9 +2044,7 @@ fetch_mmaped_event(struct perf_session *session,
 		/* We're not fetching the event so swap back again */
 		if (session->header.needs_swap)
 			perf_event_header__bswap(&event->header);
-		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
-			 __func__, head, event->header.size, mmap_size);
-		return ERR_PTR(-EINVAL);
+		return NULL;
 	}
 
 	return event;
@@ -2065,9 +2062,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	while (decomp->head < decomp->size && !session_done()) {
 		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
 
-		if (IS_ERR(event))
-			return PTR_ERR(event);
-
 		if (!event)
 			break;
 
@@ -2167,9 +2161,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
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

