Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A71D35A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgENPyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 11:54:08 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:50670 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgENPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:54:07 -0400
X-Greylist: delayed 1901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 11:54:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=loOkN7VR0utdCoO10a
        fFg9YFqd0qPWF5aEj3qXr6pO4=; b=isnKMIlXy9yyH2wYUE/NeeCXFvUqWcr4Dv
        VruGSwZ7uk/v7k5kBHCwMV1UemAeigPfehx/Wgrx5SgcS7hpUXvrD2G4oQMAHp48
        gKH8Jiegh5INBeBrWpK9gXa3vDkOBvoP2qknwb7uYzMuvsZg93AzhdP61Um3U8Jh
        LStIF/sG4=
Received: from 192.168.137.228 (unknown [112.10.75.116])
        by smtp7 (Coremail) with SMTP id DsmowADH5yPPYb1e4wrUEw--.20957S3;
        Thu, 14 May 2020 23:20:49 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] timers: Use set_current_state macro
Date:   Thu, 14 May 2020 11:20:47 -0400
Message-Id: <1589469647-33814-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowADH5yPPYb1e4wrUEw--.20957S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5KF4fZrWfJF4fCw4kGFyDJrb_yoWxWrXEk3
        97tF409r45JF9FgF4UC3yfury0gr13GF1kAw4UuF43Aw4qy3y5twnYqFn8CFn3Wr98WFy5
        Zan8J34DKr1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8kpnPUUUUU==
X-Originating-IP: [112.10.75.116]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwQEkpFpD+ZN0LAAAsr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_current_state macro instead of current->state = TASK_RUNNING

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..b9ecf87 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1882,7 +1882,7 @@ signed long __sched schedule_timeout(signed long timeout)
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
 			dump_stack();
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			goto out;
 		}
 	}
-- 
1.8.3.1

