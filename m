Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15762D5D53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbgLJOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:16:38 -0500
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:23941 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S2389288AbgLJOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:16:38 -0500
X-Greylist: delayed 3597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 09:16:27 EST
X-ASG-Debug-ID: 1607605365-0e408852cf134c0001-xx1T2L
Received: from mail.didiglobal.com (bogon [172.20.36.211]) by bsf01.didichuxing.com with ESMTP id CWRvRw7G0Y1sAVn3 for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 21:02:45 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Dec
 2020 21:02:44 +0800
Date:   Thu, 10 Dec 2020 21:02:40 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] taskstats: add ioctl to fetch pid/tgid status
Message-ID: <20201210130235.GA36889@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] taskstats: add ioctl to fetch pid/tgid status
Mail-Followup-To: bsingharora@gmail.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.211]
X-Barracuda-Start-Time: 1607605365
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3088
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0208
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.86418
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a program needs monitor lots of process's status, it needs two
syscalls for every process. The first one is telling kernel which
pid/tgid should be monitored by send a command(write socket) to kernel.
The second one is read the statistics by read socket. This patch add
a new interface /dev/taskstats to reduce two syscalls to one ioctl.
The user just set the target pid/tgid to the struct taskstats.ac_pid,
then kernel will collect statistics for that pid/tgid.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 kernel/taskstats.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2802b6ff4bb..68188cc9663d 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -21,6 +21,8 @@
 #include <net/genetlink.h>
 #include <linux/atomic.h>
 #include <linux/sched/cputime.h>
+#include <linux/miscdevice.h>
+#include <linux/uio.h>
 
 /*
  * Maximum length of a cpumask that can be specified in
@@ -666,6 +668,67 @@ static struct genl_family family __ro_after_init = {
 	.n_ops		= ARRAY_SIZE(taskstats_ops),
 };
 
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
+	case TASKSTATS_CMD_ATTR_PID:
+		ret = taskstats_ioctl_pid_tgid(arg, false);
+		break;
+	case TASKSTATS_CMD_ATTR_TGID:
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
+static const struct file_operations taskstats_ctl_fops = {
+	.open		= nonseekable_open,
+	.unlocked_ioctl	= taskstats_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= taskstats_ioctl,
+#endif
+	.owner		= THIS_MODULE,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice taskstats_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "taskstats",
+	.fops		= &taskstats_ctl_fops,
+};
+
+
 /* Needed early in initialization */
 void __init taskstats_init_early(void)
 {
@@ -682,9 +745,15 @@ static int __init taskstats_init(void)
 {
 	int rc;
 
+	rc = misc_register(&taskstats_misc);
+	if (rc < 0)
+		return rc;
+
 	rc = genl_register_family(&family);
-	if (rc)
+	if (rc) {
+		misc_deregister(&taskstats_misc);
 		return rc;
+	}
 
 	family_registered = 1;
 	pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
-- 
2.17.2

