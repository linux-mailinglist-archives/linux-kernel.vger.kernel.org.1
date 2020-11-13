Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772CF2B1659
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:53 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40398 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgKMHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] timekeeping: add kernel-doc markup for pvclock notifier
Date:   Fri, 13 Nov 2020 15:24:32 +0800
Message-Id: <1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missed parameter explaination for kernel-doc markup to remove
warning:
kernel/time/timekeeping.c:651: warning: Function parameter or member
'nb' not described in 'pvclock_gtod_register_notifier'
kernel/time/timekeeping.c:670: warning: Function parameter or member
'nb' not described in 'pvclock_gtod_unregister_notifier'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d0f7cd1b8823..9db6aee48c52 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -648,6 +648,7 @@ static void update_pvclock_gtod(struct timekeeper *tk, bool was_set)
 
 /**
  * pvclock_gtod_register_notifier - register a pvclock timedata update listener
+ * @nb: a notifier entry which register on pvclock_gtod_chain.
  */
 int pvclock_gtod_register_notifier(struct notifier_block *nb)
 {
@@ -667,6 +668,7 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_register_notifier);
 /**
  * pvclock_gtod_unregister_notifier - unregister a pvclock
  * timedata update listener
+ * @nb: a notifier entry which unregister on pvclock_gtod_chain.
  */
 int pvclock_gtod_unregister_notifier(struct notifier_block *nb)
 {
-- 
2.29.GIT

