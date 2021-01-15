Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384032F832D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbhAOR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:59:25 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58913 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbhAOR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:59:24 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D329B1C0007;
        Fri, 15 Jan 2021 17:58:41 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/2] soc: sunxi: mbus: Remove DE2 display engine compatibles
Date:   Fri, 15 Jan 2021 18:58:31 +0100
Message-Id: <20210115175831.1184260-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DE2 display engine hardware takes physical addresses that do not
need PHYS_BASE subtracted. As a result, they should not be present
on the mbus driver match list. Remove them.

This was tested on the A83T, along with the patch allowing the DMA
range map to be non-NULL and restores a working display.

Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a central place")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_mbus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_mbus.c b/drivers/soc/sunxi/sunxi_mbus.c
index e9925c8487d7..d90e4a264b6f 100644
--- a/drivers/soc/sunxi/sunxi_mbus.c
+++ b/drivers/soc/sunxi/sunxi_mbus.c
@@ -23,12 +23,7 @@ static const char * const sunxi_mbus_devices[] = {
 	"allwinner,sun7i-a20-display-engine",
 	"allwinner,sun8i-a23-display-engine",
 	"allwinner,sun8i-a33-display-engine",
-	"allwinner,sun8i-a83t-display-engine",
-	"allwinner,sun8i-h3-display-engine",
-	"allwinner,sun8i-r40-display-engine",
-	"allwinner,sun8i-v3s-display-engine",
 	"allwinner,sun9i-a80-display-engine",
-	"allwinner,sun50i-a64-display-engine",
 
 	/*
 	 * And now we have the regular devices connected to the MBUS
-- 
2.30.0

