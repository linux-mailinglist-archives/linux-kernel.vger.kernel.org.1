Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB32F9372
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbhAQPS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbhAQPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:17:00 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25535C0613ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:16:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x12so7216451plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hon7HPngFu4HxwS2zmocIDkYMNnjiKlEfAxske+w4FE=;
        b=o9w3kmdeB44NHPerSaJK3r4nOoxS+ilbYyOlCgiDtSEBLu1iCybMnEh6N0HB01ouGy
         ujK2jPwc+Bu5nlXkTUwdM/9MVD76B4p1sh37oDxRIG6JNF3F8jUnxIBe5/yM930czL2R
         6EQihcgC5IdA69gVJdaPHhNIXRxM2wG2t3m12fuqheISvcFpxG4rrmjdHo0y7q9+9+Or
         1XPm1uRdWMz6Tdple82oGQK2bYLDVnatibZtQx+djfiYOjhYURytEzion44njw7Js95e
         Z6CIvMNiJosKbmBjc6VlH1DIwFfYvApHQvsw2dtboWlcN9VoiPm6gleV0SIqRKFCpgQd
         zDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hon7HPngFu4HxwS2zmocIDkYMNnjiKlEfAxske+w4FE=;
        b=ttjeP4XXepoWb4X9Y8TWLQNYpo9EyNeLo5xM0KtYj7/YBH48ys30YyrFYviXfD+fak
         1aorOuaXcKLsUXG+1ZWZKGkOXME/D84QD7ZVbq6Bn1pZq+qpYeNsmX3Wy/6/jCjPxmF+
         +JxODhYNIY2fdQ6dA5722YIiCHbI9Df2kgh2j4ipiqbsSgWoxhaN/9lBsC5ioNJmT4hB
         mMtkBtud7R1RM1LmSi7dB7YHT0KMsksMH7rOMu/laY1u9E2xJikJ7KfJOVDgGDPX+uCo
         lJPf7fo3NpTtvaE5v3Aw7fUvqT8zzn33ldfKFTpgQneTAHSTVzNVwg2lySDIG9J6SCGd
         gVZQ==
X-Gm-Message-State: AOAM5339Tru0E7iyeWKeLcdUcudxsOa2US6KZ6yDZUIVihypF3mZndr1
        5jSAv4i/3fkW4mAdSCIBZ9TRGw==
X-Google-Smtp-Source: ABdhPJyMujlTajhbDBzy36AvKbjYP8NL6BMKYb+gJOmBwUZHEJq3x9AY9vNFVVF5MFrYR3Imq/emHg==
X-Received: by 2002:a17:90a:c82:: with SMTP id v2mr21354379pja.171.1610896579767;
        Sun, 17 Jan 2021 07:16:19 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.15.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:16:19 -0800 (PST)
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
Subject: [PATCH v13 12/12] mm: hugetlb: optimize the code with the help of the compiler
Date:   Sun, 17 Jan 2021 23:10:53 +0800
Message-Id: <20210117151053.24600-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
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
index 05fd2db09b78..b685bc4d79d5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -792,7 +792,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6b8f7bb2273e..5ea12c7507a6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -250,6 +250,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
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

