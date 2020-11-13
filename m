Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF172B131F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKMARC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgKMARA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:17:00 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD1C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:17:00 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id d4so4918288pgi.16
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ryYfvt+lWMJVuIdFeA4yxNPWYH9tZ+u/Mvva/I+PHwE=;
        b=dbPGB9FAcvnTP4ZA1p8ZUtQfF5RQhRYLEXlF7595Sv2OsT16/iC7h6cyLeq5UBY2G2
         UtPYWZAxQLDLIPVTGqvegu66k4Pn6g95aYF+CC8EsXuwOQPcaTBeZyGWJpyzIuBt7VM2
         iucd4PUCVmb8ZVKSVDttf3nnr0gHVIiTb6KY8U1FPJFht7d+yIMsNvIdenU+9Gc+UcNz
         sJPRdmeqw6qOnhChF1uGfF7KPfccprvRfwpJfJhZWQJmXHwVW8nAiaMTVIv2gEygeCcV
         s03onl4zQy0tXmAnQH9jovw8Lz1k/XoWU5qX8HDlYbhgg52BBfjJgkvef1SYZAe6HMkN
         zIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ryYfvt+lWMJVuIdFeA4yxNPWYH9tZ+u/Mvva/I+PHwE=;
        b=nYVETccw8KU8r25vqVKcJxXuH4eAv/qA1z8IwyqgWenQ2jt+BQDzZQqUrWidaN9iRi
         c7k+ucM+NzYDCye30Otu/6Qn1BRGNW11pWK6TIthAdOyjZO/5GuBk8hAxKVW/4Ou9hzJ
         XPU3jKgW58ZSe4Gm2SmB3GI1iOZchbxDOQlFkKJkl0BhrPP6HYA/2uRmkMEpF5bBuLrI
         A7daLTVW6ekHOmmFBKJe/1DAM3PWPoVoAMmww6AgnFC1z7gt3BwHwMfdW9vS+ZyWFpsV
         /qFMHUvw7zK9Hmsna7CxcNP0VNsj6e9fmbNlwO948w8nARllL7eV0qQeoyCPD0fBvd9r
         dtng==
X-Gm-Message-State: AOAM533fpAGisRgwJf61Fx8XJMPV22Dxy23bzQJ7N+SdSnfzMTeRa3e9
        HunVOCgoeaKadAy6V07DYCANgYgPwMMs
X-Google-Smtp-Source: ABdhPJxfLFnGF+ZocdGLTalH1W7KN4rMDtnDIikUAKADm9x42WYHKIzvV/RwtXPhRHBSFzw1edS6CfqZD4xe
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:aa7:8c17:0:b029:18c:967a:d793 with SMTP id
 c23-20020aa78c170000b029018c967ad793mr1792863pfd.4.1605226619538; Thu, 12 Nov
 2020 16:16:59 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:16:48 -0800
In-Reply-To: <20201113001651.544348-1-irogers@google.com>
Message-Id: <20201113001651.544348-3-irogers@google.com>
Mime-Version: 1.0
References: <20201113001651.544348-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 2/5] perf metric: Use NAN for missing event IDs.
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
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
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
 tools/perf/util/expr.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index d34b370391c6..4ce76adeb337 100644
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
@@ -89,8 +90,7 @@ expr:	  NUMBER
 					struct expr_id_data *data;
 
 					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
+						$$ = NAN;
 					}
 
 					$$ = data->val;
-- 
2.29.2.299.gdc1121823c-goog

