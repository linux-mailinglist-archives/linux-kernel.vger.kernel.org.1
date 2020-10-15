Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5A28F51A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbgJOOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389126AbgJOOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D84C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so3969439wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WAsJx74CY2IPmcGDLOrvkaDfBMxQHx6n0sH5cK54PZU=;
        b=yhtqP8yejRGVlmdCjomKcoI/3ZYiIxn4Q6bGHAX4S+GDCiecmHPgtR8rEc/IxKLrOq
         +0cfV/oBvZi+gSomo/qsv0IxrLF0jjVwsrJshq3bJRcxZruPhDuwf9CAwvR2UujBfBSE
         Ng4+XLLmYYwI4Sw5GYyLvBIdsqwoAZQcPajLLlpq+SBj4GLePZibN+Y1dOB4qvy1NqKO
         SYzlB7JP5py+0RJKGbf+ku0l/OI2EdN+xThTSnycSZpisN2naUB4BKUo4QozZtlmZ8bA
         F3/f0F4qMiR0jzzVc+oD8zlIISmshnPzDuAK606Q021Xd6UUU7ztvHeK8bCOOCqhJCwP
         qqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WAsJx74CY2IPmcGDLOrvkaDfBMxQHx6n0sH5cK54PZU=;
        b=l+HRKRXKLr8uFSQOx3wg34BK2PRWVmhekfUQ986BQ6d1i8RL5l4ZwV4tb9/3FH48Fa
         rqYClYkES/CyaBoBr1UrnoD8e41IZaXasFzohz59J7ZL3QdddRAOIJ8KAK/kVGPmPIw7
         AxrLwpc7bXV6S7zzpo1U0qkeqkXmNq8IimcIBmQZ1fmj4OLKjSJnrgvvNuRAerpRFbuq
         qV3NQRrfsYKXgnZN9HN4835Z/k4Zr2I0FlmfY525d3V9w5SBf5TI2xF6bnJCG4FLUGQB
         Pz1hGEQPM8Rvq29hYCRBq83/sWYHtCsm2giTRSHg3Qj1AIkWvhTxr3N0haXV9A4j5o0h
         1gtw==
X-Gm-Message-State: AOAM530Z+oZLsUiomIyCZpQpaJfzC0+rBa4DZUcWVhiHx8qruAWHqbCM
        sT9bv0Xt4XrPHpH3cGsh7gKHcQ==
X-Google-Smtp-Source: ABdhPJzZ1QOthLsVGj9/NJbUJ0I6cvGzjoN2FDjfHLN51PHuxdLEDvi3O61y0OgNUiFCcVdZpH/10A==
X-Received: by 2002:a1c:e283:: with SMTP id z125mr4706481wmg.154.1602773180120;
        Thu, 15 Oct 2020 07:46:20 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 8/9] perf c2c: Add metrics "RMT Load Hit"
Date:   Thu, 15 Oct 2020 15:45:47 +0100
Message-Id: <20201015144548.18482-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metrics "LLC Ld Miss" and "Load Dram" overlap with each other for
accouting items:

  "LLC Ld Miss" = "lcl_dram" + "rmt_dram" + "rmt_hit" + "rmt_hitm"
  "Load Dram"   = "lcl_dram" + "rmt_dram"

Furthermore, the metrics "LLC Ld Miss" is not directive to show
statistics due to it contains summary value and cannot give out
breakdown details.

For this reason, add a new metrics "RMT Load Hit" which is used to
present the remote cache hit; it contains two items:

  "RMT Load Hit" = remote hit ("rmt_hit") + remote hitm ("rmt_hitm")

As result, the metrics "LLC Ld Miss" is perfectly divided into two
metrics "RMT Load Hit" and "Load Dram".  It's not necessary to keep
metrics "LLC Ld Miss", so remove it.

Before:

  #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --      LLC  --- Load Dram ----
  # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm  Ld Miss       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  .......  ........  ........
  #
        0      0x55f07d580100     0    1499   85.89%      481      481        0     7243     3879     3364     2599      765      548     2615       66       169      481        0         0         0
        1      0x55f07d580080     0       1   13.93%       78       78        0      664      664        0        0        0      187      361       27        11       78        0         0         0
        2      0x55f07d5800c0     0       1    0.18%        1        1        0      405      405        0        0        0      131        0       10       263        1        0         0         0

After:

  #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x55f07d580100     0    1499   85.89%      481      481        0     7243     3879     3364     2599      765      548     2615       66       169      481         0        0         0         0
        1      0x55f07d580080     0       1   13.93%       78       78        0      664      664        0        0        0      187      361       27        11       78         0        0         0         0
        2      0x55f07d5800c0     0       1    0.18%        1        1        0      405      405        0        0        0      131        0       10       263        1         0        0         0         0

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 52 ++--------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 61fb939a4e70..9c2183957c50 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -652,45 +652,6 @@ STAT_FN(ld_l2hit)
 STAT_FN(ld_llchit)
 STAT_FN(rmt_hit)
 
-static uint64_t llc_miss(struct c2c_stats *stats)
-{
-	uint64_t llcmiss;
-
-	llcmiss = stats->lcl_dram +
-		  stats->rmt_dram +
-		  stats->rmt_hitm +
-		  stats->rmt_hit;
-
-	return llcmiss;
-}
-
-static int
-ld_llcmiss_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		 struct hist_entry *he)
-{
-	struct c2c_hist_entry *c2c_he;
-	int width = c2c_width(fmt, hpp, he->hists);
-
-	c2c_he = container_of(he, struct c2c_hist_entry, he);
-
-	return scnprintf(hpp->buf, hpp->size, "%*lu", width,
-			 llc_miss(&c2c_he->stats));
-}
-
-static int64_t
-ld_llcmiss_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-	       struct hist_entry *left, struct hist_entry *right)
-{
-	struct c2c_hist_entry *c2c_left;
-	struct c2c_hist_entry *c2c_right;
-
-	c2c_left  = container_of(left, struct c2c_hist_entry, he);
-	c2c_right = container_of(right, struct c2c_hist_entry, he);
-
-	return (uint64_t) llc_miss(&c2c_left->stats) -
-	       (uint64_t) llc_miss(&c2c_right->stats);
-}
-
 static uint64_t total_records(struct c2c_stats *stats)
 {
 	uint64_t lclmiss, ldcnt, total;
@@ -1440,21 +1401,13 @@ static struct c2c_dimension dim_ld_llchit = {
 };
 
 static struct c2c_dimension dim_ld_rmthit = {
-	.header		= HEADER_SPAN_LOW("Rmt"),
+	.header		= HEADER_SPAN("- RMT Load Hit --", "RmtHit", 1),
 	.name		= "ld_rmthit",
 	.cmp		= rmt_hit_cmp,
 	.entry		= rmt_hit_entry,
 	.width		= 8,
 };
 
-static struct c2c_dimension dim_ld_llcmiss = {
-	.header		= HEADER_BOTH("LLC", "Ld Miss"),
-	.name		= "ld_llcmiss",
-	.cmp		= ld_llcmiss_cmp,
-	.entry		= ld_llcmiss_entry,
-	.width		= 7,
-};
-
 static struct c2c_dimension dim_tot_recs = {
 	.header		= HEADER_BOTH("Total", "records"),
 	.name		= "tot_recs",
@@ -1658,7 +1611,6 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_l2hit,
 	&dim_ld_llchit,
 	&dim_ld_rmthit,
-	&dim_ld_llcmiss,
 	&dim_tot_recs,
 	&dim_tot_loads,
 	&dim_percent_hitm,
@@ -2854,7 +2806,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			"stores_l1hit,stores_l1miss,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
 			"ld_lclhit,lcl_hitm,"
-			"ld_llcmiss,"
+			"ld_rmthit,rmt_hitm,"
 			"dram_lcl,dram_rmt",
 			c2c.display == DISPLAY_TOT ? "tot_hitm" :
 			c2c.display == DISPLAY_LCL ? "lcl_hitm" : "rmt_hitm"
-- 
2.17.1

