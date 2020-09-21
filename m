Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75E52734B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgIUVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbgIUVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600723071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpHRYhcxU0Jm84kdlicXVMnaAbcYEgTsJ/Su9ANodSU=;
        b=eM04IRL5Dro5oziOT7+PY7Chscv7vWnhBWvHSJHVOuLGYcKSzfAPDJP/R+rCGT6mnZ+eCV
        CWrAi9X5+n8zHxOD+1wmzAxVJ51GBIPSyQTZ6kWqE6ChjaUi9kw8EzDm9At2oIQslUxAn2
        8POfDLw+f88zweep8ccOMlj2TDH/ngk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-yUMke5lsP1G5DJv_hs7C0w-1; Mon, 21 Sep 2020 17:17:50 -0400
X-MC-Unique: yUMke5lsP1G5DJv_hs7C0w-1
Received: by mail-qk1-f200.google.com with SMTP id a2so12004215qkg.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpHRYhcxU0Jm84kdlicXVMnaAbcYEgTsJ/Su9ANodSU=;
        b=d5aK4okryMU6Li+KKUnEeXG2O0k9CKWeShOWBM5mnRfN6sXfD42jMBJwmXU8ua6Wus
         mMcX1B3+Qa7zZxx/x74+Sp0RkAyNYpDvVdMmIqxalPaI7Nnp49IZYSSB12phfNnHsre4
         LVKpNaPP0X1i5BAxMhOb5qEM6QPuvmrAA5CDl3nAgqVzcx9peBR4Oxxb29QBpbM8p4pi
         anfGaFSucQQmrRGrneQ/G/p8p88WDu8J/y2+/ffKkXRRmlN5G1akbu/cw0sp3oAT0sbS
         Qz0y03iB++HFpfG8pfSCm97HqgIfGp5S1/E4JjJL25p+oriTlYeitVzdcvWQz8vZkpL0
         GyvA==
X-Gm-Message-State: AOAM531Mhjyvy7H3Mo8u/Z9mJY4r6/aKKrLUM/Qe0cmr9ipCzE6lVIvm
        faz886F5gN2Uyf2bow5F6RMWXCBPeW9PHVtH41y6Q0K4JHCZMXNh+++cmCqiBejYV3hSDC5hxa1
        b4y43bh4P7xMvhOrgTpPMG0CF
X-Received: by 2002:aed:2767:: with SMTP id n94mr1564509qtd.237.1600723069544;
        Mon, 21 Sep 2020 14:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAG8txO9WFH1rMkSLxGPM+sc0589D4XINUeX9PKEy7c+VL4Izqm5WI4T67amcxlFTx2ENd2g==
X-Received: by 2002:aed:2767:: with SMTP id n94mr1564475qtd.237.1600723069285;
        Mon, 21 Sep 2020 14:17:49 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h68sm10225108qkf.30.2020.09.21.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:17:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Date:   Mon, 21 Sep 2020 17:17:40 -0400
Message-Id: <20200921211744.24758-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921211744.24758-1-peterx@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Commit message collected from Jason Gunthorpe)

Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
track if the mm_struct has ever been used with pin_user_pages(). mm_structs
that have never been passed to pin_user_pages() cannot have a positive
page_maybe_dma_pinned() by definition. This allows cases that might drive up
the page ref_count to avoid any penalty from handling dma_pinned pages.

Due to complexities with unpining this trivial version is a permanent sticky
bit, future work will be needed to make this a counter.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 10 ++++++++++
 kernel/fork.c            |  1 +
 mm/gup.c                 |  6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..6f291f8b74c6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -441,6 +441,16 @@ struct mm_struct {
 #endif
 		int map_count;			/* number of VMAs */
 
+		/**
+		 * @has_pinned: Whether this mm has pinned any pages.  This can
+		 * be either replaced in the future by @pinned_vm when it
+		 * becomes stable, or grow into a counter on its own. We're
+		 * aggresive on this bit now - even if the pinned pages were
+		 * unpinned later on, we'll still keep this bit set for the
+		 * lifecycle of this mm just for simplicity.
+		 */
+		int has_pinned;
+
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
 					     */
diff --git a/kernel/fork.c b/kernel/fork.c
index 49677d668de4..7237d418e7b5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1011,6 +1011,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
+	mm->has_pinned = 0;
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..2d9019bf1773 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1255,6 +1255,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
+	if (flags & FOLL_PIN)
+		WRITE_ONCE(mm->has_pinned, 1);
+
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
 	 * is to set FOLL_GET if the caller wants pages[] filled in (but has
@@ -2660,6 +2663,9 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
+	if (gup_flags & FOLL_PIN)
+		WRITE_ONCE(current->mm->has_pinned, 1);
+
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
 
-- 
2.26.2

