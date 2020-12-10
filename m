Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76F2D5291
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgLJEG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbgLJD6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:58:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F63C061282
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 19:57:54 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so2800345pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XGFv2MFzigC1jXEGuh+0xsxrvpr1DgA3wrXZ9QAYoM=;
        b=UM06XiPJqXnNYlPIjuwiT0W1AlWph80UIuK+UAPTeaaBD6XgIYHFSlzuWNT515fqmr
         k9xRiE585WZptnPdyF/efcDBc5v26PvTmi7zF6JEPLA7KZDEi5fUX8V1PAsJt2cwG4QN
         xDqkJEdc49ZcSV5xsP50XZF9cBNLJXJAuD0Oqp/yvOd/rD3/dWb2EeC76jEsV0/dD+rU
         io2TGZx+zIPTjnSZCGRC9Hn/Zd2e+M/nauB6/VdrvwG2R0nMFjXWLfuijL6REIXYS8vg
         lgWfZw4n3fgyKfwTNsGhlrIBMhTYuEMIMgfytqfzyYHF/Ffq4ImSVxTENbIQpYnzaK0X
         Y17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XGFv2MFzigC1jXEGuh+0xsxrvpr1DgA3wrXZ9QAYoM=;
        b=PfR/c2bkPbWvuQFd0DxbJZwanZVuB7Snm41+6VN3VpKxi7fY7J0QoesezJp1E4yuYf
         jtO43Ages9xtrd6r4LrV85ROnlWbPupFAafViflIIUWegsH6UkJZVAybEphYbkNkmwFQ
         W80JC0F68EZfwhCFIUFW3KttvXDHCVS9CR+WC4t5AWApvqkDTFob9RpVF1cstjCSB0lx
         CKaowdJHUOglyUqnBDapu3MU65W/pSyo4sF9baBQwdZytev+bgLBRBWyaByuJAiefUDP
         cc5ak+v2IX3yRBFIIrP0HmPtx3gwAXh3komdRv1762WlJRBrUt0/HI7Jk/06GaKSvKwi
         I/AQ==
X-Gm-Message-State: AOAM531iDnUlpnbgHYhm8f5fsOwd96sTaTtZgMLZHFoWy+Nf4yq0HAGt
        J4yd0HOTAMWmFM+8dcV6l1Ci+Q==
X-Google-Smtp-Source: ABdhPJxwKlxOJeNA9Om/OdTPt9auWCJxB8SXy1Uy9JpRxNcf+KV7zoDGblL5f34prJm4UPuvAUEw9Q==
X-Received: by 2002:a63:e207:: with SMTP id q7mr4799499pgh.377.1607572674495;
        Wed, 09 Dec 2020 19:57:54 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:57:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 03/12] mm/bootmem_info: Introduce free_bootmem_page helper
Date:   Thu, 10 Dec 2020 11:55:17 +0800
Message-Id: <20201210035526.38938-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any memory allocated via the memblock allocator and not via the buddy
will be makred reserved already in the memmap. For those pages, we can
call free_bootmem_page() to free it to buddy allocator.

Becasue we wan to free some vmemmap pages of the HugeTLB to the buddy
allocator, we can use this helper to do that in the later patchs.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..20a8b0df0c39 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,24 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
 void get_page_bootmem(unsigned long info, struct page *page,
 		      unsigned long type);
 void put_page_bootmem(struct page *page);
+
+/*
+ * Any memory allocated via the memblock allocator and not via the
+ * buddy will be makred reserved already in the memmap. For those
+ * pages, we can call this function to free it to buddy allocator.
+ */
+static inline void free_bootmem_page(struct page *page)
+{
+	unsigned long magic = (unsigned long)page->freelist;
+
+	/* bootmem page has reserved flag in the reserve_bootmem_region */
+	VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
+
+	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
+		put_page_bootmem(page);
+	else
+		WARN_ON(1);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.11.0

