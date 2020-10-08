Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8128725F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgJHKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729292AbgJHKTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A784AF33979FBDE97AD;
        Thu,  8 Oct 2020 18:19:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:18:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <james.clark@arm.com>,
        <linux-imx@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v4 01/13] perf jevents: Add support for an extra directory level
Date:   Thu, 8 Oct 2020 18:15:09 +0800
Message-ID: <1602152121-240367-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
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
sub-directories in future.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fc9c158bfa13..6ab96c8dbc27 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -981,15 +981,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
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
@@ -1002,13 +1007,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
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

