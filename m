Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766229CA89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373121AbgJ0Unv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:43:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444404AbgJ0Unv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:43:51 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPosX-1klcYT1OCJ-00MsYB; Tue, 27 Oct 2020 21:43:22 +0100
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
Subject: [PATCH v5 2/3] fs/proc: apply the time namespace offset to /proc/stat btime
Date:   Tue, 27 Oct 2020 21:42:57 +0100
Message-Id: <20201027204258.7869-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
References: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pStfLKp+1UGGUytPlNfr4G1VQSSbzAUy7INCEsakj+97qr3BzDy
 4ayuQu2ztlwWHq8BKog9pPTWv23UO5LbGX4z6rYoOb+NlCyXuaVZFEHkOUTqfsZ0LfSU8g4
 HwOtaXLaJxkTjfUJ/rcqm+IhDPJxd6F2o235UMtLhax2Z1n+YL46KQtDEWMsThDLRHjFiEG
 6zsA3EaQr06ovi0oMm7QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWejzHoRkpY=:vfuRR8ebRyaiIl6xZVDywT
 4SdIWDn4hrXINQzeLJvsX5Ki6Y1j+emdMsn5+GoxPqYB2cmHzyNYpVi+GMosHwZCmPpJYF8/y
 OVaq/dV7Q02b2i5CoKZgARmAJexuKfOkMcBTWrIXUUXeNs6P8Lw6cMQI5W0mKZwp6LRvX7q+G
 42bMWwVRJGQ9bF+/1Fw0zeYMDzr2qPQr9BeMSAaLrRAw+PtIshb6OPEte6c7DfEYV0/+54AYY
 JmruKemK+PoHDU8Ha68jthBuZqr9c6opH0jbHBX7ViFqZmGGt4M9dcIByt2KUoGazP/i96liM
 DyP6qxl+KBJ+MR3ng5u2GygAESCfDDffZUKb/RHkIpyZS6mwytzBYL+3sPwYmAhTtDuVTrdx5
 Php5iWv6tPJa5PIn3sxT+xUj9IKt19vtUr38ookyYeeE8s3YCDMj5henKpusbsqwjWLK8FN05
 5DOTM7wdkHgng19fkUGTF7zfyS4YuK8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'/proc/stat' provides the field 'btime' which states the time stamp of
system boot in seconds. In case of time namespaces, the offset to the
boot time stamp was not applied earlier.
This confuses tasks which are in another time universe, e.g., in a
container of a container runtime which utilize time namespaces to
virtualize boottime.

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
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/array.c | 6 ++++--
 fs/proc/stat.c  | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 46b3293015fe..9df128ea9417 100644
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
@@ -118,6 +119,8 @@ static int show_stat(struct seq_file *p, void *v)
 		irq = softirq = steal = 0;
 	guest = guest_nice = 0;
 	getboottime64(&boottime);
+	/* shift boot timestamp according to the timens offset */
+	timens_sub_boottime(&boottime);
 
 	for_each_possible_cpu(i) {
 		struct kernel_cpustat kcpustat;
-- 
2.20.1

