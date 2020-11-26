Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BE2C59BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403976AbgKZRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:00:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403791AbgKZRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:00:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQGVSXw064087;
        Thu, 26 Nov 2020 12:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=xLLYkQqQFU+OX7rJCIVxSIQbccOuUwR6E7EFl8NMsZs=;
 b=X6Tu8KUGX44DlQ1Dlxlgp4jUsSIwqwQlzSiGqLmEIqwjbuMHG7pohUKez3lYTU3LUskR
 jqSKk1bqDbYkTD1U05NXCGgCDXA+Mw3tT6QpCeVtKojq+jANRDQAbX9Aq1qJ8wUyme4m
 v6EOYJiVTncGS2RwusY19tWks2mNILYVIziJPcG+/cZ0e81w4riERxz52mv1cHCe9rVL
 7NDRgVny+MGZd1ynRYVLHb9koqmbREI23iZL0jIbrJtK1jP9nC8Njwn42MaoKKG0aqKQ
 3FW5yo6To8PquPfPz8RGDoR4eNWiKdvhuu1OquBGYQFMYKVIbnhlP6pQll0b+MpbuTlk Aw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3526nps8bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 12:00:45 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQGwD6b003406;
        Thu, 26 Nov 2020 17:00:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8durw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 17:00:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQH0dWi53084544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 17:00:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC4494204D;
        Thu, 26 Nov 2020 17:00:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 543724203F;
        Thu, 26 Nov 2020 17:00:39 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.159.67])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 17:00:39 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Date:   Thu, 26 Nov 2020 18:00:37 +0100
Message-Id: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_06:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The directed MSIs are delivered to CPUs whose address is
written to the MSI message data. The current code assumes
that a CPU logical number (as it is seen by the kernel)
is also that CPU address.

The above assumption is not correct, as the CPU address
is rather the value returned by STAP instruction. That
value does not necessarily match the kernel logical CPU
number.

Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

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
-- 
2.26.0

