Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D22966EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372674AbgJVWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:05:02 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36989 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372666AbgJVWFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:05:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603404300; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nKH7VLBQhE3Mu51emIZ9NIquRcR56rtwk5fWzTGhkoo=; b=hwwAnd6HANRKd8sL1YgTd4do4fFrDzbv2pFycqGbb9jlAqflsxxX9rUsq3MWWMM+7KImXmGk
 6xXLPaKhd28R1VEBHkWompyVi4vtVTxjjCWq+HC7M62DGUKfcSgsJsafauw1UIT8Q68O2YJ2
 nD6k5yE0NjoCe3jErKkEMdTeKKk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f9201dbbfed2afaa6864793 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Oct 2020 22:04:11
 GMT
Sender: eberman=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FE7EC433FF; Thu, 22 Oct 2020 22:04:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA3F4C433C9;
        Thu, 22 Oct 2020 22:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA3F4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
Date:   Thu, 22 Oct 2020 15:04:03 -0700
Message-Id: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a heterogeneous multiprocessor system, specifying the 'maxcpus'
parameter on kernel command line does not provide sufficient control
over which CPUs are brought online at kernel boot time, since CPUs may
have nonuniform performance characteristics. Thus, add bootcpus kernel
parameter to control which CPUs should be brought online during kernel
boot. When both maxcpus and bootcpus is set, the more restrictive of the
two are booted.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 include/linux/cpu.h                             |  2 +-
 kernel/cpu.c                                    |  4 ++--
 kernel/smp.c                                    | 28 +++++++++++++++++++++++--
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65d047f..ea31af3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -449,6 +449,14 @@
 
 			See Documentation/admin-guide/bootconfig.rst
 
+	bootcpus=	[SMP]  List of processors that an SMP kernel
+			will bring up during bootup. Similar to maxcpus, except
+			as a cpu list as described above. The more restrictive
+			of maxcpus and bootcpus applies. If bootcpus=1-3 and
+			maxcpus=2, only processors 1 and 2 are booted. As with
+			maxcpus, you can bring up other plugged cpu by executing
+			"echo 1 > /sys/devices/system/cpu/cpuX/online"
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8aa84c0..4146f71 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -95,7 +95,7 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 int bringup_hibernate_cpu(unsigned int sleep_cpu);
-void bringup_nonboot_cpus(unsigned int setup_max_cpus);
+void bringup_nonboot_cpus(unsigned int setup_max_cpus, cpumask_var_t boot_cpus);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578..71f626b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1328,14 +1328,14 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 	return 0;
 }
 
-void bringup_nonboot_cpus(unsigned int setup_max_cpus)
+void bringup_nonboot_cpus(unsigned int setup_max_cpus, cpumask_var_t boot_cpus)
 {
 	unsigned int cpu;
 
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >= setup_max_cpus)
 			break;
-		if (!cpu_online(cpu))
+		if (!cpu_online(cpu) && cpumask_test_cpu(cpu, boot_cpus))
 			cpu_up(cpu, CPUHP_ONLINE);
 	}
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501..727e003 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -738,7 +738,7 @@ EXPORT_SYMBOL(smp_call_function);
 /* Setup configured maximum number of CPUs to activate */
 unsigned int setup_max_cpus = NR_CPUS;
 EXPORT_SYMBOL(setup_max_cpus);
-
+static cpumask_var_t boot_cpus;
 
 /*
  * Setup routine for controlling SMP activation
@@ -787,6 +787,27 @@ static int __init maxcpus(char *str)
 
 early_param("maxcpus", maxcpus);
 
+static int __init bootcpus(char *str)
+{
+	alloc_bootmem_cpumask_var(&boot_cpus);
+	if (cpulist_parse(str, boot_cpus) < 0) {
+		pr_warn("incorrect bootcpus mask\n");
+		return -EINVAL;
+	}
+	cpumask_set_cpu(smp_processor_id(), boot_cpus);
+	return 0;
+}
+
+early_param("bootcpus", bootcpus);
+
+static void __init boot_cpus_init(void)
+{
+	if (!cpumask_available(boot_cpus))
+		zalloc_cpumask_var(&boot_cpus, GFP_NOWAIT);
+	if (cpumask_empty(boot_cpus))
+		cpumask_setall(boot_cpus);
+}
+
 /* Setup number of possible processor ids */
 unsigned int nr_cpu_ids __read_mostly = NR_CPUS;
 EXPORT_SYMBOL(nr_cpu_ids);
@@ -804,10 +825,13 @@ void __init smp_init(void)
 
 	idle_threads_init();
 	cpuhp_threads_init();
+	boot_cpus_init();
 
 	pr_info("Bringing up secondary CPUs ...\n");
 
-	bringup_nonboot_cpus(setup_max_cpus);
+	bringup_nonboot_cpus(setup_max_cpus, boot_cpus);
+
+	free_bootmem_cpumask_var(boot_cpus);
 
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

