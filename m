Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD22CECDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgLDLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:15:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgLDLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:15:43 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnVTh1qgxz15XYj;
        Fri,  4 Dec 2020 19:14:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 19:14:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <irogers@google.com>
CC:     <qiangqing.zhang@nxp.com>, <kjain@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <kan.liang@linux.intel.com>, <kim.phillips@amd.com>,
        <ak@linux.intel.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v6 03/10] perf pmu: Add pmu_id()
Date:   Fri, 4 Dec 2020 19:10:09 +0800
Message-ID: <1607080216-36968-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
References: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to read the PMU id sysfs entry. This is only done for uncore
PMUs where this would possibly be relevant.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/pmu.c | 18 ++++++++++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d41caeb35cf6..cbeda45ce578 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -597,6 +597,7 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
+#define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
 #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 
@@ -635,6 +636,21 @@ static bool pmu_is_uncore(const char *name)
 	return file_available(path);
 }
 
+static char *pmu_id(const char *name)
+{
+	char path[PATH_MAX], *str;
+	size_t len;
+
+	snprintf(path, PATH_MAX, SYS_TEMPLATE_ID, name);
+
+	if (sysfs__read_str(path, &str, &len) < 0)
+		return NULL;
+
+	str[len - 1] = 0; /* remove line feed */
+
+	return str;
+}
+
 /*
  *  PMU CORE devices have different name other than cpu in sysfs on some
  *  platforms.
@@ -847,6 +863,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	if (pmu->is_uncore)
+		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a64e9c9ce731..d4366e8e79df 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,6 +30,7 @@ struct perf_pmu_caps {
 
 struct perf_pmu {
 	char *name;
+	char *id;
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
-- 
2.26.2

