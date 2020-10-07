Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04A82868C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgJGUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:01:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgJGUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:01:14 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mm9NA-1kqozl46Vc-00iCmY; Wed, 07 Oct 2020 22:01:02 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 3/4] fs/proc: apply timens offset for start_boottime of processes
Date:   Wed,  7 Oct 2020 22:00:14 +0200
Message-Id: <20201007200015.30868-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
References: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TU8MOXyzC5ITS5h5SQXAVQJaNCSW+GUs23n815igV1Fg49UWUj4
 vv9WA9hwCnHlpdZde/5zpC5h2VrG+ZZVhjBFZjVpHjUQ4O3MO4dHY3P4aIyErLzAJV1Zk4S
 Y1wIfg1031V0Zsx6bdhujKitgTQQZKMhZWI06hmyvBNA+UPr1hFae+Ghu/wDKyVuVk7pghU
 Qqgwz6JKlThGSPlqWlIQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wpTpl0KUL1U=:uAF7UMz4lQ3Ab5LfT7FPyw
 DaaoYJHtPd9W7/avjTV3CPYqmMRjYT/s/rIsA22iSkxdgFSIdbdXG7Is2okLzbRN4zRtMLZK7
 +j7V1upsfQ+oDXHCnn2g9rJnSzz6A0r1+YCjjRsm3oCZe2aPxvz+T9iBIoZk31aWAqSkpf1o3
 F7gSyWSXTWspMO5TIwwmdHk5AEzXbbwB9RW0fOR/bVDJMFp5EZsho/MfKu/xyREx2UyNRn1nH
 Nqumzy92Tros53IPkIYmnVwI728vUXXZ4kwVoEYu/B0zaaQqM7Txb4kwhh0gajWs9WWqwGm/+
 EASk3c+EJGscvtQs+u4UMq2KUFJb7FMyE0OWnq2RzsVq1E4rrT7LIJNyvnrs5YuD0vM9R+vEk
 NdPJhUcXlgMfkP6CK1YmD5i8xR2cpopECbHYUYJbE7rA1wOoE6woBHrD+SU/gNPh5ygItEZBh
 mjUS3X+ElcVYrszRScniX9UExKuyja3ycZJuEJkXT4VkI5fA/94WB55p6vDi3ZYhvtnQTN5DY
 fEje6aqpRHyczYap4SW2/4fs+N2DCZmomnAnIrzIysc/PhBD84MGLqjwCM2eA1pBPq/qvgh68
 Bz4Wb4AtOFpefIyGi9pdSSWAOHP4URfKps3rnuxxS0iWw7j8SVorIyE2P48YE2hjaNdjaks1W
 4I6SQVBs1IQE1pDGGjucwO1KsY+vIulkF1epY+7IcoMKstgA8/YTlgXaru+RexkTPT5z9jvcp
 41rTeo5iuyZi1vUZhlDXQGoNbgiaMhknsQ+a71rdGGLRjAEZw8fl7vASPv8DLbnJTC9S+L34R
 5MVXf4yn0F/quQD+XPyleYKKWFyedhbuevdsgwS56eC1R6wsYO9Wl2z60tQLrjVeNwhxbVvKx
 AJmxk0OukfLvM9yvJk4Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since start_boottime of processes are seconds since boottime and the
boottime stamp is now shifted according to the timens offset, the
offset of the time namespace also needs to be applied before the
process stats are given to userspace.

This avoids that processes shown, e.g., by 'ps' appear as time
travelers in the corresponding time namespace.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/proc/array.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
-- 
2.20.1

