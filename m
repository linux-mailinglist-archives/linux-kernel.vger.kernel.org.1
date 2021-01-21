Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEA2FE1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAUFbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:31:42 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:57008 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhAUFar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:30:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611207015; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J0KG47KVOR32r/lwzoIa1wQj1mJpH9+Gnjwqvmty8jE=; b=ez66t7ZCb9ho+ogilmvtOKJHuZSzchfziEhaG4uPCaR3VADn54/IygptSJtySK5wkg2uO1xO
 HmcixFPZA1eS4rScrdvHzO64mEwl1dKSXwvBWAgMvO76EhYpCMPzGtsd88hekBvKuSy81s4R
 96tknMfYxJLiDjc6raB+bbxSTAM=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 600911465677aca7bd783ffd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 05:29:42
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3421C43461; Thu, 21 Jan 2021 05:29:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC03AC433CA;
        Thu, 21 Jan 2021 05:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC03AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Date:   Wed, 20 Jan 2021 21:29:13 -0800
Message-Id: <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1611206601.git.sudaraja@codeaurora.org>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_block_size_bytes() determines the memory hotplug granularity i.e the
amount of memory which can be hot added or hot removed from the kernel. The
generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
for memory_block_size_bytes() on platforms like arm64 that does not override.

Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
increases memory hotplug granularity, thus improving its agility. A reduced
section size also reduces memory wastage in vmemmmap mapping for sections
with large memory holes. So we try to set the least section size as possible.

A section size bits selection must follow:
(MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS

CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and so just following it
would help achieve the smallest section size.

SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)

SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP

But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
much would over populate /sys/devices/system/memory/ and also consume too many
page->flags bits in the !vmemmap case. Also section size needs to be multiple
of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.

Given these constraints, lets just reduce the section size to 128MB for 4K
and 16K base page size configs, and to 512MB for 64K base page size config.

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/include/asm/sparsemem.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1f43fcc79738..eb4a75d720ed 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,26 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
-#endif
+
+/*
+ * Section size must be at least 512MB for 64K base
+ * page size config. Otherwise it will be less than
+ * (MAX_ORDER - 1) and the build process will fail.
+ */
+#ifdef CONFIG_ARM64_64K_PAGES
+#define SECTION_SIZE_BITS 29
+
+#else
+
+/*
+ * Section size must be at least 128MB for 4K base
+ * page size config. Otherwise PMD based huge page
+ * entries could not be created for vmemmap mappings.
+ * 16K follows 4K for simplicity.
+ */
+#define SECTION_SIZE_BITS 27
+#endif /* CONFIG_ARM64_64K_PAGES */
+
+#endif /* CONFIG_SPARSEMEM*/
 
 #endif
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

