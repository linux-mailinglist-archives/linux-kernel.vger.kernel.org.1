Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D232F9BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbhARI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:59:16 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:45894 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387918AbhARI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:59:12 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10I8qj7E044071;
        Mon, 18 Jan 2021 16:52:45 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.206) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Jan
 2021 16:58:03 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jenmin_yuan@aspeedtech.com>, <kuohsiang_chou@aspeedtech.com>,
        <arc_sung@aspeedtech.com>, <tommy_huang@aspeedtech.com>
Subject: [PATCH] drm/ast: Update the sequence of Clearing Fast-reset
Date:   Mon, 18 Jan 2021 16:57:55 +0800
Message-ID: <20210118085755.107804-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.206]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10I8qj7E044071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Bug][AST2500]
If SCU00 is not unlocked, just enter its password again.
It is unnecessary to clear AHB lock condition and restore WDT default
setting again, before Fast-reset clearing.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_post.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 1f0007daa005..4f194c5fd2c2 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -2030,7 +2030,6 @@ void ast_patch_ahb_2500(struct ast_private *ast)
 {
 	u32	data;

-patch_ahb_lock:
 	/* Clear bus lock condition */
 	ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
 	ast_moutdwm(ast, 0x1e600084, 0x00010000);
@@ -2044,11 +2043,9 @@ void ast_patch_ahb_2500(struct ast_private *ast)
 		ast_moutdwm(ast, 0x1E78500c, 0x00000033);
 		udelay(1000);
 	}
-	ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
 	do {
+		ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
 		data = ast_mindwm(ast, 0x1e6e2000);
-		if (data == 0xffffffff)
-			goto patch_ahb_lock;
 	}	while (data != 1);
 	ast_moutdwm(ast, 0x1e6e207c, 0x08000000);	/* clear fast reset */
 }
--
2.18.4

