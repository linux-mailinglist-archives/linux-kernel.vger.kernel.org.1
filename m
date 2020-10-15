Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5428F526
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgJOOqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389098AbgJOOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F08C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s9so3810452wro.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NXN8hwrPb+lJlOuAgZkqK2DimwM/0xZ9mR6pAnduiqQ=;
        b=L2TAeo2fnE0IaFZdTLH5FuMVAK/X1Lw3lyAwU5M5Bie+rp+LOSi+DkYeX/9sWxRJCh
         QN9Dg9zfIgcjkU6hrMz6QqgdlUXePC4sYzPJy/TtpQakfqy7LeAxrzRNCQRSQ+gxKU+4
         6xWXiVk9R9ik3d0VrhQbIRv+PT+1QxZNUXPht4fmmy35JlV6WOSKxjbWjVws3PYgRjP9
         RQa2m5JTKaBAWCJNttQq9aSeZHQEwdiZsCgVmTwYw1GcSqr16fJlNhCn+1JrLlatiOQN
         q98ZBZcpCUK71CIlktY9PA/N/3DxHMFggP2OvsWk3MjbRiSwBD+wAh72yTw0JefeBaN9
         dCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NXN8hwrPb+lJlOuAgZkqK2DimwM/0xZ9mR6pAnduiqQ=;
        b=bgIkpSQO3IXYAiywuz+KTbvpA0VY2Sbi0rDzqc8vIP+SM96oOTxbTYM5/Mwb0VzDSJ
         81wDOLJfmCbIwI/FogbuHclkBDhhTMnz98pwJj0FDnQv4KUkb/I0ylxrQLskweDZFbS0
         DAJn4NaEXL+3CU9ke+75unj7TsmulhV6VD2gSlnVtB7uRDN/ASHvzrlJr/68CgPVgaGh
         pwemshLoJdJDWD7eiA8FyK8I2RZMxDeo3vUX4D/60IoasREZyKbfECUtPSGhCcmgwuuk
         yrH7XZhBeAUccQ35+o6wU9AjZbNWzk90tmkbFgSa5oxMxtwSCW5BbBRywwwMYuY8kw4i
         YW/A==
X-Gm-Message-State: AOAM530ADxju69wIiFRmLsYQuhCf/RnxByL8ArtBYjXR5MRSC5wtNVCY
        0NQ1ZXgwkoopa7d6TeAvGCsvLQ==
X-Google-Smtp-Source: ABdhPJxZC0mYMAk54BvcqeYGvHdyVZ/2m+Zr8rD7LuwjgV0U+FaQJZsSFGaeUcdK8ecDi48QFLffUA==
X-Received: by 2002:a05:6000:1151:: with SMTP id d17mr5120685wrx.363.1602773176190;
        Thu, 15 Oct 2020 07:46:16 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:15 -0700 (PDT)
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
Subject: [PATCH v2 5/9] perf c2c: Use more explicit headers for HITM
Date:   Thu, 15 Oct 2020 15:45:44 +0100
Message-Id: <20201015144548.18482-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
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
Tested-by: Joe Mario <jmario@redhat.com>
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

