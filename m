Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF46F2B2C66
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKNJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKNJYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:24:23 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289ED22254;
        Sat, 14 Nov 2020 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605345863;
        bh=U3nup5XbP1pjxnq+2s17x952RznDuwTkPkOChvEHv4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXOt0IOT9zE6WS/sPR43HvcVjJSq8DyRmXLbVuo04ndnvI1XdkkokR7VhOKZR9vcj
         CuqGGqzAU1aYjjSRLOk/TNUA2nNkTaHKsgqLeqE44tIsVjVs+HJ4nJRzivSsTVxna7
         adIIhV1qfammJez72i8HFLK4PT/o3es8uVDopynY=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: share a single ctx-mutex between all MMUs
Date:   Sat, 14 Nov 2020 11:24:13 +0200
Message-Id: <20201114092414.12244-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114092414.12244-1-ogabbay@kernel.org>
References: <20201114092414.12244-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

Multiple locks are usually a source of problems, which in the MMU
case can be avoided since it is relatively rare that both MMU
tables are updated at the same time.

Therefore, use a single shared lock instead of two separate ones.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu.c    | 4 ++++
 drivers/misc/habanalabs/common/mmu_v1.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 6f535c81478d..f4b3d02fe0d8 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -81,6 +81,8 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	if (!hdev->mmu_enable)
 		return 0;
 
+	mutex_init(&ctx->mmu_lock);
+
 	if (hdev->mmu_func[MMU_DR_PGT].ctx_init != NULL) {
 		rc = hdev->mmu_func[MMU_DR_PGT].ctx_init(ctx);
 		if (rc)
@@ -115,6 +117,8 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 
 	if (hdev->mmu_func[MMU_HR_PGT].ctx_fini != NULL)
 		hdev->mmu_func[MMU_HR_PGT].ctx_fini(ctx);
+
+	mutex_destroy(&ctx->mmu_lock);
 }
 
 /*
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index 5f62cb158eef..92b22298bb5c 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -481,9 +481,7 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
  */
 static int hl_mmu_v1_ctx_init(struct hl_ctx *ctx)
 {
-	mutex_init(&ctx->mmu_lock);
 	hash_init(ctx->mmu_shadow_hash);
-
 	return dram_default_mapping_init(ctx);
 }
 
@@ -516,8 +514,6 @@ static void hl_mmu_v1_ctx_fini(struct hl_ctx *ctx)
 			pgt_info->phys_addr, ctx->asid, pgt_info->num_of_ptes);
 		_free_hop(ctx, pgt_info);
 	}
-
-	mutex_destroy(&ctx->mmu_lock);
 }
 
 static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
-- 
2.17.1

