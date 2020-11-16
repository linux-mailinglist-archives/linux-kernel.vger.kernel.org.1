Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89812B42FA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKPLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:35:58 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62589 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgKPLf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:35:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605526557; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=K9LOsX2gLgSoNSTyxciP2LJzFbg0b7nckKv9VIJNYQQ=; b=FxqGoKzzfP15YkimXabQnO7pMYzIirfKC1QqkByKAhWqfsXSPImkMR4rcyOJrVKt29A28INw
 dfXw87SWs3HKsN1fB+kALh/yZiuyJLU6jC8FEbu3FxVUmt+WWGI56PP4D5n4INaDAw+wYm/8
 0FNwiOnuhNfOPM+ed3S0wv9dKeA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fb264148bd2e3c222d0b399 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 11:35:48
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8B80C433ED; Mon, 16 Nov 2020 11:35:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35485C433C6;
        Mon, 16 Nov 2020 11:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35485C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@kernel.org
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v2] mm: memblock: drop __init from memblock functions to make it inline
Date:   Mon, 16 Nov 2020 17:05:37 +0530
Message-Id: <1605526537-16166-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init is used with inline due to which memblock wraper functions are
not getting inline.
for example:
[    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc+0x20/0x2c
[    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188

Dropping __init from memblock wrapper functions to make it inline and it
increase the debugability.
After:
[    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0xa4/0x568
[    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 include/linux/memblock.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ef13125..f78113f 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -404,13 +404,13 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
 
-static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
+static inline void *memblock_alloc(phys_addr_t size,  phys_addr_t align)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
 }
 
-static inline void * __init memblock_alloc_raw(phys_addr_t size,
+static inline void *memblock_alloc_raw(phys_addr_t size,
 					       phys_addr_t align)
 {
 	return memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
@@ -418,7 +418,7 @@ static inline void * __init memblock_alloc_raw(phys_addr_t size,
 					  NUMA_NO_NODE);
 }
 
-static inline void * __init memblock_alloc_from(phys_addr_t size,
+static inline void *memblock_alloc_from(phys_addr_t size,
 						phys_addr_t align,
 						phys_addr_t min_addr)
 {
@@ -426,33 +426,33 @@ static inline void * __init memblock_alloc_from(phys_addr_t size,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
 }
 
-static inline void * __init memblock_alloc_low(phys_addr_t size,
+static inline void *memblock_alloc_low(phys_addr_t size,
 					       phys_addr_t align)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
 				      ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE);
 }
 
-static inline void * __init memblock_alloc_node(phys_addr_t size,
+static inline void *memblock_alloc_node(phys_addr_t size,
 						phys_addr_t align, int nid)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 }
 
-static inline void __init memblock_free_early(phys_addr_t base,
+static inline void memblock_free_early(phys_addr_t base,
 					      phys_addr_t size)
 {
 	memblock_free(base, size);
 }
 
-static inline void __init memblock_free_early_nid(phys_addr_t base,
+static inline void memblock_free_early_nid(phys_addr_t base,
 						  phys_addr_t size, int nid)
 {
 	memblock_free(base, size);
 }
 
-static inline void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
+static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	__memblock_free_late(base, size);
 }
@@ -460,7 +460,7 @@ static inline void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 /*
  * Set the allocation direction to bottom-up or top-down.
  */
-static inline void __init memblock_set_bottom_up(bool enable)
+static inline void memblock_set_bottom_up(bool enable)
 {
 	memblock.bottom_up = enable;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

