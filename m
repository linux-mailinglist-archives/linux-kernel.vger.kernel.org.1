Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A252920B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgJSAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgJSAg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 20:36:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9852C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 17:36:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a1so4627758pjd.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a97rYEMPIJ5X1UFltYu73/ikGgyNB1NPDJLFOwycyaQ=;
        b=CjkQTXZ5clH7rUyVTzd9sclC3SJOZF4zIc8LgYMXdRc+t2xXgzgWzSh0MzsARS0zqd
         ct8LoTRQpmcSq4T/AJlZ0KSsQdDohLt+ZahpLfOMxGYwvU+UlP0w7rsEPmVCB8h9iPhT
         HKTzZHRCO3Sci+2oq7WVa9Aqr43GnvBSpEuCjgtLvjaEfDP8xbc4zWCACu3qUF6kobP3
         thizbuogfKuXMbt/4Zezv14YVtmhqp8T9tV3PCUHYxOEOFOqsxzRYRj8d0jan6wRmfnR
         Ekw6PXGXqopTX4ezyTqdBuc3L/jcl3d6wczlHNU/oNuOTuyALWG1dsUbj1eru0uCY10B
         Zdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a97rYEMPIJ5X1UFltYu73/ikGgyNB1NPDJLFOwycyaQ=;
        b=Jn1BnIIq97Vj67SQRyIpBVrbrSjxPPwqXBY1pu3W36tmMwqwX5/PpzrSQ2b3ptXoaB
         DF6HEY3NzN/sfnRUViAQwWbfwVdb55tZ7iF6NDVUK0QTA6R+pvjztrJbtd29vcuc0Y38
         YGL7VgVOJCOOPRzNTf7LmMrvCisy82pZRi3THO+njcFEscu/qZMyj4HHkal4vMymeooU
         nTJNq8cb7s6COiOfcM1WqmHET9dTbfV2etj1IIoXKRDJKHiGSfuxRI5S+HNx3ccS2fl6
         axLLc/bkpPdQasEDK7mxxRqDe72xppFkV8KRvoT/67TBK3qS1XSAV4kw3HmOi/DnStHr
         tw3g==
X-Gm-Message-State: AOAM530t+6Cm+DB7fvMH3hA9fyidZ8nRtmdaG9L90IrigURWCF0qgcx3
        WDLEbbsamwV3fzngsnI0XJ1d1Q==
X-Google-Smtp-Source: ABdhPJzDU9qsYFs723cJE4A7T562FxY/viJQEfvD5U19ElDoOK+JC+e9tGZuzM7Fv7I9pmEWOwiPoA==
X-Received: by 2002:a17:90b:1902:: with SMTP id mp2mr15638800pjb.176.1603067788060;
        Sun, 18 Oct 2020 17:36:28 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 131sm9686144pfy.5.2020.10.18.17.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Oct 2020 17:36:27 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf mem2node: Improve warning if detected no memory nodes
Date:   Mon, 19 Oct 2020 08:36:13 +0800
Message-Id: <20201019003613.8399-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some archs (e.g. x86 and Arm64) don't enable the configuration
CONFIG_MEMORY_HOTPLUG by default, if this configuration is not enabled
when build the kernel image, the SysFS for memory nodes will be missed.
This results in perf tool has no chance to catpure the memory nodes
information, when perf tool reports the result and detects no memory
nodes, it outputs "assertion failed at util/mem2node.c:99".

The output log doesn't give out reason for the failure and users have no
clue for how to fix it.  This patch changes to use explicit way for
warning: it tells user that detected no memory nodes and suggests to
enable CONFIG_MEMORY_HOTPLUG for kernel building.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem2node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index c84f5841c7ab..03a7d7b27737 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -96,7 +96,8 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 
 	/* Cut unused entries, due to merging. */
 	tmp_entries = realloc(entries, sizeof(*entries) * j);
-	if (tmp_entries || WARN_ON_ONCE(j == 0))
+	if (tmp_entries ||
+	    WARN_ONCE(j == 0, "No memory nodes, is CONFIG_MEMORY_HOTPLUG enabled?\n"))
 		entries = tmp_entries;
 
 	for (i = 0; i < j; i++) {
-- 
2.17.1

