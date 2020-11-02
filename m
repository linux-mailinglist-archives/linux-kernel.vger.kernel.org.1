Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691AD2A302A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKBQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgKBQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:43:50 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82DA22268;
        Mon,  2 Nov 2020 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604335429;
        bh=A4CrSl0xCUEbjxHUHtrDjJ4RCOsU/ynwC3kjXjcWM1M=;
        h=From:To:Cc:Subject:Date:From;
        b=iDFfGvn4cAesZ5C8deKe2W3JopbFeQNtNbhLTW5Zdo4HY8pdV+1p0SAnF7w9ja2V7
         fu6NH98jGrmGtl4K+Lx3m0rH9y4dDtvzyrUFJQ5NsPpjKWJjeswVFFVqBZbnZq0YTt
         juT/y2HhsmE8GcVGkzXaXfYJs4rw3+YdbCk4FNVo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs/gaudi: move coresight mmu config
Date:   Mon,  2 Nov 2020 18:43:43 +0200
Message-Id: <20201102164343.17268-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We must relocate the coresight mmu configuration to the coresight
flow to make it work in case the first submission is to configure
the profiler.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c           | 5 +----
 drivers/misc/habanalabs/gaudi/gaudiP.h          | 1 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c | 5 +++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b071965fa10a..2519a34e25b7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4742,7 +4742,7 @@ static void gaudi_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 			(addr - gaudi->hbm_bar_cur_addr));
 }
 
-static void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid)
+void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid)
 {
 	/* mask to zero the MMBP and ASID bits */
 	WREG32_AND(reg, ~0x7FF);
@@ -4910,9 +4910,6 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 	gaudi_mmu_prepare_reg(hdev, mmMME2_ACC_WBC, asid);
 	gaudi_mmu_prepare_reg(hdev, mmMME3_ACC_WBC, asid);
 
-	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER, asid);
-	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER, asid);
-
 	hdev->asic_funcs->set_clock_gating(hdev);
 
 	mutex_unlock(&gaudi->clk_gate_mutex);
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 83ad2b0a3a61..8eb598db81b2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -271,5 +271,6 @@ void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 int gaudi_debug_coresight(struct hl_device *hdev, void *data);
 void gaudi_halt_coresight(struct hl_device *hdev);
 int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid);
 
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 881531d4d9da..3d2b0f0f4650 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -623,6 +623,11 @@ static int gaudi_config_etr(struct hl_device *hdev,
 			return -EINVAL;
 		}
 
+		gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER,
+						hdev->compute_ctx->asid);
+		gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER,
+						hdev->compute_ctx->asid);
+
 		msb = upper_32_bits(input->buffer_address) >> 8;
 		msb &= PSOC_GLOBAL_CONF_TRACE_ADDR_MSB_MASK;
 		WREG32(mmPSOC_GLOBAL_CONF_TRACE_ADDR, msb);
-- 
2.17.1

