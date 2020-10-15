Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B798528F51B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgJOOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389117AbgJOOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51DC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so3838869wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pz6yxk8KPIsP7TnN47K850oOi6nqdJTd3epd7g7O438=;
        b=sGGgGGKDc+NO4q+A5vIdBAnem0BXzL6VsGUMq9uI31g9DoVOSlMmfxnO1pPjybsc5d
         2LCvx5vJQ9BREASfaU7kUxg5Hn8gjnRWMbJl/Upt6zfg6TMpI0W7aqIQ0gnTcMfhXOJ5
         kbuEEyCqsOQ60X7Ru/Idmb6d7qJvrw9e+kz4B5yMISLXWA2wT7eaZPNUt47uPGLg0H5U
         3dv1PtEYjKYwygVHLKZZjddFxmw1oVB6HgBzXUIkgnMHt4xrkHR7yDs6G51+/o5tAiY2
         gDMRFjNOHrwzTMN154e/KKUr8rNYyB/Q89LgeS73u5k1zv/484iCvYIA5IhxLR88EUhF
         4A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pz6yxk8KPIsP7TnN47K850oOi6nqdJTd3epd7g7O438=;
        b=ZpGepi/iTn534izx8CkyicfcvhzE41kgDo8gsheloq9pu2xdvfHZcodaH3Fd8oMoJt
         MR7jd2XJrdpDf3/q5YJzZvCPMZl3gM0wFqD16/EeLn99DFJMjgn7nmW7H3/2ffalhpeA
         lpuwKTpJwW98uH8831ymOLVY7hwjUqXUsXnrMdsP/Hg751aqDw+zb4NuzhQykysE69Vs
         4CYkLio3HEs4jijW+tlH6GsReB660E/7JZ2w55uWJtgwEgy6Y0C29quB3xxkbZvdLtid
         7A5FLMtk2lWHR7i3/pXx3qX7xXbC8gVDFtZ0OI8d3kW4etrgdJTYgcPyLDnFvT6d3CGP
         GGsg==
X-Gm-Message-State: AOAM533UfsilqkIY44Gh2YiNcgdfCR5w0qqW6HjigExQLtmujS5pbEEx
        ODrbVtLHaXclKTP53L645Ga0QA==
X-Google-Smtp-Source: ABdhPJw5B1fDpve9RgNVOh/bvr6Fnhdkp+wHT5ljjUZC0gi6T2SYWW8n+3h1Nw213Ss0l69V8umJWw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr4817947wrj.415.1602773178771;
        Thu, 15 Oct 2020 07:46:18 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:18 -0700 (PDT)
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
Subject: [PATCH v2 7/9] perf c2c: Correct LLC load hit metrics
Date:   Thu, 15 Oct 2020 15:45:46 +0100
Message-Id: <20201015144548.18482-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"rmt_hit" is accounted into two metrics: one is accounted into the
metrics "LLC Ld Miss" (see the function llc_miss() for calculation
"llcmiss"); and it's accounted into metrics "LLC Load Hit".  Thus,
for the literal meaning, it is contradictory that "rmt_hit" is
accounted for both "LLC Ld Miss" (LLC miss) and "LLC Load Hit"
(LLC hit).

Thus this is easily to introduce confusion: "LLC Load Hit" gives
impression that all items belong to it are LLC hit; in fact "rmt_hit"
is LLC miss and remote cache hit.

To give out clear semantics for metric "LLC Load Hit", "rmt_hit" is
moved out from it and changes "LLC Load Hit" to contain two items:

  LLC Load Hit = LLC's hit ("ld_llchit") + LLC's hitm ("lcl_hitm")

For output alignment, adjusts the header for "LLC Load Hit".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2292261b40a2..61fb939a4e70 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1432,7 +1432,7 @@ static struct c2c_dimension dim_ld_l2hit = {
 };
 
 static struct c2c_dimension dim_ld_llchit = {
-	.header		= HEADER_SPAN("-- LLC Load Hit --", "LclHit", 1),
+	.header		= HEADER_SPAN("- LLC Load Hit --", "LclHit", 1),
 	.name		= "ld_lclhit",
 	.cmp		= ld_llchit_cmp,
 	.entry		= ld_llchit_entry,
@@ -2853,7 +2853,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			"tot_stores,"
 			"stores_l1hit,stores_l1miss,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
-			"ld_lclhit,ld_rmthit,"
+			"ld_lclhit,lcl_hitm,"
 			"ld_llcmiss,"
 			"dram_lcl,dram_rmt",
 			c2c.display == DISPLAY_TOT ? "tot_hitm" :
-- 
2.17.1

