Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE9E2AB7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgKIMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:10:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7067 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgKIMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:10:26 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CV8vY4zjbzhjVK;
        Mon,  9 Nov 2020 20:10:17 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 20:10:18 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] perf intel-bts: use true for bool variables
Date:   Mon, 9 Nov 2020 20:22:10 +0800
Message-ID: <1604924530-71405-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warnings:

./intel-bts.c:472:3-13: WARNING: Assignment of 0/1 to bool variable
./intel-bts.c:515:3-13: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/perf/util/intel-bts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index af1e78d..aa4fad9 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -469,7 +469,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 
 	if (!buffer) {
 		if (!btsq->bts->sampling_mode)
-			btsq->done = 1;
+			btsq->done = true;
 		err = 1;
 		goto out_put;
 	}
@@ -512,7 +512,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 			*timestamp = btsq->buffer->reference;
 	} else {
 		if (!btsq->bts->sampling_mode)
-			btsq->done = 1;
+			btsq->done = true;
 	}
 out_put:
 	thread__put(thread);
-- 
2.6.2

