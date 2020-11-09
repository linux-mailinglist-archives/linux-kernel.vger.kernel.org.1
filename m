Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180182ABB57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgKIN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:27:20 -0500
Received: from smtp.asem.it ([151.1.184.197]:50633 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbgKIN1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:27:17 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 08:27:16 EST
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000594617.MSG 
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:22:10 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 14:22:06 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 9 Nov 2020 14:22:06 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Vineet Gupta <vgupta@synopsys.com>
CC:     <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] ARC: mm: fix spelling mistakes
Date:   Mon, 9 Nov 2020 14:21:30 +0100
Message-ID: <20201109132130.34555-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020B.5FA9427F.0071,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arc/mm/tlb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index c340acd989a0..9bb3c24f3677 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -30,14 +30,14 @@
  *  -Changes related to MMU v2 (Rel 4.8)
  *
  * Vineetg: Aug 29th 2008
- *  -In TLB Flush operations (Metal Fix MMU) there is a explict command to
+ *  -In TLB Flush operations (Metal Fix MMU) there is a explicit command to
  *    flush Micro-TLBS. If TLB Index Reg is invalid prior to TLBIVUTLB cmd,
  *    it fails. Thus need to load it with ANY valid value before invoking
  *    TLBIVUTLB cmd
  *
  * Vineetg: Aug 21th 2008:
  *  -Reduced the duration of IRQ lockouts in TLB Flush routines
- *  -Multiple copies of TLB erase code seperated into a "single" function
+ *  -Multiple copies of TLB erase code separated into a "single" function
  *  -In TLB Flush routines, interrupt disabling moved UP to retrieve ASID
  *       in interrupt-safe region.
  *
@@ -66,7 +66,7 @@
  *
  * Although J-TLB is 2 way set assoc, ARC700 caches J-TLB into uTLBS which has
  * much higher associativity. u-D-TLB is 8 ways, u-I-TLB is 4 ways.
- * Given this, the thrasing problem should never happen because once the 3
+ * Given this, the thrashing problem should never happen because once the 3
  * J-TLB entries are created (even though 3rd will knock out one of the prev
  * two), the u-D-TLB and u-I-TLB will have what is required to accomplish memcpy
  *
@@ -127,7 +127,7 @@ static void utlb_invalidate(void)
 	 * There was however an obscure hardware bug, where uTLB flush would
 	 * fail when a prior probe for J-TLB (both totally unrelated) would
 	 * return lkup err - because the entry didn't exist in MMU.
-	 * The Workround was to set Index reg with some valid value, prior to
+	 * The Workaround was to set Index reg with some valid value, prior to
 	 * flush. This was fixed in MMU v3
 	 */
 	unsigned int idx;
@@ -272,7 +272,7 @@ noinline void local_flush_tlb_all(void)
 }
 
 /*
- * Flush the entrie MM for userland. The fastest way is to move to Next ASID
+ * Flush the entire MM for userland. The fastest way is to move to Next ASID
  */
 noinline void local_flush_tlb_mm(struct mm_struct *mm)
 {
@@ -303,7 +303,7 @@ noinline void local_flush_tlb_mm(struct mm_struct *mm)
  * Difference between this and Kernel Range Flush is
  *  -Here the fastest way (if range is too large) is to move to next ASID
  *      without doing any explicit Shootdown
- *  -In case of kernel Flush, entry has to be shot down explictly
+ *  -In case of kernel Flush, entry has to be shot down explicitly
  */
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end)
@@ -620,7 +620,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr_unaligned,
  * Super Page size is configurable in hardware (4K to 16M), but fixed once
  * RTL builds.
  *
- * The exact THP size a Linx configuration will support is a function of:
+ * The exact THP size a Linux configuration will support is a function of:
  *  - MMU page size (typical 8K, RTL fixed)
  *  - software page walker address split between PGD:PTE:PFN (typical
  *    11:8:13, but can be changed with 1 line)
@@ -698,7 +698,7 @@ void local_flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 #endif
 
-/* Read the Cache Build Confuration Registers, Decode them and save into
+/* Read the Cache Build Configuration Registers, Decode them and save into
  * the cpuinfo structure for later use.
  * No Validation is done here, simply read/convert the BCRs
  */
@@ -803,13 +803,13 @@ void arc_mmu_init(void)
 	pr_info("%s", arc_mmu_mumbojumbo(0, str, sizeof(str)));
 
 	/*
-	 * Can't be done in processor.h due to header include depenedencies
+	 * Can't be done in processor.h due to header include dependencies
 	 */
 	BUILD_BUG_ON(!IS_ALIGNED((CONFIG_ARC_KVADDR_SIZE << 20), PMD_SIZE));
 
 	/*
 	 * stack top size sanity check,
-	 * Can't be done in processor.h due to header include depenedencies
+	 * Can't be done in processor.h due to header include dependencies
 	 */
 	BUILD_BUG_ON(!IS_ALIGNED(STACK_TOP, PMD_SIZE));
 
@@ -881,7 +881,7 @@ void arc_mmu_init(void)
  *      the duplicate one.
  * -Knob to be verbose abt it.(TODO: hook them up to debugfs)
  */
-volatile int dup_pd_silent; /* Be slient abt it or complain (default) */
+volatile int dup_pd_silent; /* Be silent abt it or complain (default) */
 
 void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
 			  struct pt_regs *regs)
@@ -948,7 +948,7 @@ void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
 
 /***********************************************************************
  * Diagnostic Routines
- *  -Called from Low Level TLB Hanlders if things don;t look good
+ *  -Called from Low Level TLB Handlers if things don;t look good
  **********************************************************************/
 
 #ifdef CONFIG_ARC_DBG_TLB_PARANOIA
-- 
2.25.1

