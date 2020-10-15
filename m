Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2841928F541
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbgJOOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389236AbgJOOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C7C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n6so3800236wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJCHZKXsHWszxVFgajcRhNjk7Pew+OgbybugT6SAaH8=;
        b=buQmkRQXYnjLO/57VA7Rg89FldWSQ3Z9OaT6tdZt4NLT2sNCGk3APRfnEL4k+N1Hoz
         FJpHMGbpwZsizItXmrRBAt0Kp5kVWPyrxhgAPAW72lgboUozcDXlZBtaWJZtjsmk0EFV
         KWKXHqo2Bhl+HDWxJ6CKJCh8kiKgva8gBzvfTvoUBGn1sxFfluTqPvWfHYDbmYpupJ9D
         /JzLB85g2YRXuiLYRM7qd+QOa0oLDofU9jm66mFXhMyqKpf8vaXggVsdGx+zW+PYr1BA
         VAFl/CXw45CUD9fLsWfAItV/OL6U5jUKm2yXdkoSB6OVR4WipWpOWSMtwavRHeoRuCq8
         hLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IJCHZKXsHWszxVFgajcRhNjk7Pew+OgbybugT6SAaH8=;
        b=n4XZWjf+3BJfc01JG2mkUSBeYFV6OnM96sMSlpMo1RNddwGvfEOT34vbnHu8XrXBnm
         XwdkDGXA8Fthfj2VsGJX32vx7dvtwT4nj+KIEr3RiymOJSw3H4mYhAuPCGAmtdLY4gVz
         XBDXJ9weA0yzWwnewv3Tdei6Ir+o3SZ9KO81d73nQJt6VTuaPPM6JzbxkV2i5Q/GuJsm
         zGuiVEfzTmtHYcUfR/LA7hHe+GBl0So5cj8S2M+JGBDvgBOzcJaX6ibWt7IO/VVp6Xq9
         POn01pWhgzcR7iZiMxsfYsgb+TWLnUsN9Q8/EouA5t9Rswgwd+dUglAnBZFvW0U0glhT
         YhAQ==
X-Gm-Message-State: AOAM531cEMAEiOcPHJN0i8lLekbpDSjqa8fymwLf9BhlkaooW0R2hm1F
        7xGrMXPKrVtDqEnbO6lw/vmaMA==
X-Google-Smtp-Source: ABdhPJz/ooIkeAhnSinOcptGIPhBZ65aKHuqHjWQ5jB7B/NBNfVjx6lwwtS/Qi3PUeBU0ssazF4deg==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr5191439wrr.57.1602773472176;
        Thu, 15 Oct 2020 07:51:12 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:11 -0700 (PDT)
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
Subject: [PATCH v1 8/8] perf c2c: Update documentation for display option 'llc'
Date:   Thu, 15 Oct 2020 15:50:41 +0100
Message-Id: <20201015145041.10953-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new display option 'llc' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-c2c.txt | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index c81d72e3eecf..eadce62ecd28 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,8 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or LLC load access (llc) to display
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
 
+  LLC Hit Pct (For display 'llc')
+  - cacheline percentage of all LLC load accesses
+
+  LLC Hit Total (For display 'llc')
+  - sum of all LLC load accesses
+
   Total records
   - sum of all cachelines accesses
 
@@ -207,9 +214,12 @@ For each cacheline in the 1) list we display following data:
 
 For each offset in the 2) list we display following data:
 
-  HITM - Rmt, Lcl
+  HITM - Rmt, Lcl (For display with HITM types)
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  LLC LD - LclHit, LclHitm (For display 'llc')
+  - % of LLC hits and LLC HITMs accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss
   - % of store accesses that hit/missed L1 for given offset within cacheline
 
-- 
2.17.1

