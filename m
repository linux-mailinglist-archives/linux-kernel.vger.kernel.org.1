Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D521028F53C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgJOOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388978AbgJOOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30754C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so3819206wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8PZ8l02+toML67yEOjEjJY6rkobtS5I360qrBpnXYk=;
        b=WjZWfHGy2uN4GDEA14BOS53WA9WvnFKZpEPnGs3qzsEYEMuVn7O9drEVvDbeuJZBsL
         AQBwL6lrVGaj6NqnhR9Fio7ZYyAkT06bRRgp0CDS4Aez8PJLEgcKRw+dO2+XgOncfBM+
         6VKBIzHKRI5Ln2oUUAlrbgkBX1YDml+oG2MvS3W3IbMiso+OMdSvkJYSVguExDJrpY3l
         0tflGlTpj/PelZ6Qk6HtThzn8cE228Ps/XkXVJEYb3k+YAVA+GZW/CV3jqvUuVOlwJBR
         2Jx45bA2ILKEmrs9/ppqZG5H4NFaUtVWBE8USPhQiX10u4Zhx2WIXWVN8UxolMlhlcxh
         HuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8PZ8l02+toML67yEOjEjJY6rkobtS5I360qrBpnXYk=;
        b=maP84/Sst2KaTeiLxM0GZVlNd6MWD7qgb3NQ2O5+O44q4BC7fGD9U3k8JFEl9CIAu7
         Or1WV02zSuZv4rqmqYqYbPqsD+qbEjwMkhcHOMTkrU6sA8vO7qOxAdkHeSAhRz+GDga3
         wv2sOvBQYGitsH9CVC/ny6Q3Ws9Pi8ecsxHaiz5yyJ/tBSAXEU9b9EfAGbWSuomc4ypc
         +iF1VOqMr/vnWe9V2+oZm2TzlTiFAjYHzKdaxJ7qBr021ZOQ0dWA02z5dG6JTy/YZEAc
         LvWa3KY7Soh/VWF1hz+61F1z/FTHuM9BWiFl5n2Y6BT0GvXFD0CxTmgN/8a/WtSSzUse
         h40A==
X-Gm-Message-State: AOAM533AMj4gaVsAUdA1yrv22ZTDdddRUYZCKhAs2xmglmRn6VriorTE
        j+dAlF71LEV2sNwGPAEQUezaEA==
X-Google-Smtp-Source: ABdhPJwhyhe6zkpOUhxW9Phvud0Pwlld54SvBmJriP6hBJIy6TA3fOFcAEcIUXKCJ88e1j+8SlmbOw==
X-Received: by 2002:a05:6000:1045:: with SMTP id c5mr5093653wrx.296.1602773470797;
        Thu, 15 Oct 2020 07:51:10 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 7/8] perf c2c: Add option '-d llc' for sorting with LLC load
Date:   Thu, 15 Oct 2020 15:50:40 +0100
Message-Id: <20201015145041.10953-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except the existed three display options 'tot', 'rmt', 'lcl', this patch
adds option 'llc' so that can sort on LLC load metrics.  The new
introduced option can work as a choice if the memory event doesn't
contain HITM tags.

For the display with option 'llc', both the "Shared Data Cache Line
Table" and "Shared Cache Line Distribution Pareto" have difference
comparing to other three display options.

For the "Shared Data Cache Line Table", instead of sorting HITM metrics,
it sorts with the LLC hit metrics "tot_llchit".  In this case, users
should be interested in LLC related statistics, so the dimensions of
total LLC hit is used to replace HITM related dimensions.

For Pareto, every single cache line shows the metrics "cl_llc_hit"
instead of "cl_rmt_hitm", and the single cache line view is sorted by
metrics "tot_llchit".

As result, we can get the 'llc' display as follows:

  # perf c2c report -d llc --coalesce tid,pid,iaddr,dso --stdio

  [...]

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------  LLC Hit   LLC Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt      Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x563b01e83100     0    1401   65.32%       648     7011     3738     3273     2582      691      515     2516       59       143      505         0        0         0         0
        1      0x563b01e830c0     0       1   26.51%       263      400      400        0        0        0      130        3        4       262        1         0        0         0         0
        2      0x563b01e83080     0       1    7.76%        77      650      650        0        0        0      180      348       45        14       63         0        0         0         0
        3  0xffff88c3d74e82c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
        4  0xffffa587c11e38c0   N/A       0    0.10%         1        2        1        1        1        0        0        0        0         1        0         0        0         0         0
        5  0xffffffffbd5e6fc0     0       1    0.10%         1        1        1        0        0        0        0        0        0         0        1         0        0         0         0
        6      0x7f90a4d6c2c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        ---- LLC LD ----  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
  #   Num   LclHit  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
  #
    -------------------------------------------------------------
        0      143      505     2582      691      0x563b01e83100
    -------------------------------------------------------------
            96.50%    7.72%   46.79%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c16         0      1949      1331     1876         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
             0.00%   35.05%    0.00%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c1d         0      2651       975      748         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%   30.89%    0.00%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c1d         0      1425      1003      762         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             2.10%    7.52%   49.19%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c16         0      1585      1053     2037         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
             0.00%    0.00%    2.52%   44.86%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c28         0         0         0      375         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    1.51%   55.14%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c28         0         0         0      420         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             1.40%   12.87%    0.00%    0.00%                0x20     0       1    14100    14104:reader_thd      0x563b01c81c73         0       166        99      417         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
             0.00%    5.94%    0.00%    0.00%                0x20     0       1    14100    14105:reader_thd      0x563b01c81c73         0       144        85      376         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 142 ++++++++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d15a6220bfd0..0147c23ff918 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -113,13 +113,15 @@ enum {
 	DISPLAY_LCL,
 	DISPLAY_RMT,
 	DISPLAY_TOT,
+	DISPLAY_LLC,
 	DISPLAY_MAX,
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL] = "Local",
-	[DISPLAY_RMT] = "Remote",
-	[DISPLAY_TOT] = "Total",
+	[DISPLAY_LCL] = "Local HITMs",
+	[DISPLAY_RMT] = "Remote HITMs",
+	[DISPLAY_TOT] = "Total HITMs",
+	[DISPLAY_LLC] = "LLC Access",
 };
 
 static const struct option c2c_options[] = {
@@ -1193,6 +1195,10 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 				break;
 			case DISPLAY_TOT:
 				DISPLAY_ENTRY(tot_hitm);
+				break;
+			case DISPLAY_LLC:
+				DISPLAY_ENTRY(tot_llchit);
+				break;
 			default:
 				break;
 			}
@@ -1533,6 +1539,7 @@ static struct c2c_header percent_hitm_header[] = {
 	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_LLC] = HEADER_BOTH("LLC", "Hit"),
 };
 
 static struct c2c_dimension dim_percent_hitm = {
@@ -2002,6 +2009,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		break;
 	case DISPLAY_TOT:
 		FILTER_ENTRY(tot_hitm);
+		break;
+	case DISPLAY_LLC:
+		FILTER_ENTRY(tot_llchit);
+		break;
 	default:
 		break;
 	}
@@ -2032,6 +2043,9 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	case DISPLAY_TOT:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
+	case DISPLAY_LLC:
+		has_record = !!c2c_he->stats.tot_llchit;
+		break;
 	default:
 		break;
 	}
@@ -2186,17 +2200,20 @@ static int setup_nodes(struct perf_session *session)
 }
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
+#define HAS_LLCHIT(__h) ((__h)->stats.tot_llchit)
 
 static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	if (HAS_HITMS(c2c_he)) {
+	if (c2c.display == DISPLAY_LLC && HAS_LLCHIT(c2c_he)) {
+		c2c.shared_clines++;
+		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
+	} else if (HAS_HITMS(c2c_he)) {
 		c2c.shared_clines++;
 		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
 	}
-
 	return 0;
 }
 
@@ -2315,16 +2332,26 @@ static void print_pareto(FILE *out)
 	struct perf_hpp_list hpp_list;
 	struct rb_node *nd;
 	int ret;
+	const char *cl_output;
+
+	if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
+	    c2c.display == DISPLAY_RMT)
+		cl_output = "cl_num,"
+			    "cl_rmt_hitm,"
+			    "cl_lcl_hitm,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "dcacheline";
+	else /* c2c.display == DISPLAY_LLC */
+		cl_output = "cl_num,"
+			    "cl_llc_hit,"
+			    "cl_lcl_hitm,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "dcacheline";
 
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
@@ -2357,7 +2384,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2514,7 +2541,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
@@ -2720,6 +2747,8 @@ static int setup_display(const char *str)
 		c2c.display = DISPLAY_RMT;
 	else if (!strcmp(display, "lcl"))
 		c2c.display = DISPLAY_LCL;
+	else if (!strcmp(display, "llc"))
+		c2c.display = DISPLAY_LLC;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2766,9 +2795,10 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	}
 
 	if (asprintf(&c2c.cl_output,
-		"%s%s%s%s%s%s%s%s%s%s",
+		"%s%s%s%s%s%s%s%s%s%s%s",
 		c2c.use_stdio ? "cl_num_empty," : "",
-		"percent_rmt_hitm,"
+		c2c.display == DISPLAY_LLC ? "percent_llc_hit," :
+					     "percent_rmt_hitm,",
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
@@ -2798,6 +2828,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 static int setup_coalesce(const char *coalesce, bool no_source)
 {
 	const char *c = coalesce ?: coalesce_default;
+	const char *sort_str;
 
 	if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
 		return -ENOMEM;
@@ -2805,12 +2836,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 	if (build_cl_output(c2c.cl_sort, no_source))
 		return -1;
 
-	if (asprintf(&c2c.cl_resort, "offset,%s",
-		     c2c.display == DISPLAY_TOT ?
-		     "tot_hitm" :
-		     c2c.display == DISPLAY_RMT ?
-		     "rmt_hitm,lcl_hitm" :
-		     "lcl_hitm,rmt_hitm") < 0)
+	if (c2c.display == DISPLAY_TOT)
+		sort_str = "tot_hitm";
+	else if (c2c.display == DISPLAY_RMT)
+		sort_str = "rmt_hitm,lcl_hitm";
+	else if (c2c.display == DISPLAY_LCL)
+		sort_str = "lcl_hitm,rmt_hitm";
+	else if (c2c.display == DISPLAY_LLC)
+		sort_str = "tot_llchit";
+
+	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
 		return -ENOMEM;
 
 	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
@@ -2862,6 +2897,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
+	const char *output_str, *sort_str;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -2936,24 +2972,48 @@ static int perf_c2c__report(int argc, const char **argv)
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
+	if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
+	    c2c.display == DISPLAY_RMT)
+		output_str = "cl_idx,"
+			     "dcacheline,"
+			     "dcacheline_node,"
+			     "dcacheline_count,"
+			     "percent_hitm,"
+			     "tot_hitm,lcl_hitm,rmt_hitm,"
+			     "tot_recs,"
+			     "tot_loads,"
+			     "tot_stores,"
+			     "stores_l1hit,stores_l1miss,"
+			     "ld_fbhit,ld_l1hit,ld_l2hit,"
+			     "ld_lclhit,lcl_hitm,"
+			     "ld_rmthit,rmt_hitm,"
+			     "dram_lcl,dram_rmt";
+	else /* c2c.display == DISPLAY_LLC */
+		output_str = "cl_idx,"
+			     "dcacheline,"
+			     "dcacheline_node,"
+			     "dcacheline_count,"
+			     "percent_llchit,"
+			     "tot_llchit,"
+			     "tot_recs,"
+			     "tot_loads,"
+			     "tot_stores,"
+			     "stores_l1hit,stores_l1miss,"
+			     "ld_fbhit,ld_l1hit,ld_l2hit,"
+			     "ld_lclhit,lcl_hitm,"
+			     "ld_rmthit,rmt_hitm,"
+			     "dram_lcl,dram_rmt";
+
+	if (c2c.display == DISPLAY_TOT)
+		sort_str = "tot_hitm";
+	else if (c2c.display == DISPLAY_RMT)
+		sort_str = "rmt_hitm";
+	else if (c2c.display == DISPLAY_LCL)
+		sort_str = "lcl_hitm";
+	else if (c2c.display == DISPLAY_LLC)
+		sort_str = "tot_llchit";
+
+	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
-- 
2.17.1

