Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E345D2B1988
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKMLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgKMLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:46 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EAC061A55
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:04 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so7340702pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=VXie40CJ/fHrNIqDxNTz1GZQ9IUwdONiHU7BNAkIY8B2uU8hpqGGZFFGMkRMjvUHxM
         bnwwM0lkwcuOxrSnvs0tEfBJS8l0MqOb+zmKW2JGLjAgfvn54whcocRtiQNLzGFVF+4D
         Hov8wnJwOFJa0AXkTfmtTsgXBJ1QGaQyNs1QqmydTXHXH/kY4VPmnLIM66LxcvsPPuRb
         auD5GVm6SIHHjS3IdC4oC/JNZznkRbWzWnUqDZfIWxBSYVSNZpsA2HQH7sCsuDtnprw6
         L+21F7cWT+Doj8Kxmr9kKjJ9dPaP6PE7rxydgtjMrWsz6e/cZglYP4WQKQm3JXnOOwbX
         6Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=JRBr3XK2iFoCd/Ke+d5Fcrzmb4yLr58s0GhtrZPFOIBUDw7iVEP+ZusBRvzlMImtUV
         ZSmD3P+Y8Kzuxfb2Umdg1oaVlZQQT3icDKrYseuzZkvvuLT3PQMptko2WJqolWYI+phj
         9ZVrNPgbvBBmHHXQJWuwRWZ5Tv/gGAhazkXYrRUgV2iGiEj6BPlIga9NLojXzvLg5sUF
         LZ2FlnivA7RAYHI16yYy7RvyU7W75PSD5P8527fPz2eSLBYKVcDyOh0GaxEXX7uEq9Rq
         nD2WEe15HYuYr5JwH714PKOLjLRJWNC6ze2QyG7fJz3E1wkn5qmR1/j29y5ltvLmn5PL
         rDyA==
X-Gm-Message-State: AOAM533iT6bh+eocF3Wauylk9JtMquXSqV+nZYh7inEzg5Af/tuWi8QH
        egquPH8dasVrKOlwIA6LjKJHbQ==
X-Google-Smtp-Source: ABdhPJxbg1v/KZquALQzR8zC1f8a2UHGf7V/31l5O4xTMJCYuYdRHE2ig6g4Zrdc9lqZDjdhP6lnLg==
X-Received: by 2002:aa7:970a:0:b029:18b:5773:13e6 with SMTP id a10-20020aa7970a0000b029018b577313e6mr1665133pfg.34.1605265324421;
        Fri, 13 Nov 2020 03:02:04 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:02:03 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 06/21] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Fri, 13 Nov 2020 18:59:37 +0800
Message-Id: <20201113105952.11638-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we can use the free_vmemmap_page() to free the
unused vmemmap pages and initialize a page for vmemmap page using
via prepare_vmemmap_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..239e3cc8f86c 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
 void get_page_bootmem(unsigned long info, struct page *page,
 		      unsigned long type);
 void put_page_bootmem(struct page *page);
+
+static inline void free_vmemmap_page(struct page *page)
+{
+	VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
+
+	/* bootmem page has reserved flag in the reserve_bootmem_region */
+	if (PageReserved(page)) {
+		unsigned long magic = (unsigned long)page->freelist;
+
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
+			put_page_bootmem(page);
+		else
+			WARN_ON(1);
+	}
+}
+
+static inline void prepare_vmemmap_page(struct page *page)
+{
+	unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
+
+	get_page_bootmem(section_nr, page, SECTION_INFO);
+	mark_page_reserved(page);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.11.0

