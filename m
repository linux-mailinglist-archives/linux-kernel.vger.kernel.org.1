Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6924E403
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHUXuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 19:50:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726737AbgHUXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598053812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0CkcmCYgcP4TRFy3+MaJk8hhxqQa23QkpKUGatylGE=;
        b=DydGPsInDYqspIePWektOp8KxYhRBl9PlA9uTc43vehmRuR2F5HN2uJ/Ll91IjQmrP1NwE
        rxGw9T1uGwwFWjw62jo/k6aw7+Cn4Q10cKxUQ5emTWYbvcHF4zFFi6Ta/pmlrPXhtJ9QvA
        EoPZqC+4zWjPOQX2wUEn+hh1z1qhYn0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-UgnwhL5EPWKGv6hmT2GFMA-1; Fri, 21 Aug 2020 19:50:11 -0400
X-MC-Unique: UgnwhL5EPWKGv6hmT2GFMA-1
Received: by mail-qv1-f71.google.com with SMTP id q4so2308317qvu.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0CkcmCYgcP4TRFy3+MaJk8hhxqQa23QkpKUGatylGE=;
        b=NXkh8ouNm0Gd5nTSFTLiPMZSC5mg+UYfb+GByeLc3Pl4df15ZnT75DRmKExJA7LB2k
         RjN9qZjMzz/t0tBl2G7bZe84VuvSKvr+XZIlKkFstNDKdnHMYXLjFEdq3AsVv8mvGoy1
         6wi6sZk1rohPwGe/GI53qYQBtLSDPcXTq1kQWrKr8GaNFTohQCftm7SjI75tEOzIK+jJ
         hdVR7KQwqEbiBHEssncHKxWzg5SjfUdRRUuHqoHKlPVAHCLKt74w77mwV6YNqJdfef5/
         QpLHR9AgCBu51E9QoDqlOca3Bd8dQtSf/kNX49r8DOzalR9fqxVtkwDz70Zr3QzkR9W0
         D3Tg==
X-Gm-Message-State: AOAM533oni5zlzfVimxX8Cb4C3l0yh+wIhsnEwn57jMYuXW5aOnn+tm+
        J8eGxbDutgBLBHGh3s+KJWwOhWLsGiDh/oXl+KxLrxNit9Q8IicLleEBa1smQMTkQT1qV8fGI+W
        uTynZ/qexXG8Hd7YZTHheYxkV
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr4945275qkn.418.1598053810815;
        Fri, 21 Aug 2020 16:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq8utWn/uGDVs4w1V1vmhZ4RBMhtk+HitMud9u/saO8354xmjH2egHRHqcI3om3OSy7hnB5w==
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr4945253qkn.418.1598053810611;
        Fri, 21 Aug 2020 16:50:10 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t69sm2821600qka.73.2020.08.21.16.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:50:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>, peterx@redhat.com,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] mm: Add PGREUSE counter
Date:   Fri, 21 Aug 2020 19:49:58 -0400
Message-Id: <20200821234958.7896-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accounts for wp_page_reuse() case, where we reused a page for COW.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/memory.c                   | 1 +
 mm/vmstat.c                   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2e6ca53b9bbd..18e75974d4e3 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -30,6 +30,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
 		PGREFILL,
+		PGREUSE,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
 		PGSCAN_KSWAPD,
diff --git a/mm/memory.c b/mm/memory.c
index cb9006189d22..148eafb8cbb1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2622,6 +2622,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	count_vm_event(PGREUSE);
 }
 
 /*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index e670f910cd2f..4f7b4ee6aa12 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1241,6 +1241,7 @@ const char * const vmstat_text[] = {
 	"pglazyfreed",
 
 	"pgrefill",
+	"pgreuse",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
 	"pgscan_kswapd",
-- 
2.26.2

