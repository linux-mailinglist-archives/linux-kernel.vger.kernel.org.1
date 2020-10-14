Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FD28DC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgJNIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgJNIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:54:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9DC045850
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so2104205wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ce+FvFJBRE11bDKI8Lnjmb/d7tP78b7hhZzZtpCvlRs=;
        b=MyY4v/U4Y9zUyrC/OthQ48MdMCzvLzyRd7MiKhDNNnUR23htpmNdhyGGYWv5UASH3R
         xb9LLeYM0sK7GAKIs7fiO2DMljvnJyn1Yf87UOYwrCI7MrDl368dkiqScQXf54G60J3F
         gwONd5KEJNsirPcNHTRq8VsPLy3R3mOfchiOA3onmJBoV7OKKuLLBrtnahCgUuJxg+ml
         FqIVfoDl2GYUKUE7kJQn8OxyG7JVjVX7D7/pK+k+n3jJTIgvG2GW4yzQ7Jj62512I4/S
         fb99XiiqsLGsrVH4mOf1E81miQK/Pk1L2m7s1S4HD/64ePVlD5BAIUVjhwf7Jl9ml/Pd
         6aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ce+FvFJBRE11bDKI8Lnjmb/d7tP78b7hhZzZtpCvlRs=;
        b=lHLGgp4cqhmCUPI7aN9lyM6C3XeNPpXNITZo5NYzYr1AOg0I5BoyqjfrCVAgnRLrBk
         r+eczhtE52vV94FHmDTZ1/himq4f4cOsq0UtoBkYoNpnNJSmECvcoApfr+On/U2inbWq
         GaewIjay8f7JJ4OOTOKsQs3UOme8VJIbbHVAI5IVzAPsvIghBQakp55fKNAfXRaom124
         B4SXYNI/XSiXwWJuLGI49S5vzaXtfT3Wxu6+m8DsK0EZ4SqWtl9r+jAKou3KqbFngvzE
         GjKohVcA9IMLUbC2p0y7yap8zKujGUe33KNyxZueU6NPo17dja6alx62JgS2e3RWzBKE
         Uk1g==
X-Gm-Message-State: AOAM531iyqkdD1QIMzYiE3lx4QBFjwRF2bVbATta9VZHM6zXLDt48B6q
        VOKcq17B1YhqktSWiXTrq7/8Pw==
X-Google-Smtp-Source: ABdhPJyYK4NPjQwu+wIm50xqGJ7khe+x4LnT6gb0rgqCfunTpxx8jUpPqPWdw+b7Nq0OtNkK5e1nrw==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr3006514wro.337.1602652177573;
        Tue, 13 Oct 2020 22:09:37 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/8] perf c2c: Use more explicit headers for HITM
Date:   Wed, 14 Oct 2020 06:09:18 +0100
Message-Id: <20201014050921.5591-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local and remote HITM use the headers 'Lcl' and 'Rmt' respectively,
suppose if we want to extend the tool to display these two dimensions
under any one metrics, users cannot understand the semantics if only
based on the header string 'Lcl' or 'Rmt'.

To explicit express the meaning for HITM items, this patch changes the
headers string as "LclHitm" and "RmtHitm", the strings are more readable
and this allows to extend metrics for using HITM items.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index fa7a1c55b989..3d5aa21020f2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1336,7 +1336,7 @@ static struct c2c_dimension dim_tot_hitm = {
 };
 
 static struct c2c_dimension dim_lcl_hitm = {
-	.header		= HEADER_SPAN_LOW("Lcl"),
+	.header		= HEADER_SPAN_LOW("LclHitm"),
 	.name		= "lcl_hitm",
 	.cmp		= lcl_hitm_cmp,
 	.entry		= lcl_hitm_entry,
@@ -1344,7 +1344,7 @@ static struct c2c_dimension dim_lcl_hitm = {
 };
 
 static struct c2c_dimension dim_rmt_hitm = {
-	.header		= HEADER_SPAN_LOW("Rmt"),
+	.header		= HEADER_SPAN_LOW("RmtHitm"),
 	.name		= "rmt_hitm",
 	.cmp		= rmt_hitm_cmp,
 	.entry		= rmt_hitm_entry,
@@ -1486,7 +1486,7 @@ static struct c2c_dimension dim_percent_hitm = {
 };
 
 static struct c2c_dimension dim_percent_rmt_hitm = {
-	.header		= HEADER_SPAN("----- HITM -----", "Rmt", 1),
+	.header		= HEADER_SPAN("----- HITM -----", "RmtHitm", 1),
 	.name		= "percent_rmt_hitm",
 	.cmp		= percent_rmt_hitm_cmp,
 	.entry		= percent_rmt_hitm_entry,
@@ -1495,7 +1495,7 @@ static struct c2c_dimension dim_percent_rmt_hitm = {
 };
 
 static struct c2c_dimension dim_percent_lcl_hitm = {
-	.header		= HEADER_SPAN_LOW("Lcl"),
+	.header		= HEADER_SPAN_LOW("LclHitm"),
 	.name		= "percent_lcl_hitm",
 	.cmp		= percent_lcl_hitm_cmp,
 	.entry		= percent_lcl_hitm_entry,
-- 
2.17.1

