Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB128F537
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgJOOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbgJOOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF4C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so3799762wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0sI25plOCaeAJia+RtBvtg3Jz41CamOyEc+wnzOZ1M=;
        b=rRL5Eayv03Tu/O0txzuuAlOOW3Eu9lDaGx/mSV5VnV2d5PPVUqbiBNcl36PeUYqO/t
         kSzEOlYjTkujpY0yHyFigbGSVl24CylrKrbpZEIpcBJR03j/YVaEtbFMEQ7xlqcKcdDD
         OwG4zypCUeK55j8va7grrcfpB9+0tpHFUCv2RdyztkTMndXbfeV5I3uyW2OjRlBlePrU
         UmKGCRVfuAm936HxO1kEzHiNz0fTmaMsTuVUpQ0HhurLXypJow7V1rLbHmgEsFUo4pSx
         4HIBULTLa1YbXZ0NVVP2xOkJsGE2qR7ROQp9a3tm4OcSzpXcafZx7N9uBHN3aoLQ719X
         kLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I0sI25plOCaeAJia+RtBvtg3Jz41CamOyEc+wnzOZ1M=;
        b=dmk3W/qJcCQ95KxyX1u0SuPf1l4Tl0I3MscDZz7n92b8KiVBFhw+71l9gIoZD0iUqH
         xfha2eO9MMnMofN41BvZ/aB6Rp7hqckiMzQr3/0pU3yk6gOM7s1Nwht/UjshbCP0m/CS
         AI/5Itq5KBK+TjOeYCPmHJc+dlmUsT20KmIrIEn9FlfGg9Xg0LJdyiDQbojc+02DZJO9
         PF68j3ocqmZZOozZvTnbH5oRK6w1UoCqiDpReqSeg/3A2pC+L/gemcwcOeIDh5WjeVcW
         ivcjStwRBKXMXr+UlNZ76M5ijQVcEXEMyJgHCUM1Sbf0AmHlhDi4P7emRSXC7jxY3tbj
         VlBA==
X-Gm-Message-State: AOAM533B1K9hMB70na+ORYpSp1ofX6WQw751HjF1A+6HHlpWrark+gj0
        +8/XgRPkcMADe2PCyiklS29ywQ==
X-Google-Smtp-Source: ABdhPJx02AM3u/ICfyzQ+desg1fbu9+ycZd+9s8U6kEbarnYbT2GmwR23iIz6ajzNotTzJsdsNQ5Gw==
X-Received: by 2002:a05:6000:1045:: with SMTP id c5mr5093137wrx.296.1602773464835;
        Thu, 15 Oct 2020 07:51:04 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:04 -0700 (PDT)
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
Subject: [PATCH v1 3/8] perf c2c: Add dimensions for LLC load hit
Date:   Thu, 15 Oct 2020 15:50:36 +0100
Message-Id: <20201015145041.10953-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dimensions for LLC load hit and its associated percentage
calculation, which is to be displayed in the single cache line output.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5fb77fcd3c9c..3f6271a779c4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -947,6 +947,7 @@ static double percent_ ## __f(struct c2c_hist_entry *c2c_he)			\
 
 PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
+PERCENT_FN(ld_llchit)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
 
@@ -1012,6 +1013,37 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_llc_hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, ld_llchit);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_llc_hit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_ld_llchit);
+}
+
+static int64_t
+percent_llc_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		    struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, ld_llchit);
+	per_right = PERCENT(right, ld_llchit);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1377,6 +1409,14 @@ static struct c2c_dimension dim_cl_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_llc_hit = {
+	.header		= HEADER_SPAN("--- LLC Load ---", "LclHit", 1),
+	.name		= "cl_llc_hit",
+	.cmp		= ld_llchit_cmp,
+	.entry		= ld_llchit_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_lcl_hitm = {
 	.header		= HEADER_SPAN_LOW("Lcl"),
 	.name		= "cl_lcl_hitm",
@@ -1530,6 +1570,15 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_llc_hit = {
+	.header		= HEADER_SPAN("---- LLC LD ----", "LclHit", 1),
+	.name		= "percent_llc_hit",
+	.cmp		= percent_llc_hit_cmp,
+	.entry		= percent_llc_hit_entry,
+	.color		= percent_llc_hit_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
 	.name		= "percent_stores_l1hit",
@@ -1673,6 +1722,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
 	&dim_rmt_hitm,
+	&dim_cl_llc_hit,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
 	&dim_tot_stores,
@@ -1692,6 +1742,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_llchit,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_llc_hit,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
 	&dim_dram_lcl,
-- 
2.17.1

