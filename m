Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6427942A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgIYW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbgIYW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:26:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+o6VUGgCEedkH4qsZJWlfLcQyoccvndv43VtGbLQGg=;
        b=OUDdycIcmKvSRDuiEgq1s1d8k/L7RoFicgoUfhsy1YQLgdJTnxCGBS64zX6Qv5SdF/JH0a
        rsCauCe9Svc8UiiV6kiTUS1Xb6ukb1fJ4OOD7p94U4gL/8tsP/HG21OUYxz7coLHx1x4rS
        QZnHEz3tkC50ghjeaEIcTWMcFs1Ywbk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-sG3Pqi9ONeu4VjD-8x7iIA-1; Fri, 25 Sep 2020 18:25:59 -0400
X-MC-Unique: sG3Pqi9ONeu4VjD-8x7iIA-1
Received: by mail-qv1-f71.google.com with SMTP id t7so2736033qvz.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+o6VUGgCEedkH4qsZJWlfLcQyoccvndv43VtGbLQGg=;
        b=Aq/dPLXzXk/xnDBZ4MPllemv9u/+KNgg4F5GxOiBgSr+2YQyqzQtOTU+XlsIfg5zMK
         XPaqe4hsCLNDLrPinKhvEKFBa92VpKoiu3oCVuG3/Oa8JeKGpyLNlfWUJ+8mUJFpUKZa
         h4Ne6FAnSXIBJJ198/CH5C71wURsqzBUo/msd74LF0vlGP1Q/DgWCOXMiyIqclg4ic24
         T7OzcjX+iP2CVo8pBWGmsA2rzfE/ac65iBHVAXE7Fo++edk3b93dLCvOykhp2zqp3pLO
         7EQ4Qcji9Pvqo9ohXvgITXfqnC4jsh02n+2PU3Q9YGdd2G4sDqRaf4C9K1dWL8ycdtp9
         Knsw==
X-Gm-Message-State: AOAM530cdMdhxL+boKqSXfg0s9NN6RHyHiF+60vBFuefK2aCsGalK7Sj
        +dhz/WT8FYkyQW7jZLEH7apD5T8okWA7D1TGD372cSgrIXI+/AEymgd0LMhaYkgWUosVNbxNwxE
        PCji50FMiCyytGK4n8FIlEM5B
X-Received: by 2002:a37:9ed3:: with SMTP id h202mr2282058qke.66.1601072758428;
        Fri, 25 Sep 2020 15:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRrlc9138emjhNCE1DdjfK+f5739ImDYiquqqyoPqiCh+4PuUBO3ufEAh8Ba/zMvHD/ji8FQ==
X-Received: by 2002:a37:9ed3:: with SMTP id h202mr2282025qke.66.1601072758162;
        Fri, 25 Sep 2020 15:25:58 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w44sm3051471qth.9.2020.09.25.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:25:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 1/4] mm: Introduce mm_struct.has_pinned
Date:   Fri, 25 Sep 2020 18:25:57 -0400
Message-Id: <20200925222600.6832-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925222600.6832-1-peterx@redhat.com>
References: <20200925222600.6832-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Commit message majorly collected from Jason Gunthorpe)

Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
track if the mm_struct has ever been used with pin_user_pages().  This allows
cases that might drive up the page ref_count to avoid any penalty from handling
dma_pinned pages.

Future work is planned, to provide a more sophisticated solution, likely to
turn it into a real counter.  For now, make it atomic_t but use it as a boolean
for simplicity.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 10 ++++++++++
 kernel/fork.c            |  1 +
 mm/gup.c                 |  6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..ed028af3cb19 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -436,6 +436,16 @@ struct mm_struct {
 		 */
 		atomic_t mm_count;
 
+		/**
+		 * @has_pinned: Whether this mm has pinned any pages.  This can
+		 * be either replaced in the future by @pinned_vm when it
+		 * becomes stable, or grow into a counter on its own. We're
+		 * aggresive on this bit now - even if the pinned pages were
+		 * unpinned later on, we'll still keep this bit set for the
+		 * lifecycle of this mm just for simplicity.
+		 */
+		atomic_t has_pinned;
+
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 49677d668de4..e65d8192d080 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1011,6 +1011,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
+	atomic_set(&mm->has_pinned, 0);
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..238667445337 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1255,6 +1255,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
+	if (flags & FOLL_PIN)
+		atomic_set(&current->mm->has_pinned, 1);
+
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
 	 * is to set FOLL_GET if the caller wants pages[] filled in (but has
@@ -2660,6 +2663,9 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
+	if (gup_flags & FOLL_PIN)
+		atomic_set(&current->mm->has_pinned, 1);
+
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
 
-- 
2.26.2

