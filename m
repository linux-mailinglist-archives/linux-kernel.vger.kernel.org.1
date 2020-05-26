Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184371B0B04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgDTMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:46:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728930AbgDTMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KCZlaQ003448;
        Mon, 20 Apr 2020 08:46:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2vxyvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 08:46:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03KCcnlp012366;
        Mon, 20 Apr 2020 08:46:02 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2vxyv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 08:46:02 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03KCeZ4k025281;
        Mon, 20 Apr 2020 12:46:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 30fs66cptx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 12:46:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KCjxVD65143198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 12:45:59 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA4B513604F;
        Mon, 20 Apr 2020 12:45:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2282136055;
        Mon, 20 Apr 2020 12:45:55 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.51.43])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 12:45:55 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc:     npiggin@gmail.com, paulus@ozlabs.org, leonardo@linux.ibm.com,
        kirill@shutemov.name,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v3 16/22] powerpc/kvm/book3s: Avoid using rmap to protect parallel page table update.
Date:   Mon, 20 Apr 2020 18:14:28 +0530
Message-Id: <20200420124434.47330-17-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200420124434.47330-1-aneesh.kumar@linux.ibm.com>
References: <20200420124434.47330-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_04:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=8 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now depend on kvm->mmu_lock

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 38 +++++++----------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index acc3ce570be7..167029e57c8f 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -74,8 +74,8 @@ struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvmppc_find_table);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-static long kvmppc_rm_tce_to_ua(struct kvm *kvm, unsigned long tce,
-		unsigned long *ua, unsigned long **prmap)
+static long kvmppc_rm_tce_to_ua(struct kvm *kvm,
+				unsigned long tce, unsigned long *ua)
 {
 	unsigned long gfn = tce >> PAGE_SHIFT;
 	struct kvm_memory_slot *memslot;
@@ -87,9 +87,6 @@ static long kvmppc_rm_tce_to_ua(struct kvm *kvm, unsigned long tce,
 	*ua = __gfn_to_hva_memslot(memslot, gfn) |
 		(tce & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
 
-	if (prmap)
-		*prmap = &memslot->arch.rmap[gfn - memslot->base_gfn];
-
 	return 0;
 }
 
@@ -116,7 +113,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_PARAMETER;
 
-	if (kvmppc_rm_tce_to_ua(stt->kvm, tce, &ua, NULL))
+	if (kvmppc_rm_tce_to_ua(stt->kvm, tce, &ua))
 		return H_TOO_HARD;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
@@ -411,7 +408,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return ret;
 
 	dir = iommu_tce_direction(tce);
-	if ((dir != DMA_NONE) && kvmppc_rm_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
+	if ((dir != DMA_NONE) && kvmppc_rm_tce_to_ua(vcpu->kvm, tce, &ua))
 		return H_PARAMETER;
 
 	entry = ioba >> stt->page_shift;
@@ -488,7 +485,6 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret = H_SUCCESS;
 	unsigned long tces, entry, ua = 0;
-	unsigned long *rmap = NULL;
 	unsigned long mmu_seq;
 	bool prereg = false;
 	struct kvmppc_spapr_tce_iommu_table *stit;
@@ -530,7 +526,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 */
 		struct mm_iommu_table_group_mem_t *mem;
 
-		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce_list, &ua, NULL))
+		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce_list, &ua))
 			return H_TOO_HARD;
 
 		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
@@ -546,23 +542,9 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 * We do not require memory to be preregistered in this case
 		 * so lock rmap and do __find_linux_pte_or_hugepte().
 		 */
-		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
-			return H_TOO_HARD;
-
-		rmap = (void *) vmalloc_to_phys(rmap);
-		if (WARN_ON_ONCE_RM(!rmap))
+		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce_list, &ua))
 			return H_TOO_HARD;
 
-		/*
-		 * Synchronize with the MMU notifier callbacks in
-		 * book3s_64_mmu_hv.c (kvm_unmap_hva_range_hv etc.).
-		 * While we have the rmap lock, code running on other CPUs
-		 * cannot finish unmapping the host real page that backs
-		 * this guest real page, so we are OK to access the host
-		 * real page.
-		 */
-		lock_rmap(rmap);
-
 		arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
 		if (kvmppc_rm_ua_to_hpa(vcpu, mmu_seq, ua, &tces)) {
 			ret = H_TOO_HARD;
@@ -582,7 +564,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		ua = 0;
-		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce, &ua, NULL)) {
+		if (kvmppc_rm_tce_to_ua(vcpu->kvm, tce, &ua)) {
 			ret = H_PARAMETER;
 			goto invalidate_exit;
 		}
@@ -607,10 +589,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		iommu_tce_kill_rm(stit->tbl, entry, npages);
 
 unlock_exit:
-	if (rmap)
-		unlock_rmap(rmap);
-
-	arch_spin_unlock(&kvm->mmu_lock.rlock.raw_lock);
+	if (!prereg)
+		arch_spin_unlock(&kvm->mmu_lock.rlock.raw_lock);
 	return ret;
 }
 
-- 
2.25.3

