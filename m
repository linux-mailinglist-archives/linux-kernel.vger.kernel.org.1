Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26E1AF4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgDRUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728685AbgDRUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14EC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so7134137wrm.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBtphzshsTJT+agYSVfMzy6VHv96OSjVYiPTsDxjpkc=;
        b=o6EpWV3VVSXvpl/hrQGc10y7cAUTC0DcFWtmI0xzDg16KHP4Zxe5M9rGYf6JvRnunz
         wztn5ICbEybWn/EUa1IbDKG6EyHgHDOeJbFDQjmIhFPWvuVzSm1bZwBIq9ZiMuOk8ZGb
         wxvnAXWL5hMGD8tvQwAsrwrgOtBtmWtGx1eCdGY49RVhsRXV6zXcHBlv1gUC0XyHhRu1
         PBriJZDJyVoM3mYBQ0HCMDstIWzLr+h1Jz8S9j9tOMHkoqFLZHr34sLZB8Q9JWLdHNga
         rv/nTLA7ww7IgsJjziYK9WPyXd9TN69IQ7jvExyAAD0/5nTPTEHev+xomjwN9cwHIDiB
         JErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBtphzshsTJT+agYSVfMzy6VHv96OSjVYiPTsDxjpkc=;
        b=EhOiixsX8WHtnZQHM5jFK51rV33f0uwLe3p3PDwCKdBwLzJQi0ifmaF80ImIY5GUf8
         2nqvXbm7EogkGRAk+lDhcCgmOLYpJ4cqAbaqhVmI2bVqWm8GI4/6XOscC+v+kGeM/CYO
         rUQVX+WuGdhoPYb7JJVpRc5i68JR2FWTbDLCvyTsHg1Rrxon6PAV5Fag0jibZTCREtST
         M65oqFWs7ll0KzmAXj3T8CdwK6AtWndZZvOHX6hwlhcUZH9aaFTHIlz/vsYwxqKH8LE0
         jvZLBILLLVrv1JaNLDsxa8tXXM8/Uzkb7m5ya+ogJbWgQ/nELlI43mFu6zvbPWhGvXxG
         AeGg==
X-Gm-Message-State: AGi0PuZRYQzHdZNgduMAMVrVw64JIPXJaToS0Of+zUA3ZPbXSd8I1Hsq
        M5G3I3Ukim9rpS2IdoRpIJUlDjPpQKo=
X-Google-Smtp-Source: APiQypLVzU9qJCfqyhfMat7fp+t5PJcUPMe8hdQuHtXodAIdOVArOCTZ86ab+1BziVRpuCYO4/6hWA==
X-Received: by 2002:adf:b344:: with SMTP id k4mr10081517wrd.76.1587241250001;
        Sat, 18 Apr 2020 13:20:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:49 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCHv3 44/50] sysrq: Use show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:38 +0100
Message-Id: <20200418201944.482088-45-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the stack trace on a CPU with the same log level as "CPU%d" header.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c         | 2 +-
 include/linux/sched/debug.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 5e0d0813da55..b11300b16f62 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -232,7 +232,7 @@ static void showacpu(void *dummy)
 
 	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_INFO);
 	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index 95fb9e025247..373e4e3faf2a 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -31,6 +31,8 @@ extern void show_regs(struct pt_regs *);
  * trace (or NULL if the entire call-chain of the task should be shown).
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
+extern void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+			      const char *loglvl);
 
 extern void sched_show_task(struct task_struct *p);
 
-- 
2.26.0

