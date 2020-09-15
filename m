Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368726B13C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgIOW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:27:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgIOQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:21:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kIDhJ-0007yl-QR; Tue, 15 Sep 2020 16:20:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Zhong <zyw@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: cdn-dp: fix sign extension on an int multiply for a u64 result
Date:   Tue, 15 Sep 2020 17:20:49 +0100
Message-Id: <20200915162049.36434-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bit_per_pix is a u8 and is promoted in the multiplication
to an int type and then sign extended to a u64. If the result of the
int multiplication is greater than 0x7fffffff then the upper 32 bits will
be set to 1 as a result of the sign extension. Avoid this by casting
tu_size_reg to u64 to avoid sign extension and also a potential overflow.

Addresses-Coverity: ("Unintended sign extension")
Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 9d2163ef4d6e..33fb4d05c506 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -658,7 +658,7 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	 */
 	do {
 		tu_size_reg += 2;
-		symbol = tu_size_reg * mode->clock * bit_per_pix;
+		symbol = (u64)tu_size_reg * mode->clock * bit_per_pix;
 		do_div(symbol, dp->max_lanes * link_rate * 8);
 		rem = do_div(symbol, 1000);
 		if (tu_size_reg > 64) {
-- 
2.27.0

