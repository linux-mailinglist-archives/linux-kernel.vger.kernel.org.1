Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB52F81C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbhAORL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733304AbhAORLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbapPq1ojGk8GME+3Q5hIrqVuXOJyakklI0BdH5xjl0=;
        b=RPvO9DAHzNPX9jbxZh82wlZbpKC/kbAayXirvdDPyWlo4K33UgBGAAmrrNF76W8PcCmAar
        wTKRF3tyks7iCJTwpcgAH+bgVjI+MUrc15c50kCVtHE46PHSLW3W/BMmm156EZmz8UjHZL
        ZwyZCf0L7L+jfE7u/x044np4WnoxQoc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-DaPw4eWDOFqjZaGWKxnRyQ-1; Fri, 15 Jan 2021 12:09:56 -0500
X-MC-Unique: DaPw4eWDOFqjZaGWKxnRyQ-1
Received: by mail-qt1-f200.google.com with SMTP id l7so7871259qth.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbapPq1ojGk8GME+3Q5hIrqVuXOJyakklI0BdH5xjl0=;
        b=MuCNp9cuVqc3u+tIHVwEW5yDKZUdfZhnmt1Rp6SBGr3uot24NDSar++BEcHKZNNyPP
         0s38VVmXaUvybihnLRV2R5al25Z+DxOSOZTFBnDuDn4LVAZ1yUT1OLTjP7WSGnJE4UQ9
         2/shia53Kgx7u0OPoIX76eWaEDSm4YYj8GpzZU+1X7jsNrjpQkvd3fpnk6JZ3nd34qRt
         9QPONCiCoeWi8RZm7JF69AxNcw2yiZJaxStVUpzbM1SMw/mmOIJCI3Gn+MroMqmkDdjH
         qTa4Sg6jVNssTkujJqPXd0WGn7TWFvrTxuNW5A3IbW8idLMKjB5noKrMa+4QxGOFxaRE
         0XQg==
X-Gm-Message-State: AOAM532EnaGUe8K1pnoOaoMlBSCRzwJp6D1GlP84U4JhzsvjQULeOXkB
        WO8o6tSDcVYV3LKrN1R6LO+7cDnOBaTkIlpz4zZ2Fs73g92vYNXhPUhN/fDWBNRG84+fclB13D7
        mo8/rO1Yf4EF/wfOXzTtqSCocTUwIDaDsYYNJNnxd41rzzvWYjSY8pmasznhy8BCUAfSYFP9wHA
        ==
X-Received: by 2002:a37:d13:: with SMTP id 19mr13531605qkn.93.1610730595287;
        Fri, 15 Jan 2021 09:09:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykF/E1p80aUABfZGvXlMxL3xP2NWVwmUQdTiVuy3IF0dNtbXolMRMz6g1eiLbW1PrGID+lQw==
X-Received: by 2002:a37:d13:: with SMTP id 19mr13531559qkn.93.1610730594964;
        Fri, 15 Jan 2021 09:09:54 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:54 -0800 (PST)
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
Subject: [PATCH RFC 23/30] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Fri, 15 Jan 2021 12:09:00 -0500
Message-Id: <20210115170907.24498-24-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let hugetlbfs be prepared to also recognize swap special ptes just
like uffd-wp special swap ptes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd2acb8b3f0f..16a07f41880e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -82,6 +82,25 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
+/*
+ * These are sister versions of is_swap_pte() and pte_has_swap_entry().  We
+ * need standalone ones because huge_pte_none() is handled differently from
+ * pte_none().  For more information, please refer to comments above
+ * is_swap_pte() and pte_has_swap_entry().
+ *
+ * Here we directly reuse the pte level of swap special ptes, for example, the
+ * pte_swp_uffd_wp_special().  It just stands for a huge page rather than a
+ * small page for hugetlbfs pages.
+ */
+static inline bool is_huge_swap_pte(pte_t pte)
+{
+	return !huge_pte_none(pte) && !pte_present(pte);
+}
+static inline bool huge_pte_has_swap_entry(pte_t pte)
+{
+	return is_huge_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
 	bool free = (spool->count == 0) && (spool->used_hpages == 0);
@@ -3710,7 +3729,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -3723,7 +3742,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.26.2

