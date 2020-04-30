Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7B1BF1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD3Hvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgD3Hvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFBC08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m138so6769716ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9wYxdKZj/jWS2uBsJWtPB4xs5KgCG01/7TEpkkXSh6Q=;
        b=CfW2yPPqFlKlE8tNQ90LheC3WniA7GjbO3jppC94+w4rPqc16oL4A2w8u420I+TjTK
         Pi2BOV9+/eY2pE2LaLc7iLOBbAH6MHG9qFyfQRetamPnGptpu655+nJclAkHU9SUUiyG
         jJeld+kjNHAcmdSzlFd2tjeL2PqAAGBYFYeyUPx92z+zjVy+LAfbB5IYka6OL7ez7kMl
         Ub9Ih5gfrsgyLmc/1XYWiQD3enYUXTC8foOkvA0qRUt29aoC3ogQQX0Q1oSgmrgvC3nP
         U1tIKQ6tr90kLIAkuzpbk8+8XgXSMBawqos0lbgCctcDPRk3P/7mUkciVVYDz1I4/FRd
         2FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9wYxdKZj/jWS2uBsJWtPB4xs5KgCG01/7TEpkkXSh6Q=;
        b=CIEtretcXjJk4CLx5y/Y8g1j/cJs5Eg0zVSP6Xn8kUj6+mOZ0hEo+okmLwvyc73v7J
         NxM7skJMOFLYsaXmJJwIHRSwx5FDcomFl8deI5C3HIQx2z5tF4tMYmb0rt905HjPqXW4
         6Lh0gGS64ZvXCyrO+vB7b9rwmDKh1Bs81eGXUPMddSLd2wyGl/B8mBgVv8jzjePwGM7T
         1fgny/C597AxHPwa5pRRECGNu8ZN5ZmZ7sgkmmgFDFX0ehLP6QQdlbNWwU0PXnWi1HL6
         Oiq/vIZvlj0mUUH/dvY8gomXhUlX1pSmj8Xav9Cw8ot+5kpvjGWTb50asXOfsdIoAMGX
         TQOg==
X-Gm-Message-State: AGi0Pua7xf6AqxmbNlhX9mhFM8qFTh0MZZTssAofeIdFFpL7Jm7M7/pF
        7y77jDYIVLjAWtwmsvMb34pqWvlIcXPQ
X-Google-Smtp-Source: APiQypJk0FPv6cPNuYtm2arTwq8BSJ0htCtxguNICztIwKep6/sEnBqU+ZpIl7KL740sTaYuJdFwTAPFdACv
X-Received: by 2002:a5b:48f:: with SMTP id n15mr3706762ybp.507.1588233111163;
 Thu, 30 Apr 2020 00:51:51 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:34 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-3-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 02/12] perf metrics: fix parse errors in cascade lake metrics
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
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove over escaping with \\.
Remove extraneous if 1 if 0 == 1 else 0 else 0.

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 7fde0d2943cd..d25eebce34c9 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -328,31 +328,31 @@
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
     {
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
-        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Write_BW"
     },
-- 
2.26.2.303.gf8c07b1a785-goog

