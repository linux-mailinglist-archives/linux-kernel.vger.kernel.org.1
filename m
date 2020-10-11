Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7228A7E1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbgJKPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:00:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbgJKPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:00:25 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbzhv-1jv1lP0l7X-00dUsr; Sun, 11 Oct 2020 16:59:52 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v3 2/3] fs/proc: apply the time namespace offset to /proc/stat btime
Date:   Sun, 11 Oct 2020 16:59:23 +0200
Message-Id: <20201011145924.6554-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
References: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BlZ+ml3gNUZCR2Ao520OTL3pAiCWgg3Y30IudqkxiTs1H8Gpe9/
 cAIrOtGT5tTm7sZudjczF03rwU2HXXnYZZhbWfUYXwrQWRlb9YboHEiOsxGpMoMv06YUHrW
 Ud/TlKDS3/vjhNkBdVkBLF2g4ltC9FapGxRCNpZJHgOoOMK0SJ+zqxm8qRg8F7ekyLfa5DO
 t/hlH5sz3QIvDp/jQ5Smg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w2Rnp1CuVKI=:mkKbGE+3taQjPLfKu32H/z
 T1SipQxCXA4W+IdjTDh1S4O0AOQK/YG/e1c4tC3icqG70eIiX195z65QoJetpoYxynhPhugyE
 uDf6d9hcFD+wQmTGTAVeHu+dTGXMhwyUDZblzT866lKuRWyeyEraCIVWc1b0O8US/0pBiSuPE
 8olUgLKLustU4GZUbya9XypSZLolb6Ax4GBFQlIkCk27//0TaqC6OqjZlyNY3GB/+qsrTJ/9w
 6dggQKD1kYo4gCQgWvXTQGj5bznbNeEwH8G1pK/20VI6QqHuN3ATBYZQenwDSDFDI4NPMLeSq
 3n5taKZQVNuejNV49ujeEvD/lfnVT7L/Z2hFUH4oUkvkI9CiIjkz/CFhgDJgQaLMc2f5qNhF/
 wmTO3Xs2l8ZFaXuh9SD2HkiPkAPzrIpCjRvUCR33Cn9cFeq4O6FxLN6oh42vCN9W7W3DfSX04
 o8XEja528rIGutNC/jJKEajViyp55St8zMwlWflaNsn/fGy/DNUcRT8w+4GuzvB4OQRUv1ea+
 OwkJkukzDn+plDK8ot2KxsXRV58h1k+Z0f9Q0QyeRp8A4YZtebuBlWpXIc7s3NOaXUXcaZieZ
 Ws6m/cPyWlhsmqCMDKJDL+wr9vxjCxv/wbN8GbggqbFyzwuf18zBVRA5Ps7PB0wwbtqa2yUO4
 sxn0hygMyc+zi6gLn3LdYn4U83rsN9mwOkK7xKNtvLiygRekqNbYOa8Ah7foTGwzhH2aNgxp5
 MUo+Mz7hLdLRt/9bg7GU9qaGnLya+1XvHbj3/W7xC2BIyNhOkttxeYpxT4KFKr8HVkmUr85I5
 78s6jvu4ihwvsy9Zpepts6MBSwbppl6gB56gAgdzz2qOCrdMUeZE4PBlcicGgf1BiMfCXNf7q
 asWeFsGWRuifu0LqEIwQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'/proc/stat' provides the field 'btime' which states the time stamp of
system boot in seconds. In case of time namespaces, the offset to the
boot time stamp was not applied earlier. However, in container
runtimes which utilize time namespaces to virtualize boottime of a
container, this leaks information about the host system boot time.

Therefore, we make procfs to virtualize also the btime field by
subtracting the offset of the timens boottime from 'btime' before
printing the stats.

Since start_boottime of processes are seconds since boottime and the
boottime stamp is now shifted according to the timens offset, the
offset of the time namespace also needs to be applied before the
process stats are given to userspace.

This avoids that processes shown, e.g., by 'ps' appear as time
travelers in the corresponding time namespace.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/proc/array.c |  6 ++++--
 fs/proc/stat.c  | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa80..277f654f289e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -56,6 +56,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/tty.h>
@@ -533,8 +534,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	priority = task_prio(task);
 	nice = task_nice(task);
 
-	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(task->start_boottime);
+	/* apply timens offset for boottime and convert nsec -> ticks */
+	start_time =
+		nsec_to_clock_t(timens_add_boottime_ns(task->start_boottime));
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..5ae59297591a 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
@@ -79,6 +80,20 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 #endif
 
+static void get_boottime(struct timespec64 *ts)
+{
+	ktime_t boottime;
+
+	/* get kernel internal system boot timestamp */
+	getboottime64(ts);
+
+	/* shift boot timestamp according to the timens offset */
+	boottime = timespec64_to_ktime(*ts);
+	boottime = timens_ktime_to_host(CLOCK_BOOTTIME, boottime);
+
+	*ts = ktime_to_timespec64(boottime);
+}
+
 static void show_irq_gap(struct seq_file *p, unsigned int gap)
 {
 	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
@@ -117,7 +132,7 @@ static int show_stat(struct seq_file *p, void *v)
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = 0;
 	guest = guest_nice = 0;
-	getboottime64(&boottime);
+	get_boottime(&boottime);
 
 	for_each_possible_cpu(i) {
 		struct kernel_cpustat kcpustat;
-- 
2.20.1

