Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9806B2A9357
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgKFJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKFJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A263C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so833429pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LYurlota429k+S26ab5934uwHlC+pF/vMcIbnSJ/V9o=;
        b=qagIXdRGk0Gmhr9PFGLytsMpJ6MiBHp+xj3CZSq0X36y7BrRRE/WL9JjhmvSHfsI7E
         Ruo7NHtohS7VNOXD9PDQIO9oZdo9Ow4q58Fv9SWL1s8PGex1gvhC7xF08vV/kFTc3eEF
         koH1cJr5IFatibk70QhtI0tl6AFyl3tMFGCAABL+HSesli6KrYdqectKDCe3cpV1rM6K
         fEIdc1LVqsYQcELYIjyj7AXPVwQEmvggXtPskfX2vUuIPrwD7NDS/fPnUNWpjxDfXkXv
         D0JIW8TGyPp3n9z2p5l59nsJeQl8+6JV3dz5EuQh6pfOCtIqCXr0TOUxS+tieXuf/kTI
         zjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LYurlota429k+S26ab5934uwHlC+pF/vMcIbnSJ/V9o=;
        b=pHomP694CLxFRQe86HYWD+YJuKnczv840RfRqYTXkAhF2LFSoxmdIoxkKN4C3KuA3X
         Z4InYEdCKgJH/RvWLWktSbzmbizXoeMUhsd1BDW+Wn3nwFoj+HdmpDaZhBuHvguq9iGB
         JD2ZXNUVPVWS/1H/XYKiiHhhhmQ6g7S2kGiOtj6qt+SXmPqqPjmeth2byxqhqYdRCXgG
         GfZEFWilTiRrksKVKkh/d/190MGeXv1SuXMuuAzKXhpikraVC3HON9N9A0XTikxgDmAA
         v3fxNhe9Qb405J1GdMJ83OMNrCL3BHfhr2cwAIubeU23hrOmObLW9Jz8Wnp0hPxKZHL6
         mZMA==
X-Gm-Message-State: AOAM532DyftqWl0xfYq5Po1wr5ChRS7aC8vwyWeuE1GjbFEDhaXWH98G
        Ic0Suk6ZOJCvBnUDotBrIf7BpQ==
X-Google-Smtp-Source: ABdhPJy3smMYOtATZcLboJdt62vLjlIt4Z1DwdMeYX/nzaKvREMsTC/fo3oENctsIYtIEJnzJYnt2Q==
X-Received: by 2002:a63:de07:: with SMTP id f7mr1036356pgg.27.1604656186608;
        Fri, 06 Nov 2020 01:49:46 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id o10sm1049774pgp.16.2020.11.06.01.49.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:46 -0800 (PST)
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
Subject: [PATCH v4 5/9] perf mem: Only initialize memory event for recording
Date:   Fri,  6 Nov 2020 17:48:49 +0800
Message-Id: <20201106094853.21082-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needless to initialize memory events for reporting, this patch
moves memory event initialization for only recording.  Furthermore,
the change allows to parse perf data on cross platforms, e.g. perf
tool can report result properly even the machine doesn't support
the memory events.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-mem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 21ebe0f47e64..72ce4b8fbb0f 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -77,6 +77,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	OPT_END()
 	};
 
+	if (perf_mem_events__init()) {
+		pr_err("failed: memory events not supported\n");
+		return -1;
+	}
+
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
@@ -441,11 +446,6 @@ int cmd_mem(int argc, const char **argv)
 		NULL
 	};
 
-	if (perf_mem_events__init()) {
-		pr_err("failed: memory events not supported\n");
-		return -1;
-	}
-
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-- 
2.17.1

