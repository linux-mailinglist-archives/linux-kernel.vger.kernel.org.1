Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70C2D8D58
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436807AbgLMNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406907AbgLMNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD2C0617A7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so13726083wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wxFaXccY9/MAWY3aar+5xEJ7Ow3ilb8gqP0VaqmAqc=;
        b=xaAnBxktjYoMq5CL4WKy/jup3cNuL/oUjTdJJ2tY0CeUHF4cF4xqDpJMvSxWc+BBZQ
         9IeBBCY4k2o9H93QOR+w10EPmVRgWqW6noKv1/AQ9bxWxRi7kU0fxRNq8MF49UjjpcTP
         rQdK0iSO3JA5kFPLI5SCfYi4vDJk/6b+k4IaDYKViCGUVFGBWxJo28micDqGfuqLgNt1
         wtBQMoFVc2xrOvsFDjvSY5UligAsM5oSrkJr+J3Wcr6uwMG8fdj/WBP+cMM1JtsfTE8n
         AT5ZNNXSx0+mLydQ9hPd1QDEVZ+tABiaMQcQJOxYw/VchKGCM35zj5OdlieZ1qaSGxfH
         3saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wxFaXccY9/MAWY3aar+5xEJ7Ow3ilb8gqP0VaqmAqc=;
        b=mu7gr0OT5etYLDcK/3NcBMr9FZ4lwV7O2x0EHrCiVMgQ46Jac6a+AnxmWykYmWWxom
         5potQGyJjjYveFkH/+bxorDbIU1XMtROUHBNs/2BkYUZ9cEgVEo/bnWpQ4KnqQ6JiJJl
         ppWYmSxmPI5CmyyICKOyWsAEXBb6CxGfSZgXwVgeHg2NK3ZD2Uxu76WiX3/OZbIEKl8F
         q1wIpFAaG8iElWNsnpxZ+KK0/UqKiJ0fDJ0jZv04lG6Nr3YBXaIDHYYaLx7Eq/FP8z+b
         AbJ7f3PDcd/ri2JWSqzpRd95Qrv0lnqxqtVq2AfRVepDxFqbEUSeZBRJJLp/7xQnYZGn
         R3EA==
X-Gm-Message-State: AOAM5303S6nYG72SR4x9GzifJia3s4euM3n7YuQ0WK+Po2xkyB9/hTAp
        oAaQZgn5KmuuXjjZIUvV291IKA==
X-Google-Smtp-Source: ABdhPJxV9AvZEQ4R2FAE5HhdW1pJeYKN5gcUuNdP2ma8y6JfkyLqOir1JWRnxT8KhvIJR9bel0SNVA==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr23281524wru.8.1607866749418;
        Sun, 13 Dec 2020 05:39:09 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:08 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 07/11] perf c2c: Refactor node display macro
Date:   Sun, 13 Dec 2020 13:38:46 +0000
Message-Id: <20201213133850.10070-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro DISPLAY_HITM() is used to calculate HITM percentage introduced
by every node and it's shown for the node info.

This patch refactors the macro, it is renamed it as DISPLAY_METRICS().
And the parameters is changed for passing the metric's statistic value
and the sum value, this is flexsible for later's extension, e.g. it's
easier to be used for metrics which combines multiple fields from
structure c2c_stats.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f11c3c84bb2b..50018bfb1089 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1324,23 +1324,26 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
 			advance_hpp(hpp, ret);
 
-		#define DISPLAY_HITM(__h)						\
-			if (c2c_he->stats.__h> 0) {					\
+		#define DISPLAY_METRICS(val, sum)					\
+		{									\
+			if ((sum) > 0) {						\
 				ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",	\
-						percent(stats->__h, c2c_he->stats.__h));\
+						percent((val), (sum)));			\
 			} else {							\
 				ret = scnprintf(hpp->buf, hpp->size, "%6s ", "n/a");	\
-			}
+			}								\
+		}
 
 			switch (c2c.display) {
 			case DISPLAY_RMT:
-				DISPLAY_HITM(rmt_hitm);
+				DISPLAY_METRICS(stats->rmt_hitm, c2c_he->stats.rmt_hitm);
 				break;
 			case DISPLAY_LCL:
-				DISPLAY_HITM(lcl_hitm);
+				DISPLAY_METRICS(stats->lcl_hitm, c2c_he->stats.lcl_hitm);
 				break;
 			case DISPLAY_TOT:
-				DISPLAY_HITM(tot_hitm);
+				DISPLAY_METRICS(stats->tot_hitm, c2c_he->stats.tot_hitm);
+				break;
 			default:
 				break;
 			}
-- 
2.17.1

