Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE725F359
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 08:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgIGGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 02:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgIGGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:43:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0876WGjd195677;
        Mon, 7 Sep 2020 02:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hPwyMlvvmBwMzPPXtaOo1sxMfBSLRdWeG1Pej1RHa9Q=;
 b=ZmTw1UCFvsXc3Gn4RphjnS58HjUb7dtBZp4+KyHdR04vFjR63xjaVzJaOiNg11K1CA4Q
 3MBjFMwmqbrc6Gu1VPK9aC4vru/gqn648kLZFNoij0xTXEWdQeBvOFbRLgf2q2gqxbVo
 lrM0NViBtUrPsgZUJfsZP0IyDYzzIz2V07m+xF8siGdydLT0b4HUbLiC8B/HIhPvApLB
 U9fdbJDdFhiTC3Z6WCQ2hkxWp1jdaiDbyTolxKTOZf+lu7ASy3ecr78eHCh2iavxCZ8X
 dhrNsWYIyMTuC+PkFMHzi1+PRo8ZFXLeuYiudHo8cL9qk98KZgphkFUxvwKkdPCP96g/ pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dey1heup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:42:12 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0876XhRA003178;
        Mon, 7 Sep 2020 02:42:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dey1heu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:42:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0876bkMp011844;
        Mon, 7 Sep 2020 06:42:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 33c2a821d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 06:42:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0876g7pa25100784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 06:42:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 675B1A405B;
        Mon,  7 Sep 2020 06:42:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B12A4057;
        Mon,  7 Sep 2020 06:42:02 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.49.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 06:42:02 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v9 4/5] perf/tools: Pass pmu_event structure as a parameter for arch_get_runtimeparam
Date:   Mon,  7 Sep 2020 12:11:32 +0530
Message-Id: <20200907064133.75090-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907064133.75090-1-kjain@linux.ibm.com>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_01:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=1 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009070061
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

