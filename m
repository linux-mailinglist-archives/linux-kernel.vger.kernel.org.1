Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93F2B1657
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKMHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:49 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36834 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgKMHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:40 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] timekeeping: fix kernel-doc mark issue on read_persistent_clock64
Date:   Fri, 13 Nov 2020 15:24:35 +0800
Message-Id: <1605252275-63652-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the kernel-doc markup:
kernel/time/timekeeping.c:1563: warning: Function parameter or member
'wall_time' not described in 'read_persistent_wall_and_boot_offset'
kernel/time/timekeeping.c:1563: warning: Function parameter or member
'boot_offset' not described in 'read_persistent_wall_and_boot_offset'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 08ab749a76fc..665e820bb883 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1556,8 +1556,9 @@ void __weak read_persistent_clock64(struct timespec64 *ts)
  *                                        from the boot.
  *
  * Weak dummy function for arches that do not yet support it.
- * wall_time	- current time as returned by persistent clock
- * boot_offset	- offset that is defined as wall_time - boot_time
+ * @wall_time:	- current time as returned by persistent clock
+ * @boot_offset: - offset that is defined as wall_time - boot_time
+ *
  * The default function calculates offset based on the current value of
  * local_clock(). This way architectures that support sched_clock() but don't
  * support dedicated boot time clock will provide the best estimate of the
-- 
2.29.GIT

