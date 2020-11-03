Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F562A4C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgKCROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:14:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgKCROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:14:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3H2Cnk113142;
        Tue, 3 Nov 2020 12:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lRACQRLHLt6q2IrqORhaIKVO9hKLB13qlItsRN6SnwA=;
 b=VYgLZZ40Pc8lZyr5ot7pllR5RnIwm4qvNRVPhkZo6kjeiLkFro0xr6CEstF10a57hEy+
 YAeGiTwsC8vpde4IC1oRx0FAYjGGHwFQUF8m3v9GrNEVsmV9P4+fmmoj3qmYVOUTBRaQ
 WYfVrR9hjKMzJkI+zkoTnCBFf84LY7mdhX0F2bDcfdGI1TmBZBl/rkA6K8P/icJL7+o8
 ish7seD8XFbrxlxk6Wxl7W86EEWEPD0CQtVHCYSmvqYbr3Y3K/L9S92jXQr/eEQ8ized
 a6s3ZYinWKGKvE/dEQln76UswfWYdK5rgmgx1be73FLzVd+YrTRb845gFCBYKQh4LYwO ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jyytfcuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 12:13:42 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3H7JtX018711;
        Tue, 3 Nov 2020 17:13:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6haqht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 17:13:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3HDcHx56033540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 17:13:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1417952063;
        Tue,  3 Nov 2020 17:13:38 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.79.178])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFEEB52051;
        Tue,  3 Nov 2020 17:13:37 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/vdso: Fix VDSO unmap check
Date:   Tue,  3 Nov 2020 18:13:36 +0100
Message-Id: <20201103171336.98883-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 suspectscore=1 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check introduced by the commit 83d3f0e90c6c ("powerpc/mm: tracking vDSO
remap") is wrong and is missing some partial unmaps of the VDSO.

To be complete the check needs the base and end address of the
VDSO. Currently only the base is available in the mm_context of a task, but
the end address can easily be computed because the size of VDSO is
constant. However, there are 2 sizes for 32 or 64 bits task and they are
stored in static variables in arch/powerpc/kernel/vdso.c.

Exporting a new function called vdso_pages() to get the number of pages of
the VDSO based on the static variables from arch/powerpc/kernel/vdso.c.

Fixes: 83d3f0e90c6c ("powerpc/mm: tracking vDSO remap")

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/mmu_context.h | 18 ++++++++++++++++--
 arch/powerpc/kernel/vdso.c             | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index e02aa793420b..ced80897b7a1 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -259,11 +259,25 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
+extern int vdso_pages(void);
 static inline void arch_unmap(struct mm_struct *mm,
 			      unsigned long start, unsigned long end)
 {
-	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
-		mm->context.vdso_base = 0;
+	unsigned long vdso_end;
+
+	if (mm->context.vdso_base) {
+		/*
+		 * case 1   >  |     VDSO    |  <
+		 * case 2   >  |           < |
+		 * case 3      |  >        < |
+		 * case 4      |  >          |  <
+		 */
+		vdso_end = mm->context.vdso_base;
+		vdso_end += vdso_pages() << PAGE_SHIFT;
+
+		if (start < vdso_end && mm->context.vdso_base < end)
+			mm->context.vdso_base = 0;
+	}
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 8dad44262e75..9defa35a1eba 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -117,6 +117,20 @@ struct lib64_elfinfo
 	unsigned long	text;
 };
 
+/*
+ * Return the number of pages of the VDSO for the current task.
+ */
+int vdso_pages(void)
+{
+	int vdso_pages = vdso32_pages;
+
+#ifdef CONFIG_PPC64
+	if (!is_32bit_task())
+		vdso_pages = vdso64_pages;
+#endif
+
+	return vdso_pages + 1; /* Add the data page */
+}
 
 /*
  * This is called from binfmt_elf, we create the special vma for the
-- 
2.29.2

