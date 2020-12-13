Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2062D8D59
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbgLMNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406912AbgLMNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157CC061282
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id q18so6223182wrn.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqKhFTS4JJQQ1HSUECFm+BHiqJp4QZ9nqH8DUV7Rw+Q=;
        b=FKXsh+EijhZzOJFQw/xuPnUg5LtxL4U37cUOcCC3lBt1eq/Yurqt/9j6440TDEi6fH
         jNxzmnAy+yMrEseax8njoOmP4+PslR5p94p6f296xPVdUO4iGQ0Vi8tORjO51QnFXKAd
         4vCHz7zlwNJLYgWRaYxJJOtR8ymoUAnHlqL7KnsNsrc2u84D+UAG4yuuiWTXmKat4IMY
         qu5UgDlG1M8YdqfXV9i6BvOVXJUCavLLdB/zuc7fxX0bZL7NAc4Ovq9p7/wkqz/wVpnA
         AKfJuXG/TpWKesZLixyPsLdZFvvmczrqmq78/r6rUd7GN5Z1RMSP+o9DSwIsfzg2AYmc
         dFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fqKhFTS4JJQQ1HSUECFm+BHiqJp4QZ9nqH8DUV7Rw+Q=;
        b=Xb4OTscGIgJRSMXWz3FxDTbKfTmbQ7uOxUOliTC6r3I7cjouprc4pPfWF1RMudVRwQ
         RyB5p5TYw0BsN+FRhXe3x1CyIZJkXE7fc6DN9D8DpT5+QcUncQt7CI/J07AUA2Vq5DAR
         PKQcqti9w1YFpXRI27Zwt706q81lduWU9xeIfxzrgVe63vO3h4g+48TK5NqnBOyeprc3
         MCsJ1jpWRVvdW2WHWmKYkAXtLmRGgxZ4zhW4Y5Kmi5hCeT01sZEzrK2GmOOPYemIlB+O
         8W8lwqs0nyc18SfneFeU2yUSaQAwsGt3UGkKNUlu09YHOKUAUO9l+8fhyb2SJX3aVco0
         4CcA==
X-Gm-Message-State: AOAM533w5A2eGQbadkmunBLVHxWo7O/w7sqYT794YtwLi4BbT+Np5cTu
        F6W22yxheriaEXg1nn4MezBAvg==
X-Google-Smtp-Source: ABdhPJx0ZcUD/qeb+PujOIoFRGQ2s8i6Tl+iDQUv6qSgm5crTjyAueuvjYnQ4f9Qc53PlM2ntE+8AA==
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr24688696wrg.159.1607866753453;
        Sun, 13 Dec 2020 05:39:13 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:12 -0800 (PST)
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
Subject: [PATCH v2 10/11] perf c2c: Sort on all cache hit for load operations
Date:   Sun, 13 Dec 2020 13:38:49 +0000
Message-Id: <20201213133850.10070-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except the existed three display options 'tot', 'rmt', 'lcl', this patch
adds option 'all' so can sort on the all cache hit for load operation.
This new introduced option can be a choice for profiling cache false
sharing if the memory event doesn't contain HITM tags.

For displaying with option 'all', the "Shared Data Cache Line Table" and
"Shared Cache Line Distribution Pareto" both have difference comparing
to other three display options.

For the "Shared Data Cache Line Table", instead of sorting HITM metrics,
it sorts with the metrics "tot_ld_hit" and "percent_tot_ld_hit".  If
without HITM metrics, users can analyze the load hit statistics for all
cache levels, so the dimensions of total load hit is used to replace
HITM dimensions.

For Pareto, every single cache line shows the metrics "cl_tot_ld_hit"
and "cl_tot_ld_miss" instead of "cl_rmt_hitm" and "percent_lcl_hitm",
and the single cache line view is sorted by metrics "tot_ld_hit".

As result, we can get the 'all' display as follows:

  # perf c2c report -d all --coalesce tid,pid,iaddr,dso --stdio

  [...]

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------  Load Hit  Load Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt       Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  ........  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x556f25dff100     0    1895    75.73%      4591     7840     4591     3249     2633      616      849     2734       67        58      883         0        0         0         0
        1      0x556f25dff080     0       1    13.10%       794      794      794        0        0        0      164      486       28        20       96         0        0         0         0
        2      0x556f25dff0c0     0       1    10.01%       607      607      607        0        0        0      107        5        5       488        2         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        --  Load Refs --  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
  #   Num      Hit     Miss   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
  #
    -------------------------------------------------------------
        0     4591        0     2633      616      0x556f25dff100
    -------------------------------------------------------------
            20.52%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc1d         0      2200      1276      942         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
            19.82%    0.00%   38.06%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc16         0      2190      1130     1912         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
            18.25%    0.00%   56.63%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc16         0      2173      1074     2329         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
            18.23%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc1d         0      2013      1220      837         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    3.11%   59.90%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc28         0         0         0      451         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    2.20%   40.10%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc28         0         0         0      305         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
            12.00%    0.00%    0.00%    0.00%                0x20     0       1    28079    28083:reader_thd      0x556f25bfdc73         0       159       107      551         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
            11.17%    0.00%    0.00%    0.00%                0x20     0       1    28079    28084:reader_thd      0x556f25bfdc73         0       148       108      513         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 139 ++++++++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9342c30d86ee..0df4a4a30f7a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -113,13 +113,15 @@ enum {
 	DISPLAY_LCL,
 	DISPLAY_RMT,
 	DISPLAY_TOT,
+	DISPLAY_ALL,
 	DISPLAY_MAX,
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL] = "Local",
-	[DISPLAY_RMT] = "Remote",
-	[DISPLAY_TOT] = "Total",
+	[DISPLAY_LCL] = "Local HITMs",
+	[DISPLAY_RMT] = "Remote HITMs",
+	[DISPLAY_TOT] = "Total HITMs",
+	[DISPLAY_ALL] = "All Load Access",
 };
 
 static const struct option c2c_options[] = {
@@ -883,6 +885,11 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 	case DISPLAY_TOT:
 		st  = stats->tot_hitm;
 		tot = total->tot_hitm;
+		break;
+	case DISPLAY_ALL:
+		ui__warning("Calculate hitm percent for display 'all';\n"
+			    "should never happen!\n");
+		break;
 	default:
 		break;
 	}
@@ -1344,6 +1351,10 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			case DISPLAY_TOT:
 				DISPLAY_METRICS(stats->tot_hitm, c2c_he->stats.tot_hitm);
 				break;
+			case DISPLAY_ALL:
+				DISPLAY_METRICS(TOT_LD_HIT(stats),
+						TOT_LD_HIT(&c2c_he->stats));
+				break;
 			default:
 				break;
 			}
@@ -1692,6 +1703,7 @@ static struct c2c_header percent_hitm_header[] = {
 	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_ALL] = HEADER_BOTH("LLC", "Hit"),
 };
 
 static struct c2c_dimension dim_percent_hitm = {
@@ -2169,6 +2181,9 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 	case DISPLAY_TOT:
 		FILTER_DISPLAY(c2c_he->stats.tot_hitm, stats->tot_hitm);
 		break;
+	case DISPLAY_ALL:
+		FILTER_DISPLAY(TOT_LD_HIT(&c2c_he->stats), TOT_LD_HIT(stats));
+		break;
 	default:
 		break;
 	}
@@ -2199,6 +2214,9 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	case DISPLAY_TOT:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
+	case DISPLAY_ALL:
+		has_record = !!TOT_LD_HIT(&c2c_he->stats);
+		break;
 	default:
 		break;
 	}
@@ -2288,7 +2306,10 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 }
 
 static struct c2c_header header_node_0 = HEADER_LOW("Node");
-static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_hitms_stores =
+		HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_loads_stores =
+		HEADER_LOW("Node{cpus %loads %stores}");
 static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
 
 static void setup_nodes_header(void)
@@ -2298,7 +2319,10 @@ static void setup_nodes_header(void)
 		dim_node.header = header_node_0;
 		break;
 	case 1:
-		dim_node.header = header_node_1;
+		if (c2c.display == DISPLAY_ALL)
+			dim_node.header = header_node_1_loads_stores;
+		else
+			dim_node.header = header_node_1_hitms_stores;
 		break;
 	case 2:
 		dim_node.header = header_node_2;
@@ -2377,11 +2401,13 @@ static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	if (HAS_HITMS(c2c_he)) {
+	if (c2c.display == DISPLAY_ALL && TOT_LD_HIT(&c2c_he->stats)) {
+		c2c.shared_clines++;
+		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
+	} else if (HAS_HITMS(c2c_he)) {
 		c2c.shared_clines++;
 		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
 	}
-
 	return 0;
 }
 
@@ -2502,12 +2528,21 @@ static void print_pareto(FILE *out)
 	int ret;
 	const char *cl_output;
 
-	cl_output = "cl_num,"
-		    "cl_rmt_hitm,"
-		    "cl_lcl_hitm,"
-		    "cl_stores_l1hit,"
-		    "cl_stores_l1miss,"
-		    "dcacheline";
+	if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
+	    c2c.display == DISPLAY_RMT)
+		cl_output = "cl_num,"
+			    "cl_rmt_hitm,"
+			    "cl_lcl_hitm,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "dcacheline";
+	else /* c2c.display == DISPLAY_ALL */
+		cl_output = "cl_num,"
+			    "cl_tot_ld_hit,"
+			    "cl_tot_ld_miss,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
 	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
@@ -2543,7 +2578,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2700,7 +2735,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
@@ -2906,6 +2941,8 @@ static int setup_display(const char *str)
 		c2c.display = DISPLAY_RMT;
 	else if (!strcmp(display, "lcl"))
 		c2c.display = DISPLAY_LCL;
+	else if (!strcmp(display, "all"))
+		c2c.display = DISPLAY_ALL;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2952,10 +2989,12 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	}
 
 	if (asprintf(&c2c.cl_output,
-		"%s%s%s%s%s%s%s%s%s%s",
+		"%s%s%s%s%s%s%s%s%s%s%s",
 		c2c.use_stdio ? "cl_num_empty," : "",
-		"percent_rmt_hitm,"
-		"percent_lcl_hitm,"
+		c2c.display == DISPLAY_ALL ? "percent_ld_hit,"
+					     "percent_ld_miss," :
+					     "percent_rmt_hitm,"
+					     "percent_lcl_hitm,",
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
 		"offset,offset_node,dcacheline_count,",
@@ -2984,6 +3023,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 static int setup_coalesce(const char *coalesce, bool no_source)
 {
 	const char *c = coalesce ?: coalesce_default;
+	const char *sort_str = NULL;
 
 	if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
 		return -ENOMEM;
@@ -2991,12 +3031,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
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
+	else if (c2c.display == DISPLAY_ALL)
+		sort_str = "tot_ld_hit";
+
+	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
 		return -ENOMEM;
 
 	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
@@ -3131,20 +3175,37 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	output_str = "cl_idx,"
-		     "dcacheline,"
-		     "dcacheline_node,"
-		     "dcacheline_count,"
-		     "percent_hitm,"
-		     "tot_hitm,lcl_hitm,rmt_hitm,"
-		     "tot_recs,"
-		     "tot_loads,"
-		     "tot_stores,"
-		     "stores_l1hit,stores_l1miss,"
-		     "ld_fbhit,ld_l1hit,ld_l2hit,"
-		     "ld_lclhit,lcl_hitm,"
-		     "ld_rmthit,rmt_hitm,"
-		     "dram_lcl,dram_rmt";
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
+	else /* c2c.display == DISPLAY_ALL */
+		output_str = "cl_idx,"
+			     "dcacheline,"
+			     "dcacheline_node,"
+			     "dcacheline_count,"
+			     "percent_tot_ld_hit,"
+			     "tot_ld_hit,"
+			     "tot_recs,"
+			     "tot_loads,"
+			     "tot_stores,"
+			     "stores_l1hit,stores_l1miss,"
+			     "ld_fbhit,ld_l1hit,ld_l2hit,"
+			     "ld_lclhit,lcl_hitm,"
+			     "ld_rmthit,rmt_hitm,"
+			     "dram_lcl,dram_rmt";
 
 	if (c2c.display == DISPLAY_TOT)
 		sort_str = "tot_hitm";
@@ -3152,6 +3213,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		sort_str = "rmt_hitm";
 	else if (c2c.display == DISPLAY_LCL)
 		sort_str = "lcl_hitm";
+	else if (c2c.display == DISPLAY_ALL)
+		sort_str = "tot_ld_hit";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
-- 
2.17.1

