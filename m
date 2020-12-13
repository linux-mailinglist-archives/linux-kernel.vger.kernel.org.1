Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912B2D8D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406973AbgLMNmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406913AbgLMNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292EC061285
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t16so13743551wra.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4erpRO0ygNjVYCei/Kv9eK113kFOnsdzeMpjmkpAKE=;
        b=aT5Fx168Sua16ijBHm90HWFqR2otDAhRId91K3uD20DF2Gt9vfmLGceOzEsJ4dXE+5
         oTb+jREF3Hhk0ec99mz3GxkO6EimRC2vVqcgRZFF/7li+L7pZaQi3dv5DkZvAQ9to3N5
         sJfHyb3k0ta2JipbzT/ujQWjg/FP5AOsAYdIswafSTTORODmuRjvp5r3IssEpjnNidIU
         qjxdCSPfgvZGAHwHq4FQGyZI0Y+rivl8a/5HOqfW/r/naIhz09dChbNphNxniFKLpqoe
         JXdh1IxhOPkUQTzP5hwWPz3n0qrrClpnFffK7KR/OPJFs+roaWuRe8ICgFkfkJehBjym
         dQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4erpRO0ygNjVYCei/Kv9eK113kFOnsdzeMpjmkpAKE=;
        b=TUFettOJXMFLlfermaf9/0CF+R+t2Tt/dOp4pvpULPlwHcfXBNl9IYremvwYuWPayv
         GEVQHA25/LmlZ2VB7+X6sKWTCMsLL2FPYDdog2ekOsGxYCvs1zvhCqlAhUw6CyXJVxqo
         DBQN/0QHFFiu/78w32qhPs63R9bqiSJgeJGB58bApem8GL4fnFX9nMV8fGkQzvk58sm1
         rQxUXgkRcK4vNgOqPikIblO3LjimXqiSSivU8+t4q1RGuppaHIIFJRMaVDZJfF2J0ZhH
         gvEnjqlAjArsvYqAXLErf0gZA7ZIGu8XV7OwJiuiHQ9RValeX1385zbPSKy8kpbQybPL
         7lug==
X-Gm-Message-State: AOAM5325fvOmGFYrDOuTI5LweLJGLEegoE/JI5YKTvr31EXnkkuFY5oV
        FyJkUXj6dvIlzKDmWcwPhKOCNA==
X-Google-Smtp-Source: ABdhPJys6CSja5SJWXWrYSHKKabq4FSziRTiu4A6HQMntw0Nx1kW//AmBBgwar1oU7JBiZX4llHwTg==
X-Received: by 2002:a5d:4d02:: with SMTP id z2mr24738698wrt.109.1607866754886;
        Sun, 13 Dec 2020 05:39:14 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:13 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 11/11] perf c2c: Update documentation for display option 'all'
Date:   Sun, 13 Dec 2020 13:38:50 +0000
Message-Id: <20201213133850.10070-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new display option 'all' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-c2c.txt | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index c81d72e3eecf..da49c3d26316 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,8 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or all load cache hit (all) to display
+	and sort on. Total HITMs as default.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
@@ -174,12 +175,18 @@ For each cacheline in the 1) list we display following data:
   Cacheline
   - cacheline address (hex number)
 
-  Rmt/Lcl Hitm
+  Rmt/Lcl Hitm (For display with HITM types)
   - cacheline percentage of all Remote/Local HITM accesses
 
-  LLC Load Hitm - Total, LclHitm, RmtHitm
+  LLC Load Hitm - Total, LclHitm, RmtHitm (For display with HITM types)
   - count of Total/Local/Remote load HITMs
 
+  LD Hit Pct (For display 'all')
+  - cacheline percentage of all load hit accesses
+
+  LD Hit Total (For display 'all')
+  - sum of all load hit accesses
+
   Total records
   - sum of all cachelines accesses
 
@@ -207,9 +214,12 @@ For each cacheline in the 1) list we display following data:
 
 For each offset in the 2) list we display following data:
 
-  HITM - Rmt, Lcl
+  HITM - Rmt, Lcl (For display with HITM types)
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Load Refs - Hit, Miss (For display 'all')
+  - % of load accesses that hit/missed cache for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss
   - % of store accesses that hit/missed L1 for given offset within cacheline
 
@@ -249,7 +259,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (For display with HITM types)
+      Node{cpus %loads %stores} (For display with "all")
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.17.1

