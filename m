Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AB27960E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIZBzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:55:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgIZBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:55:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601085327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57u1up5OwTRuChPL+apaowPVX45DIfqc12a7a1X2m3g=;
        b=mUHNaRSIQ2lefxBD1NquljUQQlTK1vrbHXstHJdSO90BERFRWFmDWvViN/bAQsKGfqRreh
        T5LkXI5eukPI9WDKQnuTS0CFnv98GuBfTudh3FDtxAYO+cXMu9hlpgvpRhLjjbHNU2NMAZ
        LXUZBGNY62aovAitJzR8lIQ/N0wl3ms02FSxl7Z9I7KJgb8bw2gp6YdwYTGCuVcYNxCq9N
        qYNaije0wElKuZIEjYYZLBbhktFZijLVIVjABeEyenKlIEBFdRENoccz0Dre3S7hQHi9v/
        YMjxnb3PbVQiqZrewuoCxXfDjUcCABhIAL4/BhoAg2mJJqgz5UVjNeLgu8ejaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601085327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57u1up5OwTRuChPL+apaowPVX45DIfqc12a7a1X2m3g=;
        b=TRE5aTUko7Y81LL4BMvlYBjhjnDY6T87/MklWQ53gwPEYxx6UMbwdw+BoxZdmf9VnyoEeU
        lM0tGILZGsRrXzAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 2/2] printk: reduce setup_text_buf size to LOG_LINE_MAX
Date:   Sat, 26 Sep 2020 04:01:26 +0206
Message-Id: <20200926015526.8921-3-john.ogness@linutronix.de>
In-Reply-To: <20200926015526.8921-1-john.ogness@linutronix.de>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@setup_text_buf only copies the original text messages (without any
prefix or extended text). It only needs to be LOG_LINE_MAX in size.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 270f19b60e6f..c3eb97f93668 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1103,7 +1103,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	return prb_record_text_space(&e);
 }
 
-static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
+static char setup_text_buf[LOG_LINE_MAX] __initdata;
 
 void __init setup_log_buf(int early)
 {
-- 
2.20.1

