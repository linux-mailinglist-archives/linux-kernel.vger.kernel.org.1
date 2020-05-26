Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367A01B325A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDUVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 17:54:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:30839 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgDUVyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:54:40 -0400
IronPort-SDR: 3EftTwEvwcX3vFS9EnbIthQwamqgEYcIR6tU3M1vJCa8mX74xgg9saQ7YBdWJDW93s5M+BRE5a
 HxQZFJZMtXJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:54:39 -0700
IronPort-SDR: pPhU3oowlksazJLOWGL7v8xQhsYHF6OXykeWnJP1XB3ODrhnSYjOnrN0L/S7KVAiXG/cXIeAKa
 hPzFzKqzq22g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="456260770"
Received: from mnchalux-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.44.234])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 14:54:33 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org
Subject: [PATCH v29 13/20] x86/sgx: Add a page reclaimer
Date:   Wed, 22 Apr 2020 00:53:09 +0300
Message-Id: <20200421215316.56503-14-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limited amount of SGX reserved memory available. Therefore,
some of it must be copied to the regular memory, and only subset kept in
the SGX reserved memory. While kernel cannot directly access enclave
memory, SGX provides ENCLS leaf functions to perform reclaiming
functionality.

This commits implements a page reclaimer by using these leaf functions,
which picks the victim pages in LRU fashion from all enclaves running in
an enclave's pages back to the SGX reserved memory.

The thread ksgxswapd reclaims pages on the event when the number of free
EPC pages goes below %SGX_NR_LOW_PAGES up until it reaches
%SGX_NR_HIGH_PAGES.

sgx_alloc_page() can now optionally reclaim pages with @reclaim boolean
parameter. The caller must also supply owner for each page so that the
reclaimer can access the associated enclaves. This is needed for locking,
as most of the ENCLS leafs cannot be executed concurrently for an enclave,
and accessing SECS, which is required to be resident when its child pages
are being reclaimed.

Cc: linux-mm@kvack.org
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/driver.c  |   1 +
 arch/x86/kernel/cpu/sgx/encl.c    | 340 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h    |  41 ++++
 arch/x86/kernel/cpu/sgx/ioctl.c   |  76 +++++-
 arch/x86/kernel/cpu/sgx/main.c    |  61 ++++-
 arch/x86/kernel/cpu/sgx/reclaim.c | 388 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h     |  35 +++
 7 files changed, 934 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index d90114cec1c3..997a7f4117c5 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -32,6 +32,7 @@ static int sgx_open(struct inode *inode, struct file *file)
 
 	atomic_set(&encl->flags, 0);
 	kref_init(&encl->refcount);
+	INIT_LIST_HEAD(&encl->va_pages);
 	INIT_RADIX_TREE(&encl->page_tree, GFP_KERNEL);
 	mutex_init(&encl->lock);
 	INIT_LIST_HEAD(&encl->mm_list);
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 17e44bf8fa56..fe7dbca40bb4 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -9,11 +9,86 @@
 #include <linux/sched/mm.h>
 #include "arch.h"
 #include "encl.h"
+#include "encls.h"
 #include "sgx.h"
 
+static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
+			   struct sgx_epc_page *epc_page,
+			   struct sgx_epc_page *secs_page)
+{
+	unsigned long va_offset = SGX_ENCL_PAGE_VA_OFFSET(encl_page);
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_pageinfo pginfo;
+	struct sgx_backing b;
+	pgoff_t page_index;
+	int ret;
+
+	if (secs_page)
+		page_index = SGX_ENCL_PAGE_INDEX(encl_page);
+	else
+		page_index = PFN_DOWN(encl->size);
+
+	ret = sgx_encl_get_backing(encl, page_index, &b);
+	if (ret)
+		return ret;
+
+	pginfo.addr = SGX_ENCL_PAGE_ADDR(encl_page);
+	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
+	pginfo.metadata = (unsigned long)kmap_atomic(b.pcmd) +
+			  b.pcmd_offset;
+
+	if (secs_page)
+		pginfo.secs = (u64)sgx_epc_addr(secs_page);
+	else
+		pginfo.secs = 0;
+
+	ret = __eldu(&pginfo, sgx_epc_addr(epc_page),
+		     sgx_epc_addr(encl_page->va_page->epc_page) + va_offset);
+	if (ret) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "ELDU");
+
+		ret = -EFAULT;
+	}
+
+	kunmap_atomic((void *)(unsigned long)(pginfo.metadata - b.pcmd_offset));
+	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+
+	sgx_encl_put_backing(&b, false);
+
+	return ret;
+}
+
+static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
+					  struct sgx_epc_page *secs_page)
+{
+	unsigned long va_offset = SGX_ENCL_PAGE_VA_OFFSET(encl_page);
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	epc_page = sgx_alloc_page(encl_page, false);
+	if (IS_ERR(epc_page))
+		return epc_page;
+
+	ret = __sgx_encl_eldu(encl_page, epc_page, secs_page);
+	if (ret) {
+		sgx_free_page(epc_page);
+		return ERR_PTR(ret);
+	}
+
+	sgx_free_va_slot(encl_page->va_page, va_offset);
+	list_move(&encl_page->va_page->list, &encl->va_pages);
+	encl_page->desc &= ~SGX_ENCL_PAGE_VA_OFFSET_MASK;
+	encl_page->epc_page = epc_page;
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 						unsigned long addr)
 {
+	struct sgx_epc_page *epc_page;
 	struct sgx_encl_page *entry;
 	unsigned int flags;
 
@@ -33,10 +108,27 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_PTR(-EFAULT);
 
 	/* Page is already resident in the EPC. */
-	if (entry->epc_page)
+	if (entry->epc_page) {
+		if (entry->desc & SGX_ENCL_PAGE_RECLAIMED)
+			return ERR_PTR(-EBUSY);
+
 		return entry;
+	}
+
+	if (!(encl->secs.epc_page)) {
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+		if (IS_ERR(epc_page))
+			return ERR_CAST(epc_page);
+	}
+
+	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
 
-	return ERR_PTR(-EFAULT);
+	encl->secs_child_cnt++;
+	sgx_mark_page_reclaimable(entry->epc_page);
+
+	return entry;
 }
 
 static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
@@ -134,6 +226,9 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 
 	spin_lock(&encl->mm_lock);
 	list_add_rcu(&encl_mm->list, &encl->mm_list);
+	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	smp_wmb();
+	encl->mm_list_version++;
 	spin_unlock(&encl->mm_lock);
 
 	return 0;
@@ -181,6 +276,8 @@ static unsigned int sgx_vma_fault(struct vm_fault *vmf)
 		goto out;
 	}
 
+	sgx_encl_test_and_clear_young(vma->vm_mm, entry);
+
 out:
 	mutex_unlock(&encl->lock);
 	return ret;
@@ -280,6 +377,7 @@ int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
  */
 void sgx_encl_destroy(struct sgx_encl *encl)
 {
+	struct sgx_va_page *va_page;
 	struct sgx_encl_page *entry;
 	struct radix_tree_iter iter;
 	void **slot;
@@ -290,6 +388,13 @@ void sgx_encl_destroy(struct sgx_encl *encl)
 		entry = *slot;
 
 		if (entry->epc_page) {
+			/*
+			 * The page and its radix tree entry cannot be freed
+			 * if the page is being held by the reclaimer.
+			 */
+			if (sgx_unmark_page_reclaimable(entry->epc_page))
+				continue;
+
 			sgx_free_page(entry->epc_page);
 			encl->secs_child_cnt--;
 			entry->epc_page = NULL;
@@ -304,6 +409,19 @@ void sgx_encl_destroy(struct sgx_encl *encl)
 		sgx_free_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
+
+	/*
+	 * The reclaimer is responsible for checking SGX_ENCL_DEAD before doing
+	 * EWB, thus it's safe to free VA pages even if the reclaimer holds a
+	 * reference to the enclave.
+	 */
+	while (!list_empty(&encl->va_pages)) {
+		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
+					   list);
+		list_del(&va_page->list);
+		sgx_free_page(va_page->epc_page);
+		kfree(va_page);
+	}
 }
 
 /**
@@ -330,3 +448,221 @@ void sgx_encl_release(struct kref *ref)
 
 	kfree(encl);
 }
+
+static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
+					      pgoff_t index)
+{
+	struct inode *inode = encl->backing->f_path.dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	gfp_t gfpmask = mapping_gfp_mask(mapping);
+
+	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
+}
+
+/**
+ * sgx_encl_get_backing() - Pin the backing storage
+ * @encl:	an enclave
+ * @page_index:	enclave page index
+ * @backing:	data for accessing backing storage for the page
+ *
+ * Pin the backing storage pages for storing the encrypted contents and Paging
+ * Crypto MetaData (PCMD) of an enclave page.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise.
+ */
+int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+			 struct sgx_backing *backing)
+{
+	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >> 5);
+	struct page *contents;
+	struct page *pcmd;
+
+	contents = sgx_encl_get_backing_page(encl, page_index);
+	if (IS_ERR(contents))
+		return PTR_ERR(contents);
+
+	pcmd = sgx_encl_get_backing_page(encl, pcmd_index);
+	if (IS_ERR(pcmd)) {
+		put_page(contents);
+		return PTR_ERR(pcmd);
+	}
+
+	backing->page_index = page_index;
+	backing->contents = contents;
+	backing->pcmd = pcmd;
+	backing->pcmd_offset =
+		(page_index & (PAGE_SIZE / sizeof(struct sgx_pcmd) - 1)) *
+		sizeof(struct sgx_pcmd);
+
+	return 0;
+}
+
+/**
+ * sgx_encl_put_backing() - Unpin the backing storage
+ * @backing:	data for accessing backing storage for the page
+ * @do_write:	mark pages dirty
+ */
+void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write)
+{
+	if (do_write) {
+		set_page_dirty(backing->pcmd);
+		set_page_dirty(backing->contents);
+	}
+
+	put_page(backing->pcmd);
+	put_page(backing->contents);
+}
+
+static int sgx_encl_test_and_clear_young_cb(pte_t *ptep, unsigned long addr,
+					    void *data)
+{
+	pte_t pte;
+	int ret;
+
+	ret = pte_young(*ptep);
+	if (ret) {
+		pte = pte_mkold(*ptep);
+		set_pte_at((struct mm_struct *)data, addr, ptep, pte);
+	}
+
+	return ret;
+}
+
+/**
+ * sgx_encl_test_and_clear_young() - Test and reset the accessed bit
+ * @mm:		mm_struct that is checked
+ * @page:	enclave page to be tested for recent access
+ *
+ * Checks the Access (A) bit from the PTE corresponding to the enclave page and
+ * clears it.
+ *
+ * Return: 1 if the page has been recently accessed and 0 if not.
+ */
+int sgx_encl_test_and_clear_young(struct mm_struct *mm,
+				  struct sgx_encl_page *page)
+{
+	unsigned long addr = SGX_ENCL_PAGE_ADDR(page);
+	struct sgx_encl *encl = page->encl;
+	struct vm_area_struct *vma;
+	int ret;
+
+	ret = sgx_encl_find(mm, addr, &vma);
+	if (ret)
+		return 0;
+
+	if (encl != vma->vm_private_data)
+		return 0;
+
+	ret = apply_to_page_range(vma->vm_mm, addr, PAGE_SIZE,
+				  sgx_encl_test_and_clear_young_cb, vma->vm_mm);
+	if (ret < 0)
+		return 0;
+
+	return ret;
+}
+
+/**
+ * sgx_encl_reserve_page() - Reserve an enclave page
+ * @encl:	an enclave
+ * @addr:	a page address
+ *
+ * Load an enclave page and lock the enclave so that the page can be used by
+ * EDBG* and EMOD*.
+ *
+ * Return:
+ *   an enclave page on success
+ *   -EFAULT	if the load fails
+ */
+struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
+					    unsigned long addr)
+{
+	struct sgx_encl_page *entry;
+
+	for ( ; ; ) {
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr);
+		if (PTR_ERR(entry) != -EBUSY)
+			break;
+
+		mutex_unlock(&encl->lock);
+	}
+
+	if (IS_ERR(entry))
+		mutex_unlock(&encl->lock);
+
+	return entry;
+}
+
+/**
+ * sgx_alloc_page - allocate a VA page
+ *
+ * Allocates an &sgx_epc_page instance and converts it to a VA page.
+ *
+ * Return:
+ *   a &struct sgx_va_page instance,
+ *   -errno otherwise
+ */
+struct sgx_epc_page *sgx_alloc_va_page(void)
+{
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	epc_page = sgx_alloc_page(NULL, true);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
+
+	ret = __epa(sgx_epc_addr(epc_page));
+	if (ret) {
+		WARN_ONCE(1, "EPA returned %d (0x%x)", ret, ret);
+		sgx_free_page(epc_page);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return epc_page;
+}
+
+/**
+ * sgx_alloc_va_slot - allocate a VA slot
+ * @va_page:	a &struct sgx_va_page instance
+ *
+ * Allocates a slot from a &struct sgx_va_page instance.
+ *
+ * Return: offset of the slot inside the VA page
+ */
+unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page)
+{
+	int slot = find_first_zero_bit(va_page->slots, SGX_VA_SLOT_COUNT);
+
+	if (slot < SGX_VA_SLOT_COUNT)
+		set_bit(slot, va_page->slots);
+
+	return slot << 3;
+}
+
+/**
+ * sgx_free_va_slot - free a VA slot
+ * @va_page:	a &struct sgx_va_page instance
+ * @offset:	offset of the slot inside the VA page
+ *
+ * Frees a slot from a &struct sgx_va_page instance.
+ */
+void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset)
+{
+	clear_bit(offset >> 3, va_page->slots);
+}
+
+/**
+ * sgx_va_page_full - is the VA page full?
+ * @va_page:	a &struct sgx_va_page instance
+ *
+ * Return: true if all slots have been taken
+ */
+bool sgx_va_page_full(struct sgx_va_page *va_page)
+{
+	int slot = find_first_zero_bit(va_page->slots, SGX_VA_SLOT_COUNT);
+
+	return slot == SGX_VA_SLOT_COUNT;
+}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1d1bc5d590ee..f0f72e591244 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -19,6 +19,10 @@
 
 /**
  * enum sgx_encl_page_desc - defines bits for an enclave page's descriptor
+ * %SGX_ENCL_PAGE_RECLAIMED:		The page is in the process of being
+ *					reclaimed.
+ * %SGX_ENCL_PAGE_VA_OFFSET_MASK:	Holds the offset in the Version Array
+ *					(VA) page for a swapped page.
  * %SGX_ENCL_PAGE_ADDR_MASK:		Holds the virtual address of the page.
  *
  * The page address for SECS is zero and is used by the subsystem to recognize
@@ -26,16 +30,23 @@
  */
 enum sgx_encl_page_desc {
 	/* Bits 11:3 are available when the page is not swapped. */
+	SGX_ENCL_PAGE_RECLAIMED		= BIT(3),
+	SGX_ENCL_PAGE_VA_OFFSET_MASK	= GENMASK_ULL(11, 3),
 	SGX_ENCL_PAGE_ADDR_MASK		= PAGE_MASK,
 };
 
 #define SGX_ENCL_PAGE_ADDR(page) \
 	((page)->desc & SGX_ENCL_PAGE_ADDR_MASK)
+#define SGX_ENCL_PAGE_VA_OFFSET(page) \
+	((page)->desc & SGX_ENCL_PAGE_VA_OFFSET_MASK)
+#define SGX_ENCL_PAGE_INDEX(page) \
+	PFN_DOWN((page)->desc - (page)->encl->base)
 
 struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits;
 	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
 	struct sgx_encl *encl;
 };
 
@@ -63,17 +74,27 @@ struct sgx_encl {
 	struct mutex lock;
 	struct list_head mm_list;
 	spinlock_t mm_lock;
+	unsigned long mm_list_version;
 	struct file *backing;
 	struct kref refcount;
 	struct srcu_struct srcu;
 	unsigned long base;
 	unsigned long size;
 	unsigned long ssaframesize;
+	struct list_head va_pages;
 	struct radix_tree_root page_tree;
 	struct sgx_encl_page secs;
 	cpumask_t cpumask;
 };
 
+#define SGX_VA_SLOT_COUNT 512
+
+struct sgx_va_page {
+	struct sgx_epc_page *epc_page;
+	DECLARE_BITMAP(slots, SGX_VA_SLOT_COUNT);
+	struct list_head list;
+};
+
 extern const struct vm_operations_struct sgx_vm_ops;
 
 int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
@@ -84,4 +105,24 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 		     unsigned long end, unsigned long vm_prot_bits);
 
+struct sgx_backing {
+	pgoff_t page_index;
+	struct page *contents;
+	struct page *pcmd;
+	unsigned long pcmd_offset;
+};
+
+int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+			 struct sgx_backing *backing);
+void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
+int sgx_encl_test_and_clear_young(struct mm_struct *mm,
+				  struct sgx_encl_page *page);
+struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
+					    unsigned long addr);
+
+struct sgx_epc_page *sgx_alloc_va_page(void);
+unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
+void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
+bool sgx_va_page_full(struct sgx_va_page *va_page);
+
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index aea3e82a7ab9..3af0596530a8 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -19,6 +19,43 @@
 /* A per-cpu cache for the last known values of IA32_SGXLEPUBKEYHASHx MSRs. */
 static DEFINE_PER_CPU(u64 [4], sgx_lepubkeyhash_cache);
 
+static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+{
+	struct sgx_va_page *va_page = NULL;
+	void *err;
+
+	BUILD_BUG_ON(SGX_VA_SLOT_COUNT !=
+		(SGX_ENCL_PAGE_VA_OFFSET_MASK >> 3) + 1);
+
+	if (!(encl->page_cnt % SGX_VA_SLOT_COUNT)) {
+		va_page = kzalloc(sizeof(*va_page), GFP_KERNEL);
+		if (!va_page)
+			return ERR_PTR(-ENOMEM);
+
+		va_page->epc_page = sgx_alloc_va_page();
+		if (IS_ERR(va_page->epc_page)) {
+			err = ERR_CAST(va_page->epc_page);
+			kfree(va_page);
+			return err;
+		}
+
+		WARN_ON_ONCE(encl->page_cnt % SGX_VA_SLOT_COUNT);
+	}
+	encl->page_cnt++;
+	return va_page;
+}
+
+static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
+{
+	encl->page_cnt--;
+
+	if (va_page) {
+		sgx_free_page(va_page->epc_page);
+		list_del(&va_page->list);
+		kfree(va_page);
+	}
+}
+
 static u32 sgx_calc_ssaframesize(u32 miscselect, u64 xfrm)
 {
 	u32 size_max = PAGE_SIZE;
@@ -114,6 +151,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 {
 	unsigned long encl_size = secs->size + PAGE_SIZE;
 	struct sgx_epc_page *secs_epc;
+	struct sgx_va_page *va_page;
 	unsigned long ssaframesize;
 	struct sgx_pageinfo pginfo;
 	struct sgx_secinfo secinfo;
@@ -123,20 +161,29 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	if (atomic_read(&encl->flags) & SGX_ENCL_CREATED)
 		return -EINVAL;
 
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page))
+		return PTR_ERR(va_page);
+	else if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
 	ssaframesize = sgx_calc_ssaframesize(secs->miscselect, secs->xfrm);
 	if (sgx_validate_secs(secs, ssaframesize)) {
 		pr_debug("invalid SECS\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_out_shrink;
 	}
 
 	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
 				   VM_NORESERVE);
-	if (IS_ERR(backing))
-		return PTR_ERR(backing);
+	if (IS_ERR(backing)) {
+		ret = PTR_ERR(backing);
+		goto err_out_shrink;
+	}
 
 	encl->backing = backing;
 
-	secs_epc = sgx_try_alloc_page();
+	secs_epc = sgx_alloc_page(&encl->secs, true);
 	if (IS_ERR(secs_epc)) {
 		ret = PTR_ERR(secs_epc);
 		goto err_out_backing;
@@ -183,6 +230,9 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	fput(encl->backing);
 	encl->backing = NULL;
 
+err_out_shrink:
+	sgx_encl_shrink(encl, va_page);
+
 	return ret;
 }
 
@@ -319,13 +369,14 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 {
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
 	int ret;
 
 	encl_page = sgx_encl_page_alloc(encl, offset, secinfo->flags);
 	if (IS_ERR(encl_page))
 		return PTR_ERR(encl_page);
 
-	epc_page = sgx_try_alloc_page();
+	epc_page = sgx_alloc_page(encl_page, true);
 	if (IS_ERR(epc_page)) {
 		kfree(encl_page);
 		return PTR_ERR(epc_page);
@@ -337,9 +388,22 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 		goto err_out_free;
 	}
 
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page)) {
+		ret = PTR_ERR(va_page);
+		goto err_out_free;
+	}
+
 	down_read(&current->mm->mmap_sem);
 	mutex_lock(&encl->lock);
 
+	/*
+	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
+	 * deleting (via sgx_encl_shrink()) in the error path.
+	 */
+	if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
 	/*
 	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
 	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
@@ -370,6 +434,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
+	sgx_mark_page_reclaimable(encl_page->epc_page);
 	mutex_unlock(&encl->lock);
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -379,6 +444,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			  PFN_DOWN(encl_page->desc));
 
 err_out_unlock:
+	sgx_encl_shrink(encl, va_page);
 	mutex_unlock(&encl->lock);
 	up_read(&current->mm->mmap_sem);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 842f9abba1c0..5ce77e554676 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -23,6 +23,8 @@ static struct sgx_epc_page *__sgx_try_alloc_page(struct sgx_epc_section *section
 
 	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
+	section->free_cnt--;
+
 	return page;
 }
 
@@ -54,23 +56,79 @@ struct sgx_epc_page *sgx_try_alloc_page(void)
 	return ERR_PTR(-ENOMEM);
 }
 
+/**
+ * sgx_alloc_page() - Allocate an EPC page
+ * @owner:	the owner of the EPC page
+ * @reclaim:	reclaim pages if necessary
+ *
+ * Try to grab a page from the free EPC page list. If there is a free page
+ * available, it is returned to the caller. The @reclaim parameter hints
+ * the EPC memory manager to swap pages when required.
+ *
+ * Return:
+ *   a pointer to a &struct sgx_epc_page instance,
+ *   -errno on error
+ */
+struct sgx_epc_page *sgx_alloc_page(void *owner, bool reclaim)
+{
+	struct sgx_epc_page *entry;
+
+	for ( ; ; ) {
+		entry = sgx_try_alloc_page();
+		if (!IS_ERR(entry)) {
+			entry->owner = owner;
+			break;
+		}
+
+		if (list_empty(&sgx_active_page_list))
+			return ERR_PTR(-ENOMEM);
+
+		if (!reclaim) {
+			entry = ERR_PTR(-EBUSY);
+			break;
+		}
+
+		if (signal_pending(current)) {
+			entry = ERR_PTR(-ERESTARTSYS);
+			break;
+		}
+
+		sgx_reclaim_pages();
+		schedule();
+	}
+
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		wake_up(&ksgxswapd_waitq);
+
+	return entry;
+}
+
 /**
  * sgx_free_page() - Free an EPC page
  * @page:	pointer a previously allocated EPC page
  *
- * EREMOVE an EPC page and insert it back to the list of free pages.
+ * EREMOVE an EPC page and insert it back to the list of free pages. The page
+ * must not be reclaimable.
  */
 void sgx_free_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = sgx_epc_section(page);
 	int ret;
 
+	/*
+	 * Don't take sgx_active_page_list_lock when asserting the page isn't
+	 * reclaimable, missing a WARN in the very rare case is preferable to
+	 * unnecessarily taking a global lock in the common case.
+	 */
+	WARN_ON_ONCE(page->desc & SGX_EPC_PAGE_RECLAIMABLE);
+
 	ret = __eremove(sgx_epc_addr(page));
 	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
 		return;
 
 	spin_lock(&section->lock);
 	list_add_tail(&page->list, &section->page_list);
+	section->free_cnt++;
 	spin_unlock(&section->lock);
 }
 
@@ -121,6 +179,7 @@ static bool __init sgx_alloc_epc_section(u64 addr, u64 size,
 		list_add_tail(&page->list, &section->unsanitized_page_list);
 	}
 
+	section->free_cnt = nr_pages;
 	return true;
 
 err_out:
diff --git a/arch/x86/kernel/cpu/sgx/reclaim.c b/arch/x86/kernel/cpu/sgx/reclaim.c
index 9e6d3e147aa2..fb521f314fb7 100644
--- a/arch/x86/kernel/cpu/sgx/reclaim.c
+++ b/arch/x86/kernel/cpu/sgx/reclaim.c
@@ -9,10 +9,14 @@
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
+#include "encl.h"
 #include "encls.h"
 #include "driver.h"
 
 struct task_struct *ksgxswapd_tsk;
+DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
+LIST_HEAD(sgx_active_page_list);
+DEFINE_SPINLOCK(sgx_active_page_list_lock);
 
 static void sgx_sanitize_section(struct sgx_epc_section *section)
 {
@@ -66,6 +70,20 @@ static int ksgxswapd(void *p)
 			WARN(1, "EPC section %d has unsanitized pages.\n", i);
 	}
 
+	while (!kthread_should_stop()) {
+		if (try_to_freeze())
+			continue;
+
+		wait_event_freezable(ksgxswapd_waitq,
+				     kthread_should_stop() ||
+				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
+
+		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
+			sgx_reclaim_pages();
+
+		cond_resched();
+	}
+
 	return 0;
 }
 
@@ -81,3 +99,373 @@ bool __init sgx_page_reclaimer_init(void)
 
 	return true;
 }
+
+/**
+ * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * @page:	EPC page
+ *
+ * Mark a page as reclaimable and add it to the active page list. Pages
+ * are automatically removed from the active list when freed.
+ */
+void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
+{
+	spin_lock(&sgx_active_page_list_lock);
+	page->desc |= SGX_EPC_PAGE_RECLAIMABLE;
+	list_add_tail(&page->list, &sgx_active_page_list);
+	spin_unlock(&sgx_active_page_list_lock);
+}
+
+/**
+ * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
+ * @page:	EPC page
+ *
+ * Clear the reclaimable flag and remove the page from the active page list.
+ *
+ * Return:
+ *   0 on success,
+ *   -EBUSY if the page is in the process of being reclaimed
+ */
+int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
+{
+	/*
+	 * Remove the page from the active list if necessary.  If the page
+	 * is actively being reclaimed, i.e. RECLAIMABLE is set but the
+	 * page isn't on the active list, return -EBUSY as we can't free
+	 * the page at this time since it is "owned" by the reclaimer.
+	 */
+	spin_lock(&sgx_active_page_list_lock);
+	if (page->desc & SGX_EPC_PAGE_RECLAIMABLE) {
+		if (list_empty(&page->list)) {
+			spin_unlock(&sgx_active_page_list_lock);
+			return -EBUSY;
+		}
+		list_del(&page->list);
+		page->desc &= ~SGX_EPC_PAGE_RECLAIMABLE;
+	}
+	spin_unlock(&sgx_active_page_list_lock);
+
+	return 0;
+}
+
+static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl_page *page = epc_page->owner;
+	struct sgx_encl *encl = page->encl;
+	struct sgx_encl_mm *encl_mm;
+	bool ret = true;
+	int idx;
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		down_read(&encl_mm->mm->mmap_sem);
+		ret = !sgx_encl_test_and_clear_young(encl_mm->mm, page);
+		up_read(&encl_mm->mm->mmap_sem);
+
+		mmput_async(encl_mm->mm);
+
+		if (!ret || (atomic_read(&encl->flags) & SGX_ENCL_DEAD))
+			break;
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	if (!ret && !(atomic_read(&encl->flags) & SGX_ENCL_DEAD))
+		return false;
+
+	return true;
+}
+
+static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl_page *page = epc_page->owner;
+	unsigned long addr = SGX_ENCL_PAGE_ADDR(page);
+	struct sgx_encl *encl = page->encl;
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	struct vm_area_struct *vma;
+	int idx, ret;
+
+	do {
+		mm_list_version = encl->mm_list_version;
+
+		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
+		smp_rmb();
+
+		idx = srcu_read_lock(&encl->srcu);
+
+		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+			if (!mmget_not_zero(encl_mm->mm))
+				continue;
+
+			down_read(&encl_mm->mm->mmap_sem);
+
+			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
+			if (!ret && encl == vma->vm_private_data)
+				zap_vma_ptes(vma, addr, PAGE_SIZE);
+
+			up_read(&encl_mm->mm->mmap_sem);
+
+			mmput_async(encl_mm->mm);
+		}
+
+		srcu_read_unlock(&encl->srcu, idx);
+	} while (unlikely(encl->mm_list_version != mm_list_version));
+
+	mutex_lock(&encl->lock);
+
+	if (!(atomic_read(&encl->flags) & SGX_ENCL_DEAD)) {
+		ret = __eblock(sgx_epc_addr(epc_page));
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "EBLOCK");
+	}
+
+	mutex_unlock(&encl->lock);
+}
+
+static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
+			  struct sgx_backing *backing)
+{
+	struct sgx_pageinfo pginfo;
+	int ret;
+
+	pginfo.addr = 0;
+	pginfo.secs = 0;
+
+	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
+	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
+			  backing->pcmd_offset;
+
+	ret = __ewb(&pginfo, sgx_epc_addr(epc_page), va_slot);
+
+	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
+					      backing->pcmd_offset));
+	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+
+	return ret;
+}
+
+static void sgx_ipi_cb(void *info)
+{
+}
+
+static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+{
+	cpumask_t *cpumask = &encl->cpumask;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	/*
+	 * Can race with sgx_encl_mm_add(), but ETRACK has already been
+	 * executed, which means that the CPUs running in the new mm will enter
+	 * into the enclave with a fresh epoch.
+	 */
+	cpumask_clear(cpumask);
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
+
+		mmput_async(encl_mm->mm);
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return cpumask;
+}
+
+static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
+			 struct sgx_backing *backing)
+{
+	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_va_page *va_page;
+	unsigned int va_offset;
+	void *va_slot;
+	int ret;
+
+	encl_page->desc &= ~SGX_ENCL_PAGE_RECLAIMED;
+
+	va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
+				   list);
+	va_offset = sgx_alloc_va_slot(va_page);
+	va_slot = sgx_epc_addr(va_page->epc_page) + va_offset;
+	if (sgx_va_page_full(va_page))
+		list_move_tail(&va_page->list, &encl->va_pages);
+
+	ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+	if (ret == SGX_NOT_TRACKED) {
+		ret = __etrack(sgx_epc_addr(encl->secs.epc_page));
+		if (ret) {
+			if (encls_failed(ret))
+				ENCLS_WARN(ret, "ETRACK");
+		}
+
+		ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+		if (ret == SGX_NOT_TRACKED) {
+			/*
+			 * Slow path, send IPIs to kick cpus out of the
+			 * enclave.  Note, it's imperative that the cpu
+			 * mask is generated *after* ETRACK, else we'll
+			 * miss cpus that entered the enclave between
+			 * generating the mask and incrementing epoch.
+			 */
+			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+					 sgx_ipi_cb, NULL, 1);
+			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+		}
+	}
+
+	if (ret) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "EWB");
+
+		sgx_free_va_slot(va_page, va_offset);
+	} else {
+		encl_page->desc |= va_offset;
+		encl_page->va_page = va_page;
+	}
+}
+
+static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
+				struct sgx_backing *backing)
+{
+	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_backing secs_backing;
+	int ret;
+
+	mutex_lock(&encl->lock);
+
+	if (atomic_read(&encl->flags) & SGX_ENCL_DEAD) {
+		ret = __eremove(sgx_epc_addr(epc_page));
+		ENCLS_WARN(ret, "EREMOVE returned %d\n");
+	} else {
+		sgx_encl_ewb(epc_page, backing);
+	}
+
+	encl_page->epc_page = NULL;
+	encl->secs_child_cnt--;
+
+	if (!encl->secs_child_cnt) {
+		if (atomic_read(&encl->flags) & SGX_ENCL_DEAD) {
+			sgx_free_page(encl->secs.epc_page);
+			encl->secs.epc_page = NULL;
+		} else if (atomic_read(&encl->flags) & SGX_ENCL_INITIALIZED) {
+			ret = sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
+						   &secs_backing);
+			if (ret)
+				goto out;
+
+			sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
+
+			sgx_free_page(encl->secs.epc_page);
+			encl->secs.epc_page = NULL;
+
+			sgx_encl_put_backing(&secs_backing, true);
+		}
+	}
+
+out:
+	mutex_unlock(&encl->lock);
+}
+
+/**
+ * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
+ *
+ * Take a fixed number of pages from the head of the active page pool and
+ * reclaim them to the enclave's private shmem files. Skip the pages, which
+ * have been accessed since the last scan. Move those pages to the tail of
+ * active page pool so that the pages get scanned in LRU like fashion.
+ */
+void sgx_reclaim_pages(void)
+{
+	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
+	struct sgx_backing backing[SGX_NR_TO_SCAN];
+	struct sgx_epc_section *section;
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	int cnt = 0;
+	int ret;
+	int i;
+
+	spin_lock(&sgx_active_page_list_lock);
+	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
+		if (list_empty(&sgx_active_page_list))
+			break;
+
+		epc_page = list_first_entry(&sgx_active_page_list,
+					    struct sgx_epc_page, list);
+		list_del_init(&epc_page->list);
+		encl_page = epc_page->owner;
+
+		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
+			chunk[cnt++] = epc_page;
+		else
+			/* The owner is freeing the page. No need to add the
+			 * page back to the list of reclaimable pages.
+			 */
+			epc_page->desc &= ~SGX_EPC_PAGE_RECLAIMABLE;
+	}
+	spin_unlock(&sgx_active_page_list_lock);
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		encl_page = epc_page->owner;
+
+		if (!sgx_reclaimer_age(epc_page))
+			goto skip;
+
+		ret = sgx_encl_get_backing(encl_page->encl,
+					   SGX_ENCL_PAGE_INDEX(encl_page),
+					   &backing[i]);
+		if (ret)
+			goto skip;
+
+		mutex_lock(&encl_page->encl->lock);
+		encl_page->desc |= SGX_ENCL_PAGE_RECLAIMED;
+		mutex_unlock(&encl_page->encl->lock);
+		continue;
+
+skip:
+		kref_put(&encl_page->encl->refcount, sgx_encl_release);
+
+		spin_lock(&sgx_active_page_list_lock);
+		list_add_tail(&epc_page->list, &sgx_active_page_list);
+		spin_unlock(&sgx_active_page_list_lock);
+
+		chunk[i] = NULL;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		if (epc_page)
+			sgx_reclaimer_block(epc_page);
+	}
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		if (!epc_page)
+			continue;
+
+		encl_page = epc_page->owner;
+		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_encl_put_backing(&backing[i], true);
+
+		kref_put(&encl_page->encl->refcount, sgx_encl_release);
+		epc_page->desc &= ~SGX_EPC_PAGE_RECLAIMABLE;
+
+		section = sgx_epc_section(epc_page);
+		spin_lock(&section->lock);
+		list_add_tail(&epc_page->list, &section->page_list);
+		section->free_cnt++;
+		spin_unlock(&section->lock);
+	}
+}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index aa85f85412d8..0c481e6f2c95 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -15,6 +15,7 @@
 
 struct sgx_epc_page {
 	unsigned long desc;
+	struct sgx_encl_page *owner;
 	struct list_head list;
 };
 
@@ -29,6 +30,7 @@ struct sgx_epc_page {
 struct sgx_epc_section {
 	unsigned long pa;
 	void *va;
+	unsigned long free_cnt;
 	struct list_head page_list;
 	struct list_head unsanitized_page_list;
 	spinlock_t lock;
@@ -40,9 +42,14 @@ struct sgx_epc_section {
  *				physical memory. The existing and near-future
  *				hardware defines at most eight sections, hence
  *				three bits to hold a section.
+ * %SGX_EPC_PAGE_RECLAIMABLE:	The page has been been marked as reclaimable.
+ *				Pages need to be colored this way because a page
+ *				can be out of the active page list in the
+ *				process of being swapped out.
  */
 enum sgx_epc_page_desc {
 	SGX_EPC_SECTION_MASK			= GENMASK_ULL(3, 0),
+	SGX_EPC_PAGE_RECLAIMABLE		= BIT(4),
 	/* bits 12-63 are reserved for the physical page address of the page */
 };
 
@@ -62,12 +69,40 @@ static inline void *sgx_epc_addr(struct sgx_epc_page *page)
 	return section->va + (page->desc & PAGE_MASK) - section->pa;
 }
 
+#define SGX_NR_TO_SCAN		16
+#define SGX_NR_LOW_PAGES	32
+#define SGX_NR_HIGH_PAGES	64
+
 extern int sgx_nr_epc_sections;
 extern struct task_struct *ksgxswapd_tsk;
+extern struct wait_queue_head(ksgxswapd_waitq);
+extern struct list_head sgx_active_page_list;
+extern spinlock_t sgx_active_page_list_lock;
+
+static inline unsigned long sgx_nr_free_pages(void)
+{
+	unsigned long cnt = 0;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		cnt += sgx_epc_sections[i].free_cnt;
+
+	return cnt;
+}
+
+static inline bool sgx_should_reclaim(unsigned long watermark)
+{
+	return sgx_nr_free_pages() < watermark &&
+	       !list_empty(&sgx_active_page_list);
+}
 
 bool __init sgx_page_reclaimer_init(void);
+void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
+int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
+void sgx_reclaim_pages(void);
 
 struct sgx_epc_page *sgx_try_alloc_page(void);
+struct sgx_epc_page *sgx_alloc_page(void *owner, bool reclaim);
 void sgx_free_page(struct sgx_epc_page *page);
 
 #endif /* _X86_SGX_H */
-- 
2.25.1

