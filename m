Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D402CB5DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgLBHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgLBHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:40:41 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:40:01 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f11so685864qth.23
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=h9T11P8IuAbiCCNQQAXJdZ6J1ZAJ+f4CmpUctC3h5RKs8bChw50UPB0s0Uv+PIG72R
         CqeEXw92Z/yFTvyS5b3yhy2vuxyHnMniJa5Pf7hOULqg44ciMb3ixi0aR7JdfCMRkyxP
         QVMJA/Ll+gi4EPCJdUqK4wDN9kk04Qyxyp+wv4mFBWBhA4KJyuNc/yAlyhX46bWgLExg
         y6mSCnPkKvZ4D6Gtu07a4ruqTf7GAw3Fq8RwZ2Ul5aOeHlPR4cwxszMZpPvZyzVf4zN6
         vimrsq9IwdqxHnm1Kb0UMueUKdw2CiHjR3lOXYGtEq5nTaeGeJi96MZE+7xXHytv/92n
         22OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=d0B4/RhRVrf3tM1VAZZNV3tR54ifMrGWkynpKaTd5ewcDgzYXsaW9fAqYwZDpds5bh
         AvCam/dNJZ2kLBzYDkfG21DP4oihJq4kyG4etn5v3xKNdaRBeBKuvKVWMbDs/8QDqT8v
         IV+DAWVCynIH4PQq88IrilnHjfAkM23eMpt9Rq4NUjvmnq1jWxPnDPnAHTx1JXG2YdC/
         j7nJiHq4ebUKsFXkrsDQhMI0MLigg3vCygFm0kFaAC8bDpZ9+0PU3WE3ejyOhBS5xI6P
         yzvybvgrBaoaxXIAlzpA3qNQzv0GGA24eqBaYpSIu+pMwHXJUpP27kN/+wODciAVRJ3U
         nxCw==
X-Gm-Message-State: AOAM533rK885rQaU9QpUFV6Mfc3O9HPmaEuAL4TRKfdxp4NKEBjR05Ez
        dJN/0m58wabPfGWNU25ZQTxBWVZyogCJ
X-Google-Smtp-Source: ABdhPJzdhhF6JKGFz06Se4fWlvk2jaLAwTk4WL4pd5dKcGKeQBubdSh6lsUuFK8jCa+9eadh16BD0BRjP3Mk
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:d68d:: with SMTP id
 k13mr1338850qvi.62.1606894800746; Tue, 01 Dec 2020 23:40:00 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:39:50 -0800
In-Reply-To: <20201202073953.3811709-1-irogers@google.com>
Message-Id: <20201202073953.3811709-3-irogers@google.com>
Mime-Version: 1.0
References: <20201202073953.3811709-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 2/5] perf metric: Use NAN for missing event IDs.
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
2.29.2.454.gaff20da3a2-goog

