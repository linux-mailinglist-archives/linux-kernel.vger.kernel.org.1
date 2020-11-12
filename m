Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893AA2B0724
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgKLN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKLN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:59:14 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:59:13 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id rRz9230044C55Sk01Rz9M2; Thu, 12 Nov 2020 14:59:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kdD80-001rT1-LT; Thu, 12 Nov 2020 14:59:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kdD80-00G2Ra-4E; Thu, 12 Nov 2020 14:59:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Drew Fustini <drew@pdp7.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Revert "usb: musb: convert to devm_platform_ioremap_resource_byname"
Date:   Thu, 12 Nov 2020 14:59:00 +0100
Message-Id: <20201112135900.3822599-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2d30e408a2a6b3443d3232593e3d472584a3e9f8.

On Beaglebone Black, where each interface has 2 children:

    musb-dsps 47401c00.usb: can't request region for resource [mem 0x47401800-0x474019ff]
    musb-hdrc musb-hdrc.1: musb_init_controller failed with status -16
    musb-hdrc: probe of musb-hdrc.1 failed with error -16
    musb-dsps 47401400.usb: can't request region for resource [mem 0x47401000-0x474011ff]
    musb-hdrc musb-hdrc.0: musb_init_controller failed with status -16
    musb-hdrc: probe of musb-hdrc.0 failed with error -16

Before, devm_ioremap_resource() was called on "dev" ("musb-hdrc.0" or
"musb-hdrc.1"), after it is called on "&pdev->dev" ("47401400.usb" or
"47401c00.usb"), leading to a duplicate region request, which fails.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/musb/musb_dsps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 30085b2be7b90bf1..5892f3ce0cdc824d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -429,10 +429,12 @@ static int dsps_musb_init(struct musb *musb)
 	struct platform_device *parent = to_platform_device(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	void __iomem *reg_base;
+	struct resource *r;
 	u32 rev, val;
 	int ret;
 
-	reg_base = devm_platform_ioremap_resource_byname(parent, "control");
+	r = platform_get_resource_byname(parent, IORESOURCE_MEM, "control");
+	reg_base = devm_ioremap_resource(dev, r);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 	musb->ctrl_base = reg_base;
-- 
2.25.1

