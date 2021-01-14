Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DEE2F6511
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbhANPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:52 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABCC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:11 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 11so3579934pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xwxr1WKWTfmYSEYbuSnwlDnUH9AgI0vctMlc/yRg2ZQ=;
        b=zDix6IKY2Mbox5yA90OmfOVTR331W0j7TnseKnGqkCrhAD/+kBoEyT5qx/8UGWXWcj
         8RQKN/yWiR3535L0MijiVy5EtveOb59KwuycWDND3umalG4f/6gohymhgV5cOkk9Yttz
         liVVFlV+q7Yllz0KHGB67tf8k/0qCpY5IT+S0vDT1fqL1QvdrJkmSR7PvEmYwqQhZJ5Q
         ybD7PqEPrOwjA0zQLa39rljaE51tbRuOMBK/2KVCez0kByALOrwYRZt9cHc6UPUEDDJy
         vs7TbJ95PbG9B1dMHoIjkNW4EIl65G+3SlpOTz0GuLxvsAWPaVsTF8quzxOFuVAq5Lnx
         Nzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xwxr1WKWTfmYSEYbuSnwlDnUH9AgI0vctMlc/yRg2ZQ=;
        b=DsqNkkMLcYLtPH545BMNfQ31MTcb376OskfyJko32g0v+ZVL9h4631a/RMnkuH+ZHD
         6AS5wvYuhc/5T5wfL0eq5qqsmsC6B1COf85xAdWCKOT3jXoUA0giQvYY6zgMxar0YNLd
         j6tLGswwNCYDZhVjYDhD2dszq8hr489LehfcZZOz/kZVq/l4CSImw8fhXkHitRLpmcz3
         mxeIsoVrjzsTZMVJCtkdNfWIVDVKi1ndsvJkJmTXTBHuzAjIBaOMujqyhk17zQj+0e76
         AYFsMcYOMYoO8WOL3COVaatxMS9BGO90IvlhYI6F8yVX/J7oYxh7kQGen0LvJuudZKdd
         cZNA==
X-Gm-Message-State: AOAM533soAbykW1R/Ot9iv6owm+bKLjh7ysrUs+yRLdRTcTziSLk5mCu
        BPuo0fYqJWRl5EdEQzwHwerxKA==
X-Google-Smtp-Source: ABdhPJwrJskkWzD3s5oW4+Ep7AdaPTjn+U51ybSiXtpgqdB0aOuxZJaXL6mmlJj4+u2oViDEn39iBg==
X-Received: by 2002:a62:4e95:0:b029:1a3:a372:8b3c with SMTP id c143-20020a624e950000b02901a3a3728b3cmr7996419pfb.28.1610639231348;
        Thu, 14 Jan 2021 07:47:11 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id l8sm5709662pjt.32.2021.01.14.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:47:10 -0800 (PST)
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
Subject: [PATCH v4 5/6] perf c2c: Refactor node display
Date:   Thu, 14 Jan 2021 23:46:45 +0800
Message-Id: <20210114154646.209024-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro DISPLAY_HITM() is used to calculate HITM percentage introduced
by every node and it's shown for the node info.

This patch introduces the static function display_metrics() to replace
the macro, and the parameters are refined for passing the metric's
statistic value and the sum value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 7702f9599162..62213bef7b98 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1048,6 +1048,19 @@ empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return 0;
 }
 
+static int display_metrics(struct perf_hpp *hpp, u32 val, u32 sum)
+{
+	int ret;
+
+	if (sum != 0)
+		ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",
+				percent(val, sum));
+	else
+		ret = scnprintf(hpp->buf, hpp->size, "%6s ", "n/a");
+
+	return ret;
+}
+
 static int
 node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 	   struct hist_entry *he)
@@ -1091,29 +1104,23 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
 			advance_hpp(hpp, ret);
 
-		#define DISPLAY_HITM(__h)						\
-			if (c2c_he->stats.__h> 0) {					\
-				ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",	\
-						percent(stats->__h, c2c_he->stats.__h));\
-			} else {							\
-				ret = scnprintf(hpp->buf, hpp->size, "%6s ", "n/a");	\
-			}
-
 			switch (c2c.display) {
 			case DISPLAY_RMT:
-				DISPLAY_HITM(rmt_hitm);
+				ret = display_metrics(hpp, stats->rmt_hitm,
+						      c2c_he->stats.rmt_hitm);
 				break;
 			case DISPLAY_LCL:
-				DISPLAY_HITM(lcl_hitm);
+				ret = display_metrics(hpp, stats->lcl_hitm,
+						      c2c_he->stats.lcl_hitm);
 				break;
 			case DISPLAY_TOT:
-				DISPLAY_HITM(tot_hitm);
+				ret = display_metrics(hpp, stats->tot_hitm,
+						      c2c_he->stats.tot_hitm);
+				break;
 			default:
 				break;
 			}
 
-		#undef DISPLAY_HITM
-
 			advance_hpp(hpp, ret);
 
 			if (c2c_he->stats.store > 0) {
-- 
2.25.1

