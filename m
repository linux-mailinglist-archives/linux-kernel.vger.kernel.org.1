Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A82DE19F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbgLRK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgLRK54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:57:56 -0500
From:   matthias.bgg@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     mpm@selenic.com, herbert@gondor.apana.org.au, rjui@broadcom.com,
        sbranden@broadcom.com, f.fainelli@gmail.com
Cc:     linux-kernel@vger.kernel.org, Julia.Lawall@inria.fr,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, nsaenzjulienne@suse.de,
        linux-crypto@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2 1/2] hwrng: iproc-rng200: Fix disable of the block.
Date:   Fri, 18 Dec 2020 11:57:07 +0100
Message-Id: <20201218105708.28480-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

When trying to disable the block we bitwise or the control
register with value zero. This is confusing as using bitwise or with
value zero doesn't have any effect at all. Drop this as we already set
the enable bit to zero by appling inverted RNG_RBGEN_MASK.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v2:
- fix commit message, dropping Fixes tag
- drop inverted RNT_RBGEN_ENABLE in disable case

 drivers/char/hw_random/iproc-rng200.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index 01583faf9893..70cd818a0f31 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -28,7 +28,6 @@
 #define RNG_CTRL_OFFSET					0x00
 #define RNG_CTRL_RNG_RBGEN_MASK				0x00001FFF
 #define RNG_CTRL_RNG_RBGEN_ENABLE			0x00000001
-#define RNG_CTRL_RNG_RBGEN_DISABLE			0x00000000
 
 #define RNG_SOFT_RESET_OFFSET				0x04
 #define RNG_SOFT_RESET					0x00000001
@@ -61,7 +60,6 @@ static void iproc_rng200_restart(void __iomem *rng_base)
 	/* Disable RBG */
 	val = ioread32(rng_base + RNG_CTRL_OFFSET);
 	val &= ~RNG_CTRL_RNG_RBGEN_MASK;
-	val |= RNG_CTRL_RNG_RBGEN_DISABLE;
 	iowrite32(val, rng_base + RNG_CTRL_OFFSET);
 
 	/* Clear all interrupt status */
@@ -174,7 +172,6 @@ static void iproc_rng200_cleanup(struct hwrng *rng)
 	/* Disable RNG hardware */
 	val = ioread32(priv->base + RNG_CTRL_OFFSET);
 	val &= ~RNG_CTRL_RNG_RBGEN_MASK;
-	val |= RNG_CTRL_RNG_RBGEN_DISABLE;
 	iowrite32(val, priv->base + RNG_CTRL_OFFSET);
 }
 
-- 
2.29.2

