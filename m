Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0EF2D8D57
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436680AbgLMNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406901AbgLMNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C12C0617A6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id y23so12855088wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CGoUEmn4S4+rJ9SKoosyozQpH1Hp3oE2W5Wn0saZbU=;
        b=hP3R0om6jtfo77P0m5S+OSHW7qxjGdH+6G/VGSJn6O2gLkUBERjApx45tWANRctJcC
         S5ZCUQw8EJ/7iei8M5Ia1m1dqIWnbCnJdswsbpJ5qZpmuCzOXbQc6VqWjGYa8F5S8VON
         WCwxj08R9ny4oVdm0qxiPbiG68yGu89D01fS07vcUe2Flt4zLTw9PIA9U6FVeHaf/BTj
         l3fjVdkjMpKjJfi1WTt3yW7R8QShSTjOjwz/L45wNup5AgLquOfMp8QE4hSqiYaF8UJI
         sS9HDlKlpSD4M3yMzIJ+8EgvN8A76bVTPKtmlivzbhjDPvJvVdptMSS1HxxTC/nnVeKA
         ot2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CGoUEmn4S4+rJ9SKoosyozQpH1Hp3oE2W5Wn0saZbU=;
        b=SnUPgY0lJYxKePk4238nNwoCKN7txd7/YoTGJ3yeTBdWbXT+D/epltjxtFKMrCxrmf
         /sVZR0GfYAAh5qND+ggLsmiuqyAr7fSDhThDydmTNG4TUpm5uM3TyKup5x+zJmhEdJbY
         dtir/Wkx7LCK0gaRkhKmNywpb25QJ32CizUvnSMPltlNDS9V4DIKjUo6mg/ufWQyIfoi
         kQFOjKbe+QKqdffg+8ukTgZqNpw1/24Q1WbOpA5CHKS9uf2hyHOu0+LS2i+QNDkPoYf5
         j/HSoxySrlX4ossnxjoCqPIDx/xlc3TXaIPLzJlX0achMo1kF4lvf6LpmgxyeiVAW3h8
         wrgA==
X-Gm-Message-State: AOAM530Jcbc8DZn/4Kc/ZPgYuGu2wBPi4b91PK6J3NFgRnIbEtbT6iVg
        eIQhjTtJvh2Vn8CLILvcnzIacQ==
X-Google-Smtp-Source: ABdhPJwhq1pFi1b2gcSBKcpCYtvhO7XY2yhMOG9OrQScVIFvJk1mtJXrkEgdwFQkrHjASqt0uKTP3Q==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr23344378wmf.34.1607866748151;
        Sun, 13 Dec 2020 05:39:08 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:07 -0800 (PST)
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
Subject: [PATCH v2 06/11] perf c2c: Refactor display filter macro
Date:   Sun, 13 Dec 2020 13:38:45 +0000
Message-Id: <20201213133850.10070-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
macro FILTER_HITM is to filter out the cache line entries if its
overhead is less than 1%.

This patch is to refactor macro FILTER_HITM.  It uses more gernal name
FILTER_DISPLAY to replace the old name; and refines its parameter,
rather than passing field name for the data structure, it changes to
pass the cache line's statistic value and the sum value, this is more
flexsible, e.g. if consider to extend for sorting on all load hits
which combines multiple fields from structure c2c_stats.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5cd30c083d6c..f11c3c84bb2b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2151,24 +2151,27 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-#define FILTER_HITM(__h)						\
-	if (stats->__h) {						\
-		ld_dist = ((double)c2c_he->stats.__h / stats->__h);	\
+#define FILTER_DISPLAY(val, sum)					\
+{									\
+	if ((sum)) {							\
+		ld_dist = ((double)(val) / (sum));			\
 		if (ld_dist < DISPLAY_LINE_LIMIT)			\
 			he->filtered = HIST_FILTER__C2C;		\
 	} else {							\
 		he->filtered = HIST_FILTER__C2C;			\
-	}
+	}								\
+}
 
 	switch (c2c.display) {
 	case DISPLAY_LCL:
-		FILTER_HITM(lcl_hitm);
+		FILTER_DISPLAY(c2c_he->stats.lcl_hitm, stats->lcl_hitm);
 		break;
 	case DISPLAY_RMT:
-		FILTER_HITM(rmt_hitm);
+		FILTER_DISPLAY(c2c_he->stats.rmt_hitm, stats->rmt_hitm);
 		break;
 	case DISPLAY_TOT:
-		FILTER_HITM(tot_hitm);
+		FILTER_DISPLAY(c2c_he->stats.tot_hitm, stats->tot_hitm);
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

