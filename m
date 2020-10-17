Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F17290FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436746AbgJQF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:58:05 -0400
Received: from z5.mailgun.us ([104.130.96.5]:19564 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436569AbgJQF6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:58:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602914283; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=syQRF+izLbNyV3P3hHSWzRBTaZShfqT3m4lhPWabPmE=; b=pt8oQuBjR6bEPMhj0FCT6qa/+Mv9V9QPM/RgRiHWYAt8zDVu88Wz/auzUVXULbFEqeBLrZss
 ehDs7MXQT4zwvBXdv8QleqrrLgqPQxJP4bLo8zRDbMWyl12svjlGl1AFQkMVoaH6NLJQuanR
 kzshq9uhps5mVINZrk27eiaKnqg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f8a50d54f8cc67c31617d84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Oct 2020 02:03:01
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B994C433F1; Sat, 17 Oct 2020 02:03:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A49EC433FF;
        Sat, 17 Oct 2020 02:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A49EC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/2] mm/memory_hotplug: allow marking of memory sections as hotpluggable
Date:   Fri, 16 Oct 2020 19:02:23 -0700
Message-Id: <2cba881c51e42cfe5ba213e09273642136e8ef93.1602899443.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1602899443.git.sudaraja@codeaurora.org>
References: <cover.1602899443.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain architectures such as arm64 doesn't allow boot memory to be
offlined and removed. Distinguish certain memory sections as
"hotpluggable" which can be marked by module drivers stating to memory
hotplug layer that these sections can be offlined and then removed.
This is done by using a separate section memory mab bit and setting it,
rather than clearing the existing SECTION_IS_EARLY bit.
This patch introduces SECTION_MARK_HOTPLUGGABLE bit into section mem map.
Only the allowed sections which are in movable zone and have unmovable
pages are allowed to be set with this new bit.

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memory_hotplug.h |  1 +
 include/linux/mmzone.h         |  9 ++++++++-
 mm/memory_hotplug.c            | 20 ++++++++++++++++++++
 mm/sparse.c                    | 31 +++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 375515803cd8..81df45b582c8 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -319,6 +319,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 extern int offline_and_remove_memory(int nid, u64 start, u64 size);
+extern int mark_memory_hotpluggable(unsigned long start, unsigned long end);
 
 #else
 static inline void try_offline_node(int nid) {}
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..3df3a4975236 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1247,7 +1247,8 @@ extern size_t mem_section_usage_size(void);
 #define SECTION_HAS_MEM_MAP	(1UL<<1)
 #define SECTION_IS_ONLINE	(1UL<<2)
 #define SECTION_IS_EARLY	(1UL<<3)
-#define SECTION_MAP_LAST_BIT	(1UL<<4)
+#define SECTION_MARK_HOTPLUGGABLE	(1UL<<4)
+#define SECTION_MAP_LAST_BIT	(1UL<<5)
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define SECTION_NID_SHIFT	3
 
@@ -1278,6 +1279,11 @@ static inline int early_section(struct mem_section *section)
 	return (section && (section->section_mem_map & SECTION_IS_EARLY));
 }
 
+static inline int removable_section(struct mem_section *section)
+{
+	return (section && (section->section_mem_map & SECTION_MARK_HOTPLUGGABLE));
+}
+
 static inline int valid_section_nr(unsigned long nr)
 {
 	return valid_section(__nr_to_section(nr));
@@ -1297,6 +1303,7 @@ static inline int online_section_nr(unsigned long nr)
 void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
+int section_mark_hotpluggable(struct mem_section *ms);
 #endif
 #endif
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..503b0de489a0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1860,4 +1860,24 @@ int offline_and_remove_memory(int nid, u64 start, u64 size)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
+
+int mark_memory_hotpluggable(unsigned long start_pfn, unsigned long end_pfn)
+{
+	struct mem_section *ms;
+	unsigned long nr;
+	int rc = -EINVAL;
+
+	if (end_pfn < start_pfn)
+		return rc;
+
+	for (nr = start_pfn; nr <= end_pfn; nr++) {
+		ms = __pfn_to_section(nr);
+		rc = section_mark_hotpluggable(ms);
+		if (!rc)
+			break;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(mark_memory_hotpluggable);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
diff --git a/mm/sparse.c b/mm/sparse.c
index fcc3d176f1ea..cc21c23e2f1d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/page-isolation.h>
 
 #include "internal.h"
 #include <asm/dma.h>
@@ -644,6 +645,36 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
 }
+
+int section_mark_hotpluggable(struct mem_section *ms)
+{
+	unsigned long section_nr, pfn;
+	bool unmovable;
+	struct page *page;
+
+	/* section needs to be both valid and present to be marked */
+	if (WARN_ON(!valid_section(ms)) || !present_section(ms))
+		return -EINVAL;
+
+	/*
+	 * now check if this section is removable. This can be done by checking
+	 * if section has unmovable pages or not.
+	 */
+	section_nr = __section_nr(ms);
+	pfn = section_nr_to_pfn(section_nr);
+	page = pfn_to_page(pfn);
+	unmovable = has_unmovable_pages(page_zone(page), page,
+					MIGRATE_MOVABLE, MEMORY_OFFLINE | REPORT_FAILURE);
+	if (unmovable) {
+		pr_info("section %lu has unmovable pages. Cannot be marked as hotpluggable\n");
+		return -EINVAL;
+	}
+
+	/* all good! mark section as hotpluggable */
+	ms->section_mem_map |= SECTION_MARK_HOTPLUGGABLE;
+
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

