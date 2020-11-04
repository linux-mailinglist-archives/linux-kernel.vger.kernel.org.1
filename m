Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E02A6151
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgKDKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgKDKOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:14:35 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25A822280;
        Wed,  4 Nov 2020 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604484874;
        bh=j2UToYLMrKCrHzce955qZHfAT4mv5UjLZz9NmcXD9nI=;
        h=From:To:Cc:Subject:Date:From;
        b=WQCpKs1zXE/9JloL9+YbPI0co/L++uA01wrXms3NkG+UjV7gyvou+1lfmYxzxW7AF
         t0OfaL6GZJIJShcDYCDD67+dGM3X8jUV/0MAKqfyibHeQZlcCaYhpMoSM74H6S/qr6
         OV4KzsQFjs2KRidoDAEp2e5edoqF0VDnMnyhGlsw=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: fix MMU print message
Date:   Wed,  4 Nov 2020 12:14:26 +0200
Message-Id: <20201104101429.15594-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit fixes an incorrect error message

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index b5058798aeb9..451148959431 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -216,7 +216,7 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 		real_page_size = mmu_prop->page_size;
 	} else {
 		dev_err(hdev->dev,
-			"page size of %u is not %uKB aligned, can't unmap\n",
+			"page size of %u is not %uKB aligned, can't map\n",
 			page_size, mmu_prop->page_size >> 10);
 
 		return -EFAULT;
-- 
2.17.1

