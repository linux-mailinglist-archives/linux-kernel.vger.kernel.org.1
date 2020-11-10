Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8202AD610
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgKJMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:20:35 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43791 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJMUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:20:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605010834; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NcClgQULa9ITH6Tn0m0RtnZUGf/0+LsBr9Wi6wpvlDA=; b=cLShkazCsDiXH5g4GEcy8ikHy0QLFVKR3w6KeGM4zK4zqyZ0jaVlmrJyCqzy+p5HDDGPlHOo
 iCEQg4PsfZjrc3Q5EBtGdRzIvu64TYGZgsKvL7zkFz7objQfFWkp3yYMx7tMaaQaWJa8Vp3+
 tzDwxob4xTsiXa3tanaqHqMZg8A=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5faa858e8da2a3eaefb7a861 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 12:20:30
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E6EEC433FE; Tue, 10 Nov 2020 12:20:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C594AC433C6;
        Tue, 10 Nov 2020 12:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C594AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@kernel.org
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH] mm: memblock: always inline memblock_alloc
Date:   Tue, 10 Nov 2020 17:50:17 +0530
Message-Id: <1605010817-21065-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since memblock_alloc is not getting inlined, memblock_reserve owner info
is lost. Below information is not enough for memory accounting.
for example:
[    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc+0x20/0x2c
[    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188

Add "__always_inline" to make sure it get inlined and to get the exact
owner of the memblock_reserve.
After adding __always_inline:
[    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0xa4/0x568
[    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 include/linux/memblock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ef13125..54f9544 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -404,7 +404,7 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
 
-static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
+static __always_inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

