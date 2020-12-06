Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6A2D05F0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLFQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbgLFQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:26 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: update firmware boot interface
Date:   Sun,  6 Dec 2020 18:28:34 +0200
Message-Id: <20201206162835.4088-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206162835.4088-1-ogabbay@kernel.org>
References: <20201206162835.4088-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to latest firmware hl_boot_if.h file.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 755c4800f002..261cb3898980 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -158,6 +158,10 @@
  *					statuses.
  *					Initialized in: preboot
  *
+ * CPU_BOOT_DEV_STS0_SP_SRAM_EN		SP SRAM is initialized and available
+ *					for use.
+ *					Initialized in: preboot
+ *
  */
 #define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
 #define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
@@ -171,6 +175,7 @@
 #define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
 #define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN		(1 << 10)
 #define CPU_BOOT_DEV_STS0_PLL_INFO_EN			(1 << 11)
+#define CPU_BOOT_DEV_STS0_SP_SRAM_EN			(1 << 12)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.17.1

