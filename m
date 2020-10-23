Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7F29797E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758464AbgJWXJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758457AbgJWXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:09:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D582168B;
        Fri, 23 Oct 2020 23:09:38 +0000 (UTC)
Date:   Fri, 23 Oct 2020 19:09:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing, synthetic events: Replace buggy strcat() with
 seq_buf operations
Message-ID: <20201023190937.7cd48f5a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There was a memory corruption bug happening while running the synthetic
event selftests:

 kmemleak: Cannot insert 0xffff8c196fa2afe5 into the object search tree (overlaps existing)
 CPU: 5 PID: 6866 Comm: ftracetest Tainted: G        W         5.9.0-rc5-test+ #577
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  dump_stack+0x8d/0xc0
  create_object.cold+0x3b/0x60
  slab_post_alloc_hook+0x57/0x510
  ? tracing_map_init+0x178/0x340
  __kmalloc+0x1b1/0x390
  tracing_map_init+0x178/0x340
  event_hist_trigger_func+0x523/0xa40
  trigger_process_regex+0xc5/0x110
  event_trigger_write+0x71/0xd0
  vfs_write+0xca/0x210
  ksys_write+0x70/0xf0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7fef0a63a487
 Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 RSP: 002b:00007fff76f18398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000039 RCX: 00007fef0a63a487
 RDX: 0000000000000039 RSI: 000055eb3b26d690 RDI: 0000000000000001
 RBP: 000055eb3b26d690 R08: 000000000000000a R09: 0000000000000038
 R10: 000055eb3b2cdb80 R11: 0000000000000246 R12: 0000000000000039
 R13: 00007fef0a70b500 R14: 0000000000000039 R15: 00007fef0a70b700
 kmemleak: Kernel memory leak detector disabled
 kmemleak: Object 0xffff8c196fa2afe0 (size 8):
 kmemleak:   comm "ftracetest", pid 6866, jiffies 4295082531
 kmemleak:   min_count = 1
 kmemleak:   count = 0
 kmemleak:   flags = 0x1
 kmemleak:   checksum = 0
 kmemleak:   backtrace:
      __kmalloc+0x1b1/0x390
      tracing_map_init+0x1be/0x340
      event_hist_trigger_func+0x523/0xa40
      trigger_process_regex+0xc5/0x110
      event_trigger_write+0x71/0xd0
      vfs_write+0xca/0x210
      ksys_write+0x70/0xf0
      do_syscall_64+0x33/0x40
      entry_SYSCALL_64_after_hwframe+0x44/0xa9

The cause came down to a use of strcat() that was adding a string that was
shorten, but the strcat() did not take that into account.

strcat() is extremely dangerous as it does not care how big the buffer is.
Replace it with seq_buf operations that prevent the buffer from being
overwritten if what is being written is bigger than the buffer.

Fixes: 10819e25799a ("tracing: Handle synthetic event array field type checking correctly")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 37 ++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 3212e2c653b3..bdd427ccdfc5 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -585,6 +585,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
+	struct seq_buf s;
 	ssize_t size;
 
 	if (field_type[0] == ';')
@@ -630,13 +631,9 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		field_type++;
 	len = strlen(field_type) + 1;
 
-        if (array) {
-                int l = strlen(array);
+	if (array)
+		len += strlen(array);
 
-                if (l && array[l - 1] == ';')
-                        l--;
-                len += l;
-        }
 	if (prefix)
 		len += strlen(prefix);
 
@@ -645,14 +642,18 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		ret = -ENOMEM;
 		goto free;
 	}
+	seq_buf_init(&s, field->type, len);
 	if (prefix)
-		strcat(field->type, prefix);
-	strcat(field->type, field_type);
+		seq_buf_puts(&s, prefix);
+	seq_buf_puts(&s, field_type);
 	if (array) {
-		strcat(field->type, array);
-		if (field->type[len - 1] == ';')
-			field->type[len - 1] = '\0';
+		seq_buf_puts(&s, array);
+		if (s.buffer[s.len - 1] == ';')
+			s.len--;
 	}
+	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+		goto free;
+	s.buffer[s.len] = '\0';
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
@@ -663,17 +664,23 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		if (synth_field_is_string(field->type)) {
 			char *type;
 
-			type = kzalloc(sizeof("__data_loc ") + strlen(field->type) + 1, GFP_KERNEL);
+			len = sizeof("__data_loc ") + strlen(field->type) + 1;
+			type = kzalloc(len, GFP_KERNEL);
 			if (!type) {
 				ret = -ENOMEM;
 				goto free;
 			}
 
-			strcat(type, "__data_loc ");
-			strcat(type, field->type);
+			seq_buf_init(&s, type, len);
+			seq_buf_puts(&s, "__data_loc ");
+			seq_buf_puts(&s, field->type);
 			kfree(field->type);
-			field->type = type;
 
+			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+				goto free;
+			s.buffer[s.len] = '\0';
+
+			field->type = type;
 			field->is_dynamic = true;
 			size = sizeof(u64);
 		} else {
-- 
2.25.4

