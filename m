Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6828DC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgJNIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgJNIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:54:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F513C04584D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so2186840wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pOagZaIbyA6zDZtdBxIxV4Xcl1GZv0l71sQb/Rm0o28=;
        b=ydr8XyO0MMo8IbFy4YDO8bzGvtD2dhg4SDIL3bplXmyq+8FHtYRqXuYr7d93Msan4j
         O9RGj5n5zW2ORznKihQWwxE2tf9xSEKCNZ70W2W3qA9YBIhxtc4cKYQ3tgnmrJ4hf6fm
         J6iz0nryvzZCCoGknCrR1keHk15CtNiQRUJd840kcAsYYd/f6lri2F7dkT2+fWC2kSdc
         4KKTrw7nJHZZpxj0rFg46wnx6KlejI2Xfoc/whNmWf8X9h6NtkTyGWNlJUTPK3A36mw6
         7oywFcruYafBJEs4O2tpxD6gIfHEnkVdj3+3r0n4w3ZiTVGCit8mrpqZGrdGP6ey7vIR
         sWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pOagZaIbyA6zDZtdBxIxV4Xcl1GZv0l71sQb/Rm0o28=;
        b=cwhoxAt+aEs0/cGsJgtyoXggkAs3hzc3PAWUaHpnxn2IXs/3ZqXDDN0bknPWgD9XjD
         w/S4iyTG5jZyI1ePHoNCfExRxLqZLBt12PDclZgYkOZ+v7Nf173dpWjGgebvGnI7cLp1
         bITAFbo2DmNk1FOgxiTAk7YzgCMdPXXQM0m6fnbTgaUwRuPzmX6/n1OHAhPBPZUDutQJ
         fttta3jrKjDBu1Nta6nLZXbWbDTuIj+1t3a+r8GdggN0mTJD3D/2p0S36jARGZV9J1QV
         BJw+br0mfLNDPkAfxEg5ig6uYb3OeXdVQaRpeZElRMHyT3zNrjRQy126fwCNm8pcUMTr
         /VXQ==
X-Gm-Message-State: AOAM531c0IDiVrt8XcdTZBdT/N6rDNx4lQNbk82u7Rg4BeFbEWBkW2cU
        f2gTTfoCQArF4Pr0ZJzpwbzDPg==
X-Google-Smtp-Source: ABdhPJwKljnyLaZnGKzLgYnPY4VoAQzua+tYK229bfuOyE8nuvI6OY8b8SyW2bTj1OuIBxk3ecfYNg==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr3380899wrn.188.1602652174044;
        Tue, 13 Oct 2020 22:09:34 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:33 -0700 (PDT)
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
Subject: [PATCH v1 2/8] perf c2c: Display "Total Stores" as a standalone metrics
Date:   Wed, 14 Oct 2020 06:09:15 +0100
Message-Id: <20201014050921.5591-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
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

