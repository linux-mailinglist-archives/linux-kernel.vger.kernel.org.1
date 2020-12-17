Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3062DD15D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgLQMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgLQMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:18:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB8C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 04:17:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c22so4766002pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLKc/ylYHo2GjStF5CCHYeuxj4GTbCnD5ZdkK0cu8t0=;
        b=tU0IqBKmVMhKyj8NikbXTGBgiH4IX66VEr+KuEmc56agJmFGIoS8nRvEgWiFkEl+e9
         YBV1WexgvQzmd4fe5vXEwSmCKv9BTBhzFhOvrjzuTGPMvlJyChkbB3dyCUR6Hvw04dI2
         P8su279ZRwIpSIDybEf+3GhBGemvcfwgfcpArJHAKGhSV6rPG/VCddE2bOsbDS1f5hXq
         wJjLzhqMWpecu2tjJsgWxMwaxRVxMm422EcTHtDm+TWtmB5viZkTY1Mbup0C8/8oefLl
         3cGBiBBMjF1MLZI0m6WkVkkiemo/iv1tBvaBleCfjBxXNTRasnRiRjumo7mVdMrMp9vQ
         vOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLKc/ylYHo2GjStF5CCHYeuxj4GTbCnD5ZdkK0cu8t0=;
        b=MRh7XQRwIfMiiTsdjzMmXvbPhEhuCUPbxc4md8v+qlLv9actTU0dj72xhHXsj9v5Tn
         FqtrJcowNBPqHxlm/8JMMW5SxZUdz8Su5CInfl2m8/MDa9+aQJHoF0XX6SgtGhF0EDt8
         tqq+V/PFk8NsRG9fYHxzx3Lm/ToW6uw/B5nrRGAxdXIxr+EzXzNOp33P9zRBRNunbAYd
         OHNsmiklanwTB8Ipp/5y+uCAExda3mrY3TZ4n6AM4gQ6MqrkzvdAEzX95QIbVEVYWLhT
         G7ExfHOqXPJiLMMQDMBgLbIRSlDPdvwBkoW7FAp52RLdzy98HdkAPQfI9fJR2cIl+Bdh
         zFLQ==
X-Gm-Message-State: AOAM5327nkuchZgZOa31daEcYAES8iyQwslf72wvbdE7i8TqDwA9famt
        rHTntD3+MM+u9HqPBh76tZuYcw==
X-Google-Smtp-Source: ABdhPJwNWAF94v1/MjPZmdhFmgA8vL4MblAFVKgbyIhGzQw5FgVtgMkV10xLyk+9ehHM6GKpzQ0SgQ==
X-Received: by 2002:a62:ae0c:0:b029:1a5:819d:9ac5 with SMTP id q12-20020a62ae0c0000b02901a5819d9ac5mr18177290pff.26.1608207465486;
        Thu, 17 Dec 2020 04:17:45 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n15sm2775691pgl.31.2020.12.17.04.17.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 04:17:44 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 11/11] mm/hugetlb: Optimize the code with the help of the compiler
Date:   Thu, 17 Dec 2020 20:13:03 +0800
Message-Id: <20201217121303.13386-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot optimize if a "struct page" crosses page boundaries. If
it is true, we can optimize the code with the help of a compiler.
When free_vmemmap_pages_per_hpage() returns zero, most functions are
optimized by the compiler.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 3 ++-
 mm/hugetlb_vmemmap.c    | 7 +++++++
 mm/hugetlb_vmemmap.h    | 5 +++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7295f6b3d55e..adc17765e0e9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -791,7 +791,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ad123b760245..987248a004f0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -242,6 +242,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
+	/*
+	 * The compiler can help us to optimize this function to null
+	 * when the size of the struct page is not power of 2.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return;
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 8fd9ae113dbd..e8de41295d4d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -17,11 +17,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
+ * to the buddy allocator. The checking of the is_power_of_2() aims to let
+ * the compiler help us optimize the code as much as possible.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return h->nr_free_vmemmap_pages;
+	return is_power_of_2(sizeof(struct page)) ? h->nr_free_vmemmap_pages : 0;
 }
 #else
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
-- 
2.11.0

