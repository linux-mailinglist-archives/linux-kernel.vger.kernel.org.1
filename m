Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4627E472
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgI3JBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgI3JBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:01:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F252C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:01:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601456496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zpbAvUUgnuvXKvoTYxRiQVaXCaSNCsfpTcAwmFEpX8=;
        b=3+lnF0Olk77NtBQQXyGcMEWPYz4QkvaqtpzP5d3wwyMZPpfQGdXgn84zCSHeRyLigkgnYZ
        Vf0Kc2zn2vmcarnJFPawhcau5W8LsFZ2b1c4zCOe7JkMqfgTJZqX9A2SbuGeBceybm7hVX
        bDmnHR0B7g2VBTcyTI0K9xUlWAYF9aiOqxT3XHQsRA5RSrLryj+GaOw9EZrfRKLeKFOh4z
        U34bhrLI33q5V+wc0JEJPa9pMBG1EglrhW/Z4T9i9nPctXj6car7nBb0xvSaIjVEsi26Yd
        kKNjyQBpC/16BjhsltxdPBPJPZAuEvTdEJVn4dspe+ZLWH2skmyuwva5JMAzpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601456496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zpbAvUUgnuvXKvoTYxRiQVaXCaSNCsfpTcAwmFEpX8=;
        b=bhYdahacC9wzm16RzntbwPSO2HlRQbd1dWCdDz5wug21KgDopx6T5glMMYcVYCSObgWEfP
        wITTlMaFj+4iTKAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2 2/2] printk: reduce setup_text_buf size to LOG_LINE_MAX
Date:   Wed, 30 Sep 2020 11:07:34 +0206
Message-Id: <20200930090134.8723-3-john.ogness@linutronix.de>
In-Reply-To: <20200930090134.8723-1-john.ogness@linutronix.de>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@setup_text_buf only copies the original text messages (without any
prefix or extended text). It only needs to be LOG_LINE_MAX in size.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 04cf1e00478f..1538df175aae 100644
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

