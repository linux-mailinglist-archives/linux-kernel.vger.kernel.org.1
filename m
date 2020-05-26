Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD31C1BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgEAReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729807AbgEARdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201BBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y73so12912456ybe.22
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=cr8Q2UQm9Y1sHTsGcnZ9c1YBt5RmFHyx38WBHWc0yPruZgsiv1dKNzMdN9U3iSQP8p
         xN8wl38PVn+kSesh1RzRXrfX71OBoCGNp3xDQNGDqIx/iPc9syKXiyghfCzGbkCNdoFr
         UY0EuhwozvmHgEiZGwEZrtGaEYaSFVQJ+DBDQdWzskFHLh2nqjyNaw0JddoGjxBMeNv3
         wM/JKSi9Ylcgc2Z9frpp6w7Mi2CbmGSbsEmZVte9+pa4WizsNJe5T34wskZJJFsAYH/p
         fGofY7NbMUoYmChRs3iuoFU/ju2F96tqq3rmaLPLO3RSMGKZZywtuSXIJEcGo1lL0fWA
         qdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=MB3Euxld2iEwEOZkq66BDWZKGUlYLn0saU0K6P42nusVG0xwtB4TPHKyoDfcFYauOW
         9LnGnSxLe7Wz04CjR9ArrOKA74lzRp32p02B22i3Q+u4ki39aq4ECPOruMwi9ySmjzcD
         rE/Dumql/52bhFvTJRNDiFcynjGx8UhFWTC7W5tLl/AGSf9w2tDfFD72mgk2xcqUCRwz
         k2KSLvXZyPGdts+9CgzS4rOYrtIvDxVK3+Ayoj0jYvKwkk34Ll2DywvEhds1wm3xX4Pn
         TjpX37jr15ZPrab9ElCUI3kPzYSy5dmacP8IjMDccH3XEoZudPMBNiBAHOdzQ/qHb36l
         UZKQ==
X-Gm-Message-State: AGi0Pub1qvDFMZIpFbHMkFGkZgXF4pjIdGZYYBxtILwSva/BbBLMP6YQ
        RFUExHcG6XbquMXw2yd2EIp1V09ZEU3G
X-Google-Smtp-Source: APiQypL+yOApOWdJ9AZ+SBKLU/ZrzM3seiilyrGEn9HMYRmkpsieN4BKlxhRm7UIF7BvqZyh+Hrumx39eQJz
X-Received: by 2002:a25:44c5:: with SMTP id r188mr7882881yba.514.1588354422213;
 Fri, 01 May 2020 10:33:42 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:24 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-4-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 03/12] perf metrics: fix parse errors in skylake metrics
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

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
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
2.26.2.526.g744177e7f7-goog

