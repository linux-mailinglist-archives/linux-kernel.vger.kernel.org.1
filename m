Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E02D8D54
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406943AbgLMNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406886AbgLMNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:39:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44EC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w206so7432308wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ze/9Zkt8R24ns/8+wNJn9TWMC3k3FFhUo5aO++jYCAY=;
        b=Mp/v1TY2c4Di7zHhRHW/scVQLU5eBqmdCtkqeVrvYB+7H7iB3PYjKPnFYM9jVlD6t8
         LxMgn5vSUFpqBNn1zAj/ij4q3rTaUTvBetn4WzMwtmLrxBjizo7DhoDqxrSjdBM3qjTK
         M5m6g7cg976ddMvEt0FVfjqLijGj7NRcU9edeLpALY2GozAEZ7vyQeuG60Mc5e2X99sw
         7MkYfmi1RuAUhmiZFciSajRbB/LsqdlO+3H6e6O8RQiHKv8i4epwWR9HTHtnPskprGWZ
         NuKw62xgLEkGEebwlhk8pcMzENbCDW4nlDxtj+38Iop8NLbplyo5mUeDGA4UF63Agz2K
         kGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ze/9Zkt8R24ns/8+wNJn9TWMC3k3FFhUo5aO++jYCAY=;
        b=ZDjY9GE170AJgtNkHtj2z3slRLiQ33r8Ky9EO97WyeFyfhtbBeaLH+0tjQaWxBPhB9
         Zz/PubTsQjvwEAl3Quk7hPyHRsYiHJ1ov7J5Abxcx2tqIJOaywe0O/rRCGLoz4R2M1Yz
         zmXPix1+OY/CIbPi0T8PsQCm7AX1i0NQYmTzyrfKLn63MMd3vIs6b0LfinLvUqrG+RTM
         a51bdPGRYInoUmCjfPot5pz68XdoxyTBNGi5OUigUZHFSAlkzBWhJmnRtmaT8KQQu675
         VAZ3IgP17edCA1U6+bFuSCkU9NUdbITiDkHjGQk0Wy5y+9ASdqVzyJhj8citPGKlaH++
         oSRA==
X-Gm-Message-State: AOAM530lmOdja/5PneXydlijVKwx2kdNM+cMl944mvChKjnBBSUnZgYQ
        yy/f9gTDtP8225m78f5C1fuN+Q==
X-Google-Smtp-Source: ABdhPJxDGYVr0z48Dkfzdy/hz9X8/cLDdLZCQFZOt9+tZLeZsR9Hp2urVNTV0QlldQSa9mC2vCsjbw==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr23162412wmk.92.1607866741471;
        Sun, 13 Dec 2020 05:39:01 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:00 -0800 (PST)
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
Subject: [PATCH v2 01/11] perf c2c: Add dimensions for total load hit
Date:   Sun, 13 Dec 2020 13:38:40 +0000
Message-Id: <20201213133850.10070-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPE trace data doesn't support HITM, but we still want to explore
"perf c2c" tool to analyze cache false sharing.  If without HITM tag,
the tool cannot give out accurate result for cache false sharing, a
candidate solution is to sort the total load operations and connect with
the threads info, e.g. if multiple threads hit the same cache line for
many times, this can give out the hint that it's likely to cause cache
false sharing issue.

Unlike having HITM tag, the proposed solution is not accurate and might
introduce false positive reporting, but it's a pragmatic approach for
detecting false sharing if memory event doesn't support HITM.

To sort with the cache line hit, this patch adds dimensions for total
load hit and the associated percentage calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c5babeaa3b38..3d5a2dc8b4fd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -615,6 +615,47 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return tot_hitm_left - tot_hitm_right;
 }
 
+#define TOT_LD_HIT(stats)		\
+	((stats)->ld_fbhit +		\
+	 (stats)->ld_l1hit +		\
+	 (stats)->ld_l2hit +		\
+	 (stats)->ld_llchit +		\
+	 (stats)->lcl_hitm +		\
+	 (stats)->rmt_hitm +		\
+	 (stats)->rmt_hit)
+
+static int tot_ld_hit_entry(struct perf_hpp_fmt *fmt,
+			    struct perf_hpp *hpp,
+			    struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	unsigned int tot_hit;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	tot_hit = TOT_LD_HIT(&c2c_he->stats);
+
+	return scnprintf(hpp->buf, hpp->size, "%*u", width, tot_hit);
+}
+
+static int64_t tot_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			      struct hist_entry *left,
+			      struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left;
+	struct c2c_hist_entry *c2c_right;
+	uint64_t tot_hit_left;
+	uint64_t tot_hit_right;
+
+	c2c_left  = container_of(left, struct c2c_hist_entry, he);
+	c2c_right = container_of(right, struct c2c_hist_entry, he);
+
+	tot_hit_left  = TOT_LD_HIT(&c2c_left->stats);
+	tot_hit_right = TOT_LD_HIT(&c2c_right->stats);
+
+	return tot_hit_left - tot_hit_right;
+}
+
 #define STAT_FN_ENTRY(__f)					\
 static int							\
 __f ## _entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,	\
@@ -860,6 +901,58 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static double percent_tot_ld_hit(struct c2c_hist_entry *c2c_he)
+{
+	struct c2c_hists *hists;
+	int tot = 0, st = 0;
+
+	hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
+
+	st  = TOT_LD_HIT(&c2c_he->stats);
+	tot = TOT_LD_HIT(&hists->stats);
+
+	return tot ? (double) st * 100 / tot : 0;
+}
+
+static int
+percent_tot_ld_hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[10];
+	double per;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	per = percent_tot_ld_hit(c2c_he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_tot_ld_hit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_tot_ld_hit);
+}
+
+static int64_t
+percent_tot_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		   struct hist_entry *left, struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left;
+	struct c2c_hist_entry *c2c_right;
+	double per_left;
+	double per_right;
+
+	c2c_left  = container_of(left, struct c2c_hist_entry, he);
+	c2c_right = container_of(right, struct c2c_hist_entry, he);
+
+	per_left  = percent_tot_ld_hit(c2c_left);
+	per_right = percent_tot_ld_hit(c2c_right);
+
+	return per_left - per_right;
+}
+
 static struct c2c_stats *he_stats(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
@@ -1412,6 +1505,14 @@ static struct c2c_dimension dim_ld_rmthit = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_tot_ld_hit = {
+	.header		= HEADER_BOTH("Load Hit", "Total"),
+	.name		= "tot_ld_hit",
+	.cmp		= tot_ld_hit_cmp,
+	.entry		= tot_ld_hit_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_tot_recs = {
 	.header		= HEADER_BOTH("Total", "records"),
 	.name		= "tot_recs",
@@ -1460,6 +1561,15 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_tot_ld_hit = {
+	.header         = HEADER_BOTH("Load Hit", "Pct"),
+	.name		= "percent_tot_ld_hit",
+	.cmp		= percent_tot_ld_hit_cmp,
+	.entry		= percent_tot_ld_hit_entry,
+	.color		= percent_tot_ld_hit_color,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
 	.name		= "percent_stores_l1hit",
@@ -1615,11 +1725,13 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_l2hit,
 	&dim_ld_llchit,
 	&dim_ld_rmthit,
+	&dim_tot_ld_hit,
 	&dim_tot_recs,
 	&dim_tot_loads,
 	&dim_percent_hitm,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_tot_ld_hit,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
 	&dim_dram_lcl,
-- 
2.17.1

