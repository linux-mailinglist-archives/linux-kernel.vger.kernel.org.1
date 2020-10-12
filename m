Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8C28C519
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390983AbgJLXGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:06:47 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:26943 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390967AbgJLXGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:06:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602544007; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Rzrfzy2wwKZ6vAoohIvDKXUIwAX2TFJFlZiH28jpC3U=; b=imjc0d0Xmna1j8lswA+k3Ttyj6Ak3DB4AuVKOzxd5WW3deYcNlXWDCk8I1LQkRgcYKAlE9+7
 qJ0pVjpt6S9y6GF1Tj8dHxjTwQ7hV3WYhOGufqxH5cCG0TYXFYaAFvcz68GTAygSthGE+OaT
 h7H9BQ653FitJDLWnpag0RQXSK8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f84e186588858a3044df37d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 23:06:46
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA3DC43387; Mon, 12 Oct 2020 23:06:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F0D0C433C9;
        Mon, 12 Oct 2020 23:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F0D0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Gavin Shan <gshan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v3] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Mon, 12 Oct 2020 16:05:58 -0700
Message-Id: <339118202d0a4741ec22f215830dc8d9ba1ccd49.1602542734.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1602542734.git.sudaraja@codeaurora.org>
References: <cover.1602542734.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..44486fd0e883 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1121,8 +1121,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			void *p = NULL;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
-			if (!p)
-				return -ENOMEM;
+			if (!p) {
+				if (vmemmap_populate_basepages(addr, next, node, altmap))
+					return -ENOMEM;
+				continue;
+			}
 
 			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
 		} else
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

