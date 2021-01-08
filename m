Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780C42EFBA0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAHXRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:17:39 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:37698 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:17:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610147834; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vmifnDDJgJMy13vI52Ecn3QuFw9yk00wlOafIxsdu98=; b=fpr+tyoA7NIMjm8Ak468/++/DwzFpIL2QnVzzi2J5Z5nJUrus5GNT3liCrk8xh17akvdQKU8
 /xpGcZcXaHiXf2DZiOPFqHgFlJCmKFy7qM0+hJpYsaWulgFZxVHkvtFU83uoLXkYyKCdSBDR
 iYHF+qGqk+OAV/a+2b9M+7dLjP8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ff8e7d48fb3cda82f2dd586 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 23:16:36
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C785C433C6; Fri,  8 Jan 2021 23:16:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15CEBC433CA;
        Fri,  8 Jan 2021 23:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15CEBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, anshuman.khandual@arm.com, david@redhat.com
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/1] arm64: reduce section size for sparsemem
Date:   Fri,  8 Jan 2021 15:16:00 -0800
Message-Id: <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1610146597.git.sudaraja@codeaurora.org>
References: <cover.1610146597.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing the section size helps reduce wastage of reserved memory
for huge memory holes in sparsemem model. But having a much smaller
section size bits could break PMD mappings for vmemmap and wouldn't
accomodate the highest order page for certain page size granule configs.
It is determined that SECTION_SIZE_BITS of 27 (128MB) could be ideal
default value for 4K_PAGES that gives least section size without breaking
PMD based vmemmap mappings. For simplicity, 16K_PAGES could follow the
same as 4K_PAGES. And the least SECTION_SIZE_BITS for 64K_PAGES is 29
that could accomodate MAX_ORDER.

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1f43fcc79738..ff08ff6b677c 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,13 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
-#endif
+
+#if defined(CONFIG_ARM64_4K_PAGES) || defined(CONFIG_ARM64_16K_PAGES)
+#define SECTION_SIZE_BITS 27
+#else
+#define SECTION_SIZE_BITS 29
+#endif /* CONFIG_ARM64_4K_PAGES || CONFIG_ARM64_16K_PAGES */
+
+#endif /* CONFIG_SPARSEMEM*/
 
 #endif
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

