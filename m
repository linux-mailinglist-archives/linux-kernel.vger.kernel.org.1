Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8A2BA27C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgKTGrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKTGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:47:08 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F39C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so6498684pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=lQtTc4p2yBd1UOH2ODIo4IfUun/3YveKsroBrt/z05tHCQ7bizuXanOEqJk1Qjjutd
         utIgpzzvRhDMQ6v/t6lQVerFUuFfpWtu7NjhOTcfNxn2JdmEke2/UD1WxhMDXygCHzF3
         b/hXHUxHWkm6lSBs1d9sc0tIDhhA2ndRN0NkdUh8caMOLwtchHRhhGN5UyShY8Wemd06
         mjBE+2Pl3whNHKbLaFl0ukQ31HqaNNWzxH2cK4B5ZG6H5Hf0H/wqZ8x6TegDWiWypdMZ
         URFjKhezi7NvGxsfWLVNwd0rk+gsAUyGGSNL6NdCr8uz9+C0JSe/BzXZx+yFNfNtvGH3
         jkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=V0VwCDtHIutZw1PFL/+E8i26di8gThB+uAZ4z4F93BmuGmzg3WIDxcmLTFKBTssQre
         vcVtr+e7IAxBaJPFFeYCtUyl1wFQCjyGfBk1nbugmWDnw/30JDnVo9nfRsaS/rhV1tNj
         T9G1uuvJl2O0BqBXXTymp/K+4MaFdDYE2gpuNilYdB8/ml0iKAa5qZ6tJFi7UFtBJRb/
         3RQ36quYkjYCRYEX8hOZCCeFaZiIcJtru0B/rpAA4JEZAlu7+y0iDcOETHUQCPHOW5E4
         cDS4qOtuui96puyAuJeBjrfvEQuW+5IiQ/YDSmC5VGf4/DlSZtkq9T9OMF10oq88sudE
         wxvQ==
X-Gm-Message-State: AOAM532TR32ERCAgZESDNfqSwjgQuos7QBg3oM/lVhyef5/AFoIZu9lZ
        cCV2CfPJe6C9okY9RWpP9d5Ypw==
X-Google-Smtp-Source: ABdhPJxxy0AXK/uMW8d0jud0uccMRuTn/ZHVTN15mkHEhZy7MdQXjCEqDU31cygr5QSODMyZCgtrIQ==
X-Received: by 2002:a17:90a:62c8:: with SMTP id k8mr8484104pjs.33.1605854827824;
        Thu, 19 Nov 2020 22:47:07 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:47:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 06/21] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Fri, 20 Nov 2020 14:43:10 +0800
Message-Id: <20201120064325.34492-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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

