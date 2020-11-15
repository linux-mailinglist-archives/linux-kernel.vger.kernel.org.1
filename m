Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482A62B3867
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKOTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:16:38 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:16:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y22so7026230plr.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RbFwWJ4XfVmICtn4qPBK0Df3sLS76eRk5J9RrmkVevM=;
        b=lN5t0I4P8mRVTMtWkO6IuyTVJivI2Y2kwGQx5QrMyrLmWqnGF92YOu+R4AuLCdMd/S
         nttvY6i10IqAqSfqGIEeYlncQrJAoOGZEq7jMh8UlRzNN+fRrTDPcRPFrbJ/UKYo7t5q
         /MfgHB03fCBL8UJcmmPtZdKPMnc2WIdXWWOf0sTX4+JlFdRPwAYoYlyJ3B49CC/085WN
         BptjDCQ0rAPYh4yKC/zGVLO9ZJzyctzwtn7wKSAabt/PWhUPJjTlZuIWTK0+c6Of4Kh7
         eCEXzBq32Mim6IxQTnT5XRXhgUy3eToWK3cPPkKIHlBi45R1F/pYbTRatPhf1hoE1MfZ
         3nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RbFwWJ4XfVmICtn4qPBK0Df3sLS76eRk5J9RrmkVevM=;
        b=IgrssEHcSrBDY7nv1jwkjq6kbxskVfBVL5Bro99xtzFlQSigqT9v2+V2zOQTcNLfhw
         CETwjhfPYdfIWqWD4Wd1UUJREejsZ7IKsm1k1Mei9vf3QsBWtHDShJ3oe0LF/Tctakg4
         jY5xMvC6IkwaaRbaa515IYkeUaeIpgMbC3KMzbRkb5CYt1b1GZkYXq4dK8ZRVPRaKOXw
         U2yB/kD+Gm5mhuOliXpSRPD5PNyUA9mUJOuQxPzIy5lfK4pWwW1tzO6Iq3wfiQjVI/IQ
         M3X0RgfwcwV3f1KwYe7qcKuDc8T/R/2rXj8rYzZ6z3swN9NCDt5CpMoj+ku60QsR1FhD
         2k1Q==
X-Gm-Message-State: AOAM531rBPhapgxXS15HrtQMUiLwrFglLoJVeVPJ8+yVgCCqtnyhk4U8
        kw6Zx+dUqyqEp3KgPQJ5NqQQ2Q==
X-Google-Smtp-Source: ABdhPJy6lL7kZMU6l6BGjSJNQdI/L7BP4OOFAhjz7z/gLsjN21GlTqlV17NmTOy/4U2ZYBNbjwVuHA==
X-Received: by 2002:a17:902:8490:b029:d6:d165:fde with SMTP id c16-20020a1709028490b02900d6d1650fdemr9798114plo.73.1605467796498;
        Sun, 15 Nov 2020 11:16:36 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id mt2sm16548125pjb.7.2020.11.15.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:16:36 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jernej.skrabec@siol.net, linux@armlinux.org.uk, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: configs: sunxi: enable brcm wireless
Date:   Sun, 15 Nov 2020 19:16:18 +0000
Message-Id: <20201115191618.13200-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lot of sunxi boards have BRCM wireless device, so let's enable necessary
options for it in our defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/sunxi_defconfig | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 05f7f4ed8ded..084c48f5dce3 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -52,7 +52,28 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
-# CONFIG_WLAN is not set
+CONFIG_WLAN=y
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+# CONFIG_WLAN_VENDOR_ATH is not set
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+CONFIG_WLAN_VENDOR_BROADCOM=y
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+# CONFIG_WLAN_VENDOR_MEDIATEK is not set
+# CONFIG_WLAN_VENDOR_MICROCHIP is not set
+# CONFIG_WLAN_VENDOR_RALINK is not set
+# CONFIG_WLAN_VENDOR_REALTEK is not set
+# CONFIG_WLAN_VENDOR_RSI is not set
+# CONFIG_WLAN_VENDOR_ST is not set
+# CONFIG_WLAN_VENDOR_TI is not set
+# CONFIG_WLAN_VENDOR_ZYDAS is not set
+# CONFIG_WLAN_VENDOR_QUANTENNA is not set
+CONFIG_CFG80211=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=y
+CONFIG_BRCMFMAC=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
 # CONFIG_INPUT_MOUSE is not set
-- 
2.26.2

