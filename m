Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FA28F538
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389131AbgJOOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388858AbgJOOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so3863715wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ltEepQfJJYFF/tnHzGoDFvOluoM+cKJwHQGC9JJmc2o=;
        b=bJ60tqLJcD7BKUZ3NzvbmuetGHeNjiOK1vbinBh+G3lMO6ukhyw1ZAfgprMc3CbK8f
         +iGRTLxSmBFtvFRgm5DyDsQjw6UFYjaaCZVdCvehjlZ5DjivpL6sVnLYP19BxasUjN2+
         SSWngE7068+cmeNB9OdEoqK70V6IWuVZTf7MMWz3rvnKWkPH5LrzA/CkScHNG+cSoiL+
         YfBApZTWq5fXBW3KKeYs4a/WxTTPDJXeD52/47UKJITpYMEIcPfbYXf3mvrYdSI+Epx7
         AiZYdwPT7lYYiLBXPDtUHjY+OUGcLHUp5JcbGto5OC6C+B25pEHaRgbeL0KfqsjSpRue
         QBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ltEepQfJJYFF/tnHzGoDFvOluoM+cKJwHQGC9JJmc2o=;
        b=HrOuRBYmVwSqrfVvSO/dBhM4biqdhpa2siCiwY3u8B183i1pOD0RN6XjiT455GAD+f
         t34+UqUseuQq/sbzYQfr+DEgPa4jlfIUcJwBGsWuWQ4vyjCcjimD7vo1nEo0SBUwJAGy
         XGeklUkxQbAzux5Xh8V98tQE2vJygrgfwsV3TIYhWSp+a+wpRj+GGHCbw/EzVRQswKra
         nBQ/zkMa1w3cieNRtjsLbfTJdEETSEsYeSoFLAUHOF14ilDegnLl0p5Eqt9v0aN8OnKz
         gm+iIfu3qjMwEapAri/EfvUH7HLFYbOvsCWeIayL/STHxIHeDDCbLXGF3NCBWq+qkdMA
         65+Q==
X-Gm-Message-State: AOAM532phD5vwI4G3CIPtn0gm2bIRbDc+4kOdMLaVOUtTPC77GRiCt2h
        ngs+qIErfVGreOK3LzwX3plf/A==
X-Google-Smtp-Source: ABdhPJzbMFL+2I6x24urZeWK8V8hbNz0M6HQYZvIxR4ki8qHFg1LIFeRjn4HNXZoU6dT8dpaY2z3qA==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr5178029wrc.105.1602773461910;
        Thu, 15 Oct 2020 07:51:01 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:01 -0700 (PDT)
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
Subject: [PATCH v1 1/8] perf mem: Add structure field c2c_stats::tot_llchit
Date:   Thu, 15 Oct 2020 15:50:34 +0100
Message-Id: <20201015145041.10953-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new field c2c_stats::tot_llchit to count total number for LLC hit:

  c2c_stats::tot_llchit = c2c_stats::lcl_hitm + c2c_stats::ld_llchit

This is the preparation for additional sorting with total LLC hit, and
will be used in perf c2c report in following patches.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem-events.c | 3 +++
 tools/perf/util/mem-events.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ea0af0bc4314..0ad27bef0698 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -371,6 +371,8 @@ do {				\
 					HITM_INC(lcl_hitm);
 				else
 					stats->ld_llchit++;
+
+				stats->tot_llchit++;
 			}
 
 			if (lvl & P(LVL, LOC_RAM)) {
@@ -455,6 +457,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->ld_fbhit		+= add->ld_fbhit;
 	stats->ld_l1hit		+= add->ld_l1hit;
 	stats->ld_l2hit		+= add->ld_l2hit;
+	stats->tot_llchit	+= add->tot_llchit;
 	stats->ld_llchit	+= add->ld_llchit;
 	stats->lcl_hitm		+= add->lcl_hitm;
 	stats->rmt_hitm		+= add->rmt_hitm;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 904dad34f7f7..a1fa1c312ddb 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -68,6 +68,7 @@ struct c2c_stats {
 	u32	ld_fbhit;            /* count of loads hitting Fill Buffer */
 	u32	ld_l1hit;            /* count of loads that hit L1D */
 	u32	ld_l2hit;            /* count of loads that hit L2D */
+	u32	tot_llchit;          /* count of all loads that hit LLC */
 	u32	ld_llchit;           /* count of loads that hit LLC */
 	u32	lcl_hitm;            /* count of loads with local HITM  */
 	u32	rmt_hitm;            /* count of loads with remote HITM */
-- 
2.17.1

