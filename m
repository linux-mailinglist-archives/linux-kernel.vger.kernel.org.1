Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE92F6512
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbhANPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84099C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j13so3411509pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ph7p7H7ascEMj1iLwCzcmRajOUq01qWPszFgXQ+Rwtc=;
        b=c0oTZbRUtueNfF76X49DTev08LkZ41K2A0t1UM7boF3EMfkEyIVUrrP3IOgW91Q5vZ
         KcvtNXtK1h0lbEpb67FRWV6ie14rliZPTgbPd46faO+4t72ttprpVSX9lLsSynkc31Lk
         9UcA89VIflJdjZI2715AoiuzWXAea6IRI7i/bWIA1wTR96un6/bWKtIxrWer+ap7uI/L
         +ovjkpRULr/AwFEm499GNRKujBWaMNcxa4zcM1KATOFwCHKvxISwSjHnfpG2Kf1MwqZN
         iw0p6xbKR30gwixbEm2tA5L4wClxKJilTLpFmLCJVprEy6XTgQfoGys/Tw7+C6S95IN8
         q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph7p7H7ascEMj1iLwCzcmRajOUq01qWPszFgXQ+Rwtc=;
        b=ijRXjTpm5lMDijXGJoZfAlU1a41RwzhUMKbDAgSp5YF9mizLhTxutHaMCYLyCjZSG4
         UdspFCgLHJ2lMKABbsfSW/n/da543h2oI7/qjaShy9daVkYW7JYfMQCN6CqNVgp952Jd
         DfZ6c8lLUi/oGrWWQBeGKg5SAboGRnAhh9r6Wfb1SrwO2vZ4ihEEXJ4Ebrz4lBO7y/dH
         XdBPihWSnoJC2ROpgA1ox276vXVyvkreqIinsBHb+3s4tufnij2+j0JMG6tt20YSr/i0
         FLa0ML63aaI7N1WdaCPpetSI/iMBor+243QXsGsmblOZ+ZY9iLAF/Sriut8rP/P1Agtt
         KXmQ==
X-Gm-Message-State: AOAM531U3xcAB1jxQq1npEoe8qSzhX0BrNIxI2Tp7iV0vwolceHdDqlm
        wPp2OAq1Bi92BhJLFO/p6IVEQw==
X-Google-Smtp-Source: ABdhPJwXMepAI4L21k1BLJvghtnNag2Olyk/cquQ2NJHNf1Q5qr1gQqHMTZMOF6sCLcEWx6cCz6Wcg==
X-Received: by 2002:a17:902:ee14:b029:de:19f0:91b4 with SMTP id z20-20020a170902ee14b02900de19f091b4mr7935952plb.78.1610639235039;
        Thu, 14 Jan 2021 07:47:15 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 9sm5653100pfn.188.2021.01.14.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:47:14 -0800 (PST)
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
Subject: [PATCH v4 6/6] perf c2c: Add local variables for output metrics
Date:   Thu, 14 Jan 2021 23:46:46 +0800
Message-Id: <20210114154646.209024-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds several local variables:

  "cl_output": pointer for outputting single cache line metrics;
  "output_str": pointer for outputting cache line metrics;
  "sort_str": pointer to the sorting metrics.

This can improve readability for the code and it's more flexible when
later extend to different strings for the output metrics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/builtin-c2c.c | 59 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 62213bef7b98..d247f9878948 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2199,16 +2199,17 @@ static void print_pareto(FILE *out)
 	struct perf_hpp_list hpp_list;
 	struct rb_node *nd;
 	int ret;
+	const char *cl_output;
+
+	cl_output = "cl_num,"
+		    "cl_rmt_hitm,"
+		    "cl_lcl_hitm,"
+		    "cl_stores_l1hit,"
+		    "cl_stores_l1miss,"
+		    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
-	ret = hpp_list__parse(&hpp_list,
-				"cl_num,"
-				"cl_rmt_hitm,"
-				"cl_lcl_hitm,"
-				"cl_stores_l1hit,"
-				"cl_stores_l1miss,"
-				"dcacheline",
-				NULL);
+	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
 
 	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
 		return;
@@ -2752,6 +2753,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
+	const char *output_str, *sort_str = NULL;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -2828,24 +2830,29 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	c2c_hists__reinit(&c2c.hists,
-			"cl_idx,"
-			"dcacheline,"
-			"dcacheline_node,"
-			"dcacheline_count,"
-			"percent_hitm,"
-			"tot_hitm,lcl_hitm,rmt_hitm,"
-			"tot_recs,"
-			"tot_loads,"
-			"tot_stores,"
-			"stores_l1hit,stores_l1miss,"
-			"ld_fbhit,ld_l1hit,ld_l2hit,"
-			"ld_lclhit,lcl_hitm,"
-			"ld_rmthit,rmt_hitm,"
-			"dram_lcl,dram_rmt",
-			c2c.display == DISPLAY_TOT ? "tot_hitm" :
-			c2c.display == DISPLAY_LCL ? "lcl_hitm" : "rmt_hitm"
-			);
+	output_str = "cl_idx,"
+		     "dcacheline,"
+		     "dcacheline_node,"
+		     "dcacheline_count,"
+		     "percent_hitm,"
+		     "tot_hitm,lcl_hitm,rmt_hitm,"
+		     "tot_recs,"
+		     "tot_loads,"
+		     "tot_stores,"
+		     "stores_l1hit,stores_l1miss,"
+		     "ld_fbhit,ld_l1hit,ld_l2hit,"
+		     "ld_lclhit,lcl_hitm,"
+		     "ld_rmthit,rmt_hitm,"
+		     "dram_lcl,dram_rmt";
+
+	if (c2c.display == DISPLAY_TOT)
+		sort_str = "tot_hitm";
+	else if (c2c.display == DISPLAY_RMT)
+		sort_str = "rmt_hitm";
+	else if (c2c.display == DISPLAY_LCL)
+		sort_str = "lcl_hitm";
+
+	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
-- 
2.25.1

