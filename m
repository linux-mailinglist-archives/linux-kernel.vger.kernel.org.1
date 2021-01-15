Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE22F81C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbhAORLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732139AbhAORLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrCU019uaMiIX4Y0l4Cvu/CTWpK4vi96Wr+NfUKCM+Y=;
        b=TEJKu0CqoKx5Dn7Xor9yRpbT+PjnCOVigKeWH3b2aqkbrziO2XbYBja/TGpH3uaQfr6qBH
        iU9RQSKiSZCJAM80W0yDapajzYb6mfL8rMRgpwOIWrkZxYmf0+nTwqQp4wxwkFRLaaAFxP
        ukcLBYL8CQY0PatDhViOjrCqBbUijgc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-A-80URrvOB2Kkuq1nXaK1Q-1; Fri, 15 Jan 2021 12:10:03 -0500
X-MC-Unique: A-80URrvOB2Kkuq1nXaK1Q-1
Received: by mail-qt1-f200.google.com with SMTP id l7so7871501qth.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrCU019uaMiIX4Y0l4Cvu/CTWpK4vi96Wr+NfUKCM+Y=;
        b=cCuvM4bQbRXDWgkKkUCcTY6/yb2zCTeakiukHsXaJGCroaXiBW3CHPqE+hzs8bf7EW
         f10JuLBx2tukBkv6P7lpPf3P60K+hTiwyP+2f+U0pI7VM53rUPPq6pM4ldYHBmrpZGap
         njsricfze5d+zcn/JfZ5eKpVZwLzoLzzdn4e4e88mJKL+eHgIC/FxaGTysM7vgg0V+zb
         6ksssKGkAZSo4ihb8SYqafMfOiOUGLsVYqkbDgV9MeVfixFNZGkO5BsNhKTxtLaU81EU
         4RCVsiKv+S+ckog21XeM1mC8m+WsslRuuWk6/oQtDhp4rRn6mpSGL6R1rtjiS5kQsEnz
         G0JA==
X-Gm-Message-State: AOAM532IFkTll5W1GKY1sLmh+Rd3L6hzbTpmntYAuTiFO78Tm7yu8TsQ
        2opvL3brSgPBcoyqqvq+8CA1iJsa0tC4fLAItiH7KTKe9sug+Qi2O7q4Hb5AY3hg/F+9jpomQZz
        JFNKfoaHk5ja0cPIk62/jCB6wKlIW90iC2Gv4j4zYxki9hjfurckQNnSamRrxXzU7JQJ2wOvC0g
        ==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr12899078qvb.27.1610730602663;
        Fri, 15 Jan 2021 09:10:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDGxBmzq+M9a/zQLYdo9stwTA7YMDDZpLptv18Gfz7OBlvn0/azI9YdYGAEij/PUHl4Ymv6w==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr12899037qvb.27.1610730602378;
        Fri, 15 Jan 2021 09:10:02 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:10:01 -0800 (PST)
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
Subject: [PATCH RFC 27/30] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Fri, 15 Jan 2021 12:09:04 -0500
Message-Id: <20210115170907.24498-28-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach hugetlbfs code to wr-protect none ptes just in case the page cache
existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
marker pte and remove it for uffd_wp_resolve.

Since at it, introduce a variable "psize" to replace all references to the huge
page size fetcher.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b9f71ec30e1..7959fb4b1633 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4978,7 +4978,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -4998,13 +4998,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += huge_page_size(h)) {
+	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, huge_page_size(h));
+		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+			/*
+			 * When uffd-wp is enabled on the vma, unshare
+			 * shouldn't happen at all.  Warn about it if it
+			 * happened due to some reason.
+			 */
+			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -5028,12 +5034,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, huge_page_size(h));
+						     newpte, psize);
 				pages++;
 			}
 			spin_unlock(ptl);
 			continue;
 		}
+		if (unlikely(is_swap_special_pte(pte))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+			/*
+			 * This is changing a non-present pte into a none pte,
+			 * no need for huge_ptep_modify_prot_start/commit().
+			 */
+			if (uffd_wp_resolve)
+				huge_pte_clear(mm, address, ptep, psize);
+		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
 
@@ -5046,6 +5061,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						pte_swp_mkuffd_wp_special(vma));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.26.2

