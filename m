Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135C4275936
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIWN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:57:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgIWN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:57:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600869435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZciUH4eg7LXe7vhQY48rZX/NpxvqBbiLRgigFCZNks=;
        b=kyZ980lRVJ7F0rwbTqUsXnxe8C0HnAWK1qHkyqvY1QkQe1Cb11leIiXvW+VilCG+GPOU8J
        WUjOXQTI7/jpPvGD980mOwAPMfTjibDjG3Tu8PF9wM3JM5hGUKhM5I2ZFfK/IqaDTbauH6
        RnhLYid8V3Xr1H8d3K8CZgW/2Kge5Sc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20A55AD57;
        Wed, 23 Sep 2020 13:57:53 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] printk: Store all three timestamps
Date:   Wed, 23 Sep 2020 15:56:16 +0200
Message-Id: <20200923135617.27149-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923135617.27149-1-pmladek@suse.com>
References: <20200923135617.27149-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk() historically shows the timestamps from the monotonic clock.
It is fast, available early during boot, in any context, and even
without using any lock.

There are repeated requests [1][2][3] to show the timestamps from other
clocks. The main motivation is to make it easier to correlate the kernel
and userspace logs. Where userspace logs usually use the real time
clock.

Unfortunately, it is not possible to simply replace the default clock.
Userspace tools, like journalctl, dmesg, expect to get the timestamps
from the mono via /dev/kmsg interface or syslog syscall [4].
Also administrators would be confused when logs from different
systems use different clocks depending on kernel version or
build option [5].

As a result, the mono clock has to stay as the default clock
and has to be used in the current user interfaces.

The problem is solved by storing timestamps from all three clock
sources in struct printk_info for each message. The other timestamps
can be later passed to userspace by extending the existing formats.

One might ask if the timestamp from the boot clock is really needed.
The values are mostly redundant with the mono clock. And there really
does not seems to be any strong reason. Anyway, the boot clock
is useful when suspend and resume is part of the debugged/monitored
systems. And it is still easier to handle than a full real time
format.

[1] https://lore.kernel.org/r/1500985047-23038-1-git-send-email-prarit@redhat.com
[2] https://lore.kernel.org/r/20200729114423.30606-1-zhang.lyra@gmail.com
[3] https://lore.kernel.org/r/1597120822-11999-1-git-send-email-orsonzhai@gmail.com
[4] https://lore.kernel.org/r/CA+55aFzzvBD4_WYm-5Bm7TeRGR8nNu1oz0oWNcRNmTNJm=M4Lw@mail.gmail.com
[5] https://lore.kernel.org/r/20171115080402.gz5k3qzfaexucc3p@gmail.com

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            | 30 +++++++++++++++++++-----------
 kernel/printk/printk_ringbuffer.h |  3 ++-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1560649cbd35..0ed8901916f4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -326,7 +326,9 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  * Example of record values:
  *   record.text_buf                = "it's a line" (unterminated)
  *   record.info.seq                = 56
- *   record.info.ts_nsec            = 36863
+ *   record.info.ts.mono            = 363863
+ *   record.info.ts.boot            = 5122562
+ *   record.info.ts.real            = 1599211091487260162
  *   record.info.text_len           = 11
  *   record.info.facility           = 0 (LOG_KERN)
  *   record.info.flags              = 0
@@ -493,7 +495,7 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+		     enum log_flags flags, struct ktime_timestamps *ts,
 		     const struct dev_printk_info *dev_info,
 		     const char *text, u16 text_len)
 {
@@ -520,10 +522,10 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		r.info->ts_nsec = ts_nsec;
+	if (ts)
+		r.info->ts = *ts;
 	else
-		r.info->ts_nsec = local_clock();
+		ktime_get_fast_timestamps(&r.info->ts);
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
@@ -589,7 +591,7 @@ static void append_char(char **pp, char *e, char c)
 static ssize_t info_print_ext_header(char *buf, size_t size,
 				     struct printk_info *info)
 {
-	u64 ts_usec = info->ts_nsec;
+	u64 ts_mono_usec = info->ts.mono;
 	char caller[20];
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = info->caller_id;
@@ -600,11 +602,12 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 	caller[0] = '\0';
 #endif
 
-	do_div(ts_usec, 1000);
+	do_div(ts_mono_usec, 1000);
 
 	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
 			 (info->facility << 3) | info->level, info->seq,
-			 ts_usec, info->flags & LOG_CONT ? 'c' : '-', caller);
+			 ts_mono_usec, info->flags & LOG_CONT ? 'c' : '-',
+			 caller);
 }
 
 static ssize_t msg_add_ext_text(char *buf, size_t size,
@@ -982,11 +985,16 @@ void log_buf_vmcoreinfo_setup(void)
 
 	VMCOREINFO_STRUCT_SIZE(printk_info);
 	VMCOREINFO_OFFSET(printk_info, seq);
-	VMCOREINFO_OFFSET(printk_info, ts_nsec);
+	VMCOREINFO_OFFSET(printk_info, ts);
 	VMCOREINFO_OFFSET(printk_info, text_len);
 	VMCOREINFO_OFFSET(printk_info, caller_id);
 	VMCOREINFO_OFFSET(printk_info, dev_info);
 
+	VMCOREINFO_STRUCT_SIZE(ktime_timestamps);
+	VMCOREINFO_OFFSET(ktime_timestamps, mono);
+	VMCOREINFO_OFFSET(ktime_timestamps, boot);
+	VMCOREINFO_OFFSET(ktime_timestamps, real);
+
 	VMCOREINFO_STRUCT_SIZE(dev_printk_info);
 	VMCOREINFO_OFFSET(dev_printk_info, subsystem);
 	VMCOREINFO_LENGTH(printk_info_subsystem, sizeof(dev_info->subsystem));
@@ -1094,7 +1102,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->facility = r->info->facility;
 	dest_r.info->level = r->info->level;
 	dest_r.info->flags = r->info->flags;
-	dest_r.info->ts_nsec = r->info->ts_nsec;
+	dest_r.info->ts = r->info->ts;
 	dest_r.info->caller_id = r->info->caller_id;
 	memcpy(&dest_r.info->dev_info, &r->info->dev_info, sizeof(dest_r.info->dev_info));
 
@@ -1320,7 +1328,7 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
 		len = print_syslog((info->facility << 3) | info->level, buf);
 
 	if (time)
-		len += print_time(info->ts_nsec, buf + len);
+		len += print_time(info->ts.mono, buf + len);
 
 	len += print_caller(info->caller_id, buf + len);
 
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 0adaa685d1ca..09082c8472d3 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,7 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/timekeeping.h>
 
 /*
  * Meta information about each stored message.
@@ -14,7 +15,7 @@
  */
 struct printk_info {
 	u64	seq;		/* sequence number */
-	u64	ts_nsec;	/* timestamp in nanoseconds */
+	struct ktime_timestamps ts; /* timestamps */
 	u16	text_len;	/* length of text message */
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
-- 
2.26.2

