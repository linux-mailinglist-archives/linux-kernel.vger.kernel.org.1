Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156142C2577
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgKXMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:15:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52031 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:15:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khXEG-0003cP-LP; Tue, 24 Nov 2020 12:15:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/mcde: fix masking and bitwise-or on variable val
Date:   Tue, 24 Nov 2020 12:15:28 +0000
Message-Id: <20201124121528.395681-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The masking of val with ~MCDE_CRX1_CLKSEL_MASK is currently being
ignored because there seems to be a missing bitwise-or of val in the
following statement.  Fix this by replacing the assignment of val
with a bitwise-or.

Addresses-Coverity: ("Unused valued")
Fixes: d795fd322063 ("drm/mcde: Support DPI output")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/mcde/mcde_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index d941026b940c..7c2e0b865441 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -738,7 +738,7 @@ static void mcde_configure_fifo(struct mcde *mcde, enum mcde_fifo fifo,
 	} else {
 		/* Use the MCDE clock for DSI */
 		val &= ~MCDE_CRX1_CLKSEL_MASK;
-		val = MCDE_CRX1_CLKSEL_MCDECLK << MCDE_CRX1_CLKSEL_SHIFT;
+		val |= MCDE_CRX1_CLKSEL_MCDECLK << MCDE_CRX1_CLKSEL_SHIFT;
 	}
 	writel(val, mcde->regs + cr1);
 	spin_unlock(&mcde->fifo_crx1_lock);
-- 
2.29.2

