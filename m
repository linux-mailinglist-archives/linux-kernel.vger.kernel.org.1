Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE202D130D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgLGODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgLGODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:03:43 -0500
Date:   Mon, 7 Dec 2020 23:02:59 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607349782;
        bh=c8F/EMVNqrZP/Sq22+3WN6B8BYsZhcLeYaH7Qt9xiUA=;
        h=From:To:Cc:Subject:From;
        b=dxzQBYVoVlZCpPDfl87TogRmeoeyP+LqqUh0muewBkZ0yDwN0RdnmE249LuRIEL83
         CjGFEUzEdmQKu12Tu8wmyCsRLjsS1kjSLhbSaslGamAOpbwX9Ozz7eoezuIP6TNlus
         FpdKgBQ5eR+Qza3/ukFYV1S72+UA7vikSbxW7uRSD7l2xtNhEI1VXlz4C0TUkuXMMG
         +vH+LCUv28kJD2XUpIffn0bN7gwLN90FLLV/9GyQRkMyg/QSayyqyctP3YjKPtjDm4
         Y2rVDRi6ddZMLRt7y9S5MjU3hAjQJhtKKNp/VZcK3kiuS9kUeW4K6k2UGaDvQeJ+fY
         KpqPNdUPEwpPQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Ftrace startup test and boot-time tracing
Message-Id: <20201207230259.250ecc2a52281def3f8335f4@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I found that if I enabled the CONFIG_FTRACE_STARTUP_TEST=y and booted the
kernel with kprobe-events defined by boot-time tracing, a warning output.

[   59.803496] trace_kprobe: Testing kprobe tracing: 
[   59.804258] ------------[ cut here ]------------
[   59.805682] WARNING: CPU: 3 PID: 1 at kernel/trace/trace_kprobe.c:1987 kprobe_trace_self_tests_ib
[   59.806944] Modules linked in:
[   59.807335] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc7+ #172
[   59.808029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/204
[   59.808999] RIP: 0010:kprobe_trace_self_tests_init+0x5f/0x42b
[   59.809696] Code: e8 03 00 00 48 c7 c7 30 8e 07 82 e8 6d 3c 46 ff 48 c7 c6 00 b2 1a 81 48 c7 c7 7
[   59.812439] RSP: 0018:ffffc90000013e78 EFLAGS: 00010282
[   59.813038] RAX: 00000000ffffffef RBX: 0000000000000000 RCX: 0000000000049443
[   59.813780] RDX: 0000000000049403 RSI: 0000000000049403 RDI: 000000000002deb0
[   59.814589] RBP: ffffc90000013e90 R08: 0000000000000001 R09: 0000000000000001
[   59.815349] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffef
[   59.816138] R13: ffff888004613d80 R14: ffffffff82696940 R15: ffff888004429138
[   59.816877] FS:  0000000000000000(0000) GS:ffff88807dcc0000(0000) knlGS:0000000000000000
[   59.817772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.818395] CR2: 0000000001a8dd38 CR3: 0000000002222000 CR4: 00000000000006a0
[   59.819144] Call Trace:
[   59.819469]  ? init_kprobe_trace+0x6b/0x6b
[   59.819948]  do_one_initcall+0x5f/0x300
[   59.820392]  ? rcu_read_lock_sched_held+0x4f/0x80
[   59.820916]  kernel_init_freeable+0x22a/0x271
[   59.821416]  ? rest_init+0x241/0x241
[   59.821841]  kernel_init+0xe/0x10f
[   59.822251]  ret_from_fork+0x22/0x30
[   59.822683] irq event stamp: 16403349
[   59.823121] hardirqs last  enabled at (16403359): [<ffffffff810db81e>] console_unlock+0x48e/0x580
[   59.824074] hardirqs last disabled at (16403368): [<ffffffff810db786>] console_unlock+0x3f6/0x580
[   59.825036] softirqs last  enabled at (16403200): [<ffffffff81c0033a>] __do_softirq+0x33a/0x484
[   59.825982] softirqs last disabled at (16403087): [<ffffffff81a00f02>] asm_call_irq_on_stack+0x10
[   59.827034] ---[ end trace 200c544775cdfeb3 ]---
[   59.827635] trace_kprobe: error on probing function entry.

This is actually similar issue which you had fixed with commit b6399cc78934
("tracing/kprobe: Do not run kprobe boot tests if kprobe_event is on cmdline").

Fixing this kprobes warning is easy (see attached below), but I think this
has to be fixed widely, because other testcase also changes the boot-time
tracing results or may not work correctly with it.

There will be the 2 options, one is to change kconfig so that user can not
select FTRACE_STARTUP_TEST if BOOTTIME_TRACING=y, another is to provide
a flag from trace_boot and all tests checks the flag at runtime.
(moreover, that flag will be good to be set from other command-line options)
What would you think?

Thank you,

From 00037083baca07a8705da39852480f6f53a8297c Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 7 Dec 2020 22:53:16 +0900
Subject: [PATCH] tracing/kprobes: Fix to skip kprobe-events startup test if
 kprobe-events is used

commit b6399cc78934 ("tracing/kprobe: Do not run kprobe boot tests
if kprobe_event is on cmdline") had fixed the same issue with
kprobe-events on kernel cmdline, but boot-time tracing re-introduce
similar issue.

When the boot-time tracing uses kprobe-events with ftrace startup
test, it produced a warning on the kprobe-events startup test
because the testcase doesn't expect any kprobe events exists.

To mitigate the warning, skip the kprobe-events startup test
if any kprobe-event is defined before starting the test.

Fixes: 4d655281eb1b ("tracing/boot Add kprobe event support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b911e9f6d9f5..515e139236f2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -25,7 +25,6 @@
 
 /* Kprobe early definition from command line */
 static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
-static bool kprobe_boot_events_enabled __initdata;
 
 static int __init set_kprobe_boot_events(char *str)
 {
@@ -1887,8 +1886,6 @@ static __init void setup_boot_kprobe_events(void)
 		ret = trace_run_command(cmd, create_or_delete_trace_kprobe);
 		if (ret)
 			pr_warn("Failed to add event(%d): %s\n", ret, cmd);
-		else
-			kprobe_boot_events_enabled = true;
 
 		cmd = p;
 	}
@@ -1959,6 +1956,20 @@ find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
 	return NULL;
 }
 
+static __init int trace_kprobe_exist(void)
+{
+	struct trace_kprobe *tk;
+	struct dyn_event *pos;
+	int n = 0;
+
+	mutex_lock(&event_mutex);
+	for_each_trace_kprobe(tk, pos) {
+		n++;
+	}
+	mutex_unlock(&event_mutex);
+
+	return n;
+}
 /*
  * Nobody but us can call enable_trace_kprobe/disable_trace_kprobe at this
  * stage, we can do this lockless.
@@ -1973,8 +1984,8 @@ static __init int kprobe_trace_self_tests_init(void)
 	if (tracing_is_disabled())
 		return -ENODEV;
 
-	if (kprobe_boot_events_enabled) {
-		pr_info("Skipping kprobe tests due to kprobe_event on cmdline\n");
+	if (trace_kprobe_exist()) {
+		pr_info("Skipping kprobe tests because kprobe_event is used on boot.\n");
 		return 0;
 	}
 
-- 
2.25.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
