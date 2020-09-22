Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120D274573
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIVPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgIVPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:21 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dla4699JD/gd71lqvXhIDNCtJl+qRQcMC1dkGxY9hv0=;
        b=Uo3bnzVVGBXerDtdtizKg01zkYOYxKFjti6UggzqS8mVqjlxK/1VQv5mtdhbKyRy1HPH/5
        Jki2fZ7Gq/pH8HRrhvghyEhBiq7w9RWhKG5yfYpzvXwP1/1FQmJes59fw3hxbeQsEu72Kv
        JgSu1ktpuh8ZWL+d8iF5j8Cr4A3Zr/4qo4cx08Uy2+/NwDFVyQn8YcYIbY6l6MG8eVjPKr
        TRNk9DOa4VEBaj6yFiLpIg+Rl0iiqRd0QliOpebxz5V/OPkF16iHE63+OH2fpILpSyFT/q
        RbAcyFG5t3TdN25RX2qX5x49gBlox0cCA4xeC1S0HmomwDPDGy5+i/PbFnUFog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dla4699JD/gd71lqvXhIDNCtJl+qRQcMC1dkGxY9hv0=;
        b=qzPj+CUlGEI3T8DCZxk5mrmKdqWIqM8LM0mRq+NP1mwItUhvIdgTfNdWjnhxchwoTN5M0n
        1SdWpK6SoSFQ7cCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Date:   Tue, 22 Sep 2020 17:44:14 +0206
Message-Id: <20200922153816.5883-4-john.ogness@linutronix.de>
In-Reply-To: <20200922153816.5883-1-john.ogness@linutronix.de>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vprintk_store() is using a single static buffer as a temporary
sprint buffer for the message text. This will not work once
@logbuf_lock is removed. Replace the single static buffer with a
pool of buffers.

The pool is large enough to support a worse case of 2 contexts
per CPU (non-NMI and NMI).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 142 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cff13b33e926..763494d1d6b3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1872,6 +1872,112 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 	}
 }
 
+/*
+ * The sprint buffers are used with interrupts disabled, so each CPU
+ * only requires 2 buffers: for non-NMI and NMI contexts. Recursive
+ * printk() calls are handled by the safe buffers.
+ */
+#define SPRINT_CTX_DEPTH 2
+
+/* Static sprint buffers for early boot (only 1 CPU). */
+static DECLARE_BITMAP(sprint_static_textbuf_map, SPRINT_CTX_DEPTH);
+static char sprint_static_textbuf[SPRINT_CTX_DEPTH * LOG_LINE_MAX];
+
+/* Dynamically allocated sprint buffers. */
+static unsigned int sprint_dynamic_textbuf_count;
+static unsigned long *sprint_dynamic_textbuf_map;
+static char *sprint_dynamic_textbuf;
+
+/*
+ * Acquire an unused buffer, returning its index. If no buffer is
+ * available, @count is returned.
+ */
+static int _get_sprint_buf(unsigned long *map, int count)
+{
+	int index;
+
+	do {
+		index = find_first_zero_bit(map, count);
+		if (index == count)
+			break;
+	/*
+	 * Guarantee map changes are ordered for the other CPUs.
+	 * Pairs with clear_bit() in _put_sprint_buf().
+	 */
+	} while (test_and_set_bit(index, map));
+
+	return index;
+}
+
+/* Mark the buffer @index as unused. */
+static void _put_sprint_buf(unsigned long *map, unsigned int count, unsigned int index)
+{
+	/*
+	 * Guarantee map changes are ordered for the other CPUs.
+	 * Pairs with test_and_set_bit() in _get_sprint_buf().
+	 */
+	clear_bit(index, map);
+}
+
+/*
+ * Get a buffer sized LOG_LINE_MAX for sprinting. On success, @id is set and
+ * interrupts are disabled. @id is used to put back the buffer.
+ *
+ * @id is non-negative for static buffers, negative for dynamic buffers.
+ */
+static char *get_sprint_buf(int *id, unsigned long *flags)
+{
+	unsigned int index;
+
+	local_irq_save(*flags);
+
+	/* First try with static pool. */
+	index = _get_sprint_buf(sprint_static_textbuf_map, SPRINT_CTX_DEPTH);
+	if (index != SPRINT_CTX_DEPTH) {
+		*id = index;
+		return &sprint_static_textbuf[index * LOG_LINE_MAX];
+	}
+
+	/*
+	 * Fallback to dynamic pool, if available.
+	 *
+	 * Guarantee the buffer is loaded before loading the map and count.
+	 * Pairs with smp_store_release() in console_init().
+	 */
+	if (smp_load_acquire(&sprint_dynamic_textbuf)) {
+		index = _get_sprint_buf(sprint_dynamic_textbuf_map,
+					sprint_dynamic_textbuf_count);
+		if (index != sprint_dynamic_textbuf_count) {
+			/* Convert to dynamic buffer representation. */
+			*id = -index - 1;
+			return &sprint_dynamic_textbuf[index * LOG_LINE_MAX];
+		}
+	}
+
+	/* Failed to get a buffer. */
+	local_irq_restore(*flags);
+	return NULL;
+}
+
+/* Put back an sprint buffer and restore interrupts. */
+static void put_sprint_buf(int id, unsigned long flags)
+{
+	unsigned int index;
+
+	if (id >= 0) {
+		index = id;
+		_put_sprint_buf(sprint_static_textbuf_map,
+				SPRINT_CTX_DEPTH, index);
+	} else {
+		/* Convert from dynamic buffer representation. */
+		index = -id - 1;
+		_put_sprint_buf(sprint_dynamic_textbuf_map,
+				sprint_dynamic_textbuf_count, index);
+	}
+
+	local_irq_restore(flags);
+}
+
 int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(void)
@@ -1921,21 +2027,26 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
 			 dev_info, text, text_len);
 }
 
-/* Must be called under logbuf_lock. */
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
-	static char textbuf[LOG_LINE_MAX];
-	char *text = textbuf;
 	size_t text_len;
 	enum log_flags lflags = 0;
+	unsigned long irqflags;
+	int sprint_id;
+	char *text;
+	int ret;
+
+	text = get_sprint_buf(&sprint_id, &irqflags);
+	if (WARN_ON_ONCE(!text))
+		return 0;
 
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
 	 */
-	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
+	text_len = vscnprintf(text, LOG_LINE_MAX, fmt, args);
 
 	/* mark and strip a trailing newline */
 	if (text_len && text[text_len-1] == '\n') {
@@ -1968,7 +2079,11 @@ int vprintk_store(int facility, int level,
 	if (dev_info)
 		lflags |= LOG_NEWLINE;
 
-	return log_output(facility, level, lflags, dev_info, text, text_len);
+	ret = log_output(facility, level, lflags, dev_info, text, text_len);
+
+	put_sprint_buf(sprint_id, irqflags);
+
+	return ret;
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
@@ -2920,6 +3035,23 @@ void __init console_init(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
+	sprint_dynamic_textbuf_count = num_possible_cpus() * SPRINT_CTX_DEPTH;
+	sprint_dynamic_textbuf_map = bitmap_alloc(sprint_dynamic_textbuf_count, GFP_KERNEL);
+	if (sprint_dynamic_textbuf_map) {
+		/*
+		 * Guarantee the buffer is stored after storing the
+		 * map and count. Pairs with smp_load_acquire() in
+		 * get_sprint_buf().
+		 */
+		smp_store_release(&sprint_dynamic_textbuf,
+			kmalloc(sprint_dynamic_textbuf_count * LOG_LINE_MAX, GFP_KERNEL));
+	}
+	if (!sprint_dynamic_textbuf) {
+		bitmap_free(sprint_dynamic_textbuf_map);
+		pr_info("sprint_dynamic_textbuf: %u buffers not available\n",
+			sprint_dynamic_textbuf_count);
+	}
+
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
 
-- 
2.20.1

