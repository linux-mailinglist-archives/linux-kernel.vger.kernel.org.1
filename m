Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D692D2127
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgLHCvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbgLHCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzE0WQTA1Dwd5PkGUcDTN27r/6OT+CPdQW7/EJE5vos=;
        b=hJp0mHZ82f27Z6nMsgAasbtwNjE1tdKHASfMnSZ7VK7MrrH55OEShoWkaDdY2bku5EeBEh
        93VoNEgDIwnvJa/VdBiVg559RXFgMaDcaHKRCT0OTsQDfmQAdaA6CHuU6vjV/TxullK0Ve
        au8aO5WsSAwOyNz/R9tVHQs7haQ86xc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2yOwJVKoNA2Cmn-HdYmwVQ-1; Mon, 07 Dec 2020 21:50:26 -0500
X-MC-Unique: 2yOwJVKoNA2Cmn-HdYmwVQ-1
Received: by mail-qt1-f199.google.com with SMTP id f17so5563631qtl.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzE0WQTA1Dwd5PkGUcDTN27r/6OT+CPdQW7/EJE5vos=;
        b=irCJD0+J0FBVcyZF6/8GSKgVeo8A3E3j/IVn1dko1/SYfZCCmCsy5R7a8IIfnpM6oC
         FNFcSAsyfNXX0VbnK4Bf7KKsUJYLv8pUAPQd4Cmg3sUdVj0jOMRAD4ItYPDspKlLAVQT
         Z5nXSfU6KcabnsdrFLFbzKQ5AUVA1LlhRZX537ShFdMSQdq5vGjMeCvmzAY+65tJ5pNR
         InN9YPp8tN9DmFX0lbwAkqANc6dkYuJJZxsqrSWkbNY8eVlDYKQaBy9CJ630Ym48zT5L
         ZF86/0uzIiA37LXGMbI9EiLg6c+ZqDzi6ldtcsi8VlfGuqNUTV80pYJP3QnXXV0yTQ2t
         l8Tg==
X-Gm-Message-State: AOAM530l3+5HgY9xfTJ5a9HxDSs1S7OvUR6fqvDLiRqzi1zKHOBuDVaM
        0P7th0VL7jwPibt+6p30hYzsW/dYjxyfverZvj/zI/M1EOCUNw02rSa9cC+xUJChR+PL1D3x376
        en5/qhFOnvFZhIwttbBEE9c2XUZLD1Sn1Ye9zgrBwx3/02GzyNBsFbJBzzr4I2frayWctxuY/Cg
        ==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr27449742qkg.56.1607395826073;
        Mon, 07 Dec 2020 18:50:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/BqcivJZFIop18PT06X3Iy/glDGRBOA2o1sTDQkDzVRUfyfyhCPefW8cuvWaFM1lo8SkbhA==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr27449718qkg.56.1607395825822;
        Mon, 07 Dec 2020 18:50:25 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id a28sm2632766qtm.80.2020.12.07.18.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:50:25 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] mm: Drop first_index/last_index in zap_details
Date:   Mon,  7 Dec 2020 21:50:20 -0500
Message-Id: <20201208025022.8234-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208025022.8234-1-peterx@redhat.com>
References: <20201208025022.8234-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first_index/last_index parameters in zap_details are actually only used in
unmap_mapping_range_tree().  At the meantime, this function is only called by
unmap_mapping_pages() once.  Instead of passing these two variables through the
whole stack of page zapping code, remove them from zap_details and let them
simply be parameters of unmap_mapping_range_tree(), which is inlined.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b799a0522c..5d977e484095 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,6 @@ extern void user_shm_unlock(size_t, struct user_struct *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index eeae590e526a..70d57c39380d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3136,20 +3136,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
 }
 
 static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
+					    pgoff_t first_index,
+					    pgoff_t last_index,
 					    struct zap_details *details)
 {
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, zba, zea;
 
-	vma_interval_tree_foreach(vma, root,
-			details->first_index, details->last_index) {
-
+	vma_interval_tree_foreach(vma, root, first_index, last_index) {
 		vba = vma->vm_pgoff;
 		vea = vba + vma_pages(vma) - 1;
-		zba = details->first_index;
+		zba = first_index;
 		if (zba < vba)
 			zba = vba;
-		zea = details->last_index;
+		zea = last_index;
 		if (zea > vea)
 			zea = vea;
 
@@ -3175,17 +3175,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
+	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = { };
 
 	details.check_mapping = even_cows ? NULL : mapping;
-	details.first_index = start;
-	details.last_index = start + nr - 1;
-	if (details.last_index < details.first_index)
-		details.last_index = ULONG_MAX;
+	if (last_index < first_index)
+		last_index = ULONG_MAX;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
-		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
+					 last_index, &details);
 	i_mmap_unlock_write(mapping);
 }
 
-- 
2.26.2

