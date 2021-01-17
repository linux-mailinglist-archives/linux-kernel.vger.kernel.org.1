Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5C2F9371
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbhAQPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbhAQPQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:16:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42FC061757
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:15:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x12so7215806plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxK3vZa53yZECwtQk1Adv7wPniSEQYOdf+3yOUQ+iTA=;
        b=VloiUfaBTFBH6av464B48TOSDY83SUQFlqHi/txGmQyrX218GAYQBQhyq0WjV9WSp4
         fAnE0GoAJOib3PeCNzoKWPq0RX17INjsjqCahhWrBMCyu/slW6aszOhLyaFkrXwVkjwN
         oiVZkw65xaqOwZKastwbxIDB6TCMZ2wWI/LK84KCuo+QygmxV7xCc2haNABtnJkp5pEr
         vrktkQV+1+2kbd4CFrxClL5QKM9TmJ9W6Yq+wAwwvtUmmozsBTUFj02M0tLpo2vnNxsB
         ywdk6XJC0SogXpATcViLbUJoauiiicklpf0Rwp5NF2SBI49KaR8RPbxZb1TzxI1+vu7m
         6Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxK3vZa53yZECwtQk1Adv7wPniSEQYOdf+3yOUQ+iTA=;
        b=JNStirEdF8pZ4aYsPuamRFPhd/JSoEe4Q1T9gOFGYlHS+0QYb7+6/3YhpUzPnIXp7/
         7ybGJQGirCjHHiIzQi0FqsQiQFy9EiEDGvQieYyoUTP3JWCr5XnRhkV0vxzVXeFcXS0D
         Bouvjjbwpkc1xsRJtCXk93KONJZS0OXfTF6fc2NLr82vMBXZdeJNZUwC430h4Nm3JVTX
         COeF3mBkMvUjRzgg9U9m4s+72WIDBSMoPEBB0D9z7lrCqQ8S+PB4+f9G/9V5TFKJtDQJ
         SXp73LuwJVH9BFNLVEEuIJluezGMIZZ8Xfd3UXvw6FKZ3OXNZjvWL/RSFRXWAQv5Ll7t
         MHXA==
X-Gm-Message-State: AOAM530IWyX3kSOPxM8ilMZfGa8HQUULm5B+srNcXi7KKoGtTaqWtWPs
        3sHkisDz/9iRuP2uibcjgIVc5g==
X-Google-Smtp-Source: ABdhPJyr7NtH4kJKhAyQwyRjTW71YeutQtiSSXnPvRjRNUKly/sIybKd5/ljO7yMJOxXNGQFIdkrYQ==
X-Received: by 2002:a17:902:b493:b029:dc:3e1d:4dda with SMTP id y19-20020a170902b493b02900dc3e1d4ddamr22133630plr.48.1610896537688;
        Sun, 17 Jan 2021 07:15:37 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.15.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:15:37 -0800 (PST)
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
Subject: [PATCH v13 10/12] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Sun, 17 Jan 2021 23:10:51 +0800
Message-Id: <20210117151053.24600-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
field in the hstate to indicate how many vmemmap pages associated with
a HugeTLB page that can be freed to buddy allocator. And initialize it
in the hugetlb_vmemmap_init(). This patch is actual enablement of the
feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 25 +++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7f47f0eeca3b..66d82ae7b712 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -492,6 +492,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 14549204ddcb..0e14fad63823 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3385,6 +3385,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 8206978d1679..7dcb4aa1e512 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -236,3 +236,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	if (!hugetlb_free_vmemmap_enabled)
+		return;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * allocator, the other pages will map to the first tail page, so they
+	 * can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
+	 * on some architectures (e.g. aarch64). See Documentation/arm64/
+	 * hugetlbpage.rst for more details.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+
+	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index b2c8d2f11d48..8fd9ae113dbd 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,17 +13,15 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return 0;
+	return h->nr_free_vmemmap_pages;
 }
 #else
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
@@ -38,5 +36,9 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
 }
+
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

