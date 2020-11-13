Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123F2B1656
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKMHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:46 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36839 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgKMHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] timekeeping: add ts/tk explaination for kernel-doc
Date:   Fri, 13 Nov 2020 15:24:34 +0800
Message-Id: <1605252275-63652-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixed kernel-doc mark incorrection:
kernel/time/timekeeping.c:1543: warning: Function parameter or member
'ts' not described in 'read_persistent_clock64'
kernel/time/timekeeping.c:764: warning: Function parameter or member
'tk' not described in 'timekeeping_forward_now'
kernel/time/timekeeping.c:1331: warning: Function parameter or member
'ts' not described in 'timekeeping_inject_offset'
kernel/time/timekeeping.c:1331: warning: Excess function parameter 'tv'
description in 'timekeeping_inject_offset'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 9bee13d94d70..08ab749a76fc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -759,6 +759,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 
 /**
  * timekeeping_forward_now - update clock to the current time
+ * @tk: pointer to time clock which will be correct.
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
@@ -1327,7 +1328,7 @@ EXPORT_SYMBOL(do_settimeofday64);
 
 /**
  * timekeeping_inject_offset - Adds or subtracts from the current time.
- * @tv:		pointer to the timespec variable containing the offset
+ * @ts:		pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
@@ -1536,6 +1537,7 @@ u64 timekeeping_max_deferment(void)
 
 /**
  * read_persistent_clock64 -  Return time from the persistent clock.
+ * @ts: pointer to timespec to initialize.
  *
  * Weak dummy function for arches that do not yet support it.
  * Reads the time from the battery backed persistent clock.
@@ -1640,6 +1642,7 @@ static struct timespec64 timekeeping_suspend_time;
 
 /**
  * __timekeeping_inject_sleeptime - Internal function to add sleep interval
+ * @tk: pointer to a timekeeper to be updated
  * @delta: pointer to a timespec delta value
  *
  * Takes a timespec offset measuring a suspend interval and properly
-- 
2.29.GIT

