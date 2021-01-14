Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740982F597F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbhANDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbhANDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9804C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t6so2244377plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lF0Ed3o9Cco45AdJyImBJeivw9RcTPo65rwmacryi30=;
        b=Wxw9/BymNaG1auLeKAdRia3kGg20mUhMXDaAyIRUiariIpsvdq0LbYQHeLjdKxnLqm
         DW/WvvLzMjapwe4IoaJXChu4b4yAleJnPUegjH0P1eToft/tNEGCHS0g+LWytQEBOE3C
         kLB+OQOJ6/1CGy+fzD7DEysp1Zv/n4nn4DUf/xMIMlX+EC42ydSoFBKk5uvNVO6Pp9WR
         ryyOODTd0Gapr3hf+g67tj9uFPl0CKlGmzfy9iQid8WyoBwl5Q4brkgzYKB2rNX59IeL
         4eezbBYFisWCSUlIhMgEFu5G5+Ol3IKFkhorpgaLqi7pcfAJvajGyhF+FZnJbdDhCg+h
         ROEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lF0Ed3o9Cco45AdJyImBJeivw9RcTPo65rwmacryi30=;
        b=N/MvC8yL82hg0VQkv8F5nxpCygOdmwlU6BquqGcWj9exOgD2CDrOMFgawBGePrYXK8
         tIxS8euas0QCIbWN61i9k64v/iO+rAO7xOwwM8J+atzbQhI1xI17MROdTQHoRRnmQ7sa
         lGKVk+qw2PkSipk0kR9Bjc2CWtaP1zvB9/aHvKbpfWQ8H4RHRtMThThCCrGp1h1MZU8q
         7BMhGZLgRi7cJFMoMqGoLTbKA73/wtJkZTZ6GPI0G8CHJQGauIn1RdbwXrK6L4tWoqw4
         JjDPk/lxCXt9pwFzAIG5dN5IgJ/Y1OHZQ0kDYb7XVzC/YIuW7SgkrDW209o7U71usIfk
         MJxg==
X-Gm-Message-State: AOAM532laI2RgC6hOviZeGlQfW116JmWQ20KcE2eM5hGNEEz66Qfudz/
        Xy5RUJbCjcErnjqNlRzc0iMGpw==
X-Google-Smtp-Source: ABdhPJymynQNVh3F5q1CyLiOaUV4I/MpvFODTupt9Yun8f/hmt/AaKlnK5BiiUmgSskLn0qmFc2jHA==
X-Received: by 2002:a17:902:d4d1:b029:de:30a4:360f with SMTP id o17-20020a170902d4d1b02900de30a4360fmr5512389plg.83.1610595608370;
        Wed, 13 Jan 2021 19:40:08 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id n1sm3804415pfu.28.2021.01.13.19.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:40:07 -0800 (PST)
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
Subject: [PATCH v3 4/5] perf c2c: Refactor node display
Date:   Thu, 14 Jan 2021 11:39:38 +0800
Message-Id: <20210114033939.164538-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114033939.164538-1-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
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
index de1b804d31be..fe811b8e02bb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1048,6 +1048,19 @@ empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return 0;
 }
 
+static int display_metrics(struct perf_hpp *hpp, u32 val, u32 sum)
+{
+	int ret;
+
+	if ((sum) > 0)
+		ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",
+				percent((val), (sum)));
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

