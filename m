Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D326B870
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIPAn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIONB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23719C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1912656pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xbcz6YL/V2+vBJkP0RuPn1EYocXGKAfrd+QWEMaxAUM=;
        b=OUdkxbexs/MVUGZt2ahUW/InQH4DpqpR5JJ1oBb+J1X5eZKkizEqnmv60+K7HFZrLr
         OVKqtQHYFVYnqX0kj1o45dnJG6jPv26zLnwRxJNA16fWPRitcW3BHga2oxsq2rGVELhn
         kUHn3tN214hB5Z2AeqD1vODmkiownOfNFsbYicarsbxcKNvEG6wzTJPQ+l3d47+LMXQe
         8pkzMxqwgTNfDyZGx2S3lCJND+F8hegnCnJXesFON/ZNiUGuVFHYXQ9K9zFfvp90WKi2
         HOkUQ5hJ81UyQqS1JBwNLnp46AhnNdB6TWKDGFkYdQUpabRyhyZ5eqkZBbRrgZ9JuHl5
         +ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xbcz6YL/V2+vBJkP0RuPn1EYocXGKAfrd+QWEMaxAUM=;
        b=iQdNvJFHK6npa+82fuuWF5e3u5Lj0lcUjy1dU6j6CcbfRt05fvvdsO3aQW/cpQgZml
         8yk9K1T18xQB+eMllmFuAGZowRMYkOw5sWPRzSEN1vIR/oPOfd2jydgBsI2AKB/pBdnV
         5ouTosKD8uicMe5cHXNAcIKVnI1xyMMipWzNsa2hB+tVN+6kV2rNxwkrzDhsN4CrdkGO
         IX97K2srfs6h2Zcc0C3dZS019i2w6FhsLQfVV4m4m1MIMJUQ3k0S9nD7BURXAmPsHfGS
         umBpYjTz0IZOich8177W5LTX95+yLVPLM0cyFbL9Lg6Mw+l+0SlBvveBSVkxKLHIfWt3
         iECA==
X-Gm-Message-State: AOAM5312s06HmBkJv9skJyngF9SqEhFgs5zn2RRwan3gNTctJN6yEG7t
        mA8y9xwojZJjhkZsBUItV78uRA==
X-Google-Smtp-Source: ABdhPJzenFF0hJojbFeX+YMQrctmN2BJy+iieQr74UR3tyIddb8Jks43HUjUyWDUpivgKWRty3UcRg==
X-Received: by 2002:a62:cfc5:0:b029:13e:d13d:a083 with SMTP id b188-20020a62cfc50000b029013ed13da083mr18107687pfg.26.1600174886630;
        Tue, 15 Sep 2020 06:01:26 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 08/24] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Tue, 15 Sep 2020 20:59:31 +0800
Message-Id: <20200915125947.26204-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we can use the free_vmemmap_page() to free the
unused vmemmap pages and initialize a page for vmemmap page using
via prepare_vmemmap_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..ce9d8c97369d 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,30 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
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
+	__SetPageReserved(page);
+	adjust_managed_page_count(page, -1);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.20.1

