Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819362D2129
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLHCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbgLHCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3Z2K8nRRfGkaf6Txv+p5jeGljoBTJFR0t93dd3Zx9U=;
        b=Gs6LxJ2QSDCr+xI9/nONJy0WglY4dWPG09VWE85sSNiEQh5I3VsCKcG7nc8/rs+LEMV4d6
        MioP/HH5l9OanjwSRh9y4hoTqKPiaorDqjZVaLyTEm0VW0lqGRzHkj3+EE3Ux0FtpIZ2G/
        aNRjLklv0hPN57H2x2q+1bxv5wFrb3g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-wWiW8vdAPIySeKZ0wJgLyQ-1; Mon, 07 Dec 2020 21:50:29 -0500
X-MC-Unique: wWiW8vdAPIySeKZ0wJgLyQ-1
Received: by mail-qt1-f200.google.com with SMTP id i1so8398443qtw.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3Z2K8nRRfGkaf6Txv+p5jeGljoBTJFR0t93dd3Zx9U=;
        b=fYf3LH3OtoMxpw/X0MfA5HycYLX96VPFn7PNaULDxFNcn/mEX4kld0vIng0JTXpd5C
         om2gHoYF4OmtS7Ye2UwxPRws/unOQRKy6bB6WR/hVKwRXJ3AEGgQmBvFugRdm8+V33xR
         PlPuxiyquKd8swpiGiVR6tqszyPBKKlCqWPNmRH5XMpOerSxPvlwJ/3LgfpW50SkfrxO
         yXfNOqkMmnME/H4S3Wm+YcF/aAARjyIi9sQpobeSOtUqyvr4R8XFl6GbgFoKoiJyN/VV
         upH8i0KhwVC4ZELiDAm/4gWq8dmH+2MqLTgR2Jx9ApEZ54PbwD1e/LvDd4rPuLRVj+OF
         Hx2Q==
X-Gm-Message-State: AOAM5301TTuPIqaLDgcVKZXJm3UnxTayXbUVlLEVO8mxtLBdzJyukCEX
        lAngr3fEdaC387eUEmOjcwvCcLylHVj6rumqIl9zmCT1J90WTW5wLJQToXDdsJt4glrG0CDmNaM
        18tuQHCaNxFutdrLxRyfzzzjyzzWLD6HkLx/T5mZoyRho1NlyMODxtL8Nqwfsdw3dfHg8aLIhkQ
        ==
X-Received: by 2002:a0c:c405:: with SMTP id r5mr16720991qvi.4.1607395828993;
        Mon, 07 Dec 2020 18:50:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHzUEslTZ1FZEWzJNu0W0qlP5gzOXXVxFImV3fi6ypeqsM2vcqg63+0O0dcsbZ71OFP2qwyQ==
X-Received: by 2002:a0c:c405:: with SMTP id r5mr16720969qvi.4.1607395828714;
        Mon, 07 Dec 2020 18:50:28 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id a28sm2632766qtm.80.2020.12.07.18.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:50:28 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Mon,  7 Dec 2020 21:50:22 -0500
Message-Id: <20201208025022.8234-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208025022.8234-1-peterx@redhat.com>
References: <20201208025022.8234-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, it's confusing too on not explaining why passing in the details
pointer would mean to skip all swap entries.  New user of zap_details could
very possibly miss this fact if they don't read deep until zap_pte_range()
because there's no comment at zap_details talking about it at all, so swap
entries could be errornously skipped without being noticed.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which is still the
major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ed4352ec84f..16631ee5eb9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1622,6 +1622,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1644,6 +1646,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
 	return details->zap_mapping != page_rmapping(page);
 }
 
+/* Return true if skip swap entries, false otherwise */
+static inline bool
+zap_skip_swap(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 20a8ba05c334..c9945f3c374d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1262,8 +1262,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3159,7 +3158,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { .zap_mapping = mapping };
+	struct zap_details details = {
+		.zap_mapping = mapping,
+		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+	};
 
 	if (!even_cows)
 		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-- 
2.26.2

