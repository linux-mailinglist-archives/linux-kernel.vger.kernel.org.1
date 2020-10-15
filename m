Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABC28F53E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbgJOOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388856AbgJOOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so3799678wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCEMkqtW0at6OfkJYkXSC89pAhfBuQRiBO8vpzVxVyI=;
        b=FDlDdVm6b8PUY+hsPwnFE7mB5rw0bQ2dVWlnZUneZxxJ1EJFfmMJB9HKhxszBxP37D
         OH0m03x2I42XZdhJ5ehGczYC4UtEw4bkTdg59158z48ra9XJne6KCS0vXo9IVVLPR5tB
         xxlWLv9CPCelz65Cj+qWj00jpel1xm3i4AnNaqOLaBXJzn3zMVxVXpCjcenGj0meQB+v
         IAyk9zw8VpF/LSgdGDbiOifLfeDBz7gdLHIaxjR4nD7I8BomLp4p5P/uPweIAp1lslYd
         QaFqxoxHfbyR6FKmDVJLWz/qsMFqXJdwMRHUsygs3ICP/yhgZs24Wuddmr6/krrQ96Q0
         oeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCEMkqtW0at6OfkJYkXSC89pAhfBuQRiBO8vpzVxVyI=;
        b=QO7F88zkof6C9yqboG56gtwJKA4s24vaJNlXykhK8N4Ou5iSvhkqz5zEWnXcsz3n2U
         //ZOh1U4S0qtgDPDIm4QmbBH8I6hm+6JnFBqMFnXR4TVNC4xrOKX3KH9zmJWK8oATqhx
         VNG13PVtzBOaLMblQLPiJ3OMw3mAVCdKp2kc50/AfGt/qL+RuPZPl5tXyIeTxrbnDOVM
         3pdTcAzmXftTMg2pYTktsIA8bbbLUifnEr4+GUlIfsVxikD8ZZhAHft4FLPlU/PNuA11
         A7C46/q+ZG+gO4mfEmt1qfrLASGuB6GjuMJGlGLirlN3Q2IEaWz4x1YXYJtR8Wx1OjFq
         GnCQ==
X-Gm-Message-State: AOAM531qCXOZ9hnDW1Oz9QRqM5MBIgZnKDQCQnjTld7tK+DQbTHSAsYF
        DfTv1itJ4Z+48g5mVz2Lo8w4Ow==
X-Google-Smtp-Source: ABdhPJx8TyLlDp1cDBu2i3c53tPkHOUPGNCDSrkfEbg9mqEv8n6/h+3i5U9TlPKbPZolEyvBhdKqqw==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr5172971wrj.201.1602773463353;
        Thu, 15 Oct 2020 07:51:03 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:02 -0700 (PDT)
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
Subject: [PATCH v1 2/8] perf c2c: Add dimensions for total LLC hit
Date:   Thu, 15 Oct 2020 15:50:35 +0100
Message-Id: <20201015145041.10953-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Arm64 SPE trace data doesn't support HITM, we still want to
explore "perf c2c" tool to analyze cache false sharing.  If without HITM
tag, the tool cannot give out accurate result for cache false sharing,
a candidate solution is to sort the LLC hit and connect with the info of
multiple threads, e.g. if multiple threads hit the LLC on the same
cacheline for many times, this hints that it's likely to cause false
sharing issue.  Though this solution is not perfect due to lacking HITM
tag, it's pragmatic for detecting false sharing.

To support the sorting with LLC hit, this patch adds dimensions for
total LLC hit and the associated percentage calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9c2183957c50..5fb77fcd3c9c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -651,6 +651,7 @@ STAT_FN(ld_l1hit)
 STAT_FN(ld_l2hit)
 STAT_FN(ld_llchit)
 STAT_FN(rmt_hit)
+STAT_FN(tot_llchit)
 
 static uint64_t total_records(struct c2c_stats *stats)
 {
@@ -856,6 +857,62 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static double percent_llchit(struct c2c_hist_entry *c2c_he)
+{
+	struct c2c_hists *hists;
+	struct c2c_stats *stats;
+	struct c2c_stats *total;
+	int tot = 0, st = 0;
+
+	hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
+	stats = &c2c_he->stats;
+	total = &hists->stats;
+
+	st  = stats->tot_llchit;
+	tot = total->tot_llchit;
+
+	return tot ? (double) st * 100 / tot : 0;
+}
+
+static int
+percent_llchit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[10];
+	double per;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	per = percent_llchit(c2c_he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_llchit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_llchit);
+}
+
+static int64_t
+percent_llchit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
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
+	per_left  = percent_llchit(c2c_left);
+	per_right = percent_llchit(c2c_right);
+
+	return per_left - per_right;
+}
+
 static struct c2c_stats *he_stats(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
@@ -1392,6 +1449,14 @@ static struct c2c_dimension dim_ld_l2hit = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_tot_llchit = {
+	.header		= HEADER_BOTH("LLC Hit", "Total"),
+	.name		= "tot_llchit",
+	.cmp		= tot_llchit_cmp,
+	.entry		= tot_llchit_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_ld_llchit = {
 	.header		= HEADER_SPAN("- LLC Load Hit --", "LclHit", 1),
 	.name		= "ld_lclhit",
@@ -1438,6 +1503,15 @@ static struct c2c_dimension dim_percent_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_llchit = {
+	.header         = HEADER_BOTH("LLC Hit", "Pct"),
+	.name		= "percent_llchit",
+	.cmp		= percent_llchit_cmp,
+	.entry		= percent_llchit_entry,
+	.color		= percent_llchit_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_rmt_hitm = {
 	.header		= HEADER_SPAN("----- HITM -----", "RmtHitm", 1),
 	.name		= "percent_rmt_hitm",
@@ -1611,9 +1685,11 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_l2hit,
 	&dim_ld_llchit,
 	&dim_ld_rmthit,
+	&dim_tot_llchit,
 	&dim_tot_recs,
 	&dim_tot_loads,
 	&dim_percent_hitm,
+	&dim_percent_llchit,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_stores_l1hit,
-- 
2.17.1

