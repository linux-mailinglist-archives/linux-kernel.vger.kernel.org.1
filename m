Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A892630EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgIIPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 11:49:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730423AbgIIPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:46:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A10404D340DED2722EB1;
        Wed,  9 Sep 2020 21:48:02 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:47:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] timers: Remove unused inline funtion debug_timer_free()
Date:   Wed, 9 Sep 2020 21:47:49 +0800
Message-ID: <20200909134749.32300-1-yuehaibing@huawei.com>
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
 kernel/time/timer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a50364df1054..7da4af49d1d7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -732,11 +732,6 @@ static inline void debug_timer_deactivate(struct timer_list *timer)
 	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_free(struct timer_list *timer)
-{
-	debug_object_free(timer, &timer_debug_descr);
-}
-
 static inline void debug_timer_assert_init(struct timer_list *timer)
 {
 	debug_object_assert_init(timer, &timer_debug_descr);
-- 
2.17.1


