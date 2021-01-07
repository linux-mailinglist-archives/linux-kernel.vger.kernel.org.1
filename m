Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5502ECA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 06:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAGFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 00:41:51 -0500
Received: from mx433.baidu.com ([119.249.100.169]:52089 "EHLO
        dbl-sys-mailin03.dbl01.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbhAGFlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 00:41:51 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 00:41:50 EST
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (unknown [10.172.107.253])
        by dbl-sys-mailin03.dbl01.baidu.com (Postfix) with ESMTP id 2DC8F16E00057;
        Thu,  7 Jan 2021 13:33:20 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        tglx@linutronix.de
Subject: [PATCH] alarmtimer: Do not mess with an enqueued hrtimer
Date:   Thu,  7 Jan 2021 13:33:20 +0800
Message-Id: <1609997600-13503-1-git-send-email-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when an hrtimer is enqueued already, its expires should be not
changed, otherwise, this will corrupts the ordering of the
timerqueue RB tree, if other hrtimer is enqueued before this
hrtimer is restarted, whole RB tree is completely hosed

Fixes: 6cffe00f7d4e ("alarmtimer: Add functions for timerfd support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/time/alarmtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f4ace1bf8382..3b34995ab8d2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -388,8 +388,7 @@ void alarm_restart(struct alarm *alarm)
 	unsigned long flags;
 
 	spin_lock_irqsave(&base->lock, flags);
-	hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-	hrtimer_restart(&alarm->timer);
+	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	alarmtimer_enqueue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
-- 
2.17.3

