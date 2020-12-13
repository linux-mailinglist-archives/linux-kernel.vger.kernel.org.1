Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF02D8D56
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbgLMNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406900AbgLMNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC8C06179C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:08 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so11418670wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pa5r5qnrimu2nYWUnupuE4RemzfyUj4NfPsmJ78CoA8=;
        b=SkmmpTlbgbd840FPLzwDWETO40k/02C405pKyEoAQYVt1h6iqtNHlvpJwt+BD0vf5V
         DULSIFEg8nSAj/kebER3oyFScH65sCZfM+9XHbxCX37T3A8G6s8HiNYJUJg7yIpI+BS0
         pRyNcvJDtdXJ1hNr3La/MfG9Qm1ObZOAEIkyVyKUvmfV3xjBGaGPJVX+GyTP6ljZSlkt
         SGNjHt7mi5BkS4gqa+OSga2vTjkBt6zeQhI0NuwmYCTvRQJD4BoRYbdXTq1h19HYj2sx
         ZXtIdCUpCzDH2JGInCDO5bD8phXQcs+wCG+WJdj+NGdySmKs2sgqydi/Ly9VLbBmAWsf
         tEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pa5r5qnrimu2nYWUnupuE4RemzfyUj4NfPsmJ78CoA8=;
        b=ZSgyXpz+j/vvthOfO3e3yDjUGnqMDNYpKcuv7vU/B5qbw0m3Q9UOZ+v1lsiKMKf4Qt
         784/kIObUnSbq6/Wl3okRMN6GXC2RWYiH6EP34BuwDEMc8F6ZVM/taXVTafWZ6VSzG/X
         NkC9fkob0mZeoskKXQT2UPKehL+AeawDmH3+Mh0j+VIiPHRStCG/ZCy0Vkz8eyIt5cYv
         lkEohZ8vAL8d9Klk5J9Zi2onnbcUHLYcwbZWmD5lDmwUe9DFYAppkA8i2q4bcm50fnuJ
         vdEj6diXHUVSa5tdvabXhuCHX1TPb2N9tKiRl4bbMBfgwQKp2OF8G+G5XjtsMbZ0sjSs
         GTCA==
X-Gm-Message-State: AOAM530CTyX8r1SuEdDwvz+bjl9hJHLK0ZXIYtK+Pvn3LOcNpKFuxyx8
        iiPOQ48e35HKgRl+BRSJsXNZi3M9kUctvVO1
X-Google-Smtp-Source: ABdhPJz0bP8KtQvQ1ot+y3UdlAGDz4RUXrtmDvKjiyStH/htZAZu1MBJRYFn3SRkEi3pQTwF0OC9Ug==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr23594207wmd.21.1607866746788;
        Sun, 13 Dec 2020 05:39:06 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:06 -0800 (PST)
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
Subject: [PATCH v2 05/11] perf c2c: Refactor hist entry validation
Date:   Sun, 13 Dec 2020 13:38:44 +0000
Message-Id: <20201213133850.10070-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has no any functionality changes but refactors hist entry
validation for cache line resorting.

It renames function "valid_hitm_or_store()" to "is_valid_hist_entry()",
changes return type from integer type to bool type.  In the function,
it uses switch-case instead of ternary operators, which is easier
to extend for more display types.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 580c4ead68db..5cd30c083d6c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2178,16 +2178,32 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 	return he->filtered == 0;
 }
 
-static inline int valid_hitm_or_store(struct hist_entry *he)
+static inline bool is_valid_hist_entry(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
-	bool has_hitm;
+	bool has_record = false;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	has_hitm = c2c.display == DISPLAY_TOT ? c2c_he->stats.tot_hitm :
-		   c2c.display == DISPLAY_LCL ? c2c_he->stats.lcl_hitm :
-						c2c_he->stats.rmt_hitm;
-	return has_hitm || c2c_he->stats.store;
+
+	/* It's a valid entry if contains stores */
+	if (c2c_he->stats.store)
+		return true;
+
+	switch (c2c.display) {
+	case DISPLAY_LCL:
+		has_record = !!c2c_he->stats.lcl_hitm;
+		break;
+	case DISPLAY_RMT:
+		has_record = !!c2c_he->stats.rmt_hitm;
+		break;
+	case DISPLAY_TOT:
+		has_record = !!c2c_he->stats.tot_hitm;
+		break;
+	default:
+		break;
+	}
+
+	return has_record;
 }
 
 static void set_node_width(struct c2c_hist_entry *c2c_he, int len)
@@ -2241,7 +2257,7 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 	calc_width(c2c_he);
 
-	if (!valid_hitm_or_store(he))
+	if (!is_valid_hist_entry(he))
 		he->filtered = HIST_FILTER__C2C;
 
 	return 0;
-- 
2.17.1

