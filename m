Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765FC213D21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGCP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 11:59:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgGCP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:59:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 063FWGE2031673;
        Fri, 3 Jul 2020 11:59:22 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322144uhhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 11:59:22 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 063FuYVw002499;
        Fri, 3 Jul 2020 15:59:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 31wwr7uj21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 15:59:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 063FxG9224772696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jul 2020 15:59:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D77FA42042;
        Fri,  3 Jul 2020 15:59:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 726D842045;
        Fri,  3 Jul 2020 15:59:16 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.68.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jul 2020 15:59:16 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org
Cc:     bharata@linux.ibm.com, bauerman@linux.ibm.com,
        sukadev@linux.ibm.com, sathnaga@linux.vnet.ibm.com,
        Ram Pai <linuxram@us.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: move kvmppc_svm_page_out up
Date:   Fri,  3 Jul 2020 17:59:13 +0200
Message-Id: <20200703155914.40262-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703155914.40262-1-ldufour@linux.ibm.com>
References: <20200703155914.40262-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_10:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 suspectscore=2 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmppc_svm_page_out() will need to be called by kvmppc_uvmem_drop_pages()
so move it upper in this file.

Furthermore it will be interesting to call this function when already
holding the kvm->arch.uvmem_lock, so prefix the original function with __
and remove the locking in it, and introduce a wrapper which call that
function with the lock held.

There is no functional change.

Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 166 ++++++++++++++++-------------
 1 file changed, 90 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 778a6ea86991..852cc9ae6a0b 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -435,6 +435,96 @@ unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
 	return ret;
 }
 
+/*
+ * Provision a new page on HV side and copy over the contents
+ * from secure memory using UV_PAGE_OUT uvcall.
+ * Caller must held kvm->arch.uvmem_lock.
+ */
+static int __kvmppc_svm_page_out(struct vm_area_struct *vma,
+		unsigned long start,
+		unsigned long end, unsigned long page_shift,
+		struct kvm *kvm, unsigned long gpa)
+{
+	unsigned long src_pfn, dst_pfn = 0;
+	struct migrate_vma mig;
+	struct page *dpage, *spage;
+	struct kvmppc_uvmem_page_pvt *pvt;
+	unsigned long pfn;
+	int ret = U_SUCCESS;
+
+	memset(&mig, 0, sizeof(mig));
+	mig.vma = vma;
+	mig.start = start;
+	mig.end = end;
+	mig.src = &src_pfn;
+	mig.dst = &dst_pfn;
+	mig.src_owner = &kvmppc_uvmem_pgmap;
+
+	/* The requested page is already paged-out, nothing to do */
+	if (!kvmppc_gfn_is_uvmem_pfn(gpa >> page_shift, kvm, NULL))
+		return ret;
+
+	ret = migrate_vma_setup(&mig);
+	if (ret)
+		return -1;
+
+	spage = migrate_pfn_to_page(*mig.src);
+	if (!spage || !(*mig.src & MIGRATE_PFN_MIGRATE))
+		goto out_finalize;
+
+	if (!is_zone_device_page(spage))
+		goto out_finalize;
+
+	dpage = alloc_page_vma(GFP_HIGHUSER, vma, start);
+	if (!dpage) {
+		ret = -1;
+		goto out_finalize;
+	}
+
+	lock_page(dpage);
+	pvt = spage->zone_device_data;
+	pfn = page_to_pfn(dpage);
+
+	/*
+	 * This function is used in two cases:
+	 * - When HV touches a secure page, for which we do UV_PAGE_OUT
+	 * - When a secure page is converted to shared page, we *get*
+	 *   the page to essentially unmap the device page. In this
+	 *   case we skip page-out.
+	 */
+	if (!pvt->skip_page_out)
+		ret = uv_page_out(kvm->arch.lpid, pfn << page_shift,
+				  gpa, 0, page_shift);
+
+	if (ret == U_SUCCESS)
+		*mig.dst = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
+	else {
+		unlock_page(dpage);
+		__free_page(dpage);
+		goto out_finalize;
+	}
+
+	migrate_vma_pages(&mig);
+
+out_finalize:
+	migrate_vma_finalize(&mig);
+	return ret;
+}
+
+static inline int kvmppc_svm_page_out(struct vm_area_struct *vma,
+				      unsigned long start, unsigned long end,
+				      unsigned long page_shift,
+				      struct kvm *kvm, unsigned long gpa)
+{
+	int ret;
+
+	mutex_lock(&kvm->arch.uvmem_lock);
+	ret = __kvmppc_svm_page_out(vma, start, end, page_shift, kvm, gpa);
+	mutex_unlock(&kvm->arch.uvmem_lock);
+
+	return ret;
+}
+
 /*
  * Drop device pages that we maintain for the secure guest
  *
@@ -801,82 +891,6 @@ unsigned long kvmppc_h_svm_page_in(struct kvm *kvm, unsigned long gpa,
 	return ret;
 }
 
-/*
- * Provision a new page on HV side and copy over the contents
- * from secure memory using UV_PAGE_OUT uvcall.
- */
-static int kvmppc_svm_page_out(struct vm_area_struct *vma,
-		unsigned long start,
-		unsigned long end, unsigned long page_shift,
-		struct kvm *kvm, unsigned long gpa)
-{
-	unsigned long src_pfn, dst_pfn = 0;
-	struct migrate_vma mig;
-	struct page *dpage, *spage;
-	struct kvmppc_uvmem_page_pvt *pvt;
-	unsigned long pfn;
-	int ret = U_SUCCESS;
-
-	memset(&mig, 0, sizeof(mig));
-	mig.vma = vma;
-	mig.start = start;
-	mig.end = end;
-	mig.src = &src_pfn;
-	mig.dst = &dst_pfn;
-	mig.src_owner = &kvmppc_uvmem_pgmap;
-
-	mutex_lock(&kvm->arch.uvmem_lock);
-	/* The requested page is already paged-out, nothing to do */
-	if (!kvmppc_gfn_is_uvmem_pfn(gpa >> page_shift, kvm, NULL))
-		goto out;
-
-	ret = migrate_vma_setup(&mig);
-	if (ret)
-		goto out;
-
-	spage = migrate_pfn_to_page(*mig.src);
-	if (!spage || !(*mig.src & MIGRATE_PFN_MIGRATE))
-		goto out_finalize;
-
-	if (!is_zone_device_page(spage))
-		goto out_finalize;
-
-	dpage = alloc_page_vma(GFP_HIGHUSER, vma, start);
-	if (!dpage) {
-		ret = -1;
-		goto out_finalize;
-	}
-
-	lock_page(dpage);
-	pvt = spage->zone_device_data;
-	pfn = page_to_pfn(dpage);
-
-	/*
-	 * This function is used in two cases:
-	 * - When HV touches a secure page, for which we do UV_PAGE_OUT
-	 * - When a secure page is converted to shared page, we *get*
-	 *   the page to essentially unmap the device page. In this
-	 *   case we skip page-out.
-	 */
-	if (!pvt->skip_page_out)
-		ret = uv_page_out(kvm->arch.lpid, pfn << page_shift,
-				  gpa, 0, page_shift);
-
-	if (ret == U_SUCCESS)
-		*mig.dst = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
-	else {
-		unlock_page(dpage);
-		__free_page(dpage);
-		goto out_finalize;
-	}
-
-	migrate_vma_pages(&mig);
-out_finalize:
-	migrate_vma_finalize(&mig);
-out:
-	mutex_unlock(&kvm->arch.uvmem_lock);
-	return ret;
-}
 
 /*
  * Fault handler callback that gets called when HV touches any page that
-- 
2.27.0

