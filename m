Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89A22E3627
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 12:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgL1LFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 06:05:49 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:57698 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgL1LFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 06:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JM1NyRbKhxlRO/i7Ij
        VnVe89Cxv6XhhrXatSpVLuSsQ=; b=ij9TKUUhEXTu8hlHPoN2+BAXhLEXxsPgah
        9iWgPlKps1Z96XoGIjKchSKTVN/bCrnXfnAuAS2KLPKi0KC2pmY2g6bvLw+uRaus
        Y6mq8k6mK3WGxXkC8ZyJ98mHOVQ/5tEkgC2UqpUx6C1gIIdKWbX9tID9vrsaNQ9d
        j4qvaxvSI=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowACHjeGsQulfI9kSNQ--.5611S2;
        Mon, 28 Dec 2020 10:27:57 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@redhat.com, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] drivers/gpu/drm/ast: Fix infinite loop if read fails
Date:   Mon, 28 Dec 2020 10:27:49 +0800
Message-Id: <1609122469-217583-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowACHjeGsQulfI9kSNQ--.5611S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr43JF4Dur1xXFWkJw4Dtwb_yoW8Gw13pF
        4UJFyYvrZ5tFn0yFW7Can7GFyrCa97Ja4F9r97Jwn3uFyY93ZYvr90yayrKFy7JrZ7AFyS
        qr97tryUX3W09w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U59N3UUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikg0J11pECFzcjwAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
Similar to commit <298360af3>("drivers/gpu/drm/ast: Fix infinite loop if read fails"),
ast_init_dram_reg() configures a window in order to access BMC memory.
A BMC register can be configured to disallow this, and if so, causes
an infinite loop in the ast driver which renders the system unusable.

[How]
Fix this by erroring out if an error is detected.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/ast/ast_post.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 8902c2f..8bcd1e6 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -287,7 +287,8 @@ static void ast_init_dram_reg(struct drm_device *dev)
 			ast_write32(ast, 0x10100, 0xa8);
 
 			do {
-				;
+				if (pci_channel_offline(dev->pdev))
+					return;
 			} while (ast_read32(ast, 0x10100) != 0xa8);
 		} else {/* AST2100/1100 */
 			if (ast->chip == AST2100 || ast->chip == 2200)
@@ -299,12 +300,14 @@ static void ast_init_dram_reg(struct drm_device *dev)
 			ast_write32(ast, 0xf000, 0x1);
 			ast_write32(ast, 0x12000, 0x1688A8A8);
 			do {
-				;
+				if (pci_channel_offline(dev->pdev))
+					return;
 			} while (ast_read32(ast, 0x12000) != 0x01);
 
 			ast_write32(ast, 0x10000, 0xfc600309);
 			do {
-				;
+				if (pci_channel_offline(dev->pdev))
+					return;
 			} while (ast_read32(ast, 0x10000) != 0x01);
 		}
 
-- 
2.7.4

