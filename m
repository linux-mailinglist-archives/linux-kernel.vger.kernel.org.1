Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5352F650F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbhANPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so3574118pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdhacK8709Z2hdoM61gfqGqdyz7ogLRMExonvd42M/I=;
        b=BgLofFa0VcBT0Ja4S0tqMgaouhwaK6HLwbXsVARDC7pOqAh8tdj1kO/qhc9/+xSWac
         vOjkLeoMTy3dlziuK4sQidSgvNtkEECEFgWqf0SGFFEWBYdgej9Qd9OPdtDbFZ9TNW4R
         7nsw1IXDUHuMN+8OMR536pWF/IZM2Eh3KRUBE5RLEKdYNVSRDHcWEuhz8JnfYhyd/7XN
         EBU7k0jT/Pspc0LCxoO3aF7xC63AXl5Eq3AV0ZZzgxi10mibm9QLWpIbrcsY3y2RK1WF
         Sw05Grfp7WVRt5BtEH+4qpM7cIxDS736/v+el1nNQUP/IPFunSgenfkWGs34sb3H15L2
         k8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdhacK8709Z2hdoM61gfqGqdyz7ogLRMExonvd42M/I=;
        b=S8v1t5+X8hlvhKqqXA8dAt3a01mdbPBQeLttF5jvEBv7ET6gUOPASfoKZgLs7I8FqV
         43v3aExHPMkICHzF7+fKeLiI+VhcY0/srKJ3W7MSkBPkDiUQR9IkC0sMVuMFuHzTDV8/
         huBJ4ToOmGxj0NT/ux84CTohVD7OfT1x0pFPO/OJUNYCX1YJTA35oiL/nCi3SyuBfV3X
         y+cSmm+eKd47OOG3hV977Ovv3zXInsBEjkZO6sQo5aP/yyEAlKBUHZGBFxjk8LmGaEkF
         t1bkvE9nSKwyZW8PmCfFMlzOkHYotNXYjbczcnWF9qZuGNYENvxUxJkIRC2AS98EA+f8
         iBcg==
X-Gm-Message-State: AOAM532q13w/iVKVBhRHwLJc8lD0Vrgy3SyJP7yaQqcQHEGrCt5THWQC
        us04eXeR4oKqY8bMiOfmga4eRw==
X-Google-Smtp-Source: ABdhPJzdy/dWO4P8IAHpDG3Rn9vLbwMGi7A1RJqoMdVMHQ2bNqAnhW35wPax7O0qNtRkcR/IG1PIuA==
X-Received: by 2002:a63:551f:: with SMTP id j31mr7900506pgb.432.1610639223459;
        Thu, 14 Jan 2021 07:47:03 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 145sm5387216pfu.8.2021.01.14.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:47:02 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/6] perf c2c: Refactor display filter
Date:   Thu, 14 Jan 2021 23:46:43 +0800
Message-Id: <20210114154646.209024-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
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
 tools/perf/builtin-c2c.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index bc2ee84298ff..7aaccea00883 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1851,40 +1851,40 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 
 #define DISPLAY_LINE_LIMIT  0.001
 
+static u8 filter_display(u32 val, u32 sum)
+{
+	if (sum == 0 || ((double)val / sum) < DISPLAY_LINE_LIMIT)
+		return HIST_FILTER__C2C;
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

