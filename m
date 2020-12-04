Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E022CECDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgLDLPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:15:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8656 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgLDLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:15:44 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnVTh1PrGz15XYf;
        Fri,  4 Dec 2020 19:14:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 19:14:24 +0800
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
Subject: [PATCH v6 01/10] perf jevents: Add support for an extra directory level
Date:   Fri, 4 Dec 2020 19:10:07 +0800
Message-ID: <1607080216-36968-2-git-send-email-john.garry@huawei.com>
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

Currently only upto a level 2 directory is supported, in form
vendor/platform.

Add support for a further level, to support vendor/platform
sub-directories in future, which will be vendor/platform/cpu
and vendor/platform/sys.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 72cfa3b5046d..9022216b1253 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -978,15 +978,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	int level   = ftwbuf->level;
 	int err = 0;
 
-	if (level == 2 && is_dir) {
+	if (level >= 2 && is_dir) {
+		int count = 0;
 		/*
 		 * For level 2 directory, bname will include parent name,
 		 * like vendor/platform. So search back from platform dir
 		 * to find this.
+		 * Something similar for level 3 directory, but we're a PMU
+		 * category folder, like vendor/platform/cpu.
 		 */
 		bname = (char *) fpath + ftwbuf->base - 2;
 		for (;;) {
 			if (*bname == '/')
+				count++;
+			if (count == level - 1)
 				break;
 			bname--;
 		}
@@ -999,13 +1004,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 		 level, sb->st_size, bname, fpath);
 
 	/* base dir or too deep */
-	if (level == 0 || level > 3)
+	if (level == 0 || level > 4)
 		return 0;
 
 
 	/* model directory, reset topic */
 	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
-	    (level == 2 && is_dir)) {
+	    (level >= 2 && is_dir && is_leaf_dir(fpath))) {
 		if (close_table)
 			print_events_table_suffix(eventsfp);
 
-- 
2.26.2

