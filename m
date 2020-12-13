Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013632D8D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436840AbgLMNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406904AbgLMNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF8C06138C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so13769405wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3PZl3v5letKJ2h+yc7UDgCpdNc6hrV/Unle3u7Kmm4=;
        b=uW4wb4g3xbWMFVPxRoJnCkwVTFieYy588hVy4kssI1wficjVlmx+g60FiZplY3hP9h
         Ht1rP0CjIFMBmF01jBxWZmIFZ15IGB4CKIJOYPemXTfhip/Vo3CA07pj/8X/HobqfqJq
         31ZPRLskDBeHT5hwTpH2Uzl5mqEbC5ICSUNy4YU3C+2q7AUi9k89tyYuOEO7WA0G8bgL
         PEqhOwrB9Io0vYgKZiev6+pNfkP/6XSHR1U/SOG3dmTHB0UFsSX1GbpkohyArs8MyBFA
         3osEmK20uZQ+X7LCZy+eh1Hy0ZrHqknKT9/xI6Ew6ntLYF37hK0dIcOs/YYBDMAsMJvl
         MXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3PZl3v5letKJ2h+yc7UDgCpdNc6hrV/Unle3u7Kmm4=;
        b=HVUFl/+WuvRrM1sx6C5sfN7fzVsh/i/xy62O+baO2/dM0LE/qqJdwAPmAh/kasBtWH
         h1RiSoECBF9aPrfkd6y2Z7i+RhNlg5ckF655ASwNQ8ZYswAr2kYEtn6qDP3uFfvnQieB
         ePmA2g8JPPU2h+B5Rd3PzzhWldCsKvJIrE6OE2J8Bi8KTjjeADG1YBuatCIuEIrOPB0E
         kj32apqSySwwFtWtoU2goScvKjC5ylQouY8h00lGLZeHSNCvUCEU/zGiGHaM+MngyD2C
         fteYFU7r5WEtR+eeoATSpTpJlnYchodgApNOgLCwoIYqMOL09ATuW+6jbGg/llMZt8bk
         IqFQ==
X-Gm-Message-State: AOAM532gM0D0DzUophk8wXABhUvAqPWxih+yA6puVBR03VgPmK7yBO4W
        mQ3IhTvwwie4eBE5EoAzdEYjoA==
X-Google-Smtp-Source: ABdhPJzoVLId6O4O2TyX/23t+TdIg3qJ28Ko4evvH2ZY1p5zNJihlFU5bQ0C9SNP50Oz7oEnHGsAOQ==
X-Received: by 2002:adf:fd42:: with SMTP id h2mr10038786wrs.142.1607866752036;
        Sun, 13 Dec 2020 05:39:12 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:11 -0800 (PST)
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
Subject: [PATCH v2 09/11] perf c2c: Add local variables for output metrics
Date:   Sun, 13 Dec 2020 13:38:48 +0000
Message-Id: <20201213133850.10070-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For different display types, it might use different metrics for
outputting and sorting.  So this patch adds several local variables:

  "cl_output": pointer for outputting single cache line metrics;
  "output_str": pointer for outputting cache line metrics;
  "sort_str": pointer to the sorting metrics.

This is flexsible and the variables can be assigned to different strings
based on the specified display type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 59 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 846ee58d6cfb..9342c30d86ee 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2500,16 +2500,17 @@ static void print_pareto(FILE *out)
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
@@ -3053,6 +3054,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
+	const char *output_str, *sort_str = NULL;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -3129,24 +3131,29 @@ static int perf_c2c__report(int argc, const char **argv)
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
2.17.1

