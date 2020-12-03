Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630A2CDF0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgLCTeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbgLCTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3JVRWG136834;
        Thu, 3 Dec 2020 14:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=Q4a3PN0TsQdhnYtzM6IkAflTMW3fCy9lh1CIJCtTG/w=;
 b=fxmTAMQoBy+fWzfde3HBjFMfZkw6jv/SvuV9wwldK+b3LOh2Tj6I8QXBBsR0HY5JRRNH
 RC10fLEu6MpaNZo5qu0bSET9T205XzYw7ag8bq5DUO1I13NItSbsTjhSC12JpyOjpw9E
 KGOyTdNOuPFQA9DUNiwyRg8RaP65KgQhNLJV/M5sdRav1S1k61igeEjJYxk6GB/M1UL5
 uziM1kJ6LvbG3CWHdxcC53r08tsnsp+k0MJHl0S/GoRlC9oo9Xy7+9dE23A5w8k6f9n5
 Phz3K+w0RT+P9Wk7QpucpzQwkNG5c+jjY4wkclz0ejLnBKyM0k8AknCOUhAI1gq/0esC ug== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35748hm5d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 14:33:28 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3JS76t026740;
        Thu, 3 Dec 2020 19:33:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 353e68875b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 19:33:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3JUst825690450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 19:30:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39631A405F;
        Thu,  3 Dec 2020 19:30:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E19EEA405C;
        Thu,  3 Dec 2020 19:30:53 +0000 (GMT)
Received: from osiris (unknown [9.171.50.208])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Dec 2020 19:30:53 +0000 (GMT)
Date:   Thu, 3 Dec 2020 20:30:52 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.10-rc7
Message-ID: <20201203193052.GD9994@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_11:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two late fixes for s390. One commit is fixing lockdep irq state
tracing which broke with -rc6. The other one fixes logical vs physical CPU
address mixup in our PCI code.

Thanks,
Heiko

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-6

for you to fetch changes up to b1cae1f84a0f609a34ebcaa087fbecef32f69882:

  s390: fix irq state tracing (2020-12-02 18:17:50 +0100)

----------------------------------------------------------------
- fix lockdep irq state tracing

- fix logical vs physical CPU address confusion in PCI code

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/pci: fix CPU address in MSI for directed IRQ

Heiko Carstens (1):
      s390: fix irq state tracing

 arch/s390/kernel/entry.S | 15 ---------------
 arch/s390/lib/delay.c    |  5 ++---
 arch/s390/pci/pci_irq.c  | 14 +++++++++++---
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 26bb0603c5a1..92beb1444644 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -763,12 +763,7 @@ ENTRY(io_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 .Lio_loop:
 	lgr	%r2,%r11		# pass pointer to pt_regs
@@ -791,12 +786,7 @@ ENTRY(io_int_handler)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lio_work
 .Lio_restore:
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tm	__PT_PSW(%r11),3
-	jno	0f
 	TRACE_IRQS_ON
-0:
-#endif
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
@@ -976,12 +966,7 @@ ENTRY(ext_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index daca7bad66de..8c0c68e7770e 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(__delay);
 
 static void __udelay_disabled(unsigned long long usecs)
 {
-	unsigned long cr0, cr0_new, psw_mask, flags;
+	unsigned long cr0, cr0_new, psw_mask;
 	struct s390_idle_data idle;
 	u64 end;
 
@@ -45,9 +45,8 @@ static void __udelay_disabled(unsigned long long usecs)
 	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
 	set_clock_comparator(end);
 	set_cpu_flag(CIF_IGNORE_IRQ);
-	local_irq_save(flags);
 	psw_idle(&idle, psw_mask);
-	local_irq_restore(flags);
+	trace_hardirqs_off();
 	clear_cpu_flag(CIF_IGNORE_IRQ);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	__ctl_load(cr0, 0, 0);
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 743f257cf2cb..75217fb63d7b 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
 {
 	struct msi_desc *entry = irq_get_msi_desc(data->irq);
 	struct msi_msg msg = entry->msg;
+	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
 
 	msg.address_lo &= 0xff0000ff;
-	msg.address_lo |= (cpumask_first(dest) << 8);
+	msg.address_lo |= (cpu_addr << 8);
 	pci_write_msi_msg(data->irq, &msg);
 
 	return IRQ_SET_MASK_OK;
@@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned long bit;
 	struct msi_desc *msi;
 	struct msi_msg msg;
+	int cpu_addr;
 	int rc, irq;
 
 	zdev->aisb = -1UL;
@@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 					 handle_percpu_irq);
 		msg.data = hwirq - bit;
 		if (irq_delivery == DIRECTED) {
+			if (msi->affinity)
+				cpu = cpumask_first(&msi->affinity->mask);
+			else
+				cpu = 0;
+			cpu_addr = smp_cpu_get_cpu_address(cpu);
+
 			msg.address_lo = zdev->msi_addr & 0xff0000ff;
-			msg.address_lo |= msi->affinity ?
-				(cpumask_first(&msi->affinity->mask) << 8) : 0;
+			msg.address_lo |= (cpu_addr << 8);
+
 			for_each_possible_cpu(cpu) {
 				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
 			}
