Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D02A3482
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgKBTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKBTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:46:23 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D39620731;
        Mon,  2 Nov 2020 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346382;
        bh=UZnKM1AUb7EaqBHgj4FCULLOWCXRSjMNVc4G/ObDoNE=;
        h=From:To:Cc:Subject:Date:From;
        b=M3dR8bkZJ7Laknb2qofkVg5aGLiVWt9nvAIWZKcTpT92j7cVfnXnzMmfCbP9VCMnu
         pFQ7akhZ7qFOtdNrRPfY4cKZ9igZS14uy6NWzJEgL+ZY+BXnxUzux4NjIOxb4InMC9
         SZKtZGB+PLGvBEQ7ANwG9Drkr25hmvCopGV47IKM=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: move mmu_prepare to context init
Date:   Mon,  2 Nov 2020 21:46:16 +0200
Message-Id: <20201102194616.27893-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently mmu_prepare is located at context switch.
Since we support a single context, no reason to reconfigure
the MMU registers every context switch.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5f65a1691551..2910f427c716 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4505,8 +4505,6 @@ static int gaudi_context_switch(struct hl_device *hdev, u32 asid)
 		return rc;
 	}
 
-	gaudi_mmu_prepare(hdev, asid);
-
 	gaudi_restore_user_registers(hdev);
 
 	return 0;
@@ -6359,6 +6357,8 @@ static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
 
 static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
+	gaudi_mmu_prepare(ctx->hdev, ctx->asid);
+
 	return 0;
 }
 
-- 
2.17.1

