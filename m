Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23122D8D53
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406934AbgLMNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406884AbgLMNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:39:45 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81331C061793
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id q18so6222973wrn.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Ek7BEwLlu/hVk3vhh7xqfYHBICNWcm+iOocXQ0Kiw0=;
        b=o3XVNeRZAMC+Pa1YnaIgEiRaH3FqpGR+vlaGcMvmIU8YHP5raqjMqnQ+Ud9Cic6ukC
         u2NUYrqT4krE3vzV1vN2ZNj49c7drIyiUgliY5+Uo15eWuwvwh8GkLR/jIgxW9GiT9Kw
         9vi9H197kRLZq+n+gSQRolxGJUS+70IKwnwCQLroHOyM35hxG3qnisrq1Zr1cy5PA5qX
         SP9Y4nrXau/fTl2HgBHU3Jr6QarZl5PLQ4qUJpl2zuyc6vYEqcJE84DsCk1tgKljcvLF
         tG2O1jzao4nL1b1lz+NxOBCn4Ok2DTaAiO8H/HBiTaAL4kRj7f4rn6U6TWZgj6+8XPx8
         XLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Ek7BEwLlu/hVk3vhh7xqfYHBICNWcm+iOocXQ0Kiw0=;
        b=hrqHsJp2r6+4mKQj8nSQBIEwvD+OcJMykPtxX1QnzMgu14diqBLbcc4oVCYY7sOltH
         NAXknMiuK7K0bRBJqvjFcPGaVpNsAw7XH44DfNK0vuTsB+2JNINGGBlw65axONaz142W
         iOBUHvAm9aTpOz3UAfZMP2MhzlSZLGA6S0rWje2YqvLY8z6+7Wlefv/Z4G+F/z9jBVpJ
         h8UHkmvsX44mcPBLp6iRPcYBwTcDeImm6MXPhkYJx3XBCDhyVVdLkQjT2fsMZK9G6Vvw
         Xw0kDV+rgDjd8w791vYxQILJU4SKtHWTrPs/jSZSKFea/keX+yGsIDUCa6DQ87ogdl+u
         Jj1w==
X-Gm-Message-State: AOAM53280FOU8DQBrQI7TIExMs12GAl0JiH633A7nxVCPyFX/IUOJVI/
        p5KVvnVQ8uA5pAJkQWu2Ro/VoQ==
X-Google-Smtp-Source: ABdhPJyvPW0Y4QxpWMYaYl1sFBbwhsz2/EQztRT/cmpDTvuNP2Wr8QKyepbVEt/GNUTuP4GkddtDkg==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr23858804wrr.267.1607866744163;
        Sun, 13 Dec 2020 05:39:04 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:03 -0800 (PST)
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
Subject: [PATCH v2 03/11] perf c2c: Add dimensions for load miss
Date:   Sun, 13 Dec 2020 13:38:42 +0000
Message-Id: <20201213133850.10070-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dimensions for load miss and its percentage calculation, which is to
be displayed in the single cache line output.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 107 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 00014e3d81fa..27745340c14a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -624,6 +624,10 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	 (stats)->rmt_hitm +		\
 	 (stats)->rmt_hit)
 
+#define TOT_LD_MISS(stats)		\
+	((stats)->lcl_dram +		\
+	 (stats)->rmt_dram)
+
 static int tot_ld_hit_entry(struct perf_hpp_fmt *fmt,
 			    struct perf_hpp *hpp,
 			    struct hist_entry *he)
@@ -656,6 +660,38 @@ static int64_t tot_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return tot_hit_left - tot_hit_right;
 }
 
+static int tot_ld_miss_entry(struct perf_hpp_fmt *fmt,
+			     struct perf_hpp *hpp,
+			     struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	unsigned int tot_miss;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	tot_miss = TOT_LD_MISS(&c2c_he->stats);
+
+	return scnprintf(hpp->buf, hpp->size, "%*u", width, tot_miss);
+}
+
+static int64_t tot_ld_miss_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			       struct hist_entry *left,
+			       struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left;
+	struct c2c_hist_entry *c2c_right;
+	uint64_t tot_miss_left;
+	uint64_t tot_miss_right;
+
+	c2c_left  = container_of(left, struct c2c_hist_entry, he);
+	c2c_right = container_of(right, struct c2c_hist_entry, he);
+
+	tot_miss_left  = TOT_LD_MISS(&c2c_left->stats);
+	tot_miss_right = TOT_LD_MISS(&c2c_right->stats);
+
+	return tot_miss_left - tot_miss_right;
+}
+
 #define STAT_FN_ENTRY(__f)					\
 static int							\
 __f ## _entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,	\
@@ -1104,6 +1140,58 @@ percent_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static double percent_ld_miss(struct c2c_hist_entry *c2c_he)
+{
+	struct c2c_hists *hists;
+	int tot, st;
+
+	hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
+
+	st  = TOT_LD_MISS(&c2c_he->stats);
+	tot = TOT_LD_MISS(&hists->stats);
+
+	return percent(st, tot);
+}
+
+static int
+percent_ld_miss_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[10];
+	double per;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	per = percent_ld_miss(c2c_he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_ld_miss_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_ld_miss);
+}
+
+static int64_t
+percent_ld_miss_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		    struct hist_entry *left, struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left;
+	struct c2c_hist_entry *c2c_right;
+	double per_left;
+	double per_right;
+
+	c2c_left  = container_of(left, struct c2c_hist_entry, he);
+	c2c_right = container_of(right, struct c2c_hist_entry, he);
+
+	per_left  = percent_ld_miss(c2c_left);
+	per_right = percent_ld_miss(c2c_right);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1477,6 +1565,14 @@ static struct c2c_dimension dim_cl_tot_ld_hit = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_tot_ld_miss = {
+	.header		= HEADER_SPAN_LOW("Miss"),
+	.name		= "cl_tot_ld_miss",
+	.cmp		= tot_ld_miss_cmp,
+	.entry		= tot_ld_miss_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_lcl_hitm = {
 	.header		= HEADER_SPAN_LOW("Lcl"),
 	.name		= "cl_lcl_hitm",
@@ -1639,6 +1735,15 @@ static struct c2c_dimension dim_percent_ld_hit = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_ld_miss = {
+	.header		= HEADER_SPAN_LOW("Miss"),
+	.name		= "percent_ld_miss",
+	.cmp		= percent_ld_miss_cmp,
+	.entry		= percent_ld_miss_entry,
+	.color		= percent_ld_miss_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
 	.name		= "percent_stores_l1hit",
@@ -1785,6 +1890,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
 	&dim_cl_tot_ld_hit,
+	&dim_cl_tot_ld_miss,
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
@@ -1802,6 +1908,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_ld_hit,
+	&dim_percent_ld_miss,
 	&dim_percent_tot_ld_hit,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
-- 
2.17.1

