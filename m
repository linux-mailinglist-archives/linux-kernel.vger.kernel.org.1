Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504112F81C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbhAORLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733179AbhAORLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvgubUamx9bzZRkUGwNzgfOj+y21NKvpsf3CqKI90Qc=;
        b=RNE4hbkWVHlbkriKXu7UED7K8SFHO13jbmx3Iify+410q3CnGabYSlKh6n9uIgRG70Z6yr
        Ll1QkhvD2tQVJ3+wew1DL8FRZkzlAsoytQudPaNwnvOZrJDIqQA2Imc4ECq3w/lLX9hBFl
        SIsYpwLGreIzvSaYfUavX+Lm5yZjPaw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-B8ElwNVOOHq5pWQKVciMuQ-1; Fri, 15 Jan 2021 12:09:40 -0500
X-MC-Unique: B8ElwNVOOHq5pWQKVciMuQ-1
Received: by mail-qv1-f70.google.com with SMTP id h1so8238667qvr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvgubUamx9bzZRkUGwNzgfOj+y21NKvpsf3CqKI90Qc=;
        b=rCkcdBam5bAH67wwrHJ071fVobim4BVqiCqoWH4Q/mjfCl4eZV5NLs/6pSEfrKA4NF
         W93jmxwpz2M0nXEZjIdKTxl4FxNwEghHExeJI1Je9baC3plPazAI5ioViROTG3bs5Ngl
         urbu5zhS3bYJgEQMo9nA6mxI0DFQwnYzE5TvGd8PHbt9JIaqBgLjXC9mZNmkFKR3QUPF
         uurUugkSGgTdhXmnzQHdNOIvXjHVnXcnr9JWks1ea5yLm4T/Fcdh5w9tMW3z8EiloHH7
         k00j3ysoJzjXIgBsqXo0KnCKqX2dfu3NbipvJaY0dmjrsocCtO3VtxoFdFss5u7Rlh5C
         pCow==
X-Gm-Message-State: AOAM533Gos/k1+Wtf4jc7s28OFR2Rm98qGoWA0fiUzTS6oI3TeXDhL4f
        WPqzL/4iQmqW5x6ktyhXVdCoBBwxXIVjYQx9+2Eng618fTa2nVkYCWM9xMDEfmNB/2JXcr1i0+R
        /bvlZG7b9A5GkbBkmNmp54hYRwR8ID2YfA9azRsUxvvWQBwNTQeMquSMUwXnikqPQmYbslNbPTQ
        ==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr13905370qke.348.1610730579848;
        Fri, 15 Jan 2021 09:09:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypFNWmfzxwqGMAMXQdAVCpNR1NUiGkMMax+RIf/niA0GkwrkuRQrPyK91eLGDjgdLHnbwTGA==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr13905333qke.348.1610730579535;
        Fri, 15 Jan 2021 09:09:39 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:38 -0800 (PST)
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
Subject: [PATCH RFC 15/30] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Fri, 15 Jan 2021 12:08:52 -0500
Message-Id: <20210115170907.24498-16-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have "huge" version of PTE_SWP_UFFD_WP_SPECIAL, instead when necessary
we split the thp if the huge page is uffd wr-protected previously.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps - rather than doing a real split, the
thp pmd will simply got dropped in __split_huge_pmd_locked().

That is definitely not enough if e.g. when there is a thp covers range [0, 2M)
but we want to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd.

Here we leverage the previously introduced change_protection_prepare() macro so
that we'll populate the pmd with a pgtable page.  Then change_pte_range() will
do all the rest for us, e.g., install the uffd-wp swap special pte marker at
any pte that we'd like to wr-protect, under the protection of pgtable lock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index c9390fd673fe..055871322007 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -296,8 +296,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if (next - addr != HPAGE_PMD_SIZE ||
+			    /* Uffd wr-protecting a file-backed memory range */
+			    unlikely(!vma_is_anonymous(vma) &&
+				     (cp_flags & MM_CP_UFFD_WP))) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * gone; still provide a pte pgtable if needed.
+				 */
+				change_protection_prepare(vma, pmd, addr, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.26.2

