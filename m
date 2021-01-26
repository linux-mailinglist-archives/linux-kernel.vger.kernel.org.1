Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19D304FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhA0Ddf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbhAZVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E7C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFd6gMCO9KJuddyq2aIzeNhQ+6H7FzwTICOnI8G6dlo=;
        b=qIm2TsmndTOyeAvfrh1LMF44U+/3LSdgcFA2vtKL1MTua0YiHK1aKi/n7XbB0pQI1HCQF9
        ovHVszh7p4Xl0kEzudl6RHzk0AmOIMLLfsdn//KrRW1EeEhhV4ejjTyyz0v6sE+5aMaa0b
        +XYK4aVvOFI9TYuJUJkkCU9udmSSfzCpikWW9dCvMJzfa08sU+7B+w98f7OXZYMXbys4EV
        CcO2iLoHWs1cX0FuBmC0kXd9ZivV5C2RfOdi96JnVsSBr9nO7xjqsS7SHHqjA+1/tCoUKA
        qJwZGZdXFEv+xT2DY0bAJMpnQxWMdyf92Znq2sZADXeps6FyQN8hI9O3jfNEkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFd6gMCO9KJuddyq2aIzeNhQ+6H7FzwTICOnI8G6dlo=;
        b=RPeTb0VVGWocwIRwUtyjRSCCTWZaNduzJA9oH74uyfKGFj7nGpS2ORss4ryo3axcMD2/ck
        XyX7HcXRuVluMxCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
Date:   Tue, 26 Jan 2021 22:21:48 +0106
Message-Id: <20210126211551.26536-10-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing printk's @logbuf_lock, dumpers that have
assumed to be protected against parallel calls must provide their own
synchronization. Add a locally static spinlock to synchronize the
kmsg_dump call and temporary buffer usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index f38349ad00ea..173999422ed8 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
+#include <linux/spinlock.h>
 #include <linux/console.h>
 #include <shared/init.h>
 #include <shared/kern.h>
@@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 				enum kmsg_dump_reason reason,
 				struct kmsg_dumper_iter *iter)
 {
+	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
+	unsigned long flags;
 	size_t len = 0;
 
 	/* only dump kmsg when no console is available */
@@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (con)
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	printf("kmsg_dump:\n");
 	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static struct kmsg_dumper kmsg_dumper = {
-- 
2.20.1

