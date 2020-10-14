Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313C228DBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJNIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbgJNItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:49:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8BC045852
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so1177093wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrIwUA/0oJzmeC4gfrsDFOAMUjkQ7RiIZd70vI/O10o=;
        b=kKPXu1azN6/SinUyxd8R+CvWL/oXlSja6hfJyNjSmED7sMAdzKzsZbOctZOk+jwV75
         TCtDvs300ctGcgLUXyvFg7RqeZRpMwIPusWDMZIFc1Bj2X5AO6MmjJJoDapb0kKz8Lu9
         DeoWl2qWTSsIvSBxdTwCmEM4fa34kxYzFm1f0WLOg0UGtzzawXvYV6mPkKweR/hwY0lq
         uIxsU0ugBWFI2UlGv3bDT+aNtU8LdMlR1RqcpVltIebE0l7OfeKspc9odpbd3yBpn7Y/
         59tv4Vx/KZs/9eJ7EC1jU6lJHFUeIZ5rE5GicjI19OT7/VlDozgcKbUoLTVW7qDjX4+b
         x1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrIwUA/0oJzmeC4gfrsDFOAMUjkQ7RiIZd70vI/O10o=;
        b=hPhrj9ku9qWahKuz7NvudwZT8XbZUcmLxfuzP33N6a5b/Hnsru8U0uJ1O+C/p4LEGx
         L9scHDqYU9A1XkbljYjVF0/FhnZgdKsGyj2Nv4ptjy7d9dNj2UUScr1ynLlUjiUrJ1/c
         niCojovYSNiB7MvNIGr90GQAmq5weTl+h4MVfMjSTHGH7G3WxFsu18od3j0VL2sGaHdr
         4wNKodGb762A2rKcTHcU9M/eVuF2yqj2LxhcWGxIp1OhAO+SfKEariVU3kOUPdJkgD+J
         S20a5UsQy7DMQTAZKNR0dYwOV2kbvenxVGe+5zcJ5cZZbMXa03ExIP9NPw2G/erMaso4
         l0zA==
X-Gm-Message-State: AOAM531xMi2hGcQV3wciYXUcjd6D5AouMQxQ6gFBNqkd5O4uit7FwQAb
        lx18GMJjRKFwAwmhE64ZL0/3WA==
X-Google-Smtp-Source: ABdhPJw3ghDaqArZL6kpUCON31pofKkWnD4OipVJ9zoHUU3xewhwC1Kx2413APSfvXh3V7Gtzhl5Kw==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr1467609wmf.24.1602652180210;
        Tue, 13 Oct 2020 22:09:40 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:39 -0700 (PDT)
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
Subject: [PATCH v1 7/8] perf c2c: Correct LLC load hit metrics
Date:   Wed, 14 Oct 2020 06:09:20 +0100
Message-Id: <20201014050921.5591-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
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

