Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392791C1BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgEARdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730146AbgEARds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:48 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C1C08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g14so11893667qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8gUq3gZyaZ+fW8XLtscPZL56CqBcOzYoWmQ7LuAcGtI=;
        b=uK82sz2LT/jbSzyJXKJ+aocLDmjvjCNP+G6/99wXLkSfDSgrD7pZQy8C9X+Ql7vzYP
         XzHlstd4EN/MJx362hoi+aLyTKYISHNUIiZIwjl8Aitj5jB2TsdNQN0UW3a0xFSusZ2k
         AXn1jHl1Ux93M0JW7IplfIE6P5YKIuZtPlN2+tsAeV80vARbXE8mbxRa9xN2DSLcOXUC
         87PJT7OA71+yi/LXIU478JDDmmC3E0a9zNlsjT6wTPNyvbCUC2toMRi36QhfZvqmtoz/
         TwWfDrqaSUlgWprYYe8/RHwFVK51K25iHQLsfD4uwDSWsY6zNo5NcTAkVJ4sl7+lEHj4
         8FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8gUq3gZyaZ+fW8XLtscPZL56CqBcOzYoWmQ7LuAcGtI=;
        b=dTectLAkxC6Vsk6ZmNtfG9y+M89W8bVwzmYw2igzdH66xN0M9FAmJX1NDmfJ9TNJIY
         gVArYoopTlHYrJgVKgW1fGUSUMnl/MZYONyF6rkfLOoCgVUaaX+nUsnuO5BjlbGDBq2f
         IOJ6C+Ifoi4uUGbYk3vGUrkTsjwbWqyNKPTYGVC9asrCLEF9XAUjexURceeVlootOuRv
         4ScqMxzEEwdB++bsbuYwUkZdKVxGR6uclM7bV0E7TKUp/gT3OhVitRQIQlPjXYWdrXmX
         7RDo7bP60TffyXEIxFSGZAYzQ5CUXfTwRuav6tEr97I4QztYywQ17Fo4AV+x4ahghKZY
         HpWQ==
X-Gm-Message-State: AGi0PuYWPirMYvpszTYn90vhmGATomPYdsqkhrCI3ST8Pp4WWEQEI+wG
        3xpDfa/a7Q/Kpw8f0Hl8EO0rFwcuONJx
X-Google-Smtp-Source: APiQypKJHWFZ5pn6HsxVUCh//spNDBHwcTD0Uxh1qtW4ArD1Zp5WG9RwdVVvmUoYqHchPVGvJIRuTFSqws2L
X-Received: by 2002:ad4:42b1:: with SMTP id e17mr5131941qvr.149.1588354425951;
 Fri, 01 May 2020 10:33:45 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:26 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-6-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 05/12] perf expr: increase max other
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
need more space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 87d627bb699b..40fc452b0f2b 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 20
+#define EXPR_MAX_OTHER 64
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct expr_parse_id {
-- 
2.26.2.526.g744177e7f7-goog

