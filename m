Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01C25B0A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgIBQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbgIBQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:06:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082G2BDx155867;
        Wed, 2 Sep 2020 12:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hPwyMlvvmBwMzPPXtaOo1sxMfBSLRdWeG1Pej1RHa9Q=;
 b=J9396tZUf/NSHsGeRXrsyR61pBmSWXLoUAPhYbfOx3Lgw24qAYIgVym8o2ppFps9rFI+
 37d+tqe/3KqGnKlLJQHZ2drmwSw0Ey1x4vO9ftySXHKYFnZ5pjR5lHdyaFrQvrWAPZsu
 mMUO6yytKLOYx7CerNT9giq4tsBPB2YBM5oEQ2H/zqBfqwyARoIdM7LRtpLE9exs3dLS
 1zEl9WzzeQjzmhYL9M0V/DqYFc3SLAv5cq3jRtGEnuTUyOu5JY9mFixv14/r4YObc4Rn
 D59GCLqcl2ZWA08alQffkWWo3dBN8ZK9PRzT/BtTdfoJjNRXH/046ewry2TGmkd1vbsS FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ae918qk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:50 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082G2g3L159837;
        Wed, 2 Sep 2020 12:05:50 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ae918qj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:49 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082G3TMK013582;
        Wed, 2 Sep 2020 16:05:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8cw2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 16:05:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082G5jxG6684966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 16:05:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5084CA4059;
        Wed,  2 Sep 2020 16:05:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DFB5A404D;
        Wed,  2 Sep 2020 16:05:40 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.83.99])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 16:05:39 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v7 4/5] perf/tools: Pass pmu_event structure as a parameter for arch_get_runtimeparam
Date:   Wed,  2 Sep 2020 21:34:38 +0530
Message-Id: <20200902160439.335232-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902160439.335232-1-kjain@linux.ibm.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=1 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds passing of  pmu_event as a parameter in function
'arch_get_runtimeparam' which can be used to get details like
if the event is percore/perchip.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/header.c | 7 +++++--
 tools/perf/util/metricgroup.c         | 5 ++---
 tools/perf/util/metricgroup.h         | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 1a950171a66f..58b2d610aadb 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -40,8 +40,11 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 	return bufp;
 }
 
-int arch_get_runtimeparam(void)
+int arch_get_runtimeparam(struct pmu_event *pe)
 {
 	int count;
-	return sysfs__read_int("/devices/hv_24x7/interface/sockets", &count) < 0 ? 1 : count;
+	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
+
+	atoi(pe->aggr_mode) == PerChip ? strcat(path, "sockets") : strcat(path, "coresperchip");
+	return sysfs__read_int(path, &count) < 0 ? 1 : count;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..c387aa1615ba 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -15,7 +15,6 @@
 #include "rblist.h"
 #include <string.h>
 #include <errno.h>
-#include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
@@ -634,7 +633,7 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
-int __weak arch_get_runtimeparam(void)
+int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
 {
 	return 1;
 }
@@ -902,7 +901,7 @@ static int add_metric(struct list_head *metric_list,
 	} else {
 		int j, count;
 
-		count = arch_get_runtimeparam();
+		count = arch_get_runtimeparam(pe);
 
 		/* This loop is added to create multiple
 		 * events depend on count value and add
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 62623a39cbec..491a5d78252d 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdbool.h>
+#include "pmu-events/pmu-events.h"
 
 struct evsel;
 struct evlist;
@@ -52,6 +53,6 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
-int arch_get_runtimeparam(void);
+int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
 #endif
-- 
2.26.2

