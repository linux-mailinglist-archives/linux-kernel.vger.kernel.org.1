Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D72A2890
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgKBKyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:54:33 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968AFC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:54:32 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id nNuV2300N4C55Sk06NuVZp; Mon, 02 Nov 2020 11:54:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kZXTp-002Cfi-6h; Mon, 02 Nov 2020 11:54:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kZXTo-0039h3-8a; Mon, 02 Nov 2020 11:54:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: Drop superfluous ULL suffix for ~0
Date:   Mon,  2 Nov 2020 11:54:22 +0100
Message-Id: <20201102105422.752202-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to specify a "ULL" suffix for "all bits set": "~0" is
sufficient, and works regardless of type.  In fact adding the suffix
makes the code more fragile.

Fixes: 48ab6d5d1f096d6f ("dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=n")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3a469c79e6b05de4..aedfaaafd3e7edb7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -112,7 +112,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		u64 dma_end = 0;
 
 		/* Determine the overall bounds of all DMA regions */
-		for (dma_start = ~0ULL; r->size; r++) {
+		for (dma_start = ~0; r->size; r++) {
 			/* Take lower and upper limits */
 			if (r->dma_start < dma_start)
 				dma_start = r->dma_start;
-- 
2.25.1

