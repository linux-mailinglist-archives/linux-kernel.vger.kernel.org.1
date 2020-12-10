Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81A2D648B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403974AbgLJRH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:07:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403907AbgLJRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnOgp044292;
        Thu, 10 Dec 2020 17:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=hArbfACBrVSL1lzDBqGgRWQ1ZqO/zTAH/mCSVhtw3sg=;
 b=B2z2l2UDav7M4L+CL+sPJ9gc5W1pqTkG44CIChCZXMd+sLrWN2AHjKFK8PalT+a+5Abi
 IxOHahcKoPSz6QTXMs/IDC1RDJCDfGFBDWcEd6DmS8ccSZCf05M2364oxS7YhdJwt1yF
 Ah4ExO2M50CZdlOBvsAAdMvm/+VfY7LoCT5OIy9cjm3aAMkE7HOVwGsKGm3gjQrY9nT2
 bsSrV6jvBCl/1C+LeNVEBJJjQKLX77T6R5bvoqPKzIENFwe8zjb9smQl0rUom4QQhwYN
 vKk5TNX0DFN9VAbwMHeSwNlgmZY0cjHTw37gVh0G7jG34wfVNSBCLZa0gtFwatluGtKy PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825meh2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:05:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwjEh046041;
        Thu, 10 Dec 2020 17:05:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 358m41xbcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:05:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH50t0009098;
        Thu, 10 Dec 2020 17:05:00 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:59 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 22/28] mm/mmap: Move mmap_region() below do_munmap()
Date:   Thu, 10 Dec 2020 12:03:56 -0500
Message-Id: <20201210170402.3468568-23-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocation of code for the next commit.  There should be no changes here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 479 +++++++++++++++++++++++++++---------------------------
 1 file changed, 240 insertions(+), 239 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 34f337a5fc31d..b501388c73ebd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1703,245 +1703,6 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	struct vm_area_struct *prev, *next;
-	pgoff_t pglen = len >> PAGE_SHIFT;
-	unsigned long charged = 0;
-	unsigned long end = addr + len;
-	unsigned long merge_start = addr, merge_end = end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |= VM_ACCOUNT;
-	}
-
-
-	if (vm_flags & VM_SPECIAL) {
-		prev = mas_prev(&mas, 0);
-		goto cannot_expand;
-	}
-
-	/* Attempt to expand an old mapping */
-
-	/* Check next */
-	next = mas_next(&mas, ULONG_MAX);
-	if (next && next->vm_start == end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end = next->vm_end;
-		vma = next;
-		vm_pgoff = next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	prev = mas_prev(&mas, 0);
-	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				NULL_VM_UFFD_CTX)) {
-		merge_start = prev->vm_start;
-		vma = prev;
-		vm_pgoff = prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(prev, vm_flags);
-		goto expanded;
-	}
-
-	mas_reset(&mas);
-	mas_set(&mas, addr);
-	mas.last = end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start = addr;
-	vma->vm_end = end;
-	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-	vma->vm_pgoff = pgoff;
-
-	if (file) {
-		if (vm_flags & VM_DENYWRITE) {
-			error = deny_write_access(file);
-			if (error)
-				goto free_vma;
-		}
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
-
-		/* ->mmap() can change vma->vm_file, but must guarantee that
-		 * vma_link() below can deny write-access if VM_DENYWRITE is set
-		 * and map writably if VM_SHARED is set. This usually means the
-		 * new file must not have been exposed to user-space, yet.
-		 */
-		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev &&
-			     prev->vm_end == addr && !vma_policy(prev) &&
-			     can_vma_merge_after(prev, vm_flags, NULL, file,
-						 pgoff, NULL_VM_UFFD_CTX))) {
-			merge_start = prev->vm_start;
-			vm_pgoff = prev->vm_pgoff;
-			if (!vma_expand(&mas, prev, merge_start, merge_end,
-					vm_pgoff, next)) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
-				addr = vma->vm_start;
-				vm_flags = vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev and the maple tree data should
-		 * be updated for vma_link()
-		 */
-		WARN_ON_ONCE(addr != vma->vm_start);
-
-		addr = vma->vm_start;
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	mas.index = mas.last = addr;
-	mas_walk(&mas);
-	vma_mas_link(mm, vma, &mas, prev);
-	/* Once vma denies write, undo our temporary denial count */
-	if (file) {
-unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
-		if (vm_flags & VM_DENYWRITE)
-			allow_write_access(file);
-	}
-	file = vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-		    is_vm_hugetlb_page(vma) ||
-		    vma == get_gate_vma(current->mm))
-			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |= VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_vma:
-	vma->vm_file = NULL;
-	fput(file);
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged = 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
-	if (vm_flags & VM_DENYWRITE)
-		allow_write_access(file);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	return error;
-}
-
 /* unmapped_area() Find an area between the low_limit and the high_limit with
  * the correct alignment and offset, all from @info. Note: current->mm is used
  * for the search.
@@ -2800,6 +2561,246 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen = len >> PAGE_SHIFT;
+	unsigned long charged = 0;
+	unsigned long end = addr + len;
+	unsigned long merge_start = addr, merge_end = end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages = count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged = len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |= VM_ACCOUNT;
+	}
+
+
+	if (vm_flags & VM_SPECIAL) {
+		prev = mas_prev(&mas, 0);
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	next = mas_next(&mas, ULONG_MAX);
+	if (next && next->vm_start == end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff + pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end = next->vm_end;
+		vma = next;
+		vm_pgoff = next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	prev = mas_prev(&mas, 0);
+	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX)) {
+		merge_start = prev->vm_start;
+		vma = prev;
+		vm_pgoff = prev->vm_pgoff;
+	}
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(prev, vm_flags);
+		goto expanded;
+	}
+
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma = vm_area_alloc(mm);
+	if (!vma) {
+		error = -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start = addr;
+	vma->vm_end = end;
+	vma->vm_flags = vm_flags;
+	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+	vma->vm_pgoff = pgoff;
+
+	if (file) {
+		if (vm_flags & VM_DENYWRITE) {
+			error = deny_write_access(file);
+			if (error)
+				goto free_vma;
+		}
+		if (vm_flags & VM_SHARED) {
+			error = mapping_map_writable(file->f_mapping);
+			if (error)
+				goto allow_write_and_free_vma;
+		}
+
+		/* ->mmap() can change vma->vm_file, but must guarantee that
+		 * vma_link() below can deny write-access if VM_DENYWRITE is set
+		 * and map writably if VM_SHARED is set. This usually means the
+		 * new file must not have been exposed to user-space, yet.
+		 */
+		vma->vm_file = get_file(file);
+		error = call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags != vma->vm_flags && prev &&
+			     prev->vm_end == addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start = prev->vm_start;
+			vm_pgoff = prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma = prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr = vma->vm_start;
+				vm_flags = vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 * Bug: If addr is changed, prev and the maple tree data should
+		 * be updated for vma_link()
+		 */
+		WARN_ON_ONCE(addr != vma->vm_start);
+
+		addr = vma->vm_start;
+		vm_flags = vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error = shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error = -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	/*
+	 * mas was called for the prev vma, and that may not be the correct
+	 * location for the vma being inserted, but is is before that location
+	 * and so the call to vma_mas_link()->vma_mas_store()->mas_store_gfp()
+	 * will detect the write as a spanning store and reset mas if necessary.
+	 */
+	mas.index = mas.last = addr;
+	mas_walk(&mas);
+	vma_mas_link(mm, vma, &mas, prev);
+	/* Once vma denies write, undo our temporary denial count */
+	if (file) {
+unmap_writable:
+		if (vm_flags & VM_SHARED)
+			mapping_unmap_writable(file->f_mapping);
+		if (vm_flags & VM_DENYWRITE)
+			allow_write_access(file);
+	}
+	file = vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+		    is_vm_hugetlb_page(vma) ||
+		    vma == get_gate_vma(current->mm))
+			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm += (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |= VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_vma:
+	vma->vm_file = NULL;
+	fput(file);
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged = 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+allow_write_and_free_vma:
+	if (vm_flags & VM_DENYWRITE)
+		allow_write_access(file);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	return error;
+}
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
-- 
2.28.0

