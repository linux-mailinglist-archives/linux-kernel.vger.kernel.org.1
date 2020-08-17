Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA0247916
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgHQVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:47:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728684AbgHQVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:47:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HLX06C022116;
        Mon, 17 Aug 2020 17:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dMt+pC/R1fCDXZgpWnO++JFNA2C1KN+mULCs5PQzh2o=;
 b=CsZeA/Tr1mW35bglI9xuOl157VF7mdV1+osOKHTGbi2PVzLaok/rmJX25wh73MQzU/Be
 CTbezTME2DltrhbS0upxOcee3IBJuqQenCUbrqUyxIxFBbQ+TwXJvc3TlGTh9RtWKEbV
 CzD5gJF5i76GMxoVxFw9uUgXRkBVYuCe+cDJT510tT60IT6fSMFmMhwZUzcndmzu7wFa
 VQz8Fly6Wjp7ZKK603rUeHNITXr7LwqX8jXAujnHOQTBWtlcEehexb1uAlxCjL/JZyny
 fZMgLmSOfFj3CuqH7SptB+j8hz33ZcLWiw15+A3Y/R6n7RYvbiryDRvjjdEjqUY5Nus9 WA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32yxagwur1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:47:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HLjMR3013750;
        Mon, 17 Aug 2020 21:47:22 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 32xgqnwahn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 21:47:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HLlLrl29229450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 21:47:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCFC0112062;
        Mon, 17 Aug 2020 21:47:21 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26887112061;
        Mon, 17 Aug 2020 21:47:18 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.211.138.167])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 21:47:17 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     iommu@lists.linux-foundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
Date:   Mon, 17 Aug 2020 18:46:58 -0300
Message-Id: <20200817214658.103093-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=3 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER secure guests (i.e., guests which use the Protection Execution
Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
they don't need the SWIOTLB memory to be in low addresses since the
hypervisor doesn't have any addressing limitation.

This solves a SWIOTLB initialization problem we are seeing in secure guests
with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
memory, which leaves no space for SWIOTLB in low addresses.

To do this, we use mostly the same code as swiotlb_init(), but allocate the
buffer using memblock_alloc() instead of memblock_alloc_low().

We also need to add swiotlb_set_no_iotlb_memory() in order to set the
no_iotlb_memory flag if initialization fails.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h       |  4 ++++
 arch/powerpc/mm/mem.c                |  6 +++++-
 arch/powerpc/platforms/pseries/svm.c | 27 +++++++++++++++++++++++++++
 include/linux/swiotlb.h              |  1 +
 kernel/dma/swiotlb.c                 |  5 +++++
 5 files changed, 42 insertions(+), 1 deletion(-)

Changes from v1:
- Open-code swiotlb_init() in arch-specific code, as suggested by
  Christoph.

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 85580b30aba4..7546402d796a 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -15,6 +15,8 @@ static inline bool is_secure_guest(void)
 	return mfmsr() & MSR_S;
 }
 
+void __init svm_swiotlb_init(void);
+
 void dtl_cache_ctor(void *addr);
 #define get_dtl_cache_ctor()	(is_secure_guest() ? dtl_cache_ctor : NULL)
 
@@ -25,6 +27,8 @@ static inline bool is_secure_guest(void)
 	return false;
 }
 
+static inline void svm_swiotlb_init(void) {}
+
 #define get_dtl_cache_ctor() NULL
 
 #endif /* CONFIG_PPC_SVM */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..0f21bcb16405 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -50,6 +50,7 @@
 #include <asm/swiotlb.h>
 #include <asm/rtas.h>
 #include <asm/kasan.h>
+#include <asm/svm.h>
 
 #include <mm/mmu_decl.h>
 
@@ -290,7 +291,10 @@ void __init mem_init(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	swiotlb_init(0);
+	if (is_secure_guest())
+		svm_swiotlb_init();
+	else
+		swiotlb_init(0);
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 40c0637203d5..d592e663a8d6 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/memblock.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
@@ -34,6 +35,32 @@ static int __init init_svm(void)
 }
 machine_early_initcall(pseries, init_svm);
 
+/*
+ * Initialize SWIOTLB. Essentially the same as swiotlb_init(), except that it
+ * can allocate the buffer anywhere in memory. Since the hypervisor doesn't have
+ * any addressing limitation, we don't need to allocate it in low addresses.
+ */
+void __init svm_swiotlb_init(void)
+{
+	unsigned char *vstart;
+	unsigned long bytes, io_tlb_nslabs;
+
+	io_tlb_nslabs = (swiotlb_size_or_default() >> IO_TLB_SHIFT);
+	io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+
+	vstart = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
+	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
+		return;
+
+	if (io_tlb_start)
+		memblock_free_early(io_tlb_start,
+				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	pr_warn("Cannot allocate SWIOTLB buffer");
+	swiotlb_set_no_iotlb_memory(true);
+}
+
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	if (!PAGE_ALIGNED(addr))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94bd4d6..991e9f13e663 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -35,6 +35,7 @@ extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern void __init swiotlb_update_mem_attributes(void);
+void __init swiotlb_set_no_iotlb_memory(bool value);
 
 /*
  * Enumeration for sync targets
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..ed2b8818ff67 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -132,6 +132,11 @@ early_param("swiotlb", setup_io_tlb_npages);
 
 static bool no_iotlb_memory;
 
+void __init swiotlb_set_no_iotlb_memory(bool value)
+{
+	no_iotlb_memory = value;
+}
+
 unsigned long swiotlb_nr_tbl(void)
 {
 	return unlikely(no_iotlb_memory) ? 0 : io_tlb_nslabs;
