Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7B1B3955
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDVHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgDVHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1E3C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8so1455280ybj.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CjOY3OR4Eg2cZhLekBFlbGnlcNOd+9MA/W+6Zj4hY7M=;
        b=JunoKl5avalIOytg1bX1V52nSerTcdXS5n3UJeSimItSccJgo/0SvReaamTLKYuoqR
         FGYoKJAyTPIKBVhJHAzem/dM2Lfx8p1behbhbeanvHQK+byRcVUkdTlO1KFnhEojPVmc
         jqYU0a5bucRedEZXXyBAE2aG3WgU0T3+bu168rJF7J8PO8ttrxfGDfQLhZb5Abm9BbQa
         hfovFBQmcgropEUXvJkN6OoYr0fh3ohvY+DyFp+UNrwLtTgGDPNQtSvmOLsnDeUN9lWj
         CQC+yq9+WKiU0VHh4d8KZUJhavByL2RiYfhpxCIm/Ja60kWsceq7G9Qk89pwOGLAS8Iz
         Xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CjOY3OR4Eg2cZhLekBFlbGnlcNOd+9MA/W+6Zj4hY7M=;
        b=udDs5Z56TycL/fLO7Q/kTIC2BlEejaHi/73bSAyLVQgfUjb+tTWsFm7AlrUBSYfDlR
         PK7hq9zQLQ9KgSowd0+nNn/7j1rLY4JWNqzuSJeGeCS0Bl8che915pa+tvSWIfGrD9Wi
         WZ9KJaWqtGwViWbxDX7EwpB1bgMw2RtcYS1U/couUSOAVUgJNG7S2PUk4LgU4vRTXn1L
         NNo1aWv4HQiG37vsKy0n+J9CXPx3xXCMlrA/aUWQBOQTQwF6hetztWD3KepqSyX695iB
         3O1Iu3ZLukNtQeZuuK+R0aPPrJacgc18S/P3h4aDBA7TU85DLlRFCnfTqBp+I+bDxiYY
         fa3Q==
X-Gm-Message-State: AGi0PuaFCP4+fnF98OnidtntvpRuZVTHwJzKLw7MNPZvVPU1A+UVOsh6
        NoT2FKo8WE7WDroqwmeA2cOcoybdgvct
X-Google-Smtp-Source: APiQypLGcv5WRD+bm1D/ageySbQxDmbXZ6Xp/TqiuN8Zp1SPBjn071Ae4gGGi6J7X52yWyZ22ZbVt+7w7CyA
X-Received: by 2002:a25:ba81:: with SMTP id s1mr34482421ybg.114.1587541700921;
 Wed, 22 Apr 2020 00:48:20 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:04 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-4-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 3/8] perf metrics: fix parse errors in skylake metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove over escaping with \\.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index b4f91137f40c..390bdab1be9d 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -328,13 +328,13 @@
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x35\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x36\\,umask\\=0x21\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
-- 
2.26.2.303.gf8c07b1a785-goog

