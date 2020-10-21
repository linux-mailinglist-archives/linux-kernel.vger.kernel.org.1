Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94F4294601
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439644AbgJUA0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439616AbgJUA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:26:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CCC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:26:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so424339pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k4pMeAGKBlI1mwZKh2a+pxU+aGlpFdTestRytbkATrA=;
        b=npJ0H8RM+KYUc68JI7A/bPtSbAAuwMxN0OdDNyWCtTk/9A261VYAweT7W+LtQp1zNw
         G4DsSBEvIvc1wz2Nv+Yab+cQpiq+FpfpevLUxuS9IJP5FK33pGl9Rn2fuBzobn/EZt95
         Hp2gvcU5MLNA3OtFG6akSd5S3Dfhu1/xUPNs9k8xtUVLf3+vMixWELyhsPor5qpoMplL
         kWTMWCq7wrFSi0ZfSBotsHh8k47BLGaKAI4bQFdeNRQKtP1+vzui3C/xKEYjgMdwgiSs
         mxWcTQPHZNLIOpG3z7xUAO7NKkF22vEhGlVoE9BwgCLQcEKvhRI9JCXUnSkZg9fb9OkA
         pGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k4pMeAGKBlI1mwZKh2a+pxU+aGlpFdTestRytbkATrA=;
        b=Su5DCtaGqK9hN1aBwsfW1Rf5rBjntQY+y43Fr5iXTmcLEAWqKmxKQ85LJj3vgdX2Ua
         qNPPZw2gTLCVrzeN8PcwpVRgPL1vLoaaU42hD/w+1js/8kSKZOmkKOvT34u0B4lpZqQq
         oIi+Bt602gyOgjX/PkHuK7MDscQgiWwipAFCdxkPVeH1Gi43YMej3H/0eaBQ4g3iXWxK
         yXCuW3HmJJQqGHdehus/aDMY7hAZRuVJni5qZ6A8+Miqygh6ke25m1pkPr15b5drzqzX
         VTez4s6buwbMSW6l1zzOcjO+ERbW+XrcnyobqKZMcTgT6cDZ/OKeBffLhyQwwzYlfIhr
         2pNw==
X-Gm-Message-State: AOAM531I1mizpA+Po9Ckr/y/OzgbUER4g+fdIc1PB3UQesmEm4xAo7Bv
        7TaWwV63MayQBhStGTYyUfoddQ==
X-Google-Smtp-Source: ABdhPJwAjM8bbdgxHvC+8LkrYkeSDkybM7SufwhtUi0jP0I14yCnrhU0zqv/YAsi0A22U07fBIEpDQ==
X-Received: by 2002:a05:6a00:1693:b029:155:abe5:caa2 with SMTP id k19-20020a056a001693b0290155abe5caa2mr596219pfc.39.1603239995294;
        Tue, 20 Oct 2020 17:26:35 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r6sm180241pfg.85.2020.10.20.17.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 17:26:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] perf lock: Correct field name "flags"
Date:   Wed, 21 Oct 2020 08:26:18 +0800
Message-Id: <20201021002619.28072-1-leo.yan@linaro.org>
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

