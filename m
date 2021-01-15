Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF352F81DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbhAORNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbhAORKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55sEsJtJtT3yQ/SJrjmLB0CUvQ5qtdXoD13C+gjkjA8=;
        b=X1J08jdMM68I5HfOcZnmn8TyquRwkVJC5ATw4GQuatjvrASQgdva88g6GMfZxAhHV2WYIo
        Nr3aZqBmbBZ3tHRGXejDNPd2zNREqP23E1BZix1b9PH6gccoya4LjH3lwYvfe89mwVpeKa
        9WcmhtzcuAMmP5qBnjsSIVl1KJnB0M0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-kbgXBqpYNLebeqiZo_LyjA-1; Fri, 15 Jan 2021 12:09:15 -0500
X-MC-Unique: kbgXBqpYNLebeqiZo_LyjA-1
Received: by mail-qt1-f199.google.com with SMTP id l7so7869675qth.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55sEsJtJtT3yQ/SJrjmLB0CUvQ5qtdXoD13C+gjkjA8=;
        b=qEdbON5MFQv327TCXOUEH8n9PUg4jz/mC5S/9KlA+SpWKn3jXI7uOcENSWdWU4XExt
         wK9JreONqWfs2IhfxB13zwe1znNJ70a8z4a7q/C8p9sd8frxYU9vbzZXLAxO6T4lN4SV
         EK8bQ51+fsj64N+w35K/0U9aKOx9Uk2ctbgMeivWvUdtHYqTwtai61K6qy1hlpDl3mOw
         QYub0HXJPc0BhXr6VPIrx7XpKsbOxz5tex88iasHQkDO74O81IVroJOKU7gCQmqkK/7m
         A0+NfOgdHaRdU4ljrolPWWd5W2LavUX01boVwCNAjNKMSe9AUeciYVEN4jTEE94LT7zF
         1+QA==
X-Gm-Message-State: AOAM533XH0hv99BYQfSxYIsur4RVfQf53RcpHLC2vClUn91/h/FCjicN
        3xPpWj5P54Ewu4io04YtM/lxTbHnDEC6HIJvNMIlC2+S4yX6cwb5g40zA/DWYwV/IcVFeNB0f7y
        IfFZMB+RHfEctq1qtXh4sNQ7KYnB3ZIFpJY+bV5+295/Pt69N0qkdb8o+JcGZcyJCb1Dk0BUduA
        ==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr12895246qvb.27.1610730554929;
        Fri, 15 Jan 2021 09:09:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzN6JI/2g7RCjZr0SNpUqJFGmSSLlynIlwy16/M1XzDDRvPyo6B1EX1O0uPYvY1K6cPK0Z7tA==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr12895212qvb.27.1610730554659;
        Fri, 15 Jan 2021 09:09:14 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:14 -0800 (PST)
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
Subject: [PATCH RFC 03/30] mm/userfaultfd: Fix a few thp pmd missing uffd-wp bit
Date:   Fri, 15 Jan 2021 12:08:40 -0500
Message-Id: <20210115170907.24498-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These include:

  1. When remove migration pmd entry, should keep the uffd-wp bit from swap
     pte.  Note that we need to do this after setting write bit just in case we
     need to remove it.

  2. When change huge pmd and convert write -> read migration entry, persist
     the same uffd-wp bit.

  3. When convert pmd to swap entry, should drop the uffd-wp bit always.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 2 ++
 mm/huge_memory.c        | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d9b7c9132c2f..7dd57303bb0c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -258,6 +258,8 @@ static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
 
 	if (pmd_swp_soft_dirty(pmd))
 		pmd = pmd_swp_clear_soft_dirty(pmd);
+	if (pmd_swp_uffd_wp(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
 	arch_entry = __pmd_to_swp_entry(pmd);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 35d4acac6874..4abc46e780a0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1810,6 +1810,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			newpmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*pmd))
 				newpmd = pmd_swp_mksoft_dirty(newpmd);
+			if (pmd_swp_uffd_wp(*pmd))
+				newpmd = pmd_swp_mkuffd_wp(newpmd);
 			set_pmd_at(mm, addr, pmd, newpmd);
 		}
 		goto unlock;
@@ -2968,6 +2970,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_write_migration_entry(entry))
 		pmde = maybe_pmd_mkwrite(pmde, vma);
+	if (pmd_swp_uffd_wp(*pvmw->pmd))
+		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
-- 
2.26.2

