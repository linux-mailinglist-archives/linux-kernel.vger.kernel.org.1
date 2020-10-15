Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CF28F512
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgJOOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbgJOOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E08C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b127so3987689wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FCO+0O8qgdqrhhkA6/xwJiKnXmHQ8sAsd47OLDtugP0=;
        b=lJwTJHWJK7l//6MJnoR/BmzKs4IxwcVd7gwxxoY4VtU+NhVfXxZ8Yq5PDOkEtlILpn
         Pn8cQjjyYSm15Cb2kk5Pgm2x7NBgAwyUvZlkdGubg13S5wPjO5BHDvw5eB/p7Rsnn58W
         KxzeuYJT1hKhuUQ2ksAvGRwECJa9zoIvm1WmSVqYBMqgFv8+lIFp1W0hAZVaPol3ieZl
         X35CISr3nJOKcnyJePx4novNOt08T6zcu71kysjp7SlOEVgQlOPY7YdFtPhG6+SBDY1d
         4pgSeAKu+91GSJZFcKmMfU2G8rVFT/4YYjGCkTSyGr9sq8HigxygXfnnZoqPTk51kB8i
         X4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FCO+0O8qgdqrhhkA6/xwJiKnXmHQ8sAsd47OLDtugP0=;
        b=lSMNNHNdzBu17jaFJVaClGMBbMd99YPWK8GmgSwB2bnleRopqothRhCg+Bw5MJpjk7
         7Njtf76pLhSZNX7wvbMwIIPzpIXNrdKWMVNfElWfI4/XCESmvufsINRT7NZ2yYz1Z3/B
         BzO6QMUcFjQ5LWoTRP3r1m5VPKznAnqo36T+/lGZCEvsTJF4H/mVkLiSIVVQi157vR+M
         S3YoljrniCWNoZfrXmK166D6bPUjweidOfDZjRDgrPojLMPYxbvRW7y5hBE1O0RAOBYF
         Yu40vpe2YVREGPme9uRIzlwIM84P3VyoTONL8zIhELFcm9tRIM1XGZ+ubpxY1OiakyC1
         puww==
X-Gm-Message-State: AOAM5301LspqNlTwlHdeqr9vmGZj9QBFq+7gDl09IvbxSmFINytU8N61
        5lsovzYzpx0l8ikcbsUtSHW/Lw==
X-Google-Smtp-Source: ABdhPJwhKxKvzoHb6jo7oZBoFvIEq6ND+Yu3sskDxm1v5Ak3lwmJvz43CT4o9+1wql9tv6j94q4ppg==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr4317326wmb.131.1602773170286;
        Thu, 15 Oct 2020 07:46:10 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:09 -0700 (PDT)
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
Subject: [PATCH v2 2/9] perf c2c: Display "Total Stores" as a standalone metrics
Date:   Thu, 15 Oct 2020 15:45:41 +0100
Message-Id: <20201015144548.18482-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total stores is displayed under the metrics "Store Reference", to
output the same format with total records and all loads, extract the
total stores number as a standalone metrics "Total Stores".

After this patch, the tool shows the summary numbers ("Total records",
"Total loads", "Total Stores") in the unified form.

Before:

  #        ----------- Cacheline ----------      Tot  ----- LLC Load Hitm -----    Total    Total  ---- Store Reference ----  --- Load Dram ----      LLC  ----- Core Load Hit -----  -- LLC Load Hit --
  # Index             Address  Node  PA cnt     Hitm    Total      Lcl      Rmt  records    Loads    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss       FB       L1       L2       Llc       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  ........  ........
  #
        0      0x55f07d580100     0    1499   85.89%      481      481        0     7243     3879     3364     2599      765         0         0        0      548     2615       66       169         0
        1      0x55f07d580080     0       1   13.93%       78       78        0      664      664        0        0        0         0         0        0      187      361       27        11         0
        2      0x55f07d5800c0     0       1    0.18%        1        1        0      405      405        0        0        0         0         0        0      131        0       10       263         0

After:

  #        ----------- Cacheline ----------      Tot  ----- LLC Load Hitm -----    Total    Total    Total  ---- Stores ----  --- Load Dram ----      LLC  ----- Core Load Hit -----  -- LLC Load Hit --
  # Index             Address  Node  PA cnt     Hitm    Total      Lcl      Rmt  records    Loads   Stores    L1Hit   L1Miss       Lcl       Rmt  Ld Miss       FB       L1       L2       Llc       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  ........  ........
  #
        0      0x55f07d580100     0    1499   85.89%      481      481        0     7243     3879     3364     2599      765         0         0        0      548     2615       66       169         0
        1      0x55f07d580080     0       1   13.93%       78       78        0      664      664        0        0        0         0         0        0      187      361       27        11         0
        2      0x55f07d5800c0     0       1    0.18%        1        1        0      405      405        0        0        0         0         0        0      131        0       10       263         0

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e602b7891ce9..a2ad24799aea 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1367,16 +1367,16 @@ static struct c2c_dimension dim_cl_lcl_hitm = {
 	.width		= 7,
 };
 
-static struct c2c_dimension dim_stores = {
-	.header		= HEADER_SPAN("---- Store Reference ----", "Total", 2),
-	.name		= "stores",
+static struct c2c_dimension dim_tot_stores = {
+	.header		= HEADER_BOTH("Total", "Stores"),
+	.name		= "tot_stores",
 	.cmp		= store_cmp,
 	.entry		= store_entry,
 	.width		= 7,
 };
 
 static struct c2c_dimension dim_stores_l1hit = {
-	.header		= HEADER_SPAN_LOW("L1Hit"),
+	.header		= HEADER_SPAN("---- Stores ----", "L1Hit", 1),
 	.name		= "stores_l1hit",
 	.cmp		= st_l1hit_cmp,
 	.entry		= st_l1hit_entry,
@@ -1648,7 +1648,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_rmt_hitm,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
-	&dim_stores,
+	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
 	&dim_cl_stores_l1hit,
@@ -2850,7 +2850,8 @@ static int perf_c2c__report(int argc, const char **argv)
 			"tot_hitm,lcl_hitm,rmt_hitm,"
 			"tot_recs,"
 			"tot_loads,"
-			"stores,stores_l1hit,stores_l1miss,"
+			"tot_stores,"
+			"stores_l1hit,stores_l1miss,"
 			"dram_lcl,dram_rmt,"
 			"ld_llcmiss,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
-- 
2.17.1

