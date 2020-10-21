Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412BA294612
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439687AbgJUAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411013AbgJUAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:40:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE02C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:40:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gv6so230345pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k4pMeAGKBlI1mwZKh2a+pxU+aGlpFdTestRytbkATrA=;
        b=kkCWOWoyuO3NZ5xqAJwF9duYd1KIyvaWh5taMqOoeC3CYM/2bQsIWdLj8qdiFVVKLi
         wz87AqHAJzWq2lfAQxEJRVcSXU2E1yS8ZN9oCgjDEBC/h+4KL84dgIjKBTZzPzPH/k0+
         JL7wXiycb5NLdZsOR5Iy9qMPSq1FYZ5oFXSngyVrs3of6rpfe3+56KgKre1GghVF9lSM
         wCAMcZwVFM4olMjPYQSp2aPVpdndkSDdAjH4cEqe5gP6b7rom0H3iqTtAi2T5R9/Xqar
         79oK1Ab2daVpGqdPCqUNwgV60U/urjNjp7YvDL+9v5oPQSA9y8RZMXDjeU0NdFrGXtNA
         Knlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k4pMeAGKBlI1mwZKh2a+pxU+aGlpFdTestRytbkATrA=;
        b=I492OGRNby5MBzo8D/hf8EE6wYW4Thwb/FCUf73xRRnRBC/TnX6mKqCEc0OlBuPjHk
         XYAZgQ5BgY8lWb+Kjq4zbNA91VS0Rv3MCkE0D9wrRfUVUtZqJSp8ZOrE7IcRasLqlQCM
         M1lboV0AJLw26u09xSatWzBZ0WB0fvU+lntFvwWRo/PpcGhy0KMz3EdHIWDoZ1eFaS78
         R3Oc1hkq/EvI9Il0Avtzdf0P4lbg89hxHWNJjQH5lticwfe/eizpshj+h0emlgqwR6H/
         gK/XkuBnU6MFGgwXcGcd1CwGtG9ABaauhE26baRH3h2ugXXXzr5M6lWStq7mdJ10Fse7
         Xz4Q==
X-Gm-Message-State: AOAM533cKfUNQTbRW77AComlvVpabQY9FLac/lkTiWRJ4vgajDg/O+8D
        OOm3jIRt/H82KPRm/PJquOStT7dd76BbuxHG
X-Google-Smtp-Source: ABdhPJz3bJldEqWg3b6p3JSOh8269stcb4lmtSffB3LhjaJTlmndNdlaElMKgfgJsysBVY3oi5CeHA==
X-Received: by 2002:a17:902:7798:b029:d5:d3b6:2526 with SMTP id o24-20020a1709027798b02900d5d3b62526mr797495pll.2.1603240810863;
        Tue, 20 Oct 2020 17:40:10 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q16sm172228pfu.206.2020.10.20.17.40.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 17:40:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/2] perf lock: Correct field name "flags"
Date:   Wed, 21 Oct 2020 08:39:47 +0800
Message-Id: <20201021003948.28817-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoint "lock:lock_acquire" contains field "flags" but not
"flag".  Current code wrongly retrieves value from field "flag" and it
always gets zero for the value, thus "perf lock" doesn't report the
correct result.

This patch replaces the field name "flag" with "flags", so can read out
the correct flags for locking.

Fixes: 746f16ec6ae3 ("perf lock: Use perf_evsel__intval and perf_session__set_tracepoints_handlers")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index f0a1dbacb46c..5cecc1ad78e1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -406,7 +406,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
-	int flag = evsel__intval(evsel, sample, "flag");
+	int flag = evsel__intval(evsel, sample, "flags");
 
 	memcpy(&addr, &tmp, sizeof(void *));
 
-- 
2.17.1

