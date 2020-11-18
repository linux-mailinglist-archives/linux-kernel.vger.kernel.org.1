Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8D2B743A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKRCg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgKRCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:36:56 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FDC061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:36:55 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id h12so263865pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aLAwBEV8rDngSyjP7XaDJT1gxKz3iKkOVuPY4qMJ+Y4=;
        b=Sch+ceLdIm2niHQkFOJ3RkQtWCgGPslipO9TDCg80Dz8aSnw71wPiGwAt4FFHCu9TP
         0moiF/HLPZzkrpPTLpEPUi+5JWMNHGcHhrve/sDuxvkvTn3cueVFkHooYeS4xA2lwDVm
         VHQmGw3VHT/VyGLy5qg/RW2njNOmvbQfAw9Jowtp0v5iLmJEZikCW+GnyRYMnq93Loc7
         pUI+EBC5HfuWHE0V5hEpVWUj0RyK22dnnvFtZlpquHX9+XhfXhcwvXvSJjxvzukxQldq
         iR5NbMx33PeZQUd6YyNAhDWdJi6eq54gcKe7wUqJaPXvRLU9ldx+Z3wlxgqLZoguyWq/
         bozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aLAwBEV8rDngSyjP7XaDJT1gxKz3iKkOVuPY4qMJ+Y4=;
        b=ZGrwRmSHkMR/rZ64aZyJNTOIBpt6ogM419ox1W84QPZsw0kTJQrWEgMi5iu+rm32tU
         Hc/wha74L0rBrjYvQ6MKbIlOrsaCe9LvFZGpjrvs8PwFaztKYtIln+AoYdXdW6eOIVPw
         LxX95oUIU3nKVrdtq212lz5o2AelXqKi2eLu0Q2Osn6LDq+hJptqDRZwP5657Mhz5eM+
         92UIY0Wu3uh4dmC2hPyAvkqexF+d4h8GL3/AMw5z5t7GoZXmr/15f5Io82Vxx2A0ZeWU
         oAf3Va0Tym+1wjJlL+Okb55cFhfbzWk/zDCI/JzfjRIHbtF1o2t6Cf/GaV1B+YVzwt9g
         RjZQ==
X-Gm-Message-State: AOAM53249P1iPEoUn4WmOR9LAFDak2N4bfFangXpi+w8JrItTnYN0TkF
        wdZdhTndrzcUHF12PY/a8vQ=
X-Google-Smtp-Source: ABdhPJwXsbmgh7VDl77Mqc7qiFziVJuy+X4wawPYtGcauQ+tk8eWNX35YVsHNvvaJBdiBqEEDRhe/w==
X-Received: by 2002:a17:90b:b15:: with SMTP id bf21mr1911068pjb.21.1605667015399;
        Tue, 17 Nov 2020 18:36:55 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id j11sm7210265pfe.26.2020.11.17.18.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 18:36:55 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, p.zabel@pengutronix.de,
        lorenzo.pieralisi@arm.com, repk@triplefau.lt, yejune.deng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] phy: amlogic: replace devm_reset_control_array_get()
Date:   Wed, 18 Nov 2020 10:36:35 +0800
Message-Id: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_array_get_exclusive() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/phy/amlogic/phy-meson-axg-pcie.c       | 2 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
index 377ed0d..3204f02 100644
--- a/drivers/phy/amlogic/phy-meson-axg-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
@@ -155,7 +155,7 @@ static int phy_axg_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	priv->reset = devm_reset_control_array_get(dev, false, false);
+	priv->reset = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index 08e3227..bab6345 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -418,7 +418,7 @@ static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk_ref;
 
-	priv->reset = devm_reset_control_array_get(dev, false, false);
+	priv->reset = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
-- 
1.9.1

