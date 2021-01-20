Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69252FDA02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392765AbhATTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392725AbhATTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:41:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36724C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:41:09 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611171667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4k/xczm0+tWviY/LentZQRmnbNHrpN9j2j3dvysbK0c=;
        b=svmLqO22hLkJncX/7hrUumxXUwysOp+nZArHw6VGrEg6aAaZXAeBVU9kXxNIRxxXVV1D73
        +LuImkeMlKhucW/wJq2F1nObst+bgl187No0cm48lWGVf+LeMnJhmqS2kvW2u6MQkE0GXa
        9I+eGAcTaRHBGqo+g5zjdPMf6P7M0ezZSx56qc6cIIBUU6kcqBIcsU83PQ46B8qEEwLp7/
        y4J+yBrlzP6s90ySCAkQIX6hrI2H48sg2fA8//tDUrxcBr45tncEMCx7d6PdSF3vwJlKDx
        /WaPwKNzOPvvrNPhBNaWkvG40W2ev1OcenfqZhS9Ih3A+06txlLjGN8dkniRMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611171667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4k/xczm0+tWviY/LentZQRmnbNHrpN9j2j3dvysbK0c=;
        b=eTdLovGogdRe5iI7NBNADQih5PCLBzNngGtl/iHfZ1w+LEMRZLcerjysCGZciEHX91yW0u
        e5tzmjubFbNChhCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] printk: fix syslog_print_all() 1024-byte edge case
Date:   Wed, 20 Jan 2021 20:47:06 +0106
Message-Id: <20210120194106.26441-2-john.ogness@linutronix.de>
In-Reply-To: <20210120194106.26441-1-john.ogness@linutronix.de>
References: <20210120194106.26441-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If klogctl(SYSLOG_ACTION_READ_ALL) is called with a buffer size
of 1024 and the message data will exactly fill 1024 bytes and the
last message of that is multi-line, the last line of the last
message will be silently dropped.

This is because syslog_print_all() is assuming record_print_text()
will fill @size bytes and chooses the first record on this basis.
But since record_print_text() only fills @size-1 bytes, it will
truncate the last message. This behavior exists since the
introduction of msg_print_text() in commit 3ce9a7c0ac28 ("printk() -
restore prefix/timestamp printing for multi-newline strings").

SYSLOG_ACTION_READ_ALL is only supposed to print full messages, so
the expected behavior would be to drop the full multi-line message.
Fix this edge case by changing syslog_print_all() to correctly
choose the first message with the knowledge that
record_print_text() will only fill up to @size-1 bytes.

To test the syslog interface, a simple "kmsg" tool was written to
call klogctl() based on provided parameters. The tool prints the
syslog data it read and the size returned by klogctl().

A wrapper script was used to generate a single multi-line test
message and run kmsg.

----- BEGIN syslog-1024-test.sh -----
 #!/bin/sh

 msg=""
 for i in `seq $1`; do msg="$msg."; done
 msg="$msg\nhello1"
 msg="$msg\nhello2"

 dmesg -c > /dev/null
 echo -e "$msg" > /dev/kmsg
 ./kmsg SYSLOG_ACTION_READ_ALL 1024
----- END syslog-1024-test.sh -----

When $1 is 928, the syslog data will be 1024 bytes and trigger the
edge case (assuming early timestamps and CALLER_ID enabled).

BEFORE this commit:

 # ./syslog-1024-test.sh 927
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 <12>[  115.933677][ T1138] ................
 <12>[  115.933677][ T1138] hello1
 <12>[  115.933677][ T1138] hello2
 read 1023 bytes from klogctl

 # ./syslog-1024-test.sh 928
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 <12>[  124.834804][ T1143] ................
 <12>[  124.834804][ T1143] hello1
 read 990 bytes from klogctl

 # ./syslog-1024-test.sh 929
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 read 0 bytes from klogctl

AFTER this commit:

 # ./syslog-1024-test.sh 927
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 <12>[   43.079094][ T1096] ................
 <12>[   43.079094][ T1096] hello1
 <12>[   43.079094][ T1096] hello2
 read 1023 bytes from klogctl

 # ./syslog-1024-test.sh 928
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 read 0 bytes from klogctl

 # ./syslog-1024-test.sh 929
 kmsg: klogctl(SYSLOG_ACTION_READ_ALL) with buffer of 1024 bytes
 read 0 bytes from klogctl

Fixes: 3ce9a7c0ac28 ("printk() - restore prefix/timestamp printing for multi-newline strings")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6639a0cfe0ac..b640d34e0351 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1513,7 +1513,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 	/* move first record forward until length fits into the buffer */
 	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
-		if (len <= size)
+		if (len < size)
 			break;
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
-- 
2.20.1

