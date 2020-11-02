Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA02A34AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgKBT6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgKBT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:58:07 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F11208B6;
        Mon,  2 Nov 2020 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347087;
        bh=tw9J3svwWbXq+FJVS2k/2mfpBb+43r+MuLNJjGNiPbU=;
        h=From:To:Cc:Subject:Date:From;
        b=BNqHu7Av/nrYfBNdywykbvsk53Gw3JEQDazxZObt0yXqRYbgKpfiMMrh/tr7wFaeD
         a3uCy0vceQfOmDzbIk6Q0WWQbyj6T+nl/S438GpkjBBWOZva2DT8cp0f11NCKNiDyl
         2ekT1h0Sg43WSoH20WrU1a8ze3LAvPekEsUkwHdw=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: don't init vm module if no MMU
Date:   Mon,  2 Nov 2020 21:57:57 +0200
Message-Id: <20201102195802.10608-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we are running without MMU enabled (debug mode), no need to
initialize the VM module in the driver.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 33 +++++++++++--------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 84227819e4d1..75dd18771868 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1685,27 +1685,19 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 	 *   In case of DRAM mapping, the returned address is the physical
 	 *   address of the memory related to the given handle.
 	 */
-	if (ctx->hdev->mmu_enable) {
-		dram_range_start = prop->dmmu.start_addr;
-		dram_range_end = prop->dmmu.end_addr;
-		host_range_start = prop->pmmu.start_addr;
-		host_range_end = prop->pmmu.end_addr;
-		host_huge_range_start = prop->pmmu_huge.start_addr;
-		host_huge_range_end = prop->pmmu_huge.end_addr;
-	} else {
-		dram_range_start = prop->dram_user_base_address;
-		dram_range_end = prop->dram_end_address;
-		host_range_start = prop->dram_user_base_address;
-		host_range_end = prop->dram_end_address;
-		host_huge_range_start = prop->dram_user_base_address;
-		host_huge_range_end = prop->dram_end_address;
-	}
+	if (!ctx->hdev->mmu_enable)
+		return 0;
+
+	dram_range_start = prop->dmmu.start_addr;
+	dram_range_end = prop->dmmu.end_addr;
+	host_range_start = prop->pmmu.start_addr;
+	host_range_end = prop->pmmu.end_addr;
+	host_huge_range_start = prop->pmmu_huge.start_addr;
+	host_huge_range_end = prop->pmmu_huge.end_addr;
 
 	return vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
-					host_huge_range_start,
-					host_huge_range_end,
-					dram_range_start,
-					dram_range_end);
+				host_huge_range_start, host_huge_range_end,
+				dram_range_start, dram_range_end);
 }
 
 /*
@@ -1737,6 +1729,9 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	struct hlist_node *tmp_node;
 	int i;
 
+	if (!ctx->hdev->mmu_enable)
+		return;
+
 	hl_debugfs_remove_ctx_mem_hash(hdev, ctx);
 
 	/*
-- 
2.17.1

