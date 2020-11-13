Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBD2B1655
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKMHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:44 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33141 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKMHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] time: fix kernel-doc markup
Date:   Fri, 13 Nov 2020 15:24:30 +0800
Message-Id: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc interface error cause some warning:
kernel/time/timeconv.c:79: warning: Function parameter or member
'totalsecs' not described in 'time64_to_tm'
kernel/time/timeconv.c:79: warning: Function parameter or member
'offset' not described in 'time64_to_tm'
kernel/time/timeconv.c:79: warning: Function parameter or member
'result' not described in 'time64_to_tm'

Fix them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timeconv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
index 589e0a552129..62e3b46717a6 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -70,10 +70,10 @@ static const unsigned short __mon_yday[2][13] = {
 /**
  * time64_to_tm - converts the calendar time to local broken-down time
  *
- * @totalsecs	the number of seconds elapsed since 00:00:00 on January 1, 1970,
+ * @totalsecs:	the number of seconds elapsed since 00:00:00 on January 1, 1970,
  *		Coordinated Universal Time (UTC).
- * @offset	offset seconds adding to totalsecs.
- * @result	pointer to struct tm variable to receive broken-down time
+ * @offset:	offset seconds adding to totalsecs.
+ * @result:	pointer to struct tm variable to receive broken-down time
  */
 void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 {
-- 
2.29.GIT

