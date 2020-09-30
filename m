Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0216127DDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgI3BUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgI3BUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:20:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02737C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so398480eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=FJ8M+pHggei1WQdL/4TrI43/85X7WQS6HxNpsqYJ8eA=;
        b=FciCqs7O89TYrgwgKLvIjXoyAZkwsaZpE6Nuzeap1QJBgETGE1A3XhDed3ACffrhl9
         pI/uN6ZpsSHpqckKdJkUo29P7om+6IGaEzMistNwRXKqBM4TQLElVxZsPT/YPGdSnm37
         ELe8Jvzmh45qfbqhnAeWgOAGD+6ZAXUr8tynXL+2fU26DTNrrzA7kC3BBysLWmV5diB4
         GASCTl2Zgh380AIVbpjd3FciicoUwmHzW+dk4UZQDc/WEW9T3Ggbj4Umwe27DOEOGT6h
         GNbA2xZRC/wjnx70Cl0n+8QTXm+YZUkZMFTR0S2FSA3KBqyuXTbvTEV5AZt331tdi2kx
         RYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=FJ8M+pHggei1WQdL/4TrI43/85X7WQS6HxNpsqYJ8eA=;
        b=XRg4/aQnZeWTv2OMTNg+R7kaCFHiNckEmV/3fPmAMntrh8G1UZPvJHjkAdLT+xgSTq
         gUIOyiiyeYY1PR2S1aAUwnIPCfeQeDIH0h48G/4jlHszFDo/6RrD2LMoeiJwADtD+5vW
         sofGdzooBsW/AO6fbb9Z1D9Hpp1cPVQSNIAgTtxSxHIFO4bnMQKANaz0qbaFX/HtuWOk
         Yf89gmsix4f6T6oDxbjot7M1jwYRcp80Qw4frUqI+9Yh9l0bQ1U93T+GEMd1N0kUaLpk
         KnUlKi1YJeD13rWX/kKU4Fjq6T3feIvclHQ/yXA6ZNA8Cfm4LZMnRn2ptAKcA1azAh1E
         K4tA==
X-Gm-Message-State: AOAM531XeZik/KFd7Rzj30tsKROL2GCZy9CjGyluMIuz314fSho+nJSn
        NRyY7mEE2ET4+YoWlpW4XoLxFsY8xklVYFyQjhS4Sg==
X-Google-Smtp-Source: ABdhPJzeVsqTjOdTgnQ+hOnlnWn0pG7xOE1ZrHUkyx2qFe5zL92TP/PmsJUyfJx4bTRaC1pNobIQ3TeqVhuZQYimHzI=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr412804ejb.358.1601428802412;
 Tue, 29 Sep 2020 18:20:02 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2020 18:20:00 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930011944.19869-1-jannh@google.com>
References: <20200930011944.19869-1-jannh@google.com>
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 18:20:00 -0700
Message-ID: <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
Subject: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a mmap_assert_locked() check in
__get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
to operate on an mm without locking in the middle of execve() as long as
it hasn't been installed on a process yet.

Existing code paths that do this are (reverse callgraph):

  get_user_pages_remote
    get_arg_page
      copy_strings
      copy_string_kernel
      remove_arg_zero
    tomoyo_dump_page
      tomoyo_print_bprm
      tomoyo_scan_bprm
      tomoyo_environ

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/exec.c                 |  8 ++++++++
 include/linux/mm_types.h  |  9 +++++++++
 include/linux/mmap_lock.h | 16 ++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..c02b0e8e1c0b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1129,6 +1129,14 @@ static int exec_mmap(struct mm_struct *mm)
 		}
 	}

+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEBUG_VM)
+	/*
+	 * From here on, the mm may be accessed concurrently, and proper locking
+	 * is required for things like get_user_pages_remote().
+	 */
+	mm->mmap_lock_required = 1;
+#endif
+
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	membarrier_exec_mmap(mm);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ed028af3cb19..89fee0d0d652 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -552,6 +552,15 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEBUG_VM)
+		/*
+		 * Notes whether this mm has been installed on a process yet.
+		 * If not, only the task going through execve() can access this
+		 * mm, and no locking is needed around get_user_pages_remote().
+		 * This flag is only used for debug checks.
+		 */
+		bool mmap_lock_required;
+#endif
 	} __randomize_layout;

 	/*
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0707671851a8..c4fd874954d7 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -77,14 +77,22 @@ static inline void
mmap_read_unlock_non_owner(struct mm_struct *mm)

 static inline void mmap_assert_locked(struct mm_struct *mm)
 {
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEBUG_VM)
+	if (mm->mmap_lock_required) {
+		lockdep_assert_held(&mm->mmap_lock);
+		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	}
+#endif
 }

 static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEBUG_VM)
+	if (mm->mmap_lock_required) {
+		lockdep_assert_held_write(&mm->mmap_lock);
+		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	}
+#endif
 }

 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.28.0.709.gb0816b6eb0-goog
