Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176B42DD5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgLQRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:21:45 -0500
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:7980 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1728081AbgLQRVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:21:45 -0500
X-ASG-Debug-ID: 1608224419-0e408852cf2d38c0001-xx1T2L
Received: from mail.didiglobal.com (bogon [172.20.36.245]) by bsf01.didichuxing.com with ESMTP id Nwmz1cvZMuXiSevu for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:00:19 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 01:00:19 +0800
Date:   Fri, 18 Dec 2020 01:00:14 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20201217170009.GA29186@192.168.3.9>
X-ASG-Orig-Subj: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Mail-Followup-To: bsingharora@gmail.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.245]
X-Barracuda-Start-Time: 1608224419
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3962
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0002 1.0000 -2.0199
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M, BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.86577
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
        0.50 BSF_RULE7568M          Custom Rule 7568M
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a program needs monitor lots of process's status, it needs two
syscalls for every process. The first one is telling kernel which
pid/tgid should be monitored by send a command(write socket) to kernel.
The second one is read the statistics by read socket. This patch add
a new interface /proc/taskstats to reduce two syscalls to one ioctl.
The user just set the target pid/tgid to the struct taskstats.ac_pid,
then kernel will collect statistics for that pid/tgid.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
Changes since v1:
 * use /proc/taskstats instead of /dev/taskstats

 include/uapi/linux/taskstats.h |  5 +++
 kernel/taskstats.c             | 73 +++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index ccbd08709321..077eab84c77e 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -214,6 +214,11 @@ enum {
 
 #define TASKSTATS_CMD_ATTR_MAX (__TASKSTATS_CMD_ATTR_MAX - 1)
 
+/* ioctl command */
+#define TASKSTATS_IOC_ATTR_PID	_IO('T', TASKSTATS_CMD_ATTR_PID)
+#define TASKSTATS_IOC_ATTR_TGID	_IO('T', TASKSTATS_CMD_ATTR_TGID)
+
+
 /* NETLINK_GENERIC related info */
 
 #define TASKSTATS_GENL_NAME	"TASKSTATS"
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2802b6ff4bb..c0f9e2f2308b 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -21,6 +21,8 @@
 #include <net/genetlink.h>
 #include <linux/atomic.h>
 #include <linux/sched/cputime.h>
+#include <linux/proc_fs.h>
+#include <linux/uio.h>
 
 /*
  * Maximum length of a cpumask that can be specified in
@@ -28,6 +30,10 @@
  */
 #define TASKSTATS_CPUMASK_MAXLEN	(100+6*NR_CPUS)
 
+#ifdef CONFIG_PROC_FS
+#define PROC_TASKSTATS	"taskstats"
+#endif
+
 static DEFINE_PER_CPU(__u32, taskstats_seqnum);
 static int family_registered;
 struct kmem_cache *taskstats_cache;
@@ -666,6 +672,60 @@ static struct genl_family family __ro_after_init = {
 	.n_ops		= ARRAY_SIZE(taskstats_ops),
 };
 
+#ifdef CONFIG_PROC_FS
+static long taskstats_ioctl_pid_tgid(unsigned long arg, bool tgid)
+{
+	struct taskstats kstat;
+	struct taskstats *ustat = (struct taskstats *)arg;
+	u32 id;
+	unsigned long offset = offsetof(struct taskstats, ac_pid);
+	long ret;
+
+	/* userspace set monitored pid/tgid to the field "ac_pid" */
+	if (unlikely(copy_from_user(&id, (void *)(arg + offset), sizeof(u32))))
+		return -EFAULT;
+
+	if (tgid)
+		ret = fill_stats_for_tgid(id, &kstat);
+	else
+		ret = fill_stats_for_pid(id, &kstat);
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(copy_to_user(ustat, &kstat, sizeof(struct taskstats))))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long taskstats_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	switch (cmd) {
+	case TASKSTATS_IOC_ATTR_PID:
+		ret = taskstats_ioctl_pid_tgid(arg, false);
+		break;
+	case TASKSTATS_IOC_ATTR_TGID:
+		ret = taskstats_ioctl_pid_tgid(arg, true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct proc_ops taskstats_proc_ops = {
+	.proc_ioctl = taskstats_ioctl,
+#ifdef CONFIG_COMPAT
+	.proc_compat_ioctl = taskstats_ioctl,
+#endif
+};
+#endif
+
+
 /* Needed early in initialization */
 void __init taskstats_init_early(void)
 {
@@ -682,9 +742,20 @@ static int __init taskstats_init(void)
 {
 	int rc;
 
+#ifdef CONFIG_PROC_FS
+	if (!proc_create(PROC_TASKSTATS,  0, NULL, &taskstats_proc_ops)) {
+		pr_err("failed to create /proc/%s\n", PROC_TASKSTATS);
+		return -1;
+	}
+#endif
+
 	rc = genl_register_family(&family);
-	if (rc)
+	if (rc) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry(PROC_TASKSTATS, NULL);
+#endif
 		return rc;
+	}
 
 	family_registered = 1;
 	pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
-- 
2.17.2

