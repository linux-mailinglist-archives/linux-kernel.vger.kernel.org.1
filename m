Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60842630E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgIIPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 11:48:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730487AbgIIPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:46:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 630759122229F8A1A6A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:48:58 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:48:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] hrtimer: Remove unused inline function debug_hrtimer_free()
Date:   Wed, 9 Sep 2020 21:48:50 +0800
Message-ID: <20200909134850.21940-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/time/hrtimer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95b6a708b040..75d0cc1a2081 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -425,11 +425,6 @@ static inline void debug_hrtimer_deactivate(struct hrtimer *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
 
-static inline void debug_hrtimer_free(struct hrtimer *timer)
-{
-	debug_object_free(timer, &hrtimer_debug_descr);
-}
-
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode);
 
-- 
2.17.1


