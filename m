Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB582F81B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbhAORKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732398AbhAORKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCE2jOXT0VlYi8yeqH5i2c+Kk2ht8PluAgOmKW/+jmU=;
        b=NeQ92+TGzmY9tVqJvT2PxjKPOd4QSRc85RfmaqH//nokZncwsq3yp1eInGXATo/EH/9lHB
        EHHttB6RDPy7dc8yOxpbsUwU54u11geQ+v1PkDlL2vpSzALjxSdsqFy05iUTkHVbAuN04i
        QfrW4tn7ButEtovMfSa/eFhbjdSNC3w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-a5-pljsXN029ytFAxZqJkw-1; Fri, 15 Jan 2021 12:09:20 -0500
X-MC-Unique: a5-pljsXN029ytFAxZqJkw-1
Received: by mail-qt1-f200.google.com with SMTP id d26so1369379qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCE2jOXT0VlYi8yeqH5i2c+Kk2ht8PluAgOmKW/+jmU=;
        b=AhIO6uu0mdycZh1DF3XSxjTnpgtCIq0e0YFrfdrriLYxTaNHJR9BXN0a/iXuvi0aLy
         pXxw3dlA4kFs2V50i+LAUGLUcHHgm63kxx/h5IGUBPj9+kYoNsC/jh/1vlhhZ8LGwuC6
         CF49pqDUOg5hMQd32UnZnVXMJ9pjqT6yNZFyr1jv8jh6gKqwGmVNT+B/dKOSNceF/poq
         BUorss5RpPyVXW6s53fM47DSh1xpJVRiqwjtiJW2pKNE+94WkBtE1cu0Lt/syyCOrvd5
         Lo46b3wgBBNxIK9j9AaaXxdWmY+g4Vyxmoyy62FQm9bucrqdqO+etGK5v+7359CtEptp
         fwDg==
X-Gm-Message-State: AOAM530zflbm55szAm5RAK+9Cv0cqmBbotxpRTojS51tC6t+l/nJMoL3
        yCQuhMTpZkQkaTOUoVCZQzliZF8IA8Wu9Ivl1oq25CesmjpcKtOFRQP4OauRDEO8BXP1v6U9GfE
        ZECyWn272hmNRgArVEbFTfAKqhF2Lu3m7P3dxq+YGEGM/lNzQF2V3ngHbCIHT1YwpGt4mU/Ur9w
        ==
X-Received: by 2002:a0c:b21e:: with SMTP id x30mr13021659qvd.21.1610730559204;
        Fri, 15 Jan 2021 09:09:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySkGiY3Z/8br+xmbJLSbFkxSFlEGX46L/q0MAxVvLzmhfZ9gxy0ZD2X+oBqYSHUsZRO+Ix2w==
X-Received: by 2002:a0c:b21e:: with SMTP id x30mr13021616qvd.21.1610730558892;
        Fri, 15 Jan 2021 09:09:18 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:18 -0800 (PST)
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
Subject: [PATCH RFC 05/30] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Fri, 15 Jan 2021 12:08:42 -0500
Message-Id: <20210115170907.24498-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
will not be valid any more.  We should clear it.

It was safe only because no one is accessing vmf->pte after pte_unmap_same()
returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
where vmf->pte will in most cases be overwritten very soon.

pte_unmap_same() will be used in other places in follow up patches, so that
vmf->pte will not always be re-written.  This patch enables us to call
functions like finish_fault() because that'll conditionally unmap the pte by
checking vmf->pte first.  Or, alloc_set_pte() will make sure to allocate a new
pte even after calling pte_unmap_same().

Since we'll need to modify vmf->pte, directly pass in vmf into pte_unmap_same()
and then we can also avoid the long parameter list.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d6d2873368e1..5ab3106cdd35 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2559,19 +2559,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
  * proceeding (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page can safely check later on).
  */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-				pte_t *page_table, pte_t orig_pte)
+static inline int pte_unmap_same(struct vm_fault *vmf)
 {
 	int same = 1;
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(mm, pmd);
+		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
+		same = pte_same(*vmf->pte, vmf->orig_pte);
 		spin_unlock(ptl);
 	}
 #endif
-	pte_unmap(page_table);
+	pte_unmap(vmf->pte);
+	/* After unmap of pte, the pointer is invalid now - clear it. */
+	vmf->pte = NULL;
 	return same;
 }
 
@@ -3251,7 +3252,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.26.2

