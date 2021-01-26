Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C20304FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhA0DdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbhAZVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F3C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwcyLRKvRYCggpKhobLC2ptBLH4n0BU4QQA2pSmy6gc=;
        b=ZDmxBTp/e21MbdofjzyTZ41PDXwtt17H0NYYfF5AKLQf7Ledyd4KkAsyL+KLxyeR++e83c
        onDqaLI3DKzTJvmgdsEceRX2yLfKukqPjbayILLZPi+ErkpSUfgRfQYtTZpq3OpUe8LsAy
        qzFWjrVLOCG9cnjN4qydposjHkeUyDVaRari9Wkh9dmCVzQhabgXw8FiCTeTNYTB405WmV
        Qmesxzu1sZhPfokjCFkigv+eU5qvU2bYtcxzgtAf49LPUXP5YPaC3CGeQ2qBQa2ufgWhvg
        kByjJaKDFbkrlgno3ZV52Elkgo9y92ZHwCfzaJyrIlFEiRlvc/zp8/j2MEwkZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwcyLRKvRYCggpKhobLC2ptBLH4n0BU4QQA2pSmy6gc=;
        b=O4mx4UC8ttIswaw3XxFwpD3FCh/yRWHNG2fOJv2rkgnTaMtYCBJgHu5QDr9YyoBuM/God4
        qr55WlvmphLh4FCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 10/12] hv: synchronize kmsg_dumper
Date:   Tue, 26 Jan 2021 22:21:49 +0106
Message-Id: <20210126211551.26536-11-john.ogness@linutronix.de>
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
kmsg_dump call.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/hv/vmbus_drv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fbeddef90941..08db95e1a139 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1362,23 +1362,27 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 			 enum kmsg_dump_reason reason,
 			 struct kmsg_dumper_iter *iter)
 {
+	static DEFINE_SPINLOCK(lock);
 	size_t bytes_written;
 	phys_addr_t panic_pa;
+	unsigned long flags;
 
 	/* We are only interested in panics. */
 	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	panic_pa = virt_to_phys(hv_panic_page);
 
-	/*
-	 * Write dump contents to the page. No need to synchronize; panic should
-	 * be single-threaded.
-	 */
+	/* Write dump contents to the page. */
 	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static struct kmsg_dumper hv_kmsg_dumper = {
-- 
2.20.1

