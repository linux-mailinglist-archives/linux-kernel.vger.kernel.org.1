Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF01D270927
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRX1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 19:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgIRX1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 19:27:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IN0isR093076;
        Fri, 18 Sep 2020 19:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=2Ds5r1v6f9ceQqOExZQOdajAD7V5ZU6MzzYQvVTIiSc=;
 b=PVk4TZPmhh0tNJGhj3Ousfcdl3QgKHSbUBE8ayByDKn/mLE0Pqk1mYSr8QUJMQj9qTA4
 IAgrruEj7s8eskD0e5AK4dZaTM5QJJFmUQk9sdu7lNoaYgTJWAwxBIk4AWnhgfi9Isab
 C/gp7JGDB8zH+NGrzRcHMNFTthop5skbBqO28hn+32FglA8ZwjYEmqw1tKJO++1ig/mx
 dzKrZZbIEPXFt+lVrRTjSNpnkZCY8z+88RkLLRBh50SVPgFCKm0WZxK5Dk7PpAfmWQSQ
 oQDnIPLoJLY1BK+HbT9hWpaKmYnctpgFPfaV2su4mtP4vYuCATx12e4Ah20OTd+BhsN/ Rg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33n5kmh4h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 19:27:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08INMWbt011074;
        Fri, 18 Sep 2020 23:27:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 33k65v1vee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 23:27:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08INRRx131457544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 23:27:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 730344203F;
        Fri, 18 Sep 2020 23:27:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C49442041;
        Fri, 18 Sep 2020 23:27:27 +0000 (GMT)
Received: from localhost (unknown [9.145.8.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Sep 2020 23:27:26 +0000 (GMT)
Date:   Sat, 19 Sep 2020 01:27:25 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.9-rc6
Message-ID: <your-ad-here.call-01600471645-ext-5592@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_18:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc6.

Thank you,
Vasily

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-6

for you to fetch changes up to cd4d3d5f21ddbfae3f686ac0ff405f21f7847ad3:

  s390: add 3f program exception handler (2020-09-14 10:08:07 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc6

- Fix order in trace_hardirqs_off_caller() to make locking state
  consistent even if the IRQ tracer calls into lockdep again.
  Touches common code. Acked-by Peter Zijlstra.

- Correctly handle secure storage violation exception to avoid kernel
  panic triggered by user space misbehaviour.

- Switch the idle->seqcount over to using raw_write_*() to avoid
  "suspicious RCU usage".

- Fix memory leaks on hard unplug in pci code.

- Use kvmalloc instead of kmalloc for larger allocations in zcrypt.

- Add few missing __init annotations to static functions to avoid section
  mismatch complains when functions are not inlined.

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: fix kmalloc 256k failure

Ilya Leoshkevich (1):
      s390/init: add missing __init annotations

Janosch Frank (1):
      s390: add 3f program exception handler

Niklas Schnelle (1):
      s390/pci: fix leak of DMA tables on hard unplug

Peter Zijlstra (1):
      s390/idle: fix suspicious RCU usage

Sven Schnelle (1):
      lockdep: fix order in trace_hardirqs_off_caller()

 arch/s390/kernel/entry.h             |  1 +
 arch/s390/kernel/idle.c              |  5 ++---
 arch/s390/kernel/pgm_check.S         |  2 +-
 arch/s390/kernel/setup.c             |  6 +++---
 arch/s390/mm/fault.c                 | 20 ++++++++++++++++++++
 arch/s390/pci/pci.c                  |  4 ++++
 arch/s390/pci/pci_event.c            |  2 ++
 drivers/s390/crypto/zcrypt_ccamisc.c |  8 ++++----
 kernel/trace/trace_preemptirq.c      |  4 ++--
 9 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index faca269d5f27..a44ddc2f2dec 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -26,6 +26,7 @@ void do_protection_exception(struct pt_regs *regs);
 void do_dat_exception(struct pt_regs *regs);
 void do_secure_storage_access(struct pt_regs *regs);
 void do_non_secure_storage_access(struct pt_regs *regs);
+void do_secure_storage_violation(struct pt_regs *regs);
 
 void addressing_exception(struct pt_regs *regs);
 void data_exception(struct pt_regs *regs);
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index c73f50649e7e..f7f1e64e0d98 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -39,14 +39,13 @@ void enabled_wait(void)
 	local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	/* XXX seqcount has tracepoints that require RCU */
-	write_seqcount_begin(&idle->seqcount);
+	raw_write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
 	idle->idle_time += idle_time;
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
-	write_seqcount_end(&idle->seqcount);
+	raw_write_seqcount_end(&idle->seqcount);
 }
 NOKPROBE_SYMBOL(enabled_wait);
 
diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
index 2c27907a5ffc..9a92638360ee 100644
--- a/arch/s390/kernel/pgm_check.S
+++ b/arch/s390/kernel/pgm_check.S
@@ -80,7 +80,7 @@ PGM_CHECK(do_dat_exception)		/* 3b */
 PGM_CHECK_DEFAULT			/* 3c */
 PGM_CHECK(do_secure_storage_access)	/* 3d */
 PGM_CHECK(do_non_secure_storage_access)	/* 3e */
-PGM_CHECK_DEFAULT			/* 3f */
+PGM_CHECK(do_secure_storage_violation)	/* 3f */
 PGM_CHECK(monitor_event_exception)	/* 40 */
 PGM_CHECK_DEFAULT			/* 41 */
 PGM_CHECK_DEFAULT			/* 42 */
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index e600f6953d7c..c2c1b4e723ea 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -619,7 +619,7 @@ static struct notifier_block kdump_mem_nb = {
 /*
  * Make sure that the area behind memory_end is protected
  */
-static void reserve_memory_end(void)
+static void __init reserve_memory_end(void)
 {
 	if (memory_end_set)
 		memblock_reserve(memory_end, ULONG_MAX);
@@ -628,7 +628,7 @@ static void reserve_memory_end(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void reserve_oldmem(void)
+static void __init reserve_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
@@ -640,7 +640,7 @@ static void reserve_oldmem(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void remove_oldmem(void)
+static void __init remove_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4c8c063bce5b..996884dcc9fd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -859,6 +859,21 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_non_secure_storage_access);
 
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	/*
+	 * Either KVM messed up the secure guest mapping or the same
+	 * page is mapped into multiple secure guests.
+	 *
+	 * This exception is only triggered when a guest 2 is running
+	 * and can therefore never occur in kernel context.
+	 */
+	printk_ratelimited(KERN_WARNING
+			   "Secure storage violation in task: %s, pid %d\n",
+			   current->comm, current->pid);
+	send_sig(SIGSEGV, current, 0);
+}
+
 #else
 void do_secure_storage_access(struct pt_regs *regs)
 {
@@ -869,4 +884,9 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 {
 	default_trap_handler(regs);
 }
+
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	default_trap_handler(regs);
+}
 #endif
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 4b62d6b55024..1804230dd8d8 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -668,6 +668,10 @@ EXPORT_SYMBOL_GPL(zpci_enable_device);
 int zpci_disable_device(struct zpci_dev *zdev)
 {
 	zpci_dma_exit_device(zdev);
+	/*
+	 * The zPCI function may already be disabled by the platform, this is
+	 * detected in clp_disable_fh() which becomes a no-op.
+	 */
 	return clp_disable_fh(zdev);
 }
 EXPORT_SYMBOL_GPL(zpci_disable_device);
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 9a3a291cad43..d9ae7456dd4c 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -143,6 +143,8 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zpci_remove_device(zdev);
 		}
 
+		zdev->fh = ccdf->fh;
+		zpci_disable_device(zdev);
 		zdev->state = ZPCI_FN_STATE_STANDBY;
 		if (!clp_get_state(ccdf->fid, &state) &&
 		    state == ZPCI_FN_STATE_RESERVED) {
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 3f5b61351cde..c793dcabd551 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1692,9 +1692,9 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	*nr_apqns = 0;
 
 	/* fetch status of all crypto cards */
-	device_status = kmalloc_array(MAX_ZDEV_ENTRIES_EXT,
-				      sizeof(struct zcrypt_device_status_ext),
-				      GFP_KERNEL);
+	device_status = kvmalloc_array(MAX_ZDEV_ENTRIES_EXT,
+				       sizeof(struct zcrypt_device_status_ext),
+				       GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
 	zcrypt_device_status_mask_ext(device_status);
@@ -1762,7 +1762,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		verify = 0;
 	}
 
-	kfree(device_status);
+	kvfree(device_status);
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f10073e62603..f4938040c228 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -102,14 +102,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
 	}
-
-	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
