Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBC27F5BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbgI3XO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:14:28 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60048 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbgI3XOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:14:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601507650; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=vkdiR7P09PCkbB+18oqh3xH2FAGNblOXdWhB2pw9H2E=; b=lCzO+LVAc3Arw7WlOv/uNWduAsiaRlGqVFIKXjMOKjbA5xoeqimyCE8QayyibHk1/mkNpeJt
 fwEXt6qaP15xXVZ6i7wmpumKlYLqYvmRb3e9g/q8wSs3ebDvMl1W99OGhaycuz+ZdGCxr+36
 PCjUKKwEIoYLjAt4WTjExo3Sr8U=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f75112f25e92f5003058e99 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 23:13:51
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC648C433C8; Wed, 30 Sep 2020 23:13:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4400EC433C8;
        Wed, 30 Sep 2020 23:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4400EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v2] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Wed, 30 Sep 2020 16:13:25 -0700
Message-Id: <a2d91c1b5874a1217e473ffd33cd4f765a0e78b7.1601506266.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1601506266.git.sudaraja@codeaurora.org>
References: <cover.1601506266.git.sudaraja@codeaurora.org>
In-Reply-To: <cover.1601506266.git.sudaraja@codeaurora.org>
References: <cover.1601506266.git.sudaraja@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When section mappings are enabled, we allocate vmemmap pages from physically
continuous memory of size PMD_SIZE using vmemmap_alloc_block_buf(). Section
mappings are good to reduce TLB pressure. But when system is highly fragmented
and memory blocks are being hot-added at runtime, its possible that such
physically continuous memory allocations can fail. Rather than failing the
memory hot-add procedure, add a fallback option to allocate vmemmap pages from
discontinuous pages using vmemmap_populate_basepages().

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62f..9edbbb8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1121,8 +1121,18 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			void *p = NULL;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
-			if (!p)
-				return -ENOMEM;
+			if (!p) {
+				if (altmap)
+					return -ENOMEM;	/* no fallback */
+
+				/*
+				 * fallback allocating with virtually
+				 * contiguous memory for this section
+				 */
+				if (vmemmap_populate_basepages(addr, next, node, NULL))
+					return -ENOMEM;
+				continue;
+			}
 
 			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
 		} else
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

