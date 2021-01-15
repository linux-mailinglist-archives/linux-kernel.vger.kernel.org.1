Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B452F81CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbhAORLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733221AbhAORLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBkQRG2pL7J64zZlZOQIc2dhhUBB5j7m8vruAB1Id6o=;
        b=Trm0kIuWJ6zgIp4I0TwYTcAuFeUc5BfNCHMHLZu1OjNgJzKn1Fxeg/qK7x0Vp/PRuPBV2S
        bHrAzrAVNlH/okCXfmbBDMaTDh9s8eSP+DsogZJtmeDzz49D6iz4fifkRfrvVSfGyRLUGw
        V+ZGxGopdSdhvoK2Tgd1jb0wtmFN7QE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-XljvGerZNEyo8Wzj26cZ2g-1; Fri, 15 Jan 2021 12:09:44 -0500
X-MC-Unique: XljvGerZNEyo8Wzj26cZ2g-1
Received: by mail-qk1-f200.google.com with SMTP id 189so8627205qko.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBkQRG2pL7J64zZlZOQIc2dhhUBB5j7m8vruAB1Id6o=;
        b=Ahx3W4NYRJ4hidJn1K9e16nW65N9vjFCXN0Uj55t9rrWQaEsxhhQvY0GnOacWxg2Vr
         q5A/sGE66oH2qg+fgfYndbvmmQiDp6QkAcpvk20IC3DFMFDoCYzyMrOEO4GKur2MheEC
         8p1WiyF1LzuwqGNAX3SFHB4pQPYb+wC4xgxdyXZCMO5h3XRpqWyn1Q/D24htwZ8ayHSW
         hv77vv9j9JpyBFJd3/QyeD/IrXo6JJ+KHWY2p1rwcDus6U2CVF+LTbzSJLzr3brYss5Y
         8JYxuXkmehMNHjmJklL7fndMCHgLXOwVHNbJtRk58Tsr10zjXxxHDuQaoGT7ahgpRDU1
         7q3A==
X-Gm-Message-State: AOAM531gCUEP8BxfAzcldpT59brIUuHAlUfk1b62hna1P/TL4gX0BBBU
        eFvf/fyvuBgO5lky4BjTjKTdPTFmbWn/HPDd+glk/IPpLK4z65QMuJivac4pQJcNI6xu/H2cXK8
        VZy/rzRy5wU3CiSIV+qOcTrbfK3WvtX8egkjhiaSUuQg/BRsP0/kzBD6/YEkWBOsrig7bNw7o5A
        ==
X-Received: by 2002:a05:620a:1264:: with SMTP id b4mr13698550qkl.187.1610730583651;
        Fri, 15 Jan 2021 09:09:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJya4OiwdJGAuCczPlqaSBaKxxbyDX4PGAfQreU5Kr2CdzlXJm35YPbgKxKn0g+KWI8OS78AjA==
X-Received: by 2002:a05:620a:1264:: with SMTP id b4mr13698504qkl.187.1610730583353;
        Fri, 15 Jan 2021 09:09:43 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:42 -0800 (PST)
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
Subject: [PATCH RFC 17/30] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Fri, 15 Jan 2021 12:08:54 -0500
Message-Id: <20210115170907.24498-18-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be handled similarly like other uffd-wp wr-protected ptes: we should
pass it over when the dst_vma has VM_UFFD_WP armed, otherwise drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f87b5a8a098e..59d56f57ba2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -703,8 +703,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	swp_entry_t entry;
+
+	if (unlikely(is_swap_special_pte(pte))) {
+		/*
+		 * uffd-wp special swap pte is the only possibility for now.
+		 * If dst vma is registered with uffd-wp, copy it over.
+		 * Otherwise, ignore this pte as if it's a none pte would work.
+		 */
+		WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+		if (userfaultfd_wp(dst_vma))
+			set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
+	}
 
+	entry = pte_to_swp_entry(pte);
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return entry.val;
-- 
2.26.2

