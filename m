Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB42F66AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhANRE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:04:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbhANRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:04:56 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610643853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U1fiNiwuw8Nonab0CYVxFTF4cWMDykMKkFX15QDXWLY=;
        b=giZ9pQH/QGhQCJd5tlwXJFoz1y9z/k7r8BABZINeHeHlFfWAeBBbvLMrTllaOSilUp1/Be
        UFJXJPrmZgAIRB3XRbgIIdoIbCfR/X+Rt5QAN/cFZywtT/erjwC8szPTJboCdwzS6AaFZ8
        dxZnvjvkOH2I06pYM7nfa7bgwzXRUwa/phh5R8YNey1YI3VLXBhMGkMuDOOrWokr1MjcDl
        aeMH5cPWjwtNmdLllYOIbwEH+aeg2YgVkYwMrJULHutRLd0GGG3oDynCDa6Rf2bl/PFlgW
        Y+f7VkyivyrYw+ttEL1/ttVDgA293SVi/J26Z4GHS836PwkSf4xK5IOCMN3x0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610643853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U1fiNiwuw8Nonab0CYVxFTF4cWMDykMKkFX15QDXWLY=;
        b=D9EcZKQhAvkk7eUew0M/11R7Y/U2mJRwW86na5cEt/aUWIRSrmbzdawwaI1pU7Uox2D5um
        Ch10GFhb7K7bV3BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: fix buffer overflow potential for print_text()
Date:   Thu, 14 Jan 2021 18:10:12 +0106
Message-Id: <20210114170412.4819-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
msg_print_text() would only write up to size-1 bytes into the
provided buffer. Some callers expect this behavior and append
a terminator to returned string. In particular:

arch/powerpc/xmon/xmon.c:dump_log_buf()
arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()

msg_print_text() has been replaced by record_print_text(), which
currently fills the full size of the buffer. This causes a
buffer overflow for the above callers.

Change record_print_text() so that it will only use size-1 bytes
for text data. Also, for paranoia sakes, add a terminator after
the text data.

And finally, document this behavior so that it is clear that only
size-1 bytes are used and a terminator is added.

Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ffdd0dc7ec6d..73f9eae19f05 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1293,9 +1293,15 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
  *   - Add prefix for each line.
  *   - Add the trailing newline that has been removed in vprintk_store().
  *   - Drop truncated lines that do not longer fit into the buffer.
+ *   - Add a trailing newline.
+ *   - Add a string terminator.
+ *
+ * Since the produced string is always terminated, the maximum possible
+ * return value is @r->text_buf_size - 1;
  *
  * Return: The length of the updated/prepared text, including the added
- * prefixes and the newline. The dropped line(s) are not counted.
+ * prefixes and the newline. The terminator is not counted. The dropped
+ * line(s) are not counted.
  */
 static size_t record_print_text(struct printk_record *r, bool syslog,
 				bool time)
@@ -1338,26 +1344,31 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 
 		/*
 		 * Truncate the text if there is not enough space to add the
-		 * prefix and a trailing newline.
+		 * prefix and a trailing newline and a terminator.
 		 */
-		if (len + prefix_len + text_len + 1 > buf_size) {
+		if (len + prefix_len + text_len + 1 + 1 > buf_size) {
 			/* Drop even the current line if no space. */
-			if (len + prefix_len + line_len + 1 > buf_size)
+			if (len + prefix_len + line_len + 1 + 1 > buf_size)
 				break;
 
-			text_len = buf_size - len - prefix_len - 1;
+			text_len = buf_size - len - prefix_len - 1 - 1;
 			truncated = true;
 		}
 
 		memmove(text + prefix_len, text, text_len);
 		memcpy(text, prefix, prefix_len);
 
+		/*
+		 * Increment the prepared length to include the text and
+		 * prefix that were just moved+copied. Also increment for the
+		 * newline at the end of this line. If this is the last line,
+		 * there is no newline, but it will be added immediately below.
+		 */
 		len += prefix_len + line_len + 1;
-
 		if (text_len == line_len) {
 			/*
-			 * Add the trailing newline removed in
-			 * vprintk_store().
+			 * This is the last line. Add the trailing newline
+			 * removed in vprintk_store().
 			 */
 			text[prefix_len + line_len] = '\n';
 			break;
@@ -1382,6 +1393,14 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 		text_len -= line_len + 1;
 	}
 
+	/*
+	 * If a buffer was provided, it will be terminated. Space for the
+	 * string terminator is guaranteed to be available. The terminator is
+	 * not counted in the return value.
+	 */
+	if (buf_size > 0)
+		text[len] = 0;
+
 	return len;
 }
 
-- 
2.20.1

