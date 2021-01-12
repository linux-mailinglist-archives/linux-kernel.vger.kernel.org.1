Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096C22F395E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406399AbhALTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392774AbhALTCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:02:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B437223122
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478114;
        bh=MBlbEwoledJKXCtGvBNreYjgEiv0uC19NQgckFNPLiY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jkBvlDnI3vPyjbffuxpWBDt4UEnu/FYijoUtxPMxwrI1CA2mM5BmqEFKCmhvUPC25
         TJ9+MrpIhf6iy3C+vxhiyf4EZBrQymYk8sKeOFgOFsMNwz3jn3MqkHTskcg2qNt/Nw
         jc+cUtVO3DF1TzTc+27veh+ikVMpn2JOoE3Nb6sBYJp1cZtqj7BVIecul8b0OEHHyh
         2kYEBa7PGgrjP/OswXaJVAX7nVwivSmZkmOtU//+4jr3O7eYD3ME2flC++Yf0snQdB
         GZBrn2hRWe4BvDYkHGmZaUSKHXV46R0pTKWvEx2UF43MDCQG+KqxsAHh2x8O8yHgrm
         2n8fP7iLs6kLw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] habanalabs: fix reset process in case of failures
Date:   Tue, 12 Jan 2021 21:01:48 +0200
Message-Id: <20210112190149.11661-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112190149.11661-1-ogabbay@kernel.org>
References: <20210112190149.11661-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some points in the reset process where if the code fails
for some reason, and the system admin tries to initiate the reset
process again we will get a kernel panic.

This is because there aren't any protections in different fini
functions that are called during the reset process.

The protections that are added in this patch make sure that if the fini
functions are called multiple times, without calling init functions
between them, there won't be double release of already released
resources.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c |  2 +-
 drivers/misc/habanalabs/common/mmu_v1.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 1456eabf9601..1ea57d86caa3 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1037,7 +1037,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 	if (hard_reset) {
 		/* Release kernel context */
-		if (hl_ctx_put(hdev->kernel_ctx) == 1)
+		if (hdev->kernel_ctx && hl_ctx_put(hdev->kernel_ctx) == 1)
 			hdev->kernel_ctx = NULL;
 		hl_vm_fini(hdev);
 		hl_mmu_fini(hdev);
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index 2ce6ea89d4fa..06d8a44dd5d4 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -467,8 +467,16 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
 {
 	/* MMU H/W fini was already done in device hw_fini() */
 
-	kvfree(hdev->mmu_priv.dr.mmu_shadow_hop0);
-	gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
+	if (!ZERO_OR_NULL_PTR(hdev->mmu_priv.hr.mmu_shadow_hop0)) {
+		kvfree(hdev->mmu_priv.dr.mmu_shadow_hop0);
+		gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
+	}
+
+	/* Make sure that if we arrive here again without init was called we
+	 * won't cause kernel panic. This can happen for example if we fail
+	 * during hard reset code at certain points
+	 */
+	hdev->mmu_priv.dr.mmu_shadow_hop0 = NULL;
 }
 
 /**
-- 
2.25.1

