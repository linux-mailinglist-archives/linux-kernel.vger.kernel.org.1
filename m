Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682ED28F523
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbgJOOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389095AbgJOOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B284C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j136so3978357wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkNY6AY8K4id4Wf/fyiZLH1PB9dlTQ62yuu0aNCwycE=;
        b=lDNr0vuSCN8gQAAkyGjPpEm6i5Fj2i2Cf32Q5kuX5c48liRlACD2w7GZQxk0v5/nh0
         8A+1TPptZiAIMcp5oDzA4zxPXl/YP4RhOgSygJRdWJjCwKMAQdpOpfszXVmqfTqZdRwU
         nUieH/CcKM1Q78r4ZF4Kyf9UUAlN/SBKtMzLI4Ir9sOaAbttLOEtAc+Q95ZaKw7ql8eg
         3BlpCg45pOk1N1ATrODyR89XSdJicWwzcTEnmbv07wunP7bpT24ZzBcPRSX5Xp87yBK2
         XpqbGPJrnXK7YljXpta1OtRRtelrtOAPdie7ci6kVuJhvDlNNJ1ZPHR37y7c7X7eTPSl
         A3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkNY6AY8K4id4Wf/fyiZLH1PB9dlTQ62yuu0aNCwycE=;
        b=jwncFKM3bDGSJFHQrWBVueQ0MMPuWrko1iPvfzUrnz686tOulcEtiiy8YXluyJEpJN
         /T7GQhTgFkvNeyFhA9mpZ+BlhFUomivqQxVoAgyIhzH2CDk0Cn/GKTYcBuLU2sWUP6pm
         Jig/CQzdNO6ut94qzXLegMhmOG39lNLfq3k6NG3556tsYJeAirVJsuTz5vSj8/XfV43J
         8wur/7nKwEgr2kWcYwUw9dembdW7sL1/qQ1mnUyTb5sdDAzb2ETH7qABf1x08RA6kkEE
         Njt+qG939Qrg/Z9VJDfTzVhOws4/UHjI8ZcQmeN9yGDBK0Dxrd40BaZd1qW9V2/fxtj5
         yUlA==
X-Gm-Message-State: AOAM532Q5vDHqrVtJpSTJFjzPLin1tLjJ8m95nZ7pHiREWaY6l39tHd8
        leF09v9vq6oQC0G7mv0xDePHpg==
X-Google-Smtp-Source: ABdhPJx6GfHPp8E8HJ4yP/P7AsN1lbylcPFfrgEaLPNqTXBKDU1WXKoHphfJmVK3J8iW+uN79UYF0g==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr4668357wmj.25.1602773181343;
        Thu, 15 Oct 2020 07:46:21 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:20 -0700 (PDT)
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
Subject: [PATCH v2 9/9] perf c2c: Update documentation for metrics reorganization
Date:   Thu, 15 Oct 2020 15:45:48 +0100
Message-Id: <20201015144548.18482-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output format for metrics has been reorganized, update documentation
to reflect the changes for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-c2c.txt | 34 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 98efdab5fbd4..c81d72e3eecf 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -174,34 +174,36 @@ For each cacheline in the 1) list we display following data:
   Cacheline
   - cacheline address (hex number)
 
-  Total records
-  - sum of all cachelines accesses
-
   Rmt/Lcl Hitm
   - cacheline percentage of all Remote/Local HITM accesses
 
-  LLC Load Hitm - Total, Lcl, Rmt
+  LLC Load Hitm - Total, LclHitm, RmtHitm
   - count of Total/Local/Remote load HITMs
 
-  Store Reference - Total, L1Hit, L1Miss
-    Total - all store accesses
-    L1Hit - store accesses that hit L1
-    L1Hit - store accesses that missed L1
+  Total records
+  - sum of all cachelines accesses
 
-  Load Dram
-  - count of local and remote DRAM accesses
+  Total loads
+  - sum of all load accesses
 
-  LLC Ld Miss
-  - count of all accesses that missed LLC
+  Total stores
+  - sum of all store accesses
 
-  Total Loads
-  - sum of all load accesses
+  Store Reference - L1Hit, L1Miss
+    L1Hit - store accesses that hit L1
+    L1Miss - store accesses that missed L1
 
   Core Load Hit - FB, L1, L2
   - count of load hits in FB (Fill Buffer), L1 and L2 cache
 
-  LLC Load Hit - Llc, Rmt
-  - count of LLC and Remote load hits
+  LLC Load Hit - LlcHit, LclHitm
+  - count of LLC load accesses, includes LLC hits and LLC HITMs
+
+  RMT Load Hit - RmtHit, RmtHitm
+  - count of remote load accesses, includes remote hits and remote HITMs
+
+  Load Dram - Lcl, Rmt
+  - count of local and remote DRAM accesses
 
 For each offset in the 2) list we display following data:
 
-- 
2.17.1

