Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5927360A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgIUW42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIUW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:56:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBAC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:56:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so14785127wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j57CFeGumUoULupeCRinOp3a9/2XpdO6zfbDwFadDd4=;
        b=iTMeBMDSd3lMbfj0ysL1nD2Uqfr0dUMPdhbZtrjhXXZTgUw96tTJw7kMUmU8lkOZRZ
         mAcaebTStOSSjVHMiecQrrWzpNxqcy3PRkbtYD/BbrPpoUPrXXn4IztAZbEKWIbmokwC
         D0bdmrBbo5MhyFH6boYh3rB9BUYn709eYJ/yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j57CFeGumUoULupeCRinOp3a9/2XpdO6zfbDwFadDd4=;
        b=YBTHSAyBq4k99DzxDDlGvyBCIGujpB6JL7hAh5bQr7FvRCnnthO1vgEQf1SKXUhszI
         n1tPsxeNqlIdc7q/AM3MLeIp6xY1xBCwiJDPReOEEHbMd5cPtrErHsG2UhCLv1l5OF53
         B0uL3+loV6929ZLc8KUMubl9LQ3jzUodRF8n1OfDUf6TwXsW+6Vbz9vBtXDK1Ad2IsfG
         QuGqXKvjmQMgCZTJY27rNfBb9kbNOupdw0RCwNSqNX6VeH40WfboR/bHFXEvTxK9/4h2
         vEqSGthJGKu1I3Dbd/5gGK6Dame1RhB/ND6oJFkEwg5VaMiRcCSw46qPKi2wKcUyYAgw
         +wyA==
X-Gm-Message-State: AOAM532BgEgs/+hQax58ivwhNGlUesxMu6Cant+FDSwX1gnop1yUkOGG
        cVjz0Fpy1iUi7R1R5OupPpk41o/skYURrda6
X-Google-Smtp-Source: ABdhPJwHEUTjE2FUfxfPVVxbUIO9QM0Shms2B58JmmJhPmYmEyqMdFXGSLoL3J9mFdd6KScW9zXpuw==
X-Received: by 2002:adf:8481:: with SMTP id 1mr1936150wrg.231.1600728985313;
        Mon, 21 Sep 2020 15:56:25 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id f14sm1543366wme.22.2020.09.21.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:56:24 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] phy: rockchip-dphy-rx0: Include linux/delay.h
Date:   Mon, 21 Sep 2020 22:56:18 +0000
Message-Id: <20200921225618.52529-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an implicit declaration of usleep_range():

drivers/phy/rockchip/phy-rockchip-dphy-rx0.c: In function 'rk_dphy_enable':
drivers/phy/rockchip/phy-rockchip-dphy-rx0.c:203:2: error: implicit declaration of function 'usleep_range' [-Werror=implicit-function-declaration]

Fixes: 32abcc4491c62 ("media: staging: phy-rockchip-dphy-rx0: add Rockchip MIPI Synopsys DPHY RX0 driver")
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c b/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
index 7c4df6d48c43..4df9476ef2a9 100644
--- a/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
+++ b/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-- 
2.28.0.681.g6f77f65b4e-goog

