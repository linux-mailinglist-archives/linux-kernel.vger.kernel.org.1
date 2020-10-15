Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95E28F514
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgJOOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389095AbgJOOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DAC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so3782302wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1kVa1CpWOjmXDcw6+jq28bwj+KPG1gzHFGZocNNsyw=;
        b=AckG4y5wm/5+Heg1QSsfFaT1IhhgyWz8sr4B15VDFhj5LIPIGKEVqp4rkMaVZqzKL2
         MCBGadgg0R8GiZI6ExdHgJI8HWspjrPPbCfTqVeQXJ89BnPuQfRtZPQbJmRKHqFjeq2M
         tzk0F8Ttobvk9pCrZl6vzPvDtfNTg1k/6/aPlmqGhgpWsvOpAC5SagGG0FVoWOY8Ww11
         Io9M3ozZSghxShxjf1V49V4Y9VTbeGASEy2uF08rx1V3JrN5jmzt6HFQ8RVO4tikqOnE
         koVYeKApBrvf+zuZti7GpZgN9Y5ykRc78UvBDkCqB6EeyAil7rRl4njDFQ3tVH3HNe+V
         +hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1kVa1CpWOjmXDcw6+jq28bwj+KPG1gzHFGZocNNsyw=;
        b=Qe7nPD7jo5MIWiGOY449AX3YFS7AzfPRn5AS12Q1huSTvTmAUb2j+a7YNPJYEgceLx
         N/Rr11wH+kyxApEk0AyRYhTrtzdcvLH9jjb7KHpE2obFgk8IY8DGUKTffLnutfxFlHpk
         +RW8lmW83RMYihIoM17N1DQIZgqGohwX72dKqa/VIVbHpgzzTI3d9EfW9at1fT3XG95I
         EqVgL4A72kOzt1+MMI6dVlhbNqK3czZnyw4fMiSb6s+RITDWebXWv1Qyvq5lSpYX9nBq
         v/S21MbkO4vR5mMFEa/wDPxr9IOUOWYxLB5T6DSP0kno4cFAHviW0/VoJ2R/4Rg15fMd
         nRsg==
X-Gm-Message-State: AOAM533htiGplUGMqY9tMuU601CAc/3nS//BN0To608gdRpWDCSYLN99
        wVo7AaSiocvF9azSAF9WxKSWxw==
X-Google-Smtp-Source: ABdhPJyVBYfKohwTrUWDovYlIEYfyLvx9lmpc9yqJnb3bxDFe4PbVo9RAdO466nivnwftkDVxe6ALg==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr4791917wrh.253.1602773172204;
        Thu, 15 Oct 2020 07:46:12 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:10 -0700 (PDT)
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
Subject: [PATCH v2 3/9] perf c2c: Organize metrics based on memory hierarchy
Date:   Thu, 15 Oct 2020 15:45:42 +0100
Message-Id: <20201015144548.18482-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metrics are not organized based on memory hierarchy, e.g. the tool
doesn't organize the metrics order based on memory nodes from the close
node (e.g. L1/L2 cache) to far node (e.g. L3 cache and DRAM).

To output metrics with more friendly form, this patch refines the
metrics order based on memory hierarchy:

  "Core Load Hit" => "LLC Load Hit" => "LLC Ld Miss" => "Load Dram"

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a2ad24799aea..404d4739b8c1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2852,10 +2852,10 @@ static int perf_c2c__report(int argc, const char **argv)
 			"tot_loads,"
 			"tot_stores,"
 			"stores_l1hit,stores_l1miss,"
-			"dram_lcl,dram_rmt,"
-			"ld_llcmiss,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
-			"ld_lclhit,ld_rmthit",
+			"ld_lclhit,ld_rmthit,"
+			"ld_llcmiss,"
+			"dram_lcl,dram_rmt",
 			c2c.display == DISPLAY_TOT ? "tot_hitm" :
 			c2c.display == DISPLAY_LCL ? "lcl_hitm" : "rmt_hitm"
 			);
-- 
2.17.1

