Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB268292EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgJSTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:53:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgJSTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:53:56 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZkYx-1kyTtQ0p6t-00WpK0; Mon, 19 Oct 2020 21:53:27 +0200
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
Subject: [PATCH v4 2/3] fs/proc: apply the time namespace offset to /proc/stat btime
Date:   Mon, 19 Oct 2020 21:52:56 +0200
Message-Id: <20201019195257.10728-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+TEBeIPpqLzjNZ4dA/j/i52GR2zdmf89+oO25GA0EKFZHQ3pDlq
 SQSyvLZe3JbBcEvepLjkrN1U7HCs0q79+RWl7TTZ9sQ6gDsDhlVRn9FbeM5EVkt7EnNjfiD
 JiIdSvhlJ8qHdob6bOfkmyEeHfnxxWk2C32ROWBR0Vd0QZpqFQseDC/ix+PC6YmsLr3Grhq
 Dkdxmi4k0+yFFRwzYjEfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEi72Y8a9zE=:BMlzomdOVvV9/Sv0uQtT3P
 H9feQWmPJlCptGYy1Xyc2j+/tLQaZRZsEueMvYvkmirN/J0u0edXJxIqlky76ik5D05kYGbp6
 xxiHX+9AnNnvfo/wJvZnkYES9I4cmfg4eh9L88G05xEUigsdpxq3IH//a0WxTM+DACMCKJWNK
 w7rie6e3V4mBbGerTwxSBYTcPX5Lh8QEheQ5MQ0h6YGbtBIFMohmqBi+3BXgQQiDhaQ/au60h
 i3jYfO4yWyCxnyMyTqugRUPVq28ltKXLg/iWFquzxnnDeIlzuABGmpBviKTYO/mUcPJtLG8Eh
 98ph0JGGOHS2whbwUR9axa/p5YqTYDpei7DOpEcf2sxXzP7Vi9AlmJJXDrdyD2gRbp3O0kZ8P
 BsJ+XAVozUbjVEmpJDiKriGlUcyYsJB4EyMj1nCzDZkcRKoXXDil67k6+o/499ieuv0IMdrvQ
 iE0L2audjD1spVv8RbguEM5ud8OKJkQ=
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

