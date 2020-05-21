Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE41DCE14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgEUNdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:33:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729362AbgEUNdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D1B0F323A3BCFC162EF6;
        Thu, 21 May 2020 21:33:08 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 21:32:58 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Bin <huawei.libin@huawei.com>,
        "Xie XiuQi" <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH 4/4] perf util: Fix potential segment fault in put_tracepoints_path
Date:   Thu, 21 May 2020 21:32:18 +0800
Message-ID: <20200521133218.30150-5-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521133218.30150-1-liwei391@huawei.com>
References: <20200521133218.30150-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Bin <huawei.libin@huawei.com>

This patch fix potential segment fault triggerd in put_tracepoints_path
when the address of the local variable 'path' be freed in error path
of record_saved_cmdline.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 086e98ff42a3..0e5c4786f296 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -428,7 +428,7 @@ get_tracepoints_path(struct list_head *pattrs)
 		if (!ppath->next) {
 error:
 			pr_debug("No memory to alloc tracepoints list\n");
-			put_tracepoints_path(&path);
+			put_tracepoints_path(path.next);
 			return NULL;
 		}
 next:
-- 
2.17.1

