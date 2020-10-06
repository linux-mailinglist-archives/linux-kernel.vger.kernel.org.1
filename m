Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D42854C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgJFWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFWzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:55:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F064C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 15:55:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so420088wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HGCVKyGQYZlN2d0OUVMXYRPm5j+ZPoa8A5kyMh5F4+U=;
        b=MtWR3VyubrBnus+o/vh7gAp/nETf7cvtPg3bsbRbOoaBmBVPhDQViSLg0Sm+d6t2EV
         1sFIztChA/8yNE6rZ+JfUbQozKN15UNruTKS97DMZO4BZGRcBJvSmnDMHH+Buvegorea
         uSJQp4hPC6vU1v94lar4/E34Wr1vxdJdwFPmNIUzMzod7kaC4cf+wsboZLdjioe0CIyN
         cdsHpaBlZizKsh1dmmSC1BTO2hcuDNe5Wuit40HFnaqcaVXxzYTB2VEYAwFzXLzXnRjN
         psNmrtLFyhE7lIzGaniy1ENf+7jOFbQs33UO6gsayyuDFY4MkBJPoFlLDmSfRDWIwUJI
         zCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGCVKyGQYZlN2d0OUVMXYRPm5j+ZPoa8A5kyMh5F4+U=;
        b=mnHo0SI64zE8B7QkdJyoJIuFUIQINsv+XfI9oh4nWJCpEyhR6jT52yxY0FJAdbegwA
         gCnPkPgSbNdn8/grEFSWVyugmy7vwkkkqJOT2A2nceGkzziAmRgjCYeHEOrW3v56YaDx
         5Ej25md5qUixVS6TTH6Upg3cCLoDSaSW+mP6qLMmLvzi27w8qsrrXopS8ohACdruxPrT
         3G6PmrlqKNLn/E7ThvzCESg0X0Bix0gGOnx9ZPuaCUeeStIu9pX8crXVhhVGey3g2bqa
         G+BHPRcFxxU9PPXy0TBqyEc/UFgngakIdLV4NvYlsW3RkxvvZNICgYl7+zChQApKQNPV
         X/Tw==
X-Gm-Message-State: AOAM533t+asqiSwwZKCzPXWSJvTVLfnfmZIFFV6q/3Du1V0e+lLZuFL3
        cxl9z/K2bzkuUkuXU4qaKTp9yg==
X-Google-Smtp-Source: ABdhPJxtwY+EEZDUG+ByVJbphRcGc6RU0rLKiFkJaQUAspMbv4Mof8L7Z40rGPrOffzEGzMOeng9Ig==
X-Received: by 2002:a05:600c:2902:: with SMTP id i2mr167748wmd.31.1602024900851;
        Tue, 06 Oct 2020 15:55:00 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id i15sm243602wrb.91.2020.10.06.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:55:00 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/2] mmap locking API: Order lock of nascent mm outside lock of live mm
Date:   Wed,  7 Oct 2020 00:54:49 +0200
Message-Id: <20201006225450.751742-2-jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201006225450.751742-1-jannh@google.com>
References: <20201006225450.751742-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
of the old mm (in dup_mmap() and in UML's activate_mm()).
A following patch will change the exec path to very broadly lock the
nascent mm, but fine-grained locking should still work at the same time for
the old mm.

In particular, mmap locking calls are hidden behind the copy_from_user()
calls and such that are reached through functions like copy_strings() -
when a page fault occurs on a userspace memory access, the mmap lock
will be taken.

To do this in a way that lockdep is happy about, let's turn around the lock
ordering in both places that currently nest the locks.
Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
instead.

The added locking calls in exec_mmap() are temporary; the following patch
will move the locking out of exec_mmap().

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/um/include/asm/mmu_context.h |  3 +--
 fs/exec.c                         |  4 ++++
 include/linux/mmap_lock.h         | 23 +++++++++++++++++++++--
 kernel/fork.c                     |  7 ++-----
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..c13bc5150607 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
+	mmap_assert_write_locked(new);
 	uml_setup_stubs(new);
-	mmap_write_unlock(new);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..229dbc7aa61a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1114,6 +1114,8 @@ static int exec_mmap(struct mm_struct *mm)
 	if (ret)
 		return ret;
 
+	mmap_write_lock_nascent(mm);
+
 	if (old_mm) {
 		/*
 		 * Make sure that if there is a core dump in progress
@@ -1125,6 +1127,7 @@ static int exec_mmap(struct mm_struct *mm)
 		if (unlikely(old_mm->core_state)) {
 			mmap_read_unlock(old_mm);
 			mutex_unlock(&tsk->signal->exec_update_mutex);
+			mmap_write_unlock(mm);
 			return -EINTR;
 		}
 	}
@@ -1138,6 +1141,7 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
+	mmap_write_unlock(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0707671851a8..24de1fe99ee4 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -3,6 +3,18 @@
 
 #include <linux/mmdebug.h>
 
+/*
+ * Lock subclasses for the mmap_lock.
+ *
+ * MMAP_LOCK_SUBCLASS_NASCENT is for core kernel code that wants to lock an mm
+ * that is still being constructed and wants to be able to access the active mm
+ * normally at the same time. It nests outside MMAP_LOCK_SUBCLASS_NORMAL.
+ */
+enum {
+	MMAP_LOCK_SUBCLASS_NORMAL = 0,
+	MMAP_LOCK_SUBCLASS_NASCENT
+};
+
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
 
@@ -16,9 +28,16 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 	down_write(&mm->mmap_lock);
 }
 
-static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
+/*
+ * Lock an mm_struct that is still being set up (during fork or exec).
+ * This nests outside the mmap locks of live mm_struct instances.
+ * No interruptible/killable versions exist because at the points where you're
+ * supposed to use this helper, the mm isn't visible to anything else, so we
+ * expect the mmap_lock to be uncontended.
+ */
+static inline void mmap_write_lock_nascent(struct mm_struct *mm)
 {
-	down_write_nested(&mm->mmap_lock, subclass);
+	down_write_nested(&mm->mmap_lock, MMAP_LOCK_SUBCLASS_NASCENT);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..db67eb4ac7bd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	unsigned long charge;
 	LIST_HEAD(uf);
 
+	mmap_write_lock_nascent(mm);
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
 		retval = -EINTR;
@@ -481,10 +482,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	}
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
-	/*
-	 * Not linked in yet - no deadlock potential:
-	 */
-	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
@@ -600,12 +597,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 out:
-	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
+	mmap_write_unlock(mm);
 	return retval;
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
-- 
2.28.0.806.g8561365e88-goog

