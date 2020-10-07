Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A41285A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgJGIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgJGINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:13:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497AEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:13:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id x5so663497pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0/rPY7WLJxFq++CdjdK9ATDolLJAaU6jqP2p2nJ/2E=;
        b=RsWlB2kEZJdh066mfhAfNImRgrEK7IbchQBG6JkzAACwvBxYo5zGp8mrOnP2NUWBNe
         KrIuwWURHDOh49SvSAo6ie9YmurLEcmyW3a799ohQPejmmD1U4mhwPL27wUK3Z7uPv6M
         JdzCXyo/CEijQ/cc7yReH90lLe00YMTV0Q8bQD+0RKhLD09kdoMch1Fcrm+IjIezuf3k
         ZONPOLN7PvT6M0qIqwsk1Q5MtBURNqcU/aio60DKzuDwxJYJUyO6AA6X0Cte2ZtI8g6g
         P2sLxx6QEoasH5c2kclUqL2B5iVciTRln8q3C4OKyqjD3S31Zh7h1bKFhXbPmwUifYIg
         aYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=A0/rPY7WLJxFq++CdjdK9ATDolLJAaU6jqP2p2nJ/2E=;
        b=JnwPXPI7MegafWAM2EURm6KnsIwvL+uCeXlKfjhwe7HcPkZCc9AnQWDIT/eyg4ixAD
         ADvCYxT9/Bd5vY53pAeT9rYkGuuKpJJhGsEpX0hdO4WQtxq7ktq+/QGKqWOS1yfdnEZh
         AgZ1V0Pfxf63cXXDUoJGZ6FZC/igP/9yoI3yoTxsgmtvQQX9Bh1HWhio/U8RenIrKIGV
         lqWQawdP0DNZVoO5bXEIORotVc0Ly4htAS9/9HHjda1EYfenYuSjeuloiBJeEVilDisY
         eVOUPfUK/yiK7WWUZch5ykFdfmtY4ou+C3lAHLE4Gk9MbJGgsIWW2eFHdRhz0cJ72gi7
         WhaQ==
X-Gm-Message-State: AOAM532mnPKuH08EgQwu5mXswPZ7ccY7Oy2ocrMUtpT9U8IxBj14F2pP
        +FHf9fGHzsxIGIbU4lkyQAQ=
X-Google-Smtp-Source: ABdhPJwC5WPLRYSaxF2/E8PYtbltzSIRiCB4ZuGHas3RhxFsVApRkS/9mjJLovGKmuonz2WWGvdpTA==
X-Received: by 2002:a17:902:ab88:b029:d3:b2d3:5708 with SMTP id f8-20020a170902ab88b02900d3b2d35708mr1798115plr.70.1602058403589;
        Wed, 07 Oct 2020 01:13:23 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([106.102.129.249])
        by smtp.gmail.com with ESMTPSA id n8sm1911329pff.188.2020.10.07.01.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:13:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Wei Li <liwei391@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] perf stat: Fix segfault on armv8_pmu events
Date:   Wed,  7 Oct 2020 17:13:11 +0900
Message-Id: <20201007081311.1831003-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that perf stat crashed when using with armv8_pmu (cpu)
events with the task mode.  As perf stat uses an empty cpu map for
task mode but armv8_pmu has its own cpu mask, it confused which map
should use when accessing file descriptors and caused segfaults:

  (gdb) bt
  #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
      cpu=<optimized out>) at evsel.c:122
  #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
  #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
  #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
      argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
      at builtin-stat.c:929
  #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
      argc=1) at builtin-stat.c:947
  #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
  #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
      argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
  #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
      argv=argv@entry=0xfffffaea2f90) at perf.c:364
  #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
      argv=<synthetic pointer>) at perf.c:408
  #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538

To fix this, I simply used the given cpu map unless the evsel actually
is not a system-wide event (like uncore events).

Reported-by: Wei Li <liwei391@huawei.com>
Tested-by: Barry Song <song.bao.hua@hisilicon.com>
Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 2208444ecb44..cfcdbd7be066 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	if (!evsel->own_cpus || evlist->has_user_cpus) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->cpus);
+	} else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
-- 
2.28.0.806.g8561365e88-goog

