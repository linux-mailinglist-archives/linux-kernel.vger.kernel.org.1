Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B82E74DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgL2ViV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgL2ViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:38:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A438222242;
        Tue, 29 Dec 2020 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277825;
        bh=kW614ANuc6ODpQD7kGOI54CVxhFM0R7lFwBfCCxNXzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2SDNY+S2vck2Ifep/iUMzgzTSa/ZtIQ1COFs3P8V0z61a9Qv27u3x4L0JhmjVm7y
         RSDnfloAn8yoy7M9X9XY4NbljXuKymNw3XwF8i0WPEbHtNET43WTvyJTsgAQLYbqiN
         36d1QcTia0p1X+nSIzSl/IDvf5TcptN1IYLkFKOmF4HgRc/Y6uJzHOdjetkEFgCCIq
         7BpZWFT5Hr5nj4xJ0vuoEm8eWEBDjjHlGhHvIWtcScFaOf38qwz5Bibz4vbzIPhnqR
         5FENvWSVLXK9sI4oBwBVcEIwXZ3MW8KVKgMiisYiqiByOxXXZVTkaMtWSt4zgDPzps
         DHK8qVZxuvOSg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 7/8] habanalabs: return dram virtual address in info ioctl
Date:   Tue, 29 Dec 2020 23:36:52 +0200
Message-Id: <20201229213653.29749-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

When working with DRAM MMU, we should supply the userspace with the
virtual start address of the DRAM instead of the physical one. This
is because the physical one has no meaning for the user as he only
knows the virtual address range.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ed325de04e35..64a82c966836 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -57,7 +57,9 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 
 	hw_ip.device_id = hdev->asic_funcs->get_pci_id(hdev);
 	hw_ip.sram_base_address = prop->sram_user_base_address;
-	hw_ip.dram_base_address = prop->dram_user_base_address;
+	hw_ip.dram_base_address =
+			hdev->mmu_enable && prop->dram_supports_virtual_memory ?
+			prop->dmmu.start_addr : prop->dram_user_base_address;
 	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
 	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
 	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
-- 
2.25.1

