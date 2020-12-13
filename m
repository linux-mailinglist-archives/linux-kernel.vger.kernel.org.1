Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A02D8D55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406958AbgLMNlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406883AbgLMNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:39:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0BAC0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y17so13725954wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3Ck7eziAaqljPCEcHMgktscMrsdvgJUb5YkG40WWYI=;
        b=cH2LRz4k3Fy5Rd7SmTQz4KfvanxXAbfkWJ5gQBZd83l46zeco4epY26XTSW1yyrrsX
         Ih25gxZwUiUpwOQ6ktQ2iFUrd5ErmU7NGloE2oXlsjKJGK0u0Ngu37LrSQ22LHRL7qi7
         ln8WXMpQf9SUlyyt2ggexpyaKDGO3FnR+GW7jx8XscdePRUCD71PQwQRzC7fzwVxxa2o
         ZWouNB0m3MTRG/uw2xoGOnaXxliXlwUpfbbucGU/QKbIVPn4axQ4R1rvbaCTZq/7Ma9W
         Q80uSwwEXN3agXmq3H50cKGT4IEb3LOyj+ZH+jjiy++DzsupkKRaxMpddUkYPRrth5DV
         3WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3Ck7eziAaqljPCEcHMgktscMrsdvgJUb5YkG40WWYI=;
        b=W4bJZ144ZbdN06P16hmvJQITKuYUc/h2iONYvy/qsJUsYZL3OFFIBs4SgdJHpSxSp+
         ufrIje+RiPV4RMFeZqQ36AbyLETtt1+jstP/8GMsoE9My51KN9IUhwwBeDwyJdILMBVS
         Hl68QTFDVIJpddzwR8C361GCRjVHilQy0oXnJokozBnZ0+yosaxjZLDsXic17soDaLjS
         ilnL2vx7mnjboX7761qswJm5jo6xlaUvYmx+OJa+nkZ5Kci3pIqvsjQ/h8JNac//5sw5
         A8LD5gXjxQYac9kpEHQEMUHVxGC3GGzha4nwtGMGKYTXYln0RDVWUwYP4zHEAJiyEWD6
         Y0Qw==
X-Gm-Message-State: AOAM5314/6qSJQbNXGfSde4vPKrrl0FcGYdEYdPKL9DWi3N+VBHr3sfd
        teKgDCBV7UltdPV2SQ4GYj8WIw==
X-Google-Smtp-Source: ABdhPJzDikl9mbhvnIjS/ZI/XmRxuNRFquCqSF4Qbes0o99VezDXl5ho0AW3K3Fw0ZWI2nN68xr3pA==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr5441943wru.152.1607866742711;
        Sun, 13 Dec 2020 05:39:02 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:01 -0800 (PST)
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
Subject: [PATCH v2 02/11] perf c2c: Add dimensions for load hit
Date:   Sun, 13 Dec 2020 13:38:41 +0000
Message-Id: <20201213133850.10070-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dimensions for load hit and its percentage calculation, which is to
be displayed in the single cache line output.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3d5a2dc8b4fd..00014e3d81fa 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1052,6 +1052,58 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static double percent_ld_hit(struct c2c_hist_entry *c2c_he)
+{
+	struct c2c_hists *hists;
+	int tot, st;
+
+	hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
+
+	st  = TOT_LD_HIT(&c2c_he->stats);
+	tot = TOT_LD_HIT(&hists->stats);
+
+	return percent(st, tot);
+}
+
+static int
+percent_ld_hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[10];
+	double per;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	per = percent_ld_hit(c2c_he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_ld_hit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_ld_hit);
+}
+
+static int64_t
+percent_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
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
+	per_left  = percent_ld_hit(c2c_left);
+	per_right = percent_ld_hit(c2c_right);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1417,6 +1469,14 @@ static struct c2c_dimension dim_cl_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_tot_ld_hit = {
+	.header		= HEADER_SPAN("--- Load ---", "Hit", 1),
+	.name		= "cl_tot_ld_hit",
+	.cmp		= tot_ld_hit_cmp,
+	.entry		= tot_ld_hit_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_lcl_hitm = {
 	.header		= HEADER_SPAN_LOW("Lcl"),
 	.name		= "cl_lcl_hitm",
@@ -1570,6 +1630,15 @@ static struct c2c_dimension dim_percent_tot_ld_hit = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_percent_ld_hit = {
+	.header		= HEADER_SPAN("--  Load Refs --", "Hit", 1),
+	.name		= "percent_ld_hit",
+	.cmp		= percent_ld_hit_cmp,
+	.entry		= percent_ld_hit_entry,
+	.color		= percent_ld_hit_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
 	.name		= "percent_stores_l1hit",
@@ -1715,6 +1784,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_rmt_hitm,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
+	&dim_cl_tot_ld_hit,
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
@@ -1731,6 +1801,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_hitm,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_ld_hit,
 	&dim_percent_tot_ld_hit,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
-- 
2.17.1

