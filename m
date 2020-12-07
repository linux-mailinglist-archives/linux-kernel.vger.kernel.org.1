Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1372D1D33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLGWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLGWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:21:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A60C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:20:24 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607379622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEtwlBL3OabOsivJm+dXOlC1opmXjQgDDvJiFstypec=;
        b=ekGrrMirk4xWdKyu0SupX6IXYEy4WZqQPuwp5XuFvVVXCpskGheJGipkE7QyqoQWA/EjWz
        FCCNaUlK8elVLgMbHAGFdP7mBET8wRhZ6u6kuO2ih/3nbxYF/T4/Wsi3iJbb05q5kpArZH
        rngsomqPD+iUe904xuZwlKEZ04Z4wa/4bLp2AH8z2o2+i6adUeTnihwpL9InXVcDcMgZK9
        axkPUEkqZP05qQYi39C/uqq6UViuhyZee4YEiTA4UKCV6GzBL1vqgwynKcEtgFvfExZWWO
        vLGf5/7Z3xlook8fsFAoGlk5Z8gHv3jfyztPO1Z89hzDFLXiMhz3NXfA1Cir5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607379622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEtwlBL3OabOsivJm+dXOlC1opmXjQgDDvJiFstypec=;
        b=bzRuDiEmNJ5avFk7RrQhrS3KyrUJAcZd2/dcthtVLKu1i6GgrVv2sEDTd5Ku0HQ2nxy4uI
        pjDNoqiXTxrqXuAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 2/3] printk: define CONSOLE_LOG_MAX in printk.h
Date:   Mon,  7 Dec 2020 23:26:19 +0106
Message-Id: <20201207222020.2923-3-john.ogness@linutronix.de>
In-Reply-To: <20201207222020.2923-1-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONSOLE_EXT_LOG_MAX for extended console messages is already defined
in printk.h. Define CONSOLE_LOG_MAX there as well so that future
changes can make use of the constant for non-extended console
messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 1 +
 kernel/printk/printk.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..6d8f844bfdff 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -45,6 +45,7 @@ static inline const char *printk_skip_headers(const char *buffer)
 }
 
 #define CONSOLE_EXT_LOG_MAX	8192
+#define CONSOLE_LOG_MAX		1024
 
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bf5fd2be3a05..e1f068677a74 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -410,7 +410,7 @@ static u64 clear_seq;
 #else
 #define PREFIX_MAX		32
 #endif
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
-- 
2.20.1

