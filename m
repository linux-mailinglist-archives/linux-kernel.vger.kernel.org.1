Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930592F3FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395008AbhALW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394989AbhALW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:58:52 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1BC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:12 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s17so199115pgv.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8b4lr3SuUDTZwBYgqf0em2Urge3q4gM5MSEM1O8DWzY=;
        b=Li8/l0pnRYNodyXy0gxZZU5rq4r0i1TsFAIio9rUCnk22FipSHZHMHNIwVKPitLPGe
         HOVlTNMiavW+oOca6BByAQvyPHzAJHMzz91+Lp1B+2KLPpuomZ/Bgs0wV9dC3UOYHscH
         zYfkZ0Eu92QMU1xBQ60T5ALY+Q0/PB1g8Ca8LI8dgf04Bba2tjEaMQOnWnq3X65cXppt
         yCnvp/KjYOgwORMVQwzrSPAze3adVYj1wLkR3e16KVsq+hCaI8zNUCLoa8THkXOQuPCE
         B6ursTy1FxsKmVRLf05RC1xtNGLY0ct6de6/lggJb0rr2e9mfW97KqlnuelfbCy7hffT
         J0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8b4lr3SuUDTZwBYgqf0em2Urge3q4gM5MSEM1O8DWzY=;
        b=eYG5YpVPjdmTAEa79jPzU2mAljV0hBr23X/wTbjvgK60BX+NBk/fJN/KT9W8vFzG+l
         zD1S83BiM++AEh6ErhB2ax9WdgbSshXcJZKACH1QJB9w+GLtdoCcyUDsr5p1Rd4jlj7N
         4cWnw3HWpOxwOnUmn0nuZoyHk8jNKhX0cDTsTS2hAp8bdu6//uOupmi27wGEKivGy2f4
         tT8ZObu+S9+MCiAWJ/hRmwBKn7n/IgN9WEvEqNLTBVyZppj+f0IV8cWbJ6hg2dFMFvkj
         xA4wAM3G4nEHqxJjsyGJHnK7X/Hk9MPLrOOvEOhtTc28AaaRDY+XZiPmLUMSqgKmPbLw
         5AKg==
X-Gm-Message-State: AOAM533tE9hoiL6aTG+jTAyNAHjXbM12U+UhNyBxJSkexTdNi28z+UPC
        choPrysdmWEH2gmj03hE9N/Hiq/2VXaZ
X-Google-Smtp-Source: ABdhPJxWJxpja5O8+LwEYh9jPlIaRe3f5EZvCzwi7kBRkE5SDbZfQzCh5SKXqZk6lDrOtrozAcXsNNwQKC6u
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr819915pjn.1.1610492291201; Tue, 12 Jan 2021 14:58:11 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:57:59 -0800
In-Reply-To: <20210112225802.2613039-1-irogers@google.com>
Message-Id: <20210112225802.2613039-3-irogers@google.com>
Mime-Version: 1.0
References: <20210112225802.2613039-1-irogers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 2/5] perf metric: Use NAN for missing event IDs.
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

