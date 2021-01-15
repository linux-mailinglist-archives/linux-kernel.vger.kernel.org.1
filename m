Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E392F81C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbhAORLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbhAORLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOQ6aKF6Uf/Sgh+ZG/y5WuLjCjtq30JXrndJQraRJDw=;
        b=dLaoSuP9Pnoc2nH+xg+b2VYQH4G261z6e92Iolue+LMb6/9p5amAukxDINMpWNo8zfWf28
        waVPNpzAuHFNtVvPw9haV+umHj49gX+qp1X46lp9+R91I2jmp1/sGatMz7sDZCccVg/5BD
        hkRHfcVAE0G8oixgLm+r9ftjn1QuJlg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-DuJePzCPORixH4-nlAhUvg-1; Fri, 15 Jan 2021 12:09:57 -0500
X-MC-Unique: DuJePzCPORixH4-nlAhUvg-1
Received: by mail-qk1-f197.google.com with SMTP id p185so8625154qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOQ6aKF6Uf/Sgh+ZG/y5WuLjCjtq30JXrndJQraRJDw=;
        b=XWYeXuzJuJypWaCx4sQRdTUnIrD28/pNhRkaWeLOLLyD33qoxu8meuyO5B2pPqJhkV
         a2tzhfbzDyeJUiV+fkB3rCR7CgblF7a74jEDLTBf5VzueUgI9JDmlvI68arzv9Pe41oF
         sFElvqNSYnlIdTrpLUJND11X0tuKKCyYK1n22BEnz/Pzzc3C69w9Rlfrsj9ApNLumnDf
         6qLoJShBELhZLgDoAbF0sWfla3KxgIeOvIurY95vlHwepCU1332OWFCc2dF12wP9PxW2
         GXu2Vr2nnOj4hhjlvzbkXQvkt2/7MgSThDVXytLQGlZjTibZDPBBUp0uTpjQrtdPC0hr
         XFvw==
X-Gm-Message-State: AOAM531b+S903ARFVKpOquALgEve9Pa9EYV6fKVQJEm5C4p8Yi+Qv+vS
        c8weHJQsSsHN7cx7eyBM2LbEompilxhnwWDyFJoHsT1NqI8EzJxxYTvxPPS/oJaf4pJd1IxE+70
        s3j5LjE22gr3FeAbkSw0PjCjqjJtUnEphfelSVX75c3WoOlMnSKOGsGcHqs8GSV/l2T8qZgWn6w
        ==
X-Received: by 2002:ac8:38f6:: with SMTP id g51mr12588374qtc.79.1610730597007;
        Fri, 15 Jan 2021 09:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgQut9yjXxi5Zbbwd9SLAQdXiEzbcIQIXaZFaxeESmgqxEn0NosiOIzyybd2fS/MF9pEL6CQ==
X-Received: by 2002:ac8:38f6:: with SMTP id g51mr12588327qtc.79.1610730596666;
        Fri, 15 Jan 2021 09:09:56 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:56 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 24/30] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
Date:   Fri, 15 Jan 2021 12:09:01 -0500
Message-Id: <20210115170907.24498-25-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for it to be called outside of mm/hugetlb.c.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 27ada597a8e6..8841d118f45b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -963,4 +963,12 @@ static inline bool want_pmd_share(struct vm_area_struct *vma)
 #endif
 }
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16a07f41880e..a971513cdff6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4948,14 +4948,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
-- 
2.26.2

