Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FD2F53C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbhAMUBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:01:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbhAMUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:01:11 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610568029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bbKNxaytHHc7ERAboHvLD0eJLsglL3VCsCRU4d9xpZk=;
        b=svCYZ9QYuxi/9XqlIcW1DtTtFDSxYkzzwfXgNyYQzHtFlCKExMU0TkzVEw55goezuBUPsE
        3QTHXNU/B8+DGVFFlOU45z0hDCX1dbu7YcasBVodI7vjk4UKb/u++ZV8pH3/xQ8tLEurfC
        3ouUSTMmTE/OGf4y9IjFXYQRPL03ijaFkJq4lmFQhItCSBbcbKLKAZ2GmQrOHIh62LNjq5
        wstuiITGPjrMYAi/0dp+8xVOUCgO7EqLADpXN2wyo3t1cpFI6DYGSCoH1Q5nLVKbKIrRJB
        OEa7NFVQhfqhV35EhrlnJkQ3+oIbUMK1jM3LN6n9ZO6ZxjhpjX5GOlRrqfCO6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610568029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bbKNxaytHHc7ERAboHvLD0eJLsglL3VCsCRU4d9xpZk=;
        b=QYgTWB4AnZQ8n/igl0sF7HYGASwfhOnVW/EcyyjWYerCwigNEZi170UpP3WtbaawloSy5J
        aJHj5BQm72mStBAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: RFC: printk: kmsg_dump_get_line_nolock() buffer overflow
Date:   Wed, 13 Jan 2021 21:06:28 +0106
Message-ID: <87im8038v7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have discovered that kmsg_dump_get_line_nolock() is not allowed to
fill the full buffer that it is provided. It should leave at least 1
byte free so that callers can append a terminator.

Example from arch/powerpc/xmon/xmon.c:

    kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len);
    buf[len] = '\0';

This unusual behavior was not noticed and with commit 896fbe20b4e2
("printk: use the lockless ringbuffer") the implementation of
kmsg_dump_get_line_nolock() was changed so that the full buffer can be
filled. This means that the two kmsg_dump_get_line*() users currently
can have a 1-byte buffer overflow.

This unusual kmsg_dump_get_line_nolock() behavior seems to have been
accidentally introduced with commit 3ce9a7c0ac28 ("printk() - restore
prefix/timestamp printing for multi-newline strings"). Indeed, the
whitespace on the line that causes this behavior is not conform, leading
me to think it was a last-minute change or a typo. (The behavior is
caused by the ">=" instead of an expected ">".)

+    if (print_prefix(msg, syslog, NULL) +
+        text_len + 1>= size - len)
+            break;

Perhaps there was some paranoia involved because this same commit also
fixes a buffer overflow in the old implementation:

-    if (len + msg->text_len > size)
-            return -EINVAL;
-    memcpy(text + len, log_text(msg), msg->text_len);
-    len += msg->text_len;
-    text[len++] = '\n';

Anyways, we currently have this 1-byte buffer overflow in 5.10 and it
needs to be corrected. I see two possibilties.

1. We leave kmsg_dump_get_line_nolock() as it is and modify the callers
   to properly terminate their buffer. This is my preferred
   approach. The patch would look like this:

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index dcd817ca2edf..9c3faab3a7a5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3019,7 +3019,7 @@ dump_log_buf(void)
 
 	kmsg_dump_rewind_nolock(&dumper);
 	xmon_start_pagination();
-	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
+	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf) - 1, &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index e4abac6c9727..acc1b399fbe2 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -25,7 +25,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		return;
 
 	printf("kmsg_dump:\n");
-	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
+	while (kmsg_dump_get_line(dumper, true, line, sizeof(line) - 1, &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}

2. We modify kmsg_dump_get_line_nolock() so that it goes back to the
   unusual behavior. The patch would look like this:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 848b56efc9d7..f0c03e432648 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3314,6 +3314,13 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 	size_t l = 0;
 	bool ret = false;
 
+	/*
+	 * Callers expect this function to never fill more than
+	 * @size-1 bytes so reduce the provided size.
+	 */
+	if (size > 0)
+		size--;
+
 	prb_rec_init_rd(&r, &info, line, size);
 
 	if (!dumper->active)

Since kmsg_dump_get_line() is an exported symbol, my preferred approach
(which changes the semantics) may not be acceptible. In that case, we
can take the 2nd approach.

Please let me know your thoughts so I can post a patch for 5.10-stable
and 5.11-rc.

John Ogness
