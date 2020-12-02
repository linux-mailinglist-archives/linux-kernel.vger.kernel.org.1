Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177282CB500
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgLBG1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgLBG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:27:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:26:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so628456ybg.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=gjji7fJ/bUmVFMRKmo/i0UBGAiQMq3/69prKtzqh1MhiI/4XNIJ9JXOg59MsVzsf8U
         gPqA+D+/WkUXUHvp6KZJ4od7mEWIV8Woeepl3tr0AgkX1amlkmn45Vn44OANfZD8WWxE
         mt6c+TAdheAtFvsh//k4KtXXcwBTT3onWUTym6RdgNjNGSoRKtceyplJkPy9xf/UCf7k
         Wr/3uJOoqTHabjq/hNwXH7dEDU4kOdEDkGwM9aywpt4tuLhV7+qC3bplYtnTawz+yng4
         wle8HzhOkrmUrTxJ4m+hnV7M/jwb5z7dezGnNjW7+LARzq2+sG0rNShJBJin+9yruidq
         QPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=okVBCSPBqiQNeYwPD4YZmqn2A/GybqId91YnmgTpPN/xSXEgCPa3CWsvQTTy/4jbSo
         +dffxGv2Yk6MXZP2aWGH6w+cU8Jfzc5qi4ASowaMgVmpiZ9nMRaAQ6skbCCkl07vDhrO
         LizYrEoHVX1SOkSGpZzKMAEr4P5qVTDyGyWRBmTRmBMYR579UbzOX7gmhQMCBOX3DWTa
         d4TC+AUCd28d6eZpHBoPFymDkUIHReSimGJr+CYhpeVkgGrKGC3Nx5GeEhZ3StzYxDFD
         Ingxi9iNb7tV3+dzHTOZpiyo4liVh7Sd4KhvKXgQf8OGbOy3yAEYdGJmDHx1VW98fb7z
         OIVA==
X-Gm-Message-State: AOAM532j98pSLHOZ1ngg+fBA6Pu9gQ1Zu0KT3DZS7Df9hed/X+jECYhC
        u1dOOUde6F1nNat0TYaKWuu5TH8ZiW0b
X-Google-Smtp-Source: ABdhPJwrUVhFtwpp/Ewgo3RUWu+ISsUwgAz/VXg/kwKStNacZH20a7qUlEeeV+tY8shZR1DihdtK6qQlxaHz
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:c343:: with SMTP id
 t64mr2149244ybf.94.1606890415468; Tue, 01 Dec 2020 22:26:55 -0800 (PST)
Date:   Tue,  1 Dec 2020 22:26:43 -0800
In-Reply-To: <20201202062646.3780002-1-irogers@google.com>
Message-Id: <20201202062646.3780002-3-irogers@google.com>
Mime-Version: 1.0
References: <20201202062646.3780002-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4 2/5] perf metric: Use NAN for missing event IDs.
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

