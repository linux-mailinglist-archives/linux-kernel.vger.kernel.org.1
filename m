Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540D32F3FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437407AbhALXF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437254AbhALXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:05:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CBBC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a206so393516ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8b4lr3SuUDTZwBYgqf0em2Urge3q4gM5MSEM1O8DWzY=;
        b=o74nh5DphUZ94wcuygdVtVAsLTJ6tlXZnY9cw0w6fLRBWOcC3ucLM4A+QH54ZcTrtH
         3rN3vMkIM2FG/V570AggMdq1LKTuK+vjfy0SSTL0RKAHJXtz7Tn2Y3wh4LCa5c+jIUFU
         PssV5f4J6CYMwp/I6C+QruDgtYEDWvQSP8LJuZEyTUSiaMtJgceiKBK4tZUGfYwnysRo
         tF/mCTPBV/QPUd+a0A8XdOXJL03mw67YHgREmNMZm7amqQZirpH3+JsAJFw7yinnvAf3
         Iamkl1RhUJ8frQilzyKDZF8WGkL355fJKLIUKp1U7DHsLG6kToAVDRNSTsiXFFj7PerX
         rvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8b4lr3SuUDTZwBYgqf0em2Urge3q4gM5MSEM1O8DWzY=;
        b=SD7Xoh6A/UwxOJyzolHXeZQKKZZMFg4dePbD/fXKaJk/pynODDz/W5OHwdgGC00+Ie
         22nZYASsebbDSBdCE0EsRxV9s68XbZQncZ6A+Rdvo9wGch0GPDVTbTENyoDazFGGjZ4l
         Zk7hI600Td2R3A7O1urGg9bYZEclQn8JsX/I2TS/zR9AMU6H2aVQB4GQtbLHzbharQmQ
         R8PXZo8hJGL93dAkf5P9/hY1k0r6K8yPYtatWmdhiivWTACo7H2+Qf9QBfkSFGqJ9oF4
         BSmq3zJ4SbMtBCSZCy9KY17MsxqOG1WRtnI7oKEK2qgekhwgtZ7hVGyDpXrJSf0cEhjN
         l3zw==
X-Gm-Message-State: AOAM531tyJftYqcdJ4KncfAbsz2aQ1II5AgVNUQZURe2pQgTFKAXTOv5
        qIo7QWJznbA+CXUHhuvO5QAnYaRfobMD
X-Google-Smtp-Source: ABdhPJx/s2V9uNeLn56uxYV/uSV7lx0BUhuu6oMb/qToBQySTq2Bl/G7Zzz7WSJnRvWOLJpzbIem+nU58mOu
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr2585658ybm.219.1610492682292; Tue, 12 Jan 2021 15:04:42 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:04:31 -0800
In-Reply-To: <20210112230434.2631593-1-irogers@google.com>
Message-Id: <20210112230434.2631593-3-irogers@google.com>
Mime-Version: 1.0
References: <20210112230434.2631593-1-irogers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v7 2/5] perf metric: Use NAN for missing event IDs.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If during computing a metric an event (id) is missing the parsing
aborts. A later patch will make it so that events that aren't used in
the output are deliberately omitted, in which case we don't want the
abort. Modify the missing ID case to report NAN for these cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2ada8f8309a..41c9cd4efadd 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <math.h>
 #include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
@@ -88,12 +89,10 @@ expr:	  NUMBER
 	| ID			{
 					struct expr_id_data *data;
 
-					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
-					}
+					$$ = NAN;
+					if (expr__resolve_id(ctx, $1, &data) == 0)
+						$$ = expr_id_data__value(data);
 
-					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

