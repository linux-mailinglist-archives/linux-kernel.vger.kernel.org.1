Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CC2C754D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgK1WXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbgK1WW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:22:57 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA492237B;
        Sat, 28 Nov 2020 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606602137;
        bh=AULh3Cht4bKBkcETIenOs98nRng2zXTdNahPd1Qiogg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBjPn2WK3ZqXeyKESGi09LxqgpSdNXeJYmp2jrRqFg/r+A7YjwYUmMUHFmIk9dGJR
         OIESChmkGSTW5G7KN+EzJNraZwlvXVr8STWizE0ZHU0jXwzx2D1U9LIKId2vQCQhex
         ERfvpmPPWOO0W5USY8HGjy7dzbfUXNmzEhlYPka8=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: free host huge va_range if not used
Date:   Sun, 29 Nov 2020 00:22:06 +0200
Message-Id: <20201128222207.23722-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201128222207.23722-1-ogabbay@kernel.org>
References: <20201128222207.23722-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

If huge range is not valid, driver uses the host range also for
huge page allocations, but driver never frees its allocation.
This introduces a memory leak every time a user closes its context.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 744275dd6410..cbe9da4e0211 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1761,6 +1761,7 @@ static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 			goto clear_host_va_range;
 		}
 	} else {
+		kfree(ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]);
 		ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE] =
 				ctx->va_range[HL_VA_RANGE_TYPE_HOST];
 	}
@@ -1906,9 +1907,10 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	spin_unlock(&vm->idr_lock);
 
 	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM]);
+	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST]);
+
 	if (hdev->pmmu_huge_range)
 		va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]);
-	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST]);
 
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
-- 
2.17.1

