Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086902C533D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgKZLsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgKZLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:48:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2685C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:48:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606391316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nn6vIi9zYYOV8SxXoVNmLqy1mY0WSdF5TV6Sb639hJY=;
        b=Hwu2le+Pa672R41U1V2yIUXxXNxp+Ix/bLanR09cAd2mo392zlDQ5RHigO0fktAeYg+jH6
        jtFysgBOeRHwxf1/WCiZGdvxnGHX2V/VHhoZAT0wNSW0rQEvCBKU7/3wfEjY8bdVfXYSIc
        6lKDfpJrblt+CluSt5P/S2O91+OUlJuEWD+rzTsqJbbtYF2O6Agl4KcJA9fnhz78MEeTpF
        TQB0Vrqwpx2NVDEWW3uM7gZShaVO7XcYbB6nErAndJRNwhYMoVMC9n63Ejeo2wxA7pbNb3
        FlReos8xvDR86Je0WvE8aZ9iTbc1gnwMyDG1s3644a4pOMmhByRExZw2uM9JsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606391316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nn6vIi9zYYOV8SxXoVNmLqy1mY0WSdF5TV6Sb639hJY=;
        b=8iAaw2193M+waPlOABmyvQOobMjiknkaBukT0KOH8xncYifzffeXqXcXU7EVzqaLnCOyp/
        Nk3Vb88U3pdXyTBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: finalize records with trailing newlines
Date:   Thu, 26 Nov 2020 12:54:36 +0106
Message-Id: <20201126114836.14750-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any record with a trailing newline (LOG_NEWLINE flag) cannot
be continued because the newline has been stripped and will
not be visible if the message is appended. This was already
handled correctly when committing in log_output() but was
not handled correctly when committing in log_store().

Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This is an important bugfix for continuous messages and should
 be part of the 5.10 release.

 If not applied, newlines will vanish when concatenating
 continuous with trailing newlines.

 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49344bf..bc1e3b5a97bd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -528,8 +528,8 @@ static int log_store(u32 caller_id, int facility, int level,
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
-	/* insert message */
-	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
+	/* A message without a trailing newline can be continued. */
+	if (!(flags & LOG_NEWLINE))
 		prb_commit(&e);
 	else
 		prb_final_commit(&e);
-- 
2.20.1

