Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C151E8E21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgE3GPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 02:15:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgE3GPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:15:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1DD37C3AA285A8AC7D5;
        Sat, 30 May 2020 14:15:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 30 May 2020
 14:15:36 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <bobo.shaobowang@huawei.com>,
        <huawei.libin@huawei.com>, <acme@kernel.org>
Subject: [PATCH] perf/evsel: Fix missing close fd when ignore_missing_thread
Date:   Sat, 30 May 2020 06:15:35 +0000
Message-ID: <20200530061535.36360-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While monitoring a multithread process with pid option, if any of the
threads exit before we open the event fd, we can ignore the missing
thread.

We use perf_evsel__remove_fd() to remove the FD of the missing thread,
but we missed to close these fds. This patch explicitly closes the fd
before remove it.

Fixes: ca8000684ec4 ("perf evsel: Enable ignore_missing_thread for pid option")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 tools/perf/util/evsel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eb880efbce16..cbb04a18839c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1489,9 +1489,13 @@ static void perf_evsel__remove_fd(struct evsel *pos,
 				  int nr_cpus, int nr_threads,
 				  int thread_idx)
 {
-	for (int cpu = 0; cpu < nr_cpus; cpu++)
-		for (int thread = thread_idx; thread < nr_threads - 1; thread++)
+	for (int cpu = 0; cpu < nr_cpus; cpu++) {
+		for (int thread = thread_idx;
+		     thread < nr_threads - 1; thread++) {
+			close(FD(pos, cpu, thread));
 			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+		}
+	}
 }
 
 static int update_fds(struct evsel *evsel,
-- 
2.17.1

