Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80E1C8DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgEGOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgEGOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:43 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC3C05BD0E
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c89so6010749qva.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lii6SAG4KfbOzXrghsoca6pr8ezjGocIYdgnUdeujGY=;
        b=qZAaEQ0B7ZKKRekZmPn1LciqER6cK0FdLI07SFwGKi32uXdy0GDYlLEQkvDaL6za2g
         MVkWPwq3W93NKTe383xsJrKUy4S0SGHq4L5Taa/Kxp5eqzPZd+9NMYZzirQHfh5w1ssk
         gY1Yv2iOqJZEwK8qSFvn+eZFX33GSIJW5oY/mdxGThuNNqqZGxDGccLYm98DgvVqpXxt
         a20N4yddyP2j56jC/s6n4aCEjuJZwOjgmFp/5UZFf4/bDQ81J1LPNtdQ+yO3w8TJqPDo
         Zc7Sy2v/G34o78OcydgMNYSBunwaRxUmn9dvGXa9SIj9+bn90Us5OMYSnoS3OmjtWn0b
         RxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lii6SAG4KfbOzXrghsoca6pr8ezjGocIYdgnUdeujGY=;
        b=lX5cCyOAOu/ddQlPUYcZXXgfijSB5XjHf1ltex/Wpq8LFZx6iw9FrhenAKqqev+uou
         dENCUjiIqdsma4eic4DVRz+JNVN+6btBAQ00xcHZlcNIefyN4GGGwcpqyKxuTqBQQ5CC
         DIZWi5dqmahtrgcVcK0QnuGySbRXFBMjbBLypqgxMVqC5dwO0nmaHGMFMjLQLZxMeZyP
         QIEWpnMrVm7syTPBRMUlMgK1rVO/48qWcQGpPLatTdmwc/zC3entArw3XiS6DSPMXsRF
         kvSW/W6iRZ/D9YjD9bRk+5mnzVdLjyKhGjGOgy/z5q+iwqYiaPy4EhbfoYubUopJh/sy
         rRwg==
X-Gm-Message-State: AGi0PuZcJP1wykLXr3pcZQfu5c1riT+wmIu2rNS/FS4qA6QfThMNa0up
        8b+/srKQjuCS+Dd3bJNTZ74negJjonOn
X-Google-Smtp-Source: APiQypIY0kCsvfpin5LZk6xK7RrJNO7Kujz8GfhLqsOKqrxQPJpE2Djp5sf8iXMO41PJaTao6Z3BVbB1VyqE
X-Received: by 2002:ad4:548b:: with SMTP id q11mr13389332qvy.129.1588860521331;
 Thu, 07 May 2020 07:08:41 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:05 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-10-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 09/23] perf metrics: fix parse errors in power9 metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        "Paul A . Clarke" <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mismatched parentheses.

Fixes: 7f3cf5ac7743 (perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 811c2a8c1c9e..f427436f2c0a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -362,7 +362,7 @@
     },
     {
         "BriefDescription": "Completion stall for other reasons",
-        "MetricExpr": "PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
+        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "other_stall_cpi"
     },
-- 
2.26.2.526.g744177e7f7-goog

