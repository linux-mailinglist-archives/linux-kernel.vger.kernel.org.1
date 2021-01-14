Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F269B2F597E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhANDlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhANDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77EC0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so2218812pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCbfdcDygxVY1a58duhGrDZtXZg7kW86cVj3DuELBH0=;
        b=CFxyjV6/KWR7cVauE2uxI0uGbOmx9MpcHp6twtoYEP5O1IxY3Jz4wr4s6hxms720Ow
         roumYtF0BLOsvkKXQHRPG2eFk6lQ85jo81Ng4gpINIxoi5O/q2oJFip1M7lbFpPyjR+G
         VTAsde+oh4PivEA48/3UChi3+aWSRDiYIx7eoVb5mC4WWf1UQmDsmZ1ou4HzxvsiQKEg
         ruZ13q3z7yidYgX+XrrzYVAxvIn+ZvlfiONwUs3mjaJO/ogdnbmxl55W67uty2jeayp2
         H2dfNQlt3m5QxpX/HAzgjRe3Int8ALDrxPx6+bQ+/9HGXrzi3Jd41bQyKfnGCpuwhuUH
         08HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCbfdcDygxVY1a58duhGrDZtXZg7kW86cVj3DuELBH0=;
        b=h9Tj3mg5hfcu6szT8iXKalS0YkCXDiF+u7e/VpKgOAgi2/+9+0PdYQ1Ukboo4JpYpo
         1tsVqRR0CRtZZ0LOG3LimxtKXuGYy5yKfBl6dqzXM1cbaB4e8OynGul72nY+nTCbmp/p
         GIifaXis59HVRgaYSanixNWyUlZrIMKZg8ooEzWPkc/8Mmh5kDt3qOFa3SGSUaBdJXp6
         w4vLfLdzJLkSosyen2+In4cnSL4lYQQFMJOLSwInRNLYgZZvTI3HZxazXQZYxIckJ5ej
         GWol6Vz0NpNqGcScNrysDWeS7HNcYcnHHA3sOIE5S9BSew8LZEub13peJ9tA33IqXRu+
         JJ2g==
X-Gm-Message-State: AOAM533EKTVH1vxDU9NlLNNdhyTLMJ/LjiK9oFgvSPfN21M64ZfpHkqL
        e3K/iRjQlmX5QRxZie9on0qWsA==
X-Google-Smtp-Source: ABdhPJxHscmwRotQ/E4/TxoYkTVDXLaG+YEoponpgtz8aJvo8ihOHPTc4D2yxR9Li7O6ywoyDaLdOQ==
X-Received: by 2002:a17:902:f688:b029:da:a817:1753 with SMTP id l8-20020a170902f688b02900daa8171753mr5494286plg.76.1610595611826;
        Wed, 13 Jan 2021 19:40:11 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id w63sm3872214pfc.20.2021.01.13.19.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:40:11 -0800 (PST)
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
Subject: [PATCH v3 5/5] perf c2c: Add local variables for output metrics
Date:   Thu, 14 Jan 2021 11:39:39 +0800
Message-Id: <20210114033939.164538-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114033939.164538-1-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
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
index fe811b8e02bb..1c5f0f8f483a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2206,16 +2206,17 @@ static void print_pareto(FILE *out)
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
@@ -2759,6 +2760,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
+	const char *output_str, *sort_str = NULL;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -2835,24 +2837,29 @@ static int perf_c2c__report(int argc, const char **argv)
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

