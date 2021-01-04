Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A022E9F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 22:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbhADVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 16:19:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbhADVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:19:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104L9dNc003882;
        Mon, 4 Jan 2021 21:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=9ojcTcaM3gIEY709+rRG+8FrnL6PBjOHQdo9WnL4oWE=;
 b=VD9u/bkx1GvHB2D5L8UQT36+8sq1afEYBb3WoVzxfLRPTXNKU7edBXPwx/0i1zhCxosX
 7KGPY0iAu1Q/U/xQotQ6/pogqTqb0BcTEi9Mpic4GBW9vmW+09Rc85JY+QYEZgkdgWHu
 bqXr5JLoGQMDj0dkfNiRE8DLgeur0IU1NOhoELg++vygtHngjqwkR/6qZyefmRiknoKa
 uifEL7lWW5wCdW0lRfv4ks7xtwV55RmrpuDGK+fX4/wiTjRBfqp8xfkoNZFjcpNyCj69
 3lZmvmWDrn0EqQsB4dQn4zj1CNbr47u1Xs5srqyPMVNpqZQ/rLQapq2IDPJFTP3taRbr rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35tg8qx8ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 21:18:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104LAJuE172572;
        Mon, 4 Jan 2021 21:16:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnrqxh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 21:16:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104LGA7A005783;
        Mon, 4 Jan 2021 21:16:10 GMT
Received: from ca-virt2-1.us.oracle.com (/10.211.11.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 21:16:10 +0000
From:   =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v1] panic: push panic() messages to the console even from the MCE nmi handler
Date:   Mon,  4 Jan 2021 16:15:55 -0500
Message-Id: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Roche <william.roche@oracle.com>

Force push panic messages to the console as panic() can be called from NMI
interrupt handler functions where printed messages can't always reach the
console without an explicit push provided by printk_safe_flush_on_panic()
and console_flush_on_panic().
This is the case with the MCE handler that can lead to a system panic
giving information on the fatal MCE root cause that must reach the console.

Signed-off-by: William Roche <william.roche@oracle.com>
---

Notes:
    	While testing MCE injection and kernel reaction, we discovered a bug
    in the way the kernel provides the panic reason information: When dealing
    with fatal MCE, the machine (physical or virtual) can reboot without
    leaving any message on the console.
    
    	This behavior can be reproduced on Intel with the mce-inject tool
    with a simple:
    	# modprobe mce-inject
    	# mce-inject test/uncorrected
    
    	The investigations showed that the MCE panic can be totally message-less
    or can give a small set of messages. This behavior depends on the use of the
    crash_kexec mechanism (using the "crashkernel" parameter). Not using this
    parameter, we get a partial [Hardware Error] information on panic, but some
    important notifications can be missing. And when using it, a fatal MCE can
    panic the system without leaving any information.
    
    . Without "crashkernel", a Fatal MCE injection shows:
    
    [  212.153928] mce: Machine check injector initialized
    [  236.730682] mce: Triggering MCE exception on CPU 0
    [  236.731304] Disabling lock debugging due to kernel taint
    [  236.731947] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 1: b000000000000000
    [  236.731948] mce: [Hardware Error]: TSC 78418fb4a83f
    [  236.731949] mce: [Hardware Error]: PROCESSOR 0:406f1 TIME 1605312952 SOCKET 0 APIC 0 microcode 1
    [  236.731949] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
    [  236.731950] mce: [Hardware Error]: Machine check: MCIP not set in MCA handler
    [  236.731950] Kernel panic - not syncing: Fatal machine check
    [  236.732047] Kernel Offset: disabled
    
    	The system hangs 30 seconds without any additional message, and finally
    reboots.
    
    . With the use of "crashkernel", a Fatal MCE injection shows only the
    injection message
    
    [   80.811708] mce: Machine check injector initialized
    [   92.298755] mce: Triggering MCE exception on CPU 0
    [   92.299362] Disabling lock debugging due to kernel taint
    
    	No other messages is displayed and the system reboots immediately.
    
    The reason behind this defective behavior is the fact that
    do_machine_check() MCE handler can call mce_panic() to finish in panic()
    trying to print out messages on the console. So we end up trying to print
    out messages directly from this interrupt handler, which can require the
    help of additional function calls like printk_safe_flush_on_panic() and
    console_flush_on_panic().
    
    With the suggested fix here, the above output turns into the expected:
    
    . Without crashkernel:
    [   92.025010] mce: Machine check injector initialized
    [  113.006798] mce: Triggering MCE exception on CPU 0
    [  113.007391] Disabling lock debugging due to kernel taint
    [  113.008061] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 1: b000000000000000
    [  113.008062] mce: [Hardware Error]: TSC 2ec380a0f187
    [  113.008063] mce: [Hardware Error]: PROCESSOR 0:406f1 TIME 1606223541 SOCKET 0 APIC 0 microcode 1
    [  113.008063] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
    [  113.008064] mce: [Hardware Error]: Machine check: MCIP not set in MCA handler
    [  113.008064] Kernel panic - not syncing: Fatal machine check
    [  113.013010] Kernel Offset: disabled
    [  113.013426] Rebooting in 30 seconds..
    
    	Note that we now have the important information about the Reboot in
    30 seconds.
    
    . With crashkernel:
    [   75.770143] mce: Machine check injector initialized
    [  100.923650] mce: Triggering MCE exception on CPU 0
    [  100.924415] Disabling lock debugging due to kernel taint
    [  100.925094] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 1: b000000000000000
    [  100.925095] mce: [Hardware Error]: TSC 2f3aa07b03de
    [  100.925096] mce: [Hardware Error]: PROCESSOR 0:406f1 TIME 1606223692 SOCKET 0 APIC 0 microcode 1
    [  100.925097] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
    [  100.925098] mce: [Hardware Error]: Machine check: MCIP not set in MCA handler
    [  100.925100] Kernel panic - not syncing: Fatal machine check
    
    	Here the reboot is immediate but the MCE error message reaches the
    console.
    
    Could you please review this fix ?
    
    Thanks in advance for any feedback you could have.
    William.

 kernel/panic.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 332736a..eb90cc0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -166,6 +166,15 @@ static void panic_print_sys_info(void)
 		ftrace_dump(DUMP_ALL);
 }
 
+/*
+ * Force flush messages to the console.
+ */
+static void panic_flush_to_console(void)
+{
+	printk_safe_flush_on_panic();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -247,7 +256,7 @@ void panic(const char *fmt, ...)
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
 	if (!_crash_kexec_post_notifiers) {
-		printk_safe_flush_on_panic();
+		panic_flush_to_console();
 		__crash_kexec(NULL);
 
 		/*
@@ -271,9 +280,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	/* Call flush even twice. It tries harder with a single online CPU */
-	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
+	panic_flush_to_console();
 
 	/*
 	 * If you doubt kdump always works fine in any situation,
@@ -298,7 +306,7 @@ void panic(const char *fmt, ...)
 	 * buffer.  Try to acquire the lock then release it regardless of the
 	 * result.  The release will also print the buffers out.  Locks debug
 	 * should be disabled to avoid reporting bad unlock balance when
-	 * panic() is not being callled from OOPS.
+	 * panic() is not being called from OOPS.
 	 */
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
@@ -314,6 +322,7 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+		panic_flush_to_console();
 
 		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -347,6 +356,7 @@ void panic(const char *fmt, ...)
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+	panic_flush_to_console();
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
-- 
1.8.3.1

