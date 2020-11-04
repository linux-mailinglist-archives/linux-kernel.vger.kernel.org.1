Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF65B2A60C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgKDJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKDJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:42:57 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 01:42:55 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so16145830pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HvRxG2eqcF4ZzClNGGlcw7JZVv/slfldb08iGS22hzA=;
        b=HHgLz+vkMCoQyO0Hx2pVgQasPa47vZzXKRdUzeqCruDMoTB47BynCJ5/UMM8TAJ6/k
         2SeC5MQEVsxInM6S2SR7OmHaedRof6z61M9kZKjAKO1xRKbWyKIfFkX85EaIjfRWv+v9
         5oB1AEFcnr4q+InKQjkyYlqkMnHuAIAHSX/C4KXOFaUKyWAPVXMllHu+iS5lr2/To9LU
         UDJym21G2Njt26KAIVZaSkAWm2eo3x0CFj+jpe7Cb4GPOe/DhWK4agexjlTFxhvkydNX
         h1Jm/Cc1OTpe3lWv+al8rVwh+NouL6lzRXjF5mVUtOpPVG+jj5rHN2qhlhyiI7yfMxlW
         IjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HvRxG2eqcF4ZzClNGGlcw7JZVv/slfldb08iGS22hzA=;
        b=mjF3kibvvCvWf1V99Azorm6W+gAlMXCCZCZ08sy5RYsweOZe9KmouPuW/MlICGC3iW
         h9plCRcUeqMZ3YESC5ys36uf4u5M2SJVr/LW40qpPk+zkeoL/96iJ3YjenGCrAycRxLc
         nwJZh6VN3dF5fR6CYYWxemEuy005Gd8RspmnGJVZ9nTWfO/ZtyT9wenVwwN8Zl0KKmbD
         I5d336hpfAUqxr2eqljaLb4tXl3N4IxzKaTMTCKHHsS+UsR6n0IoJG+Xx6n6+AIoUSPx
         omYcMgSq9DOK4pSw9RMs58cFBsjUmVXCUhgXo7youOy2SQ03d6KoxdiSKtm6zw7B0yHC
         hJhg==
X-Gm-Message-State: AOAM532r1DS7mCr80md8n7itIjVkB3lAGDZTTposgBqM1XaocE9Tc3fl
        u/NecqX1ey7Nj1iLX0/0MnD15Q==
X-Google-Smtp-Source: ABdhPJyHB429obbDA//p9tMC9jNIf0hiwFPf4UIUDhn/cisjSO9oNyIBdR/jsoRivFcUls9NORJapQ==
X-Received: by 2002:a65:6493:: with SMTP id e19mr20445729pgv.276.1604482975254;
        Wed, 04 Nov 2020 01:42:55 -0800 (PST)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a22sm1830054pfk.29.2020.11.04.01.42.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 01:42:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/2] perf lock: Correct field name "flags"
Date:   Wed,  4 Nov 2020 17:42:28 +0800
Message-Id: <20201104094229.17509-1-leo.yan@linaro.org>
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

Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
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

