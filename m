Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC019F01E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 07:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDFF2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 01:28:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58338 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDFF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:28:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0365SdiP033304;
        Mon, 6 Apr 2020 00:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586150919;
        bh=bqsyJFofXwLipd6/kzIlPGP+VpCPYwO8dYIeN4RkzLo=;
        h=From:To:CC:Subject:Date;
        b=j2vrjdnRdWbm8zLqfAdyLSAcIR/Dd36bngb3I11pg/aZzwIC01gpLDDhYOGG7HhOT
         Kh38yUEW8hBNxXc4296O2Av1MOOdm2pMlr0Ltn+Y8Zjhy/GB0IH3ZaeLS9+f+VGAVo
         PkdWtAvyicg/rYMZMao2NrbrklYMjuOKHp7Dgiq4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0365SdX5020856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Apr 2020 00:28:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Apr
 2020 00:28:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Apr 2020 00:28:39 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0365Sbw8020282;
        Mon, 6 Apr 2020 00:28:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-direct: Fix data truncation in dma_direct_get_required_mask()
Date:   Mon, 6 Apr 2020 10:58:36 +0530
Message-ID: <20200406052836.25617-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper 32-bit physical address gets truncated inadvertently
when dma_direct_get_required_mask() invokes phys_to_dma_direct().
This results in dma_addressing_limited() return incorrect value
when used in platforms with LPAE enabled.
Fix it here by explicitly type casting 'max_pfn' to phys_addr_t
in order to prevent overflow of intermediate value while evaluating
'(max_pfn - 1) << PAGE_SHIFT'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Fixes the following WARN DUMP (and hang thereafter) observed when
connecting NVMe card to a platform with ARM LPAE enabled
nvme 0000:01:00.0: overflow 0x000000027b3be000+270336 of DMA mask
ffffffffffffffff bus limit ffffffff
-----------[ cut here ]-----------
WARNING: CPU: 0 PID: 26 at kernel/dma/direct.c:35 report_addr+0xf0/0xf4
Modules linked in:
CPU: 0 PID: 26 Comm: kworker/u4:1 Not tainted 5.5.0-00002-g1383adf7b819 #2
Hardware name: Generic DRA74X (Flattened Device Tree)
Workqueue: writeback wb_workfn (flush-259:0)
(unwind_backtrace) from [<c020b494>] (show_stack+0x10/0x14)
(show_stack) from [<c0a2ae24>] (dump_stack+0x94/0xa8)
(dump_stack) from [<c022bbd8>] (__warn+0xbc/0xd8)
(__warn) from [<c022bc54>] (warn_slowpath_fmt+0x60/0xb8)
(warn_slowpath_fmt) from [<c0299928>] (report_addr+0xf0/0xf4)
(report_addr) from [<c0299ab8>] (dma_direct_map_page+0x18c/0x19c)
(dma_direct_map_page) from [<c0299b2c>] (dma_direct_map_sg+0x64/0xb4)
(dma_direct_map_sg) from [<c071b12c>] (nvme_queue_rq+0x778/0x9ec)
(nvme_queue_rq) from [<c050c8c8>] (__blk_mq_try_issue_directly+0x130/0x1bc)
(__blk_mq_try_issue_directly) from [<c050d1b8>]
(blk_mq_request_issue_directly+0x48/0x78)
(blk_mq_request_issue_directly) from [<c050d22c>]
(blk_mq_try_issue_list_directly+0x44/0xb8)
(blk_mq_try_issue_list_directly) from [<c0511620>]
(blk_mq_sched_insert_requests+0xe0/0x154)
(blk_mq_sched_insert_requests) from [<c050d13c>]
(blk_mq_flush_plug_list+0x150/0x184)
(blk_mq_flush_plug_list) from [<c0502ec4>] (blk_flush_plug_list+0xc8/0xe4)
(blk_flush_plug_list) from [<c050cc44>] (blk_mq_make_request+0x24c/0x3f0)
(blk_mq_make_request) from [<c0501acc>] (generic_make_request+0xb0/0x2d4)
(generic_make_request) from [<c0501d34>] (submit_bio+0x44/0x180)
(submit_bio) from [<c039ad10>] (mpage_writepages+0xac/0xe8)
(mpage_writepages) from [<c02f96dc>] (do_writepages+0x44/0xdc)
(do_writepages) from [<c0384830>] (__writeback_single_inode+0x2c/0x1bc)
(__writeback_single_inode) from [<c0384b98>]
(writeback_sb_inodes+0x1d8/0x404)
(writeback_sb_inodes) from [<c0384e1c>] (__writeback_inodes_wb+0x58/0x9c)
(__writeback_inodes_wb) from [<c0384ff4>] (wb_writeback+0x194/0x1d8)
(wb_writeback) from [<c0386104>] (wb_workfn+0x244/0x33c)
(wb_workfn) from [<c0244ff8>] (process_one_work+0x204/0x458)
(process_one_work) from [<c0245290>] (worker_thread+0x44/0x598)
(worker_thread) from [<c024ab30>] (kthread+0x14c/0x150)
(kthread) from [<c02010d8>] (ret_from_fork+0x14/0x3c)
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ac7956c38f69..4b24275e306a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -39,7 +39,8 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
-- 
2.17.1

