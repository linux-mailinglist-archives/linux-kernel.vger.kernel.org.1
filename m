Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717362F597D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbhANDkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbhANDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40990C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my11so3283538pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQ8Rkn1xGk5ihqUClBfb+OsbtPVxB29r9PNk924tlkM=;
        b=mupKgqHueUVtmTgMkq/7IqLG8Pc1mL5sKcU0U07D39fk8HexZzpf3mjXNPUfZjLOKF
         2f0QVO9c7uI5KERMYZZEx71AND5w4lZSeMgnzxR52+jEPk9Tk7pPWWsuJuTnlcW3EvJW
         lkQfUQD8G3RJkoXWJp8OqchXPu2vPmxvg5azqKIDWduyBG5LVD7BRVHweOZPB2Z+XkxG
         QKkXCINUNviFYoBKh5HiN6UVhLB8POz/DNovYX9g2SfiIwFayt9EWSzKythYdpKxXkt+
         WNRWYIWhMZloRceEKR1+jeu1UfKEGniQcMiSAuU4sqG+buFvGtrnHxI9SHC5B9sUaPSb
         1GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQ8Rkn1xGk5ihqUClBfb+OsbtPVxB29r9PNk924tlkM=;
        b=IvSqpyXMvvv5VG1PxnmYDkC7FGAg5g4t/jwujwMkWexhfX21FwbDK5+1nb9Cc1R3zT
         5UWIv1nMnuUVniLeRcmkqI8DP7psZ9fwS/zWkAb6CVpzCeupVY04TktcQpyaVqCSR5IB
         5FvqW5sQ/R1lmY+TIkg7tnRlMyhIiPmf6V5rxeJyxE+OwTHiuzZwxW7t+hJAnk1+t3vJ
         omTP+a0oPFBJ2nw3sP9ojvz3/py6N1t00wjxhY+Dx2TQQMTteyLe9OyCiTWwKQAjIOZs
         H+rRtnC0bBvsblvkMPWsjOz8+F2B0mHe0w5JPtZTK6ynSwTBQzkKW3mkxSrzPv3Au6UC
         6sAw==
X-Gm-Message-State: AOAM533eFPv+AIZB/YB9b8lNhsHGHaiv7n8i2k280Xdbl3YsWNmLYPoP
        lOJUJvER9zr5ag0GtTDKEUFRDg==
X-Google-Smtp-Source: ABdhPJwWi+IQ6SK1qThcuo8HrGG+WR1c6fETRUXfX8aSVP7dpTdrQv6D/fjeWGHV6cBnylEXZ5nlqw==
X-Received: by 2002:a17:90a:301:: with SMTP id 1mr2873564pje.86.1610595604828;
        Wed, 13 Jan 2021 19:40:04 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 19sm3788968pfu.85.2021.01.13.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:40:04 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/5] perf c2c: Refactor display filter
Date:   Thu, 14 Jan 2021 11:39:37 +0800
Message-Id: <20210114033939.164538-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114033939.164538-1-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
macro FILTER_HITM is to filter out the cache line entries if its
overhead is less than 1%.

This patch introduces static function filter_display() to replace macro;
and refines its parameter with more flexbile way, rather than passing
field name, it changes to pass the cache line's statistic value and the
sum value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index bc2ee84298ff..de1b804d31be 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1851,40 +1851,47 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 
 #define DISPLAY_LINE_LIMIT  0.001
 
+static u8 filter_display(u32 val, u32 sum)
+{
+	double ld_dist;
+
+	if (sum) {
+		ld_dist = ((double)(val) / (sum));
+		if (ld_dist < DISPLAY_LINE_LIMIT)
+			return HIST_FILTER__C2C;
+	} else {
+		return HIST_FILTER__C2C;
+	}
+
+	return 0;
+}
+
 static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 {
 	struct c2c_hist_entry *c2c_he;
-	double ld_dist;
 
 	if (c2c.show_all)
 		return true;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-#define FILTER_HITM(__h)						\
-	if (stats->__h) {						\
-		ld_dist = ((double)c2c_he->stats.__h / stats->__h);	\
-		if (ld_dist < DISPLAY_LINE_LIMIT)			\
-			he->filtered = HIST_FILTER__C2C;		\
-	} else {							\
-		he->filtered = HIST_FILTER__C2C;			\
-	}
-
 	switch (c2c.display) {
 	case DISPLAY_LCL:
-		FILTER_HITM(lcl_hitm);
+		he->filtered = filter_display(c2c_he->stats.lcl_hitm,
+					      stats->lcl_hitm);
 		break;
 	case DISPLAY_RMT:
-		FILTER_HITM(rmt_hitm);
+		he->filtered = filter_display(c2c_he->stats.rmt_hitm,
+					      stats->rmt_hitm);
 		break;
 	case DISPLAY_TOT:
-		FILTER_HITM(tot_hitm);
+		he->filtered = filter_display(c2c_he->stats.tot_hitm,
+					      stats->tot_hitm);
+		break;
 	default:
 		break;
 	}
 
-#undef FILTER_HITM
-
 	return he->filtered == 0;
 }
 
-- 
2.25.1

