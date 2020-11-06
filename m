Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39A2A9355
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKFJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKFJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:39 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so833153pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kd4epe4q0Au0t9vfVIipb8EifZAH94kZvxB3D28L/e8=;
        b=IA8RY+JPOGoW2yuLsWEIhueODFoxSxyOzTq9LQH/8/YF0V4KiboxL4+o1XiHUMlWQL
         MdsKIgL3QY6/AAQrFCuegnEARsCr1COpUpkPeOwzaolWucs83oSrR/6dmHjPjC4QmtKz
         kPen52Ku0Uqedu9rpODqa7/UlpbYX7oS6IwUwJYsbmY+pZu8/E3pnJmxykQAyeMXHxGO
         k4/aYVAAlxCaaHQ2f2Hn3rSOgYII7TAjnRbQvgn6CmK1L8PCwR20Lv51tgPaL0gJg8gk
         D9uV8u7Ny0qzSCmFRmb1rorcu+f2C83wLv3+wEZnGbqdwNEFJ29tO7NsLCIb7ZS9+ymO
         OktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kd4epe4q0Au0t9vfVIipb8EifZAH94kZvxB3D28L/e8=;
        b=mZik2xN2FURlHU6W6LAlWwX+wRzR594v5jxvVHXPYnejcrib+gysxjDk2BQNSWu7rz
         TPyeNBN9xSwkHcsiIIERk9ATUoeQBjDu8mBIqxOamNV+oOPTudk0SlKy4zFdDg+j+3Tr
         H8JHSyfYQawW568RsWQ85NFwgVO/0DA0aulJ4WKrtkZmZ6tK+CGq8b2nLJ19mRH1GIqa
         aB5T+rQXsJqLSB+X4l1YH1JgrpnCC/mvihruIcNyv7fuVrKHlgnA5/F0DLuY7pegUfld
         YwoqDNLLVW2a57fqW2mfM0WKM4SAq/lMdUZ1ZSiraTNtU4JmD8J7dsDYkEBQwf5dgIVf
         hjBA==
X-Gm-Message-State: AOAM532ijv83TplupbbGuhUHcgzTicEBruR3W+o/euWBC7cmD75w7ZEf
        LB/uM086wRHdPThdY6ZGPO7cAA==
X-Google-Smtp-Source: ABdhPJwP1o28b2yhGIdrMiAJxF7cQb74HsJiaXjCy267FNG09WBjctcaYpdX7FisbQjV5u3qtzkdaA==
X-Received: by 2002:a63:f84c:: with SMTP id v12mr1074588pgj.125.1604656178999;
        Fri, 06 Nov 2020 01:49:38 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id b6sm1071115pgq.58.2020.11.06.01.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:38 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/9] perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Fri,  6 Nov 2020 17:48:48 +0800
Message-Id: <20201106094853.21082-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user doesn't specify event name, perf c2c tool enables both the
load and store events, and this leads to failure for opening the
duplicate PMU device for AUX trace.

After the memory event PERF_MEM_EVENTS__LOAD_STORE is introduced, when
the user doesn't specify event name, this patch converts the required
operation to PERF_MEM_EVENTS__LOAD_STORE if the arch supports it.
Otherwise, the tool still rolls back to enable events
PERF_MEM_EVENTS__LOAD and PERF_MEM_EVENTS__STORE.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4d1a08e38233..98ae33eac6cc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2895,11 +2895,20 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
-		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-		e->record = true;
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+		/*
+		 * The load and store operations are required, use the event
+		 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
+		 */
+		if (e->tag) {
+			e->record = true;
+		} else {
+			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+			e->record = true;
 
-		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
-		e->record = true;
+			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+			e->record = true;
+		}
 	}
 
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-- 
2.17.1

