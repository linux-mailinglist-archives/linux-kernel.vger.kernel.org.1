Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3328E9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgJOBUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbgJOBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC555C004586
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:01:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so987639wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+eg8YgelJaIrse4cpi7Ihnp7zRy6v8TM+zVlOepTsI=;
        b=HEYZPCQSEY6/zZcdjkGO/ocyGBY4uDIlADTK4kJrkxdC0NoC6FN45s4b9Y48I7MXdY
         YZH5LYzFpYbFD34aBR6uUqKngYLSocyGlWnapLc2uxIJyua77nyDSn9rnXvWGy2fIARo
         SgZoKw+kcrLlbz05EST4yTQuYm3+cR2S4jlgX9Zhfvk61DLdHNCmkxt2G88WL9d+MRAR
         nTRbE7x8iJCjoWDgBM7IsI92Br5Gibvrrjia/pDchZq24bjhxqiCsp6+CJFGLjGi2Mkx
         xmpA5yL4KuqggemD/KpwxyGrGi0nd+iAboQaY5R/hH2DQJtdUjVBSaZc/mly7DdZ4njC
         ZzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+eg8YgelJaIrse4cpi7Ihnp7zRy6v8TM+zVlOepTsI=;
        b=TljhEPcx78atD3ehdTegxqDIYAwOCNMDcwc2iQefbrqMftITS1/xu+uFTLZgTa/2Wb
         R9NpKC/j0/kz9fJb2uLF/0xRbwe+lIxWn7lfA2PfS2YzNoyyZrgi9TeQOkmVyyHvilV2
         ZrKXo226GOAj25LV5Xf0eeLZvdyP67pCLEHdz2j1gTDoDafAcV8qA7Xl41k+4GbO2CY9
         KnYUI+ag6qC/p5O0hQ7l2pnGPsX7zlvQyuVpd5cUGTlsTMgUkDU0pV4TAixDqvpu1m4C
         VCSPr8/Rxpmu9LpHLW+xj4GLjPULTxWAuB09R1azNZk1YKAtsBPLpQihHfUKXcc95hcI
         iI7g==
X-Gm-Message-State: AOAM532fTWIxgic42e18+Ot8WoKxreOqbdiAd7fJptrCXFBScAmYuK5f
        VJqNV+ct7enzmU+Uki6V1ZHlEQ==
X-Google-Smtp-Source: ABdhPJyy7N9UEaPfdtetQQx+qXWmXhJLnRo6ObdxA5iADhOSskrhvebUWIovEChg8l+P+XJ+Ki5Xbw==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr1242206wrv.40.1602720055421;
        Wed, 14 Oct 2020 17:00:55 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id q8sm1428293wro.32.2020.10.14.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:00:54 -0700 (PDT)
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
        John Hubbard <jhubbard@nvidia.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 1/2] mmap locking API: Order lock of nascent mm outside lock of live mm
Date:   Thu, 15 Oct 2020 02:00:40 +0200
Message-Id: <20201015000041.1734214-2-jannh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015000041.1734214-1-jannh@google.com>
References: <20201015000041.1734214-1-jannh@google.com>
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

As Johannes Berg pointed out[1][2], moving the mmap locking of
arch/um/'s activate_mm() up into the execve code also fixes an issue that
would've caused a scheduling-in-atomic bug due to mmap_write_lock_nested()
while holding a spinlock if UM had support for voluntary preemption.
(Even when a semaphore is uncontended, locking it can still trigger
rescheduling via might_sleep().)

[1] https://lore.kernel.org/linux-mm/115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net/
[2] https://lore.kernel.org/linux-mm/7b7d6954b74e109e653539d880173fa9cb5c5ddf.camel@sipsolutions.net/

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
2.28.0.1011.ga647a8990f-goog

