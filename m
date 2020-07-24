Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6422BEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGXHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 03:13:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbgGXHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:13:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E2D676F3B3753092A76;
        Fri, 24 Jul 2020 15:13:19 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 15:13:12 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>
Subject: [PATCH v2 2/2] perf tools: ARM SPE code cleanup
Date:   Fri, 24 Jul 2020 15:11:11 +0800
Message-ID: <20200724071111.35593-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724071111.35593-1-liwei391@huawei.com>
References: <20200724071111.35593-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Firstly, the function auxtrace_record__init() will be invoked only
  once, the variable "arm_spe_pmus" will not be used afterwards, thus
  we don't need to check "arm_spe_pmus" is NULL or not;
- Another reason is, even though SPE is micro-architecture dependent,
  but so far it only supports "statistical-profiling-extension-v1" and
  we have no chance to use multiple SPE's PMU events in Perf command.

So remove the useless check code to make it clear.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 28a5d0c18b1d..b187bddbd01a 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -57,17 +57,15 @@ struct auxtrace_record
 	struct evsel *evsel;
 	bool found_etm = false;
 	struct perf_pmu *found_spe = NULL;
-	static struct perf_pmu **arm_spe_pmus = NULL;
-	static int nr_spes = 0;
+	struct perf_pmu **arm_spe_pmus = NULL;
+	int nr_spes = 0;
 	int i = 0;
 
 	if (!evlist)
 		return NULL;
 
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
-
-	if (!arm_spe_pmus)
-		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
+	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cs_etm_pmu &&
@@ -84,6 +82,7 @@ struct auxtrace_record
 			}
 		}
 	}
+	free(arm_spe_pmus);
 
 	if (found_etm && found_spe) {
 		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
-- 
2.17.1

