Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E52AB3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgKIJiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:38:55 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:10135 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgKIJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:38:55 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A99YRss012235;
        Mon, 9 Nov 2020 17:34:27 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.206) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Nov
 2020 17:38:26 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jenmin_yuan@aspeedtech.com>, <kuohsiang_chou@aspeedtech.com>,
        <arc_sung@aspeedtech.com>, <tommy_huang@aspeedtech.com>
Subject: [PATCH] drm/ast: Create chip AST2600
Date:   Mon, 9 Nov 2020 17:38:12 +0800
Message-ID: <20201109093812.161483-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.206]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A99YRss012235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[New] Support AST2600

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_drv.h  | 1 +
 drivers/gpu/drm/ast/ast_main.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 467049ca8430..6b9e3b94a712 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -63,6 +63,7 @@ enum ast_chip {
 	AST2300,
 	AST2400,
 	AST2500,
+	AST2600,
 };

 enum ast_tx_chip {
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 77066bca8793..4ec6884f6c65 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -143,7 +143,10 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 	ast_detect_config_mode(dev, &scu_rev);

 	/* Identify chipset */
-	if (dev->pdev->revision >= 0x40) {
+	if (dev->pdev->revision >= 0x50) {
+		ast->chip = AST2600;
+		drm_info(dev, "AST 2600 detected\n");
+	} else if (dev->pdev->revision >= 0x40) {
 		ast->chip = AST2500;
 		drm_info(dev, "AST 2500 detected\n");
 	} else if (dev->pdev->revision >= 0x30) {
--
2.18.4

