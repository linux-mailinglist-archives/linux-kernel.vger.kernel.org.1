Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4B2F0CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 07:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbhAKGoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 01:44:44 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:54521 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 01:44:44 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10B6ccde099152;
        Mon, 11 Jan 2021 14:38:38 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.206) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Jan
 2021 14:43:30 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jenmin_yuan@aspeedtech.com>, <kuohsiang_chou@aspeedtech.com>,
        <arc_sung@aspeedtech.com>, <tommy_huang@aspeedtech.com>
Subject: [PATCH] drm/ast: Disable fast reset after DRAM initial
Date:   Mon, 11 Jan 2021 14:43:20 +0800
Message-ID: <20210111064320.72780-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.206]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10B6ccde099152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Bug][AST2500]
When AST2500 acts as stand-alone VGA so that DRAM and DVO initialization
have to be achieved by VGA driver with P2A (PCI to AHB) enabling.
However, HW suggests disable Fast reset mode after DRAM initializaton,
because fast reset mode is mainly designed for ARM ICE debugger.
Once Fast reset is checked as enabling, WDT (Watch Dog Timer) should be
first enabled to avoid system deadlock before disable fast reset mode.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_drv.h  |  1 +
 drivers/gpu/drm/ast/ast_main.c |  4 ++
 drivers/gpu/drm/ast/ast_post.c | 72 ++++++++++++++++++++++------------
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index da6dfb677540..8bdd1482370d 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -320,6 +320,7 @@ bool ast_is_vga_enabled(struct drm_device *dev);
 void ast_post_gpu(struct drm_device *dev);
 u32 ast_mindwm(struct ast_private *ast, u32 r);
 void ast_moutdwm(struct ast_private *ast, u32 r, u32 v);
+void patch_ahb_ast2500(struct ast_private *ast);
 /* ast dp501 */
 void ast_set_dp501_video_output(struct drm_device *dev, u8 mode);
 bool ast_backup_fw(struct drm_device *dev, u8 *addr, u32 size);
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 3775fe26f792..3c072c6589a2 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -96,6 +96,10 @@ static void ast_detect_config_mode(struct drm_device *dev, u32 *scu_rev)
 	jregd0 = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
 	jregd1 = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd1, 0xff);
 	if (!(jregd0 & 0x80) || !(jregd1 & 0x10)) {
+		/* Patch AST2500 */
+		if (((dev->pdev->revision & 0xF0) == 0x40) && ((jregd0 & 0xC0) == 0))
+			patch_ahb_ast2500(ast);
+
 		/* Double check it's actually working */
 		data = ast_read32(ast, 0xf004);
 		if (data != 0xFFFFFFFF) {
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 8902c2f84bf9..2d121c5b2233 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -2026,6 +2026,33 @@ static bool ast_dram_init_2500(struct ast_private *ast)
 	return true;
 }

+void patch_ahb_ast2500(struct ast_private *ast)
+{
+	u32	data;
+
+patch_ahb_lock:
+	/* Clear bus lock condition */
+	ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
+	ast_moutdwm(ast, 0x1e600084, 0x00010000);
+	ast_moutdwm(ast, 0x1e600088, 0x00000000);
+	ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
+	data = ast_mindwm(ast, 0x1e6e2070);
+	if (data & 0x08000000) {				/* check fast reset */
+
+		ast_moutdwm(ast, 0x1E785004, 0x00000010);
+		ast_moutdwm(ast, 0x1E785008, 0x00004755);
+		ast_moutdwm(ast, 0x1E78500c, 0x00000033);
+		udelay(1000);
+	}
+	ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
+	do {
+		data = ast_mindwm(ast, 0x1e6e2000);
+		if (data == 0xffffffff)
+			goto patch_ahb_lock;
+	}	while (data != 1);
+	ast_moutdwm(ast, 0x1e6e207c, 0x08000000);		/* clear fast reset */
+}
+
 void ast_post_chip_2500(struct drm_device *dev)
 {
 	struct ast_private *ast = to_ast_private(dev);
@@ -2033,39 +2060,32 @@ void ast_post_chip_2500(struct drm_device *dev)
 	u8 reg;

 	reg = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
-	if ((reg & 0x80) == 0) {/* vga only */
+	if ((reg & 0xC0) == 0) {/* vga only */
 		/* Clear bus lock condition */
-		ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
-		ast_moutdwm(ast, 0x1e600084, 0x00010000);
-		ast_moutdwm(ast, 0x1e600088, 0x00000000);
-		ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
-		ast_write32(ast, 0xf004, 0x1e6e0000);
-		ast_write32(ast, 0xf000, 0x1);
-		ast_write32(ast, 0x12000, 0x1688a8a8);
-		while (ast_read32(ast, 0x12000) != 0x1)
-			;
-
-		ast_write32(ast, 0x10000, 0xfc600309);
-		while (ast_read32(ast, 0x10000) != 0x1)
-			;
+		patch_ahb_ast2500(ast);
+
+		/* Disable watchdog */
+		ast_moutdwm(ast, 0x1E78502C, 0x00000000);
+		ast_moutdwm(ast, 0x1E78504C, 0x00000000);
+		/* Reset USB port */
+		ast_moutdwm(ast, 0x1E6E2090, 0x20000000);		/* add at V1.2 */
+		ast_moutdwm(ast, 0x1E6E2094, 0x00004000);		/* add at V1.2 */
+		if (ast_mindwm(ast, 0x1E6E2070) & 0x00800000) {		/* add at V1.2 */
+			ast_moutdwm(ast, 0x1E6E207C, 0x00800000);	/* add at V1.2 */
+			mdelay(100);					/* add at V1.2 */
+			ast_moutdwm(ast, 0x1E6E2070, 0x00800000);	/* add at V1.2 */
+		}							/* add at V1.2 */
+		/* Modify eSPI reset pin */
+		temp = ast_mindwm(ast, 0x1E6E2070);			/* add at V1.3 */
+		if (temp & 0x02000000) {				/* add at V1.3 */
+			ast_moutdwm(ast, 0x1E6E207C, 0x00004000);	/* add at V1.3 */
+		}

 		/* Slow down CPU/AHB CLK in VGA only mode */
 		temp = ast_read32(ast, 0x12008);
 		temp |= 0x73;
 		ast_write32(ast, 0x12008, temp);

-		/* Reset USB port to patch USB unknown device issue */
-		ast_moutdwm(ast, 0x1e6e2090, 0x20000000);
-		temp  = ast_mindwm(ast, 0x1e6e2094);
-		temp |= 0x00004000;
-		ast_moutdwm(ast, 0x1e6e2094, temp);
-		temp  = ast_mindwm(ast, 0x1e6e2070);
-		if (temp & 0x00800000) {
-			ast_moutdwm(ast, 0x1e6e207c, 0x00800000);
-			mdelay(100);
-			ast_moutdwm(ast, 0x1e6e2070, 0x00800000);
-		}
-
 		if (!ast_dram_init_2500(ast))
 			drm_err(dev, "DRAM init failed !\n");

--
2.18.4

