Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65327FEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgJAMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:01:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731816AbgJAMBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:01:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0F4AFDFF130EFB85FEA;
        Thu,  1 Oct 2020 20:00:56 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.149) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 1 Oct 2020 20:00:46 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Alexey Budankov" <alexey.budankov@linux.intel.com>
Subject: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Date:   Fri, 2 Oct 2020 00:57:29 +1300
Message-ID: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7736627b865d ("perf stat: Use affinity for closing file
descriptors") will use FD(evsel, cpu, thread) to read and write
file descriptors xyarray. For a kernel PMU event, this leads to
serious memory corruption and perf crash.
I have seen evlist->core.cpus->nr is 1 while evsel has cpus->nr
with the total number of CPUs. so xyarray which is allocated by
evlist->core.cpus->nr will get overflow. This leads to various
segmentation faults in perf tool for kernel PMU events, eg:
./perf stat -e bus_cycles  sleep 1
*** Error in `./perf': free(): invalid next size (fast): 0x00000000401e6370 ***
Aborted (core dumped)

Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 tools/perf/util/evlist.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c0768c6..3022152 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1226,10 +1226,14 @@ void evlist__close(struct evlist *evlist)
 	int cpu, i;
 
 	/*
-	 * With perf record core.cpus is usually NULL.
+	 * With perf record core.cpus is usually NULL;
+	 * For Kernel PMU event x, "perf stat -e x" will set evlist->core.cpus->nr to
+	 * 1 while evsel has cpus->nr which contains all CPUs. evsel__cpu_iter_skip()
+	 * will be false, memory corruption will happen if we use affinity to close
+	 * file descriptors;
 	 * Use the old method to handle this for now.
 	 */
-	if (!evlist->core.cpus) {
+	if (!evlist->core.cpus || evlist->core.cpus->nr == 1) {
 		evlist__for_each_entry_reverse(evlist, evsel)
 			evsel__close(evsel);
 		return;
-- 
2.7.4

