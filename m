Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAB2BAF27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgKTPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgKTPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:39:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:39:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so10495401wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jt0xR/XFtpMRIuj7oLrfJvxFoX3/OcrnceaJeMN2qXk=;
        b=idKg8a9h4DmuA2CHSqlnfdiwPyTJyJUDzreNBsk55cXRvx1yJnTndM8bscb0OIT6bp
         eCH1w6RGo0XyGZ0FKyuVu1JhmkvMSnVLXNoT2s8Exk+pZa/+8I5jHAo91Pj8T2hmJ8ef
         x6/jcY/Z6Hc6Sm/sJxK1fC5QZG0NkR7tt7M9eBaAKNUc3lV2FYbdbZVibfgghtVI5lqZ
         n3sz/aQoD17JwtdAlfGkBRNgdQx6N8mLro3LpoynVFPAPLGNf7D4rCzHNtbloPj946JK
         /Gxj04J8xYC7A4fI8uoIGWGW8gRbYNVsx2SQeFFZh1LGij4oif34QiNWKwm3Lhu4KaQl
         jUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jt0xR/XFtpMRIuj7oLrfJvxFoX3/OcrnceaJeMN2qXk=;
        b=UhVfPvB/AK+4rv2rqib+7awIcUz18GVGa+OoPGz1hE4YeZn7u6R/7LJFWQe0Cyx1ub
         gj/iSrZEDavXEq1elpKChAq5lQ1L/trt9WzCuV8SEX/NZNr1ZyJydT+WBpaPNoCgpItD
         Hdmu3Vb2JCCfSwQaEhfhqtcfP7kIysYru9dOVDsPaYWDpamYqV7nE4MnQ5wCzAzS+cMM
         tGwoWoT0DLuHkKNtsCXxMmUc18xFayVcFXwnuFgFCEtSgUEPfPsORxVByufauOZQeU2I
         Z/69KaNuBZnVNyEBybOVKWYjPNaHbVLjm32oYbAleR7Ar20dzXaZePSQVNyAStYcggkY
         8GRw==
X-Gm-Message-State: AOAM532FDEwbaAkG2ZRm4MW5VjmjgY88CNsIPCzuQz+bNISXXR1r+XYI
        sQlwNG+fYLx0TmulAGupmXg8vg==
X-Google-Smtp-Source: ABdhPJzmjSiKUSGQWJXOUnb98ph3ukVEonWNRpVs1Gssn89XGBVl/IvBKBKU2+ysbbvZvrO0wLuWHg==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr17709111wrb.132.1605886740225;
        Fri, 20 Nov 2020 07:39:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id b14sm5189845wrs.46.2020.11.20.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:38:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3] phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
Date:   Fri, 20 Nov 2020 16:38:55 +0100
Message-Id: <20201120153855.3920757-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep OTG ID detection even when in Host mode, the ID line of
the PHY (if the current phy is an OTG one) pull-up should be kept
enable in both modes.

This fixes OTG switch on GXL, GXM & AXG platforms, otherwise once switched
to Host, the ID detection doesn't work anymore to switch back to Device.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 875afb2672c7..2b3c0d730f20 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -158,7 +158,8 @@ static int phy_meson_gxl_usb2_set_mode(struct phy *phy,
 				   U2P_R0_DM_PULLDOWN);
 		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
 				   U2P_R0_DP_PULLDOWN);
-		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
+		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
+				   U2P_R0_ID_PULLUP);
 		break;
 
 	case PHY_MODE_USB_DEVICE:
-- 
2.25.1

