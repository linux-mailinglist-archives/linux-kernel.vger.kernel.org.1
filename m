Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA962D2EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgLHP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbgLHP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:58:34 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH] habanalabs/goya: move mmu_prepare to context init
Date:   Tue,  8 Dec 2020 17:57:48 +0200
Message-Id: <20201208155749.5759-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Currently mmu_prepare is located at context switch.
Since we support a single context, no reason to reconfigure
the MMU registers every context switch.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6ae34905d34f..dc32091d9b4b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4876,8 +4876,6 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
 
 	WREG32(mmTPC_PLL_CLK_RLX_0, 0x200020);
 
-	goya_mmu_prepare(hdev, asid);
-
 	goya_clear_sm_regs(hdev);
 
 	return 0;
@@ -5312,6 +5310,9 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
 
 static int goya_ctx_init(struct hl_ctx *ctx)
 {
+	if (ctx->asid != HL_KERNEL_ASID_ID)
+		goya_mmu_prepare(ctx->hdev, ctx->asid);
+
 	return 0;
 }
 
-- 
2.17.1

