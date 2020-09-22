Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893BF2742E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIVNYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:24:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbgIVNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:24:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43BA166D63C5CBD85B6E;
        Tue, 22 Sep 2020 21:24:19 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 22 Sep 2020
 21:24:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Remove unused inline function uclamp_bucket_base_value()
Date:   Tue, 22 Sep 2020 21:24:10 +0800
Message-ID: <20200922132410.48440-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..1b06b952dbbe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -940,11 +940,6 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 	return clamp_value / UCLAMP_BUCKET_DELTA;
 }
 
-static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
-{
-	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
-}
-
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
-- 
2.17.1

