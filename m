Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FC2AA10A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgKFX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:26:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKFX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:26:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6NJ4wP066494;
        Fri, 6 Nov 2020 23:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=2tRXw/dchPQ13IhlNROOnimve1oFHuJwjVjFCIkQL9s=;
 b=t4xJ7y8D5a6j2f17ZwmtzWXhWCibYCpYKHz5hM4k35Ijao8Zd7CSE5HcNASyWw+7u6kn
 CRWidzhqXwCQE3Qnpzh7DDoysDdeSw2Zt5u67slbp662TgMnTljTU3fy/8P3TEvsibol
 cXtMU6V6lCg0aEu8720TIiAYOy3+TtP8YwLRmeltCdByw0WkIoXHq/pjiksub6RM0OhW
 cTCh6J55RfhxZQUZhh+iuJhg5wp+CyyUpeOq9UlynqwFDxUiy4iyA+k6oYjtaee5JZmS
 3tpTJc85Q3m5BDiWj6iyXJoZi6tCMr+WPN0a1oP4pJPDc11sV3GsaK6oITu2eal3+RRU lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw33g8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 23:25:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6NJtOf098828;
        Fri, 6 Nov 2020 23:25:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34hvs3bg1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 23:25:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A6NPtas032501;
        Fri, 6 Nov 2020 23:25:56 GMT
Received: from ca-dev-arm29.us.oracle.com (/10.129.136.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 15:25:55 -0800
From:   Henry Willard <henry.willard@oracle.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <qais.yousef@arm.com>
Subject: [PATCH] arm64: kexec: Use smp_send_stop in machine_shutdown
Date:   Fri,  6 Nov 2020 15:25:48 -0800
Message-Id: <1604705148-1831-1-git-send-email-henry.willard@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_shutdown() is called by kernel_kexec() to shutdown
the non-boot CPUs prior to starting the new kernel. The
implementation of machine_shutdown() varies by architecture.
Many make an interprocessor call, such as smp_send_stop(),
to stop the non-boot CPUs. On some architectures the CPUs make
some sort of firmware call to stop the CPU. On some architectures
without the necessary firmware support to stop the CPU, the CPUs
go into a disabled loop, which is not suitable for supporting
kexec. On Arm64 systems that support PSCI, CPUs can be stopped
with a PSCI CPU_OFF call.

Arm64 machine_shutdown() uses the CPU hotplug infrastructure via
smp_shutdown_nonboot_cpus() to stop each CPU. This is relatively
slow and takes a best case of .02 to .03 seconds per CPU which are
stopped sequentially. This can take the better part of a second for
all the CPUs to be stopped depending on how many CPUs are present.
If for some reason the CPUs are busy at the time of the kexec reboot,
it can take several seconds to shut them all down. Each CPU shuts
itself down by calling PSCI CPU_OFF.

In some applications such as embedded systems, which need a very
fast reboot (less than a second), this may be too slow.

This patch reverts to using smp_send_stop() to signal all
CPUs to stop immediately. Currently smp_send_stop() causes each cpu
to call local_cpu_stop(), which goes into a disabled loop. This patch
modifies local_cpu_stop() to call cpu_die() when kexec_in_progress
is true, so that the CPU calls PSCI CPU_OFF just as in the case of
smp_shutdown_nonboot_cpus(). Using smp_send_stop() instead of
smp_shutdown_nonboot_cpus() reduces the shutdown time for 23 CPUs
from about .65 seconds on an idle system to less than 5 msecs. On a
busy system smp_shutdown_nonboot_cpus() may take several seconds,
while smp_send_stop() needs only the 5 msecs.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 arch/arm64/kernel/process.c | 17 ++++++++++++++---
 arch/arm64/kernel/smp.c     |  8 +++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4784011cecac..2568452a2417 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -44,6 +44,7 @@
 #include <linux/percpu.h>
 #include <linux/thread_info.h>
 #include <linux/prctl.h>
+#include <linux/kexec.h>
 
 #include <asm/alternative.h>
 #include <asm/arch_gicv3.h>
@@ -142,12 +143,22 @@ void arch_cpu_idle_dead(void)
  * This must completely disable all secondary CPUs; simply causing those CPUs
  * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
  * kexec'd kernel to use any and all RAM as it sees fit, without having to
- * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
- * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
+ * avoid any code or data used by any SW CPU pin loop. The target stop function
+ * will call cpu_die() if kexec_in_progress is set.
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	unsigned long timeout;
+
+	/*
+	 * Don't wait forever, but no longer than a second
+	 */
+	timeout = USEC_PER_SEC;
+
+	smp_send_stop();
+	while (num_online_cpus() > 1 && timeout--)
+		udelay(1);
+	return;
 }
 
 /*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09c96f57818c..310cdf327d91 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -373,7 +373,9 @@ void cpu_die(void)
 	unsigned int cpu = smp_processor_id();
 	const struct cpu_operations *ops = get_cpu_ops(cpu);
 
-	idle_task_exit();
+	/* Skip this if we are about to exit the machine */
+	if (!kexec_in_progress)
+		idle_task_exit();
 
 	local_daif_mask();
 
@@ -847,6 +849,10 @@ static void local_cpu_stop(void)
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
+
+	if (kexec_in_progress)
+		cpu_die();
+
 	cpu_park_loop();
 }
 
-- 
1.8.3.1

