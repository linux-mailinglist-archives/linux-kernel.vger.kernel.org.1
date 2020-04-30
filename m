Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7541BFE02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgD3OYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgD3OYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:24:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D684C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:24:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e2so7752021ybm.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DpLe2/yxlpy0aFc7LjjFR8EhmIvjlgt7hqTB0OaUzqw=;
        b=nTwgcui2CiV0+/Jpql/konVUDAJxIwSvypifzKGqEa5N2zt4MIbFjb1mAn7/qwLihf
         vu0iHY6F0lUJ/lpzYGDHglar1oftRe5QKFNt+SxbDedcCmm3YwssWXQMsdKVrr1yW/L0
         hbh2CMDDfsfgS8wpd1ItOELZ2zX2gZZfj9jv7hfUNZD/Cc3RQHB8NT+5HAVgLV5wmXhh
         KUN8zSWgRRWlB4hEaPTS+sqCnIBgbPDRp47GrFog6FH1+9HvnApAy15WlVS+opecoFkk
         JN0c9NKlKH12GdzFIkaOkli7Zj9XnFSyHT2bAMW34rF9aCYVPepdqiv+fA60MYvdLQ0C
         bpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DpLe2/yxlpy0aFc7LjjFR8EhmIvjlgt7hqTB0OaUzqw=;
        b=CAw1zxRM4gmk2jbTrGcqkq5ZF1L46ZQL1nAhfPdALnGd8dRRPWLF/SiTIg6c1Byps7
         AkFATh9BhDIYwxy23/jLuQFy8o0R0CjDFVWolV1UK0I8q40lKcXZ2HHdHMU7bH6qqGLY
         vaQ1sHnDOxjc12QMSDQezTPQrtRtnbf3e9dYddE0nWxs+dn5gv6H8Op6FOfnbuh8HtOl
         d2EiTmHOPlf/9NnQqUcJ2kK4I39szBen5AL9oxnfJFxjfQulGR3xFEap9AFnbN98H5DO
         qRxJljTHBw333hj/aPA6iRLHT8PZWkG171W127kvUZFmnsFRJnR4uQNmAadxnuDreTyY
         yTJg==
X-Gm-Message-State: AGi0PuYNIqPEAwjFopqCCZlTgqRfa9nZ/fWgreTYLRA7uA6c8oazsEZq
        JbT4+V9hrAoNJ7w7q8UGeJ/pgMRq7k7t
X-Google-Smtp-Source: APiQypLSBWwmxXdbCXvEwu6BQZ0SdYLx5+Wv2iv/ATKlzHHRCUjvZTfhpTl6ZunjIVWUzi0myR4aFnFZeter
X-Received: by 2002:a25:9306:: with SMTP id f6mr5949447ybo.375.1588256668309;
 Thu, 30 Apr 2020 07:24:28 -0700 (PDT)
Date:   Thu, 30 Apr 2020 07:24:18 -0700
In-Reply-To: <20200430142419.252180-1-irogers@google.com>
Message-Id: <20200430142419.252180-4-irogers@google.com>
Mime-Version: 1.0
References: <20200430142419.252180-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 3/4] perf pmu: add perf_pmu__find_by_type helper
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This is used by libpfm4 during event parsing to locate the pmu for an
event.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5642de7f8be7..92bd7fafcce6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -871,6 +871,17 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, list)
+		if (pmu->type == type)
+			return pmu;
+
+	return NULL;
+}
+
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 {
 	/*
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1edd214b75a5..cb6fbec50313 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.2.303.gf8c07b1a785-goog

