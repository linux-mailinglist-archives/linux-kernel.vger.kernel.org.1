Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D92E07BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLVJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:12:43 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56881 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgLVJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:12:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UJR9VX._1608628301;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UJR9VX._1608628301)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 17:11:58 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     qais.yousef@arm.com, peterz@infradead.org, mpe@ellerman.id.au,
        bristot@redhat.com, ethp@qq.co, npiggin@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] kernel/cpu: fix: use scnprintf or sprintf.
Date:   Tue, 22 Dec 2020 17:11:39 +0800
Message-Id: <1608628299-124339-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snprintf() function returns the number of characters which would
have been printed if there were enough space, but the scnprintf()
returns the number of characters which were actually printed. If the
buffer is not large enough, then using snprintf() would result in a
read overflow and an information leak.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91..c123741 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2345,7 +2345,7 @@ static ssize_t show_cpuhp_states(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
 static ssize_t
-- 
1.8.3.1

