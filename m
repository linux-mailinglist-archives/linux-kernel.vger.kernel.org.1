Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF222AD60F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgKJMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:20:12 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43791 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJMUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:20:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605010810; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=y2rczb+wTSDbBJhBEknYiQeqZ1enHfHZnrNomlBH2Zw=; b=OMO/GFpYPiiVAMndyqQUdFNS4A1ditf9nKPNIErQmJI4Eq9jZp0hMf69vupxTL8gA9mobHEQ
 wWA+G2DTSqpxqZaRYjKBufZ73aiVVv7SmwVee0hnyZLh3ibOf5IYmKXtNkJ9n/rY6MbB+xYc
 wGL8jAmIKi66CswyKU+P1Tbvyxc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5faa8578a6da53ae7a874a09 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 12:20:08
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79A88C433CB; Tue, 10 Nov 2020 12:20:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DBCAC433C8;
        Tue, 10 Nov 2020 12:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DBCAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@kernel.org
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH] mm: memblock: add more debug logs
Date:   Tue, 10 Nov 2020 17:49:58 +0530
Message-Id: <1605010798-17545-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exact caller of memblock_phys_alloc_range is not available with
"memblock=debug". Below information is not enough for memory accounting.
for example:
[    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188

To enhance the memblock_dbg information or to get the exact owner of the
memblock_reserve, add debug logs in memblock_phys_alloc_range function.
After adding logs:
[    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 early_pgtable_alloc+0x24/0x178
[    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 049df41..f65af9f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1419,6 +1419,9 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 					     phys_addr_t start,
 					     phys_addr_t end)
 {
+	memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
+			__func__, (u64)size, (u64)align, &start, &end,
+			(void *)_RET_IP_);
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
 					false);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

