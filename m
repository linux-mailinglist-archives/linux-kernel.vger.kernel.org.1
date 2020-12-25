Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5090E2E2A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 10:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgLYJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 04:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgLYJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 04:30:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD99C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w5so2912378pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDjmC0wED5YD+zWwSTV9f3sSNl1DtsQGXc+J7WldMSU=;
        b=IDq6+mY9HiagE+bcoLTYLB1ccM6eglGCAr7GicPFjIKA7o9+qPNXEFwK2FaauiK38a
         el+BClrxiN/a8uB/9TDzCB07saucKcPX1sw4q7RXY4bX0TlfRxO9wlR6Cl2di94gfJ6v
         +RTOJPgaF1PFyD8lDx3QsjJ3MK9eiaSiACP4b7BnIABEjr5SKbMalcyo3m/4FNjMEMP1
         JF2jwq48R5vyyk5eEIIGf5vH8RP9zwpSXInlwsQC4CSa2eTBIy4Md/bqHo+8DDb8820p
         0bFJkA7+H3tosywwTUoFaPF8IWm4CluDbVUShKhhOMEbt6W+BpVUub1SLt8d+VwEbe5J
         Sz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDjmC0wED5YD+zWwSTV9f3sSNl1DtsQGXc+J7WldMSU=;
        b=opZpNBJYpuqGiLv2IcdasGlBF7W+j1lLA0OZtfwlxXX5UacFtXYIA1B7ji42nvusYn
         oDDOLoLhVC+7+vtM+65eLgwT2jHXLQUxbjsNqxMZgXSEPfxIjyZuSj0Daos3I0N9A0fZ
         FwWZM23bB5fbUCZbZi+iUCwt8nEkwoOSz7USeXkPfbbbgYT3ik1igRfjoF6eQTjW5yWx
         zd8CQ3PwBFRZvOvmIOLmJd7HDrBNrwr+9XV7j5j9zTN5esV3031fHYF20rWbl5Tq35zR
         AvqHFHOQ10PWNLiMb+JgEe7srUKDIrIGGTYNU3bw0SNhEK3KG4na5JdqqHIRCrwS3PF4
         UwLA==
X-Gm-Message-State: AOAM531ks4SXSSH+gZLBd89O7Un1S1oEHJ1UJl3NiFzfzLuRAvgJ2ff6
        3ilCnjYgO8n2/e5Y0aSM51M=
X-Google-Smtp-Source: ABdhPJy/1/+yedd/HVU2ah9M1o5ll1wUDPc9qrbrm6ucr24j/Do15+ei/nVGJU5eAX9bxpkhxlozTg==
X-Received: by 2002:a62:1b06:0:b029:19d:d05d:f67a with SMTP id b6-20020a621b060000b029019dd05df67amr30508332pfb.78.1608888579962;
        Fri, 25 Dec 2020 01:29:39 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s13sm28966659pfd.99.2020.12.25.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 01:29:39 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on soft-dirty cleanup
Date:   Fri, 25 Dec 2020 01:25:29 -0800
Message-Id: <20201225092529.3228466-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201225092529.3228466-1-namit@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Clearing soft-dirty through /proc/[pid]/clear_refs can cause memory
corruption as it clears the dirty-bit without acquiring the mmap_lock
for write and defers TLB flushes.

As a result of this behavior, it is possible that one of the CPUs would
have the stale PTE cached in its TLB and keep updating the page while
another thread triggers a page-fault, and the page-fault handler would
copy the old page into a new one.

Since the copying is performed without holding the page-table lock, it
is possible that after the copying, and before the PTE is actually
flushed, the CPU that cached the stale PTE in the TLB would keep
changing the page. These changes would be lost and memory corruption
would occur.

As Yu Zhao pointed, this race became more apparent since commit
09854ba94c6a ("mm: do_wp_page() simplification") which made
wp_page_copy() more likely to take place, specifically if
page_count(page) > 1.

The following test produces the failure quite well on 5.10 and my
machine. Note that the test is tailored for recent kernels behavior in
which wp_page_copy() is called when page_count(page) != 1, but the fact
the test does not fail on older kernels does not mean they are not
affected.

  #define _GNU_SOURCE
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <sys/mman.h>
  #include <unistd.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <assert.h>
  #include <fcntl.h>
  #include <string.h>
  #include <threads.h>
  #include <stdatomic.h>

  #define PAGE_SIZE	(4096)
  #define TLB_SIZE	(2000)
  #define N_PAGES	(300000)
  #define ITERATIONS	(2000)
  #define N_THREADS	(2)

  static int stop;
  static char *m;

  static int writer(void *argp)
  {
  	unsigned long t_idx = (unsigned long)argp;
  	int i, cnt = 0;

  	while (!atomic_load(&stop)) {
  		cnt++;
  		atomic_fetch_add((atomic_int *)m, 1);

  		/*
  		 * First thread only accesses the page to have it cached in the
  		 * TLB.
  		 */
  		if (t_idx == 0)
  			continue;

  		/*
  		 * Other threads access enough entries to cause eviction from
  		 * the TLB and trigger #PF upon the next access (before the TLB
  		 * flush of clear_ref actually takes place).
  		 */
  		for (i = 1; i < TLB_SIZE; i++) {
  			if (atomic_load((atomic_int *)(m + PAGE_SIZE * i))) {
  				fprintf(stderr, "unexpected error\n");
  				exit(1);
  			}
  		}
  	}
  	return cnt;
  }

  /*
   * Runs mlock/munlock in the background to raise the page-count of the
   * page and force copying instead of reusing the page. Raising the
   * page-count is possible in better ways, e.g., registering io_uring
   * buffers.
   */
  static int do_mlock(void *argp)
  {
  	while (!atomic_load(&stop)) {
  		if (mlock(m, PAGE_SIZE) || munlock(m, PAGE_SIZE)) {
  			perror("mlock/munlock");
  			exit(1);
  		}
  	}
  	return 0;
  }

  int main(void)
  {
  	int r, cnt, fd, total = 0;
  	long i;
  	thrd_t thr[N_THREADS];
  	thrd_t mlock_thr;

  	fd = open("/proc/self/clear_refs", O_WRONLY, 0666);
  	if (fd < 0) {
  		perror("open");
  		exit(1);
  	}

  	/*
  	 * Have large memory for clear_ref, so there would be some time between
  	 * the unmap and the actual deferred flush.
  	 */
  	m = mmap(NULL, PAGE_SIZE * N_PAGES, PROT_READ|PROT_WRITE,
  			MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, -1, 0);
  	if (m == MAP_FAILED) {
  		perror("mmap");
  		exit(1);
  	}

  	for (i = 0; i < N_THREADS; i++) {
  		r = thrd_create(&thr[i], writer, (void *)i);
  		assert(r == thrd_success);
  	}

  	r = thrd_create(&mlock_thr, do_mlock, (void *)i);
  	assert(r == thrd_success);

  	for (i = 0; i < ITERATIONS; i++) {
  		r = pwrite(fd, "4", 1, 0);
  		if (r < 0) {
  			perror("pwrite");
  			exit(1);
  		}
  	}

  	atomic_store(&stop, 1);

  	r = thrd_join(mlock_thr, NULL);
  	assert(r == thrd_success);

  	for (i = 0; i < N_THREADS; i++) {
  		r = thrd_join(thr[i], &cnt);
  		assert(r == thrd_success);
  		total += cnt;
  	}

  	r = atomic_load((atomic_int *)(m));
  	if (r != total) {
  		fprintf(stderr, "failed: expected=%d actual=%d\n", total, r);
  		exit(-1);
  	}

  	fprintf(stderr, "ok\n");
  	return 0;
  }

Fix it by taking mmap_lock for write when clearing soft-dirty.

Note that the test keeps failing without the pending fix of the missing
TLB flushes in clear_refs_write() [1].

[1] https://lore.kernel.org/patchwork/patch/1351776/

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 fs/proc/task_mmu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 217aa2705d5d..39b2bd27af79 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1189,6 +1189,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
+	bool write_lock = false;
 	struct mmu_gather tlb;
 	int itype;
 	int rv;
@@ -1236,21 +1237,16 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		}
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
+			mmap_read_unlock(mm);
+			if (mmap_write_lock_killable(mm)) {
+				count = -EINTR;
+				goto out_mm;
+			}
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
-				if (!(vma->vm_flags & VM_SOFTDIRTY))
-					continue;
-				mmap_read_unlock(mm);
-				if (mmap_write_lock_killable(mm)) {
-					count = -EINTR;
-					goto out_mm;
-				}
-				for (vma = mm->mmap; vma; vma = vma->vm_next) {
-					vma->vm_flags &= ~VM_SOFTDIRTY;
-					vma_set_page_prot(vma);
-				}
-				mmap_write_downgrade(mm);
-				break;
+				vma->vm_flags &= ~VM_SOFTDIRTY;
+				vma_set_page_prot(vma);
 			}
+			write_lock = true;
 
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
@@ -1261,7 +1257,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		if (type == CLEAR_REFS_SOFT_DIRTY)
 			mmu_notifier_invalidate_range_end(&range);
 		tlb_finish_mmu(&tlb, 0, -1);
-		mmap_read_unlock(mm);
+		if (write_lock)
+			mmap_write_unlock(mm);
+		else
+			mmap_read_unlock(mm);
 out_mm:
 		mmput(mm);
 	}
-- 
2.25.1

